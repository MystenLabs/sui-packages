module 0xc213b1a0a7e9e022f055fa4ce2f7da28bbc6b6e4cd9d88d883f580efd62f957d::version {
    public fun migrate(arg0: &mut 0xc213b1a0a7e9e022f055fa4ce2f7da28bbc6b6e4cd9d88d883f580efd62f957d::project_manager::ProjectManagerConfig, arg1: &mut 0xc213b1a0a7e9e022f055fa4ce2f7da28bbc6b6e4cd9d88d883f580efd62f957d::milestone::VestingConfig, arg2: &0xc213b1a0a7e9e022f055fa4ce2f7da28bbc6b6e4cd9d88d883f580efd62f957d::launchpad_manager_config::LaunchManagerAdmin, arg3: &mut 0xc213b1a0a7e9e022f055fa4ce2f7da28bbc6b6e4cd9d88d883f580efd62f957d::launchpad_manager::LaunchpadManager) {
        0xc213b1a0a7e9e022f055fa4ce2f7da28bbc6b6e4cd9d88d883f580efd62f957d::project_manager::migrate(arg0);
        0xc213b1a0a7e9e022f055fa4ce2f7da28bbc6b6e4cd9d88d883f580efd62f957d::milestone::migrate(arg1);
        0xc213b1a0a7e9e022f055fa4ce2f7da28bbc6b6e4cd9d88d883f580efd62f957d::launchpad_manager::migrate(arg3);
    }

    // decompiled from Move bytecode v6
}

