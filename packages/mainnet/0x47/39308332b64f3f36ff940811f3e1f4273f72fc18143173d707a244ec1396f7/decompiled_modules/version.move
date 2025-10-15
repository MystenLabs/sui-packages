module 0x4739308332b64f3f36ff940811f3e1f4273f72fc18143173d707a244ec1396f7::version {
    public fun migrate(arg0: &mut 0x4739308332b64f3f36ff940811f3e1f4273f72fc18143173d707a244ec1396f7::project_manager::ProjectManagerConfig, arg1: &mut 0x4739308332b64f3f36ff940811f3e1f4273f72fc18143173d707a244ec1396f7::milestone::VestingConfig, arg2: &0x4739308332b64f3f36ff940811f3e1f4273f72fc18143173d707a244ec1396f7::launchpad_manager_config::LaunchManagerAdmin, arg3: &mut 0x4739308332b64f3f36ff940811f3e1f4273f72fc18143173d707a244ec1396f7::launchpad_manager::LaunchpadManager) {
        0x4739308332b64f3f36ff940811f3e1f4273f72fc18143173d707a244ec1396f7::project_manager::migrate(arg0);
        0x4739308332b64f3f36ff940811f3e1f4273f72fc18143173d707a244ec1396f7::milestone::migrate(arg1);
        0x4739308332b64f3f36ff940811f3e1f4273f72fc18143173d707a244ec1396f7::launchpad_manager::migrate(arg3);
    }

    // decompiled from Move bytecode v6
}

