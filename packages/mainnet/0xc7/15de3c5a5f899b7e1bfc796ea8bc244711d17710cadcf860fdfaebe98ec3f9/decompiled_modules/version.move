module 0xc715de3c5a5f899b7e1bfc796ea8bc244711d17710cadcf860fdfaebe98ec3f9::version {
    public fun migrate(arg0: &mut 0xc715de3c5a5f899b7e1bfc796ea8bc244711d17710cadcf860fdfaebe98ec3f9::project_manager::ProjectManagerConfig, arg1: &mut 0xc715de3c5a5f899b7e1bfc796ea8bc244711d17710cadcf860fdfaebe98ec3f9::milestone::VestingConfig, arg2: &0xc715de3c5a5f899b7e1bfc796ea8bc244711d17710cadcf860fdfaebe98ec3f9::launchpad_manager_config::LaunchManagerAdmin) {
        0xc715de3c5a5f899b7e1bfc796ea8bc244711d17710cadcf860fdfaebe98ec3f9::project_manager::migrate(arg0);
        0xc715de3c5a5f899b7e1bfc796ea8bc244711d17710cadcf860fdfaebe98ec3f9::milestone::migrate(arg1);
    }

    // decompiled from Move bytecode v6
}

