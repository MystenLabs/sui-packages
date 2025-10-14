module 0x1cd6b518c6029e7f3188a65a7c9be699bbe4cf566342f765612b402843c5c881::version {
    public fun migrate(arg0: &mut 0x1cd6b518c6029e7f3188a65a7c9be699bbe4cf566342f765612b402843c5c881::project_manager::ProjectManagerConfig, arg1: &mut 0x1cd6b518c6029e7f3188a65a7c9be699bbe4cf566342f765612b402843c5c881::milestone::VestingConfig, arg2: &0x1cd6b518c6029e7f3188a65a7c9be699bbe4cf566342f765612b402843c5c881::launchpad_manager_config::LaunchManagerAdmin, arg3: &mut 0x1cd6b518c6029e7f3188a65a7c9be699bbe4cf566342f765612b402843c5c881::launchpad_manager::LaunchpadManager) {
        0x1cd6b518c6029e7f3188a65a7c9be699bbe4cf566342f765612b402843c5c881::project_manager::migrate(arg0);
        0x1cd6b518c6029e7f3188a65a7c9be699bbe4cf566342f765612b402843c5c881::milestone::migrate(arg1);
        0x1cd6b518c6029e7f3188a65a7c9be699bbe4cf566342f765612b402843c5c881::launchpad_manager::migrate(arg3);
    }

    // decompiled from Move bytecode v6
}

