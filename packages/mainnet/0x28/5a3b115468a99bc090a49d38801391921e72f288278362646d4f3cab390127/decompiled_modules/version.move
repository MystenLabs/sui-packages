module 0x285a3b115468a99bc090a49d38801391921e72f288278362646d4f3cab390127::version {
    public fun migrate(arg0: &mut 0x285a3b115468a99bc090a49d38801391921e72f288278362646d4f3cab390127::project_manager::ProjectManagerConfig, arg1: &mut 0x285a3b115468a99bc090a49d38801391921e72f288278362646d4f3cab390127::milestone::VestingConfig, arg2: &0x285a3b115468a99bc090a49d38801391921e72f288278362646d4f3cab390127::launchpad_manager_config::LaunchManagerAdmin, arg3: &mut 0x285a3b115468a99bc090a49d38801391921e72f288278362646d4f3cab390127::launchpad_manager::LaunchpadManager) {
        0x285a3b115468a99bc090a49d38801391921e72f288278362646d4f3cab390127::project_manager::migrate(arg0);
        0x285a3b115468a99bc090a49d38801391921e72f288278362646d4f3cab390127::milestone::migrate(arg1);
        0x285a3b115468a99bc090a49d38801391921e72f288278362646d4f3cab390127::launchpad_manager::migrate(arg3);
    }

    // decompiled from Move bytecode v6
}

