module 0xdec456c198200260c20663a5a53b82fd1d6c75ae893473e335a873c3f5c444d8::version {
    public fun migrate(arg0: &mut 0xdec456c198200260c20663a5a53b82fd1d6c75ae893473e335a873c3f5c444d8::project_manager::ProjectManagerConfig, arg1: &mut 0xdec456c198200260c20663a5a53b82fd1d6c75ae893473e335a873c3f5c444d8::milestone::VestingConfig, arg2: &0xdec456c198200260c20663a5a53b82fd1d6c75ae893473e335a873c3f5c444d8::launchpad_manager_config::LaunchManagerAdmin, arg3: &mut 0xdec456c198200260c20663a5a53b82fd1d6c75ae893473e335a873c3f5c444d8::launchpad_manager::LaunchpadManager) {
        0xdec456c198200260c20663a5a53b82fd1d6c75ae893473e335a873c3f5c444d8::project_manager::migrate(arg0);
        0xdec456c198200260c20663a5a53b82fd1d6c75ae893473e335a873c3f5c444d8::milestone::migrate(arg1);
        0xdec456c198200260c20663a5a53b82fd1d6c75ae893473e335a873c3f5c444d8::launchpad_manager::migrate(arg3);
    }

    // decompiled from Move bytecode v6
}

