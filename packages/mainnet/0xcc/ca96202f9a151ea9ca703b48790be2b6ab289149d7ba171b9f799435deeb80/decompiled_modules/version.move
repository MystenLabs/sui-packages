module 0xccca96202f9a151ea9ca703b48790be2b6ab289149d7ba171b9f799435deeb80::version {
    public fun migrate(arg0: &mut 0xccca96202f9a151ea9ca703b48790be2b6ab289149d7ba171b9f799435deeb80::project_manager::ProjectManagerConfig, arg1: &mut 0xccca96202f9a151ea9ca703b48790be2b6ab289149d7ba171b9f799435deeb80::milestone::VestingConfig, arg2: &0xccca96202f9a151ea9ca703b48790be2b6ab289149d7ba171b9f799435deeb80::launchpad_manager_config::LaunchManagerAdmin) {
        0xccca96202f9a151ea9ca703b48790be2b6ab289149d7ba171b9f799435deeb80::project_manager::migrate(arg0);
        0xccca96202f9a151ea9ca703b48790be2b6ab289149d7ba171b9f799435deeb80::milestone::migrate(arg1);
    }

    // decompiled from Move bytecode v6
}

