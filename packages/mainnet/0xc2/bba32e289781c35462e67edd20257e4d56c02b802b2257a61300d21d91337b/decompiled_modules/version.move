module 0xc2bba32e289781c35462e67edd20257e4d56c02b802b2257a61300d21d91337b::version {
    public fun migrate(arg0: &mut 0xc2bba32e289781c35462e67edd20257e4d56c02b802b2257a61300d21d91337b::project_manager::ProjectManagerConfig, arg1: &mut 0xc2bba32e289781c35462e67edd20257e4d56c02b802b2257a61300d21d91337b::milestone::VestingConfig, arg2: &0xc2bba32e289781c35462e67edd20257e4d56c02b802b2257a61300d21d91337b::launchpad_manager_config::LaunchManagerAdmin, arg3: &mut 0xc2bba32e289781c35462e67edd20257e4d56c02b802b2257a61300d21d91337b::launchpad_manager::LaunchpadManager) {
        0xc2bba32e289781c35462e67edd20257e4d56c02b802b2257a61300d21d91337b::project_manager::migrate(arg0);
        0xc2bba32e289781c35462e67edd20257e4d56c02b802b2257a61300d21d91337b::milestone::migrate(arg1);
        0xc2bba32e289781c35462e67edd20257e4d56c02b802b2257a61300d21d91337b::launchpad_manager::migrate(arg3);
    }

    // decompiled from Move bytecode v6
}

