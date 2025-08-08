module 0xa360119a0c5f6644a63ce41a4574dbf4bb7f1e87eb8c554c8c23d061e8820774::version {
    public fun migrate(arg0: &mut 0xa360119a0c5f6644a63ce41a4574dbf4bb7f1e87eb8c554c8c23d061e8820774::project_manager::ProjectManagerConfig, arg1: &mut 0xa360119a0c5f6644a63ce41a4574dbf4bb7f1e87eb8c554c8c23d061e8820774::milestone::VestingConfig, arg2: &0xa360119a0c5f6644a63ce41a4574dbf4bb7f1e87eb8c554c8c23d061e8820774::launchpad_manager_config::LaunchManagerAdmin) {
        0xa360119a0c5f6644a63ce41a4574dbf4bb7f1e87eb8c554c8c23d061e8820774::project_manager::migrate(arg0);
        0xa360119a0c5f6644a63ce41a4574dbf4bb7f1e87eb8c554c8c23d061e8820774::milestone::migrate(arg1);
    }

    // decompiled from Move bytecode v6
}

