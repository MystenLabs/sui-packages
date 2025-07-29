module 0xd94fb41e1ed6a862bd6bcfdc99290bf0a5cc9b98feb5ab744846d499768d74ee::version {
    public fun migrate(arg0: &mut 0xd94fb41e1ed6a862bd6bcfdc99290bf0a5cc9b98feb5ab744846d499768d74ee::project_manager::ProjectManagerConfig, arg1: &mut 0xd94fb41e1ed6a862bd6bcfdc99290bf0a5cc9b98feb5ab744846d499768d74ee::milestone::VestingConfig, arg2: &0xd94fb41e1ed6a862bd6bcfdc99290bf0a5cc9b98feb5ab744846d499768d74ee::launchpad_manager_config::LaunchManagerAdmin) {
        0xd94fb41e1ed6a862bd6bcfdc99290bf0a5cc9b98feb5ab744846d499768d74ee::project_manager::migrate(arg0);
        0xd94fb41e1ed6a862bd6bcfdc99290bf0a5cc9b98feb5ab744846d499768d74ee::milestone::migrate(arg1);
    }

    // decompiled from Move bytecode v6
}

