window.ModuleMenusConfiguration =
	[
		isHeader: true
		menuName: "Load and Analyze Data"
		requireUserRoles: [window.conf.roles.acas.userRole]
		collapsible: true
	,
		isHeader: false
		menuName: "Experiment Loader"
		mainControllerClassName: "GenericDataParserController"
		autoLaunchName:"generic_data_parser"
		requireUserRoles: [window.conf.roles.acas.userRole]
	,
		isHeader: false
		menuName: "Dose Response"
		mainControllerClassName: "DoseResponseFitWorkflowController"
		requireUserRoles: [window.conf.roles.acas.userRole]
	,
		isHeader: true
		menuName: "Create Protocol or Experiment"
		collapsible: true
	,
		isHeader: false
		menuName: "Protocol Editor"
		mainControllerClassName: window.conf.protocol.mainControllerClassName
		autoLaunchName:"protocol_base"
		requireUserRoles: [window.conf.roles.acas.userRole]
	,
		isHeader: false
		menuName: "Experiment Editor"
		mainControllerClassName: window.conf.experiment.mainControllerClassName
		autoLaunchName:"experiment_base"
		requireUserRoles: [window.conf.roles.acas.userRole]
	,
		isHeader: false
		menuName: "Protocol & Experiment Summaries"
		mainControllerClassName: "ELNHomePageController"
		autoLaunchName:"eln_home_page"
	,
		isHeader: true
		menuName: "Search and Edit"
		collapsible: true
		requireUserRoles: [window.conf.roles.acas.userRole]
	,
		isHeader: false,
		menuName: "Data Viewer"
		externalLink: "/DataViewer"
		requireUserRoles: [window.conf.roles.acas.userRole]
	,
		isHeader: false, menuName: "Protocol Browser"
		mainControllerClassName: "ProtocolBrowserController"
		requireUserRoles: [window.conf.roles.acas.userRole]
	,
		isHeader: false, menuName: "Experiment Browser"
		mainControllerClassName: "ExperimentBrowserController"
		requireUserRoles: [window.conf.roles.acas.userRole]
	,
		isHeader: true
		menuName: "Admin"
		collapsible: true
		requireUserRoles: [window.conf.roles.acas.adminRole]
	,
		isHeader: false
		menuName: "System Test"
		mainControllerClassName: "SystemTestController"
		autoLaunchName:"system_test"
		requireUserRoles: [window.conf.roles.acas.adminRole]
	,
		isHeader: true
		menuName: "CmpdReg Admin"
		requireUserRoles: [window.conf.roles.cmpdreg.adminRole]
		collapsible: true
	,
		isHeader: false
		menuName: "CmpdReg Vendors"
		mainControllerClassName: "VendorBrowserController"
		autoLaunchName: "vendor_browser"
		requireUserRoles: [window.conf.roles.cmpdreg.adminRole]
	]
