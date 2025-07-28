module 0x7e6e45a1fa9e0d6e39abdb6f87ff666f81be5c5d2a64e23d7d363333a2458f8d::version {
    public fun migrate(arg0: &mut 0x7e6e45a1fa9e0d6e39abdb6f87ff666f81be5c5d2a64e23d7d363333a2458f8d::project_manager::ProjectManagerConfig, arg1: &mut 0x7e6e45a1fa9e0d6e39abdb6f87ff666f81be5c5d2a64e23d7d363333a2458f8d::milestone::VestingConfig, arg2: &0x7e6e45a1fa9e0d6e39abdb6f87ff666f81be5c5d2a64e23d7d363333a2458f8d::launchpad_manager_config::LaunchManagerAdmin) {
        0x7e6e45a1fa9e0d6e39abdb6f87ff666f81be5c5d2a64e23d7d363333a2458f8d::project_manager::migrate(arg0);
        0x7e6e45a1fa9e0d6e39abdb6f87ff666f81be5c5d2a64e23d7d363333a2458f8d::milestone::migrate(arg1);
    }

    // decompiled from Move bytecode v6
}

