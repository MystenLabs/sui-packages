module 0x802be8fc0f2b0b66c304ad22af52ae67af0e4f9a4d5cb7ef6e71872fd4730250::version {
    public fun migrate(arg0: &mut 0x802be8fc0f2b0b66c304ad22af52ae67af0e4f9a4d5cb7ef6e71872fd4730250::project_manager::ProjectManagerConfig, arg1: &mut 0x802be8fc0f2b0b66c304ad22af52ae67af0e4f9a4d5cb7ef6e71872fd4730250::milestone::VestingConfig, arg2: &0x802be8fc0f2b0b66c304ad22af52ae67af0e4f9a4d5cb7ef6e71872fd4730250::launchpad_manager_config::LaunchManagerAdmin, arg3: &mut 0x802be8fc0f2b0b66c304ad22af52ae67af0e4f9a4d5cb7ef6e71872fd4730250::launchpad_manager::LaunchpadManager) {
        0x802be8fc0f2b0b66c304ad22af52ae67af0e4f9a4d5cb7ef6e71872fd4730250::project_manager::migrate(arg0);
        0x802be8fc0f2b0b66c304ad22af52ae67af0e4f9a4d5cb7ef6e71872fd4730250::milestone::migrate(arg1);
        0x802be8fc0f2b0b66c304ad22af52ae67af0e4f9a4d5cb7ef6e71872fd4730250::launchpad_manager::migrate(arg3);
    }

    // decompiled from Move bytecode v6
}

