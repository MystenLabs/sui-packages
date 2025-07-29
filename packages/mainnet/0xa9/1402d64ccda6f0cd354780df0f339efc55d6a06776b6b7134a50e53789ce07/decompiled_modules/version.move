module 0xa91402d64ccda6f0cd354780df0f339efc55d6a06776b6b7134a50e53789ce07::version {
    public fun migrate(arg0: &mut 0xa91402d64ccda6f0cd354780df0f339efc55d6a06776b6b7134a50e53789ce07::project_manager::ProjectManagerConfig, arg1: &mut 0xa91402d64ccda6f0cd354780df0f339efc55d6a06776b6b7134a50e53789ce07::milestone::VestingConfig, arg2: &0xa91402d64ccda6f0cd354780df0f339efc55d6a06776b6b7134a50e53789ce07::launchpad_manager_config::LaunchManagerAdmin) {
        0xa91402d64ccda6f0cd354780df0f339efc55d6a06776b6b7134a50e53789ce07::project_manager::migrate(arg0);
        0xa91402d64ccda6f0cd354780df0f339efc55d6a06776b6b7134a50e53789ce07::milestone::migrate(arg1);
    }

    // decompiled from Move bytecode v6
}

