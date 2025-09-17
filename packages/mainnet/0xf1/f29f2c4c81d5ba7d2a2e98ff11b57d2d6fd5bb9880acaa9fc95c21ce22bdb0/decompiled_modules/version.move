module 0xf1f29f2c4c81d5ba7d2a2e98ff11b57d2d6fd5bb9880acaa9fc95c21ce22bdb0::version {
    public fun migrate(arg0: &mut 0xf1f29f2c4c81d5ba7d2a2e98ff11b57d2d6fd5bb9880acaa9fc95c21ce22bdb0::project_manager::ProjectManagerConfig, arg1: &mut 0xf1f29f2c4c81d5ba7d2a2e98ff11b57d2d6fd5bb9880acaa9fc95c21ce22bdb0::milestone::VestingConfig, arg2: &0xf1f29f2c4c81d5ba7d2a2e98ff11b57d2d6fd5bb9880acaa9fc95c21ce22bdb0::launchpad_manager_config::LaunchManagerAdmin, arg3: &mut 0xf1f29f2c4c81d5ba7d2a2e98ff11b57d2d6fd5bb9880acaa9fc95c21ce22bdb0::launchpad_manager::LaunchpadManager) {
        0xf1f29f2c4c81d5ba7d2a2e98ff11b57d2d6fd5bb9880acaa9fc95c21ce22bdb0::project_manager::migrate(arg0);
        0xf1f29f2c4c81d5ba7d2a2e98ff11b57d2d6fd5bb9880acaa9fc95c21ce22bdb0::milestone::migrate(arg1);
        0xf1f29f2c4c81d5ba7d2a2e98ff11b57d2d6fd5bb9880acaa9fc95c21ce22bdb0::launchpad_manager::migrate(arg3);
    }

    // decompiled from Move bytecode v6
}

