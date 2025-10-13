module 0x4e488a117111d6506879583584aab0d99fc514ca5488015048b96857e38d4c8f::version {
    public fun migrate(arg0: &mut 0x4e488a117111d6506879583584aab0d99fc514ca5488015048b96857e38d4c8f::project_manager::ProjectManagerConfig, arg1: &mut 0x4e488a117111d6506879583584aab0d99fc514ca5488015048b96857e38d4c8f::milestone::VestingConfig, arg2: &0x4e488a117111d6506879583584aab0d99fc514ca5488015048b96857e38d4c8f::launchpad_manager_config::LaunchManagerAdmin, arg3: &mut 0x4e488a117111d6506879583584aab0d99fc514ca5488015048b96857e38d4c8f::launchpad_manager::LaunchpadManager) {
        0x4e488a117111d6506879583584aab0d99fc514ca5488015048b96857e38d4c8f::project_manager::migrate(arg0);
        0x4e488a117111d6506879583584aab0d99fc514ca5488015048b96857e38d4c8f::milestone::migrate(arg1);
        0x4e488a117111d6506879583584aab0d99fc514ca5488015048b96857e38d4c8f::launchpad_manager::migrate(arg3);
    }

    // decompiled from Move bytecode v6
}

