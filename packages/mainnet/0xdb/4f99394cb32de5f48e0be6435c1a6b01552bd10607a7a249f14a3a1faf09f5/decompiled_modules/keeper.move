module 0xdb4f99394cb32de5f48e0be6435c1a6b01552bd10607a7a249f14a3a1faf09f5::keeper {
    public fun sync_staking_pool(arg0: &mut 0xdb4f99394cb32de5f48e0be6435c1a6b01552bd10607a7a249f14a3a1faf09f5::staking_pool::StakingPool, arg1: &0xdb4f99394cb32de5f48e0be6435c1a6b01552bd10607a7a249f14a3a1faf09f5::ve_mmt::VeMMT, arg2: &0x2::clock::Clock) {
        0xdb4f99394cb32de5f48e0be6435c1a6b01552bd10607a7a249f14a3a1faf09f5::version::assert_supported_version(0xdb4f99394cb32de5f48e0be6435c1a6b01552bd10607a7a249f14a3a1faf09f5::ve_mmt::version(arg1));
        assert!(!0xdb4f99394cb32de5f48e0be6435c1a6b01552bd10607a7a249f14a3a1faf09f5::ve_mmt::is_paused(arg1), 0xdb4f99394cb32de5f48e0be6435c1a6b01552bd10607a7a249f14a3a1faf09f5::error::e_paused());
        0xdb4f99394cb32de5f48e0be6435c1a6b01552bd10607a7a249f14a3a1faf09f5::staking_pool::sync_or_advance_epoch(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

