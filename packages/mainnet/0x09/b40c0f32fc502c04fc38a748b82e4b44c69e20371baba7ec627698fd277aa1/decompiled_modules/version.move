module 0x9b40c0f32fc502c04fc38a748b82e4b44c69e20371baba7ec627698fd277aa1::version {
    public fun migrate(arg0: &mut 0x9b40c0f32fc502c04fc38a748b82e4b44c69e20371baba7ec627698fd277aa1::project_manager::ProjectManagerConfig, arg1: &mut 0x9b40c0f32fc502c04fc38a748b82e4b44c69e20371baba7ec627698fd277aa1::milestone::VestingConfig, arg2: &0x9b40c0f32fc502c04fc38a748b82e4b44c69e20371baba7ec627698fd277aa1::launchpad_manager_config::LaunchManagerAdmin) {
        0x9b40c0f32fc502c04fc38a748b82e4b44c69e20371baba7ec627698fd277aa1::project_manager::migrate(arg0);
        0x9b40c0f32fc502c04fc38a748b82e4b44c69e20371baba7ec627698fd277aa1::milestone::migrate(arg1);
    }

    // decompiled from Move bytecode v6
}

