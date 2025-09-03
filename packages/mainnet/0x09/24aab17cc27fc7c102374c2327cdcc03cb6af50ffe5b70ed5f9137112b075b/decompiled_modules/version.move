module 0x924aab17cc27fc7c102374c2327cdcc03cb6af50ffe5b70ed5f9137112b075b::version {
    public fun migrate(arg0: &mut 0x924aab17cc27fc7c102374c2327cdcc03cb6af50ffe5b70ed5f9137112b075b::project_manager::ProjectManagerConfig, arg1: &mut 0x924aab17cc27fc7c102374c2327cdcc03cb6af50ffe5b70ed5f9137112b075b::milestone::VestingConfig, arg2: &0x924aab17cc27fc7c102374c2327cdcc03cb6af50ffe5b70ed5f9137112b075b::launchpad_manager_config::LaunchManagerAdmin) {
        0x924aab17cc27fc7c102374c2327cdcc03cb6af50ffe5b70ed5f9137112b075b::project_manager::migrate(arg0);
        0x924aab17cc27fc7c102374c2327cdcc03cb6af50ffe5b70ed5f9137112b075b::milestone::migrate(arg1);
    }

    // decompiled from Move bytecode v6
}

