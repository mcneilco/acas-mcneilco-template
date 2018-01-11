path = require 'path'
fs = require 'fs'
request = require 'request'
_ = require 'underscore'

ACAS_HOME=path.resolve "#{__dirname}/../../.."
config = require(path.join(ACAS_HOME,"conf","compiled","conf.js"))
currentTime = new Date().getTime()

# once a project is registered, it's hard to get the project code unless project restrictions are off so hardcoding PROJ-00000001 for now
globalProjectCode = "PROJ-00000001"
authors = [
	{
		'firstName': 'Bob'
		'lastName': 'Roberts'
		'userName': 'bob'
		'emailAddress': 'bob@mcneilco.com'
		'version': 0
		'enabled': true
		'locked': false
		'password': '5en6G6MezRroT3XKqkdPOmY/BfQ=' # secret echo -n secret | openssl dgst -binary -sha1 | openssl base64
		'recordedBy': 'bob'
		'recordedDate': currentTime
		'lsType': 'default'
		'lsKind': 'default'
	}
]

exports.getOrCreateGlobalProjectInternal = (callback) ->
	exports.getGlobalProjectRole globalProjectCode, (globalProjectRole) ->
		if globalProjectRole?
			callback 200, {
				hasError: false
				messages: globalProjectCode
				created: false
			}
			return
		else
			options =
				method: 'POST'
				url: "#{config.all.server.nodeapi.path}/api/things/project/project"
				headers:
					accept: 'application/json, text/javascript, */*; q=0.01'
					'content-type': 'application/json'
					origin: 'http://localhost:3000'
				body:
					lsType: 'project'
					lsKind: 'project'
					corpName: ''
					recordedBy: 'bob'
					recordedDate: 1472835742009
					shortDescription: ' '
					lsLabels: [
						{
							lsType: 'name'
							lsKind: 'project name'
							labelText: 'Global'
							ignored: false
							preferred: true
							recordedDate: 1472835742010
							recordedBy: 'bob'
							physicallyLabled: false
							imageFile: null
						}
						{
							lsType: 'name'
							lsKind: 'project alias'
							labelText: 'Global'
							ignored: false
							preferred: false
							recordedDate: 1472835742012
							recordedBy: 'bob'
							physicallyLabled: false
							imageFile: null
						}
					]
					lsStates: [ {
						lsType: 'metadata'
						lsKind: 'project metadata'
						lsValues: [
							{
								lsType: 'dateValue'
								lsKind: 'start date'
								ignored: false
								recordedDate: 1472835742015
								recordedBy: 'bob'
								value: null
								dateValue: null
							}
							{
								lsType: 'codeValue'
								lsKind: 'project status'
								ignored: false
								recordedDate: 1472835742016
								recordedBy: 'bob'
								codeKind: 'status'
								codeType: 'project'
								codeOrigin: 'ACAS DDICT'
								codeValue: 'active'
								value: 'active'
							}
							{
								lsType: 'stringValue'
								lsKind: 'short description'
								ignored: false
								recordedDate: 1472835742017
								recordedBy: 'bob'
								value: ''
								stringValue: ''
							}
							{
								lsType: 'clobValue'
								lsKind: 'project details'
								ignored: false
								recordedDate: 1472835742020
								recordedBy: 'bob'
								value: ''
								clobValue: ''
							}
							{
								lsType: 'codeValue'
								lsKind: 'is restricted'
								ignored: false
								recordedDate: 1472835742022
								recordedBy: 'bob'
								codeKind: 'restricted'
								codeType: 'project'
								codeOrigin: 'ACAS DDICT'
								codeValue: 'false'
								value: 'true'
							}
						]
						ignored: false
						recordedDate: 1472835742014
						recordedBy: 'bob'
					} ]
					firstLsThings: []
					secondLsThings: []
					lsTags: []
				json: true
			request options, (error, response, body) ->
				if error
					throw new Error(error)
					statusCode=500
					hasError = true
					created = false
				else
					if response.statusCode == 500
						hasError = true
						created = false
					else
						hasError = false
						created = true
					statusCode = response.statusCode
				callback statusCode, {
					hasError: hasError
					messages: body
					created: created
				}

exports.getOrCreateGlobalProjectRoleInternal = (callback) ->
	exports.getGlobalProjectRole globalProjectCode, (globalProjectRole) ->
		if globalProjectRole?
			callback 200, {
				hasError: false
				messages: globalProjectRole
				created: false
			}
		else
			request = require('request')
			options =
				method: 'POST'
				url: "#{config.all.server.nodeapi.path}/api/projects/createRoleKindAndName"
				headers:
					accept: 'application/json, text/javascript, */*; q=0.01'
					'content-type': 'application/x-www-form-urlencoded; charset=UTF-8'
					origin: 'http://localhost:3000'
				body: "rolekind%5B0%5D%5BtypeName%5D=Project&rolekind%5B0%5D%5BkindName%5D=#{globalProjectCode}&lsroles%5B0%5D%5BlsType%5D=Project&lsroles%5B0%5D%5BlsKind%5D=#{globalProjectCode}&lsroles%5B0%5D%5BroleName%5D=User&lsroles%5B1%5D%5BlsType%5D=Project&lsroles%5B1%5D%5BlsKind%5D=#{globalProjectCode}&lsroles%5B1%5D%5BroleName%5D=Administrator"
				json: true
			request options, (error, response, body) ->
				created = false
				if error
					throw new Error(error)
					statusCode=500
					hasError = true
				else
					if response.statusCode == 500
						hasError = true
					else
						hasError = false
						created = true
					statusCode = response.statusCode
				callback statusCode, {
					hasError: hasError
					messages: body
					created: created
				}

exports.getGlobalProjectRole = (projectCode, callback) ->
	options =
		method: 'GET'
		url: "#{config.all.server.nodeapi.path}/api/projects/getByRoleTypeKindAndName/Project/#{projectCode}/User"
		json:true
	request options, (error, response, body) ->
		if error
			throw new Error(error)
		callback body[0]

getOrCreateAuthor = (author, callback) ->
	options =
		method: 'POST'
		url: config.all.client.service.persistence.fullpath+"/authors/getOrCreate"
		body: author
		json: true
	request options, (error, response, body) ->
		if !error
			if response.statusCode == 201
				callback null, "user registered"
			else
				callback "unknown error", null
		else
			console.error 'got connection error trying to register users'
			console.error options
			console.error error
			console.error response
			console.error options
			callback "unknown error", null

exports.giveUserRolesInternal = (username, callback) ->
	options =
		method: 'POST'
		url: "#{config.all.client.service.persistence.fullpath}authorroles/saveRoles"
		headers:
			'content-type': 'application/json'
		body: [
			{
				roleType: 'System'
				roleKind: 'ACAS'
				roleName: 'ROLE_ACAS-ADMINS'
				userName: username
			}
			{
				roleType: 'System'
				roleKind: 'ACAS'
				roleName: 'ROLE_ACAS-USERS'
				userName: username
			}
			{
				roleType: 'System'
				roleKind: 'ACAS'
				roleName: 'ROLE_ACAS-CROSS-PROJECT-LOADER'
				userName: username
			}
			{
				roleType: 'System'
				roleKind: 'CmpdReg'
				roleName: 'ROLE_CMPDREG-ADMINS'
				userName: username
			}
			{
				roleType: 'System'
				roleKind: 'CmpdReg'
				roleName: 'ROLE_CMPDREG-USERS'
				userName: username
			}
			{
				roleType: 'Project'
				roleKind: globalProjectCode
				roleName: 'User'
				userName: username
			}
		]
		json: true
	request options, (error, response, body) ->
		if error
			throw new Error(error)
			statusCode=500
			hasError = true
		else
			if response.statusCode == 500
				hasError = true
			else
				hasError = false
			statusCode = response.statusCode
		callback statusCode, {
			hasError: hasError
			messages: body
		}

exports.registerUsers = (callback) =>
		console.log "attempting to register users"
		saveAllAuthors = (authorsToSave, currentIndex, outerCallback) ->
				if currentIndex == -1
						outerCallback()
						return
				getOrCreateAuthor authorsToSave[currentIndex], (err, output)->
					if err?
						console.error err
					else
						console.log "registered #{authorsToSave[currentIndex].userName}"
						exports.giveUserRolesInternal authorsToSave[currentIndex].userName, (statusCode, output) ->
						console.log "gave #{authorsToSave[currentIndex].userName} all roles"
						currentIndex--
						saveAllAuthors authorsToSave, currentIndex, outerCallback
						return

		saveAllAuthors authors, authors.length-1, ->
				callback 200, "all authors saved"

exports.syncRolesInternal = (callback) ->
	options =
		method: 'GET'
		url: "#{config.all.server.nodeapi.path}/api/syncLiveDesignProjectsUsers"
	request options, (error, response, body) ->
		if error
			throw new Error(error)
			statusCode=500
			hasError = true
		else
			hasError = false
			statusCode = response.statusCode
		callback statusCode, {
			hasError: hasError
			messages: body
		}

exports.bootstrap = () =>
	  exports.getOrCreateGlobalProjectInternal (statusCode, output) ->
			exports.getOrCreateGlobalProjectRoleInternal (statusCode, output) ->
				exports.registerUsers (response) ->
					exports.syncRolesInternal (statusCode, output) ->
						console.log "synced roles"
						console.log response

# Define main such that when this script is called the function bootstrap is called
if require.main == module
	exports.bootstrap()