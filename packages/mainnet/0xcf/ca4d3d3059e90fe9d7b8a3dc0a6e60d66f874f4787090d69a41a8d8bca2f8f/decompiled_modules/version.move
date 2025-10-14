module 0xcfca4d3d3059e90fe9d7b8a3dc0a6e60d66f874f4787090d69a41a8d8bca2f8f::version {
    public fun migrate(arg0: &mut 0xcfca4d3d3059e90fe9d7b8a3dc0a6e60d66f874f4787090d69a41a8d8bca2f8f::project_manager::ProjectManagerConfig, arg1: &mut 0xcfca4d3d3059e90fe9d7b8a3dc0a6e60d66f874f4787090d69a41a8d8bca2f8f::milestone::VestingConfig, arg2: &0xcfca4d3d3059e90fe9d7b8a3dc0a6e60d66f874f4787090d69a41a8d8bca2f8f::launchpad_manager_config::LaunchManagerAdmin, arg3: &mut 0xcfca4d3d3059e90fe9d7b8a3dc0a6e60d66f874f4787090d69a41a8d8bca2f8f::launchpad_manager::LaunchpadManager) {
        0xcfca4d3d3059e90fe9d7b8a3dc0a6e60d66f874f4787090d69a41a8d8bca2f8f::project_manager::migrate(arg0);
        0xcfca4d3d3059e90fe9d7b8a3dc0a6e60d66f874f4787090d69a41a8d8bca2f8f::milestone::migrate(arg1);
        0xcfca4d3d3059e90fe9d7b8a3dc0a6e60d66f874f4787090d69a41a8d8bca2f8f::launchpad_manager::migrate(arg3);
    }

    // decompiled from Move bytecode v6
}

