module 0xb4f9cc7c1a03388823dc782ca99b5d44105f6a663dcba621192eeff3ea6523bd::version {
    public fun migrate(arg0: &mut 0xb4f9cc7c1a03388823dc782ca99b5d44105f6a663dcba621192eeff3ea6523bd::project_manager::ProjectManagerConfig, arg1: &mut 0xb4f9cc7c1a03388823dc782ca99b5d44105f6a663dcba621192eeff3ea6523bd::milestone::VestingConfig, arg2: &0xb4f9cc7c1a03388823dc782ca99b5d44105f6a663dcba621192eeff3ea6523bd::launchpad_manager_config::LaunchManagerAdmin, arg3: &mut 0xb4f9cc7c1a03388823dc782ca99b5d44105f6a663dcba621192eeff3ea6523bd::launchpad_manager::LaunchpadManager) {
        0xb4f9cc7c1a03388823dc782ca99b5d44105f6a663dcba621192eeff3ea6523bd::project_manager::migrate(arg0);
        0xb4f9cc7c1a03388823dc782ca99b5d44105f6a663dcba621192eeff3ea6523bd::milestone::migrate(arg1);
        0xb4f9cc7c1a03388823dc782ca99b5d44105f6a663dcba621192eeff3ea6523bd::launchpad_manager::migrate(arg3);
    }

    // decompiled from Move bytecode v6
}

