module 0x5ffa593f329dd0222a7bc2e87ebbc2b45a6bba3c49ce2586c718f518b89673e6::keeper {
    public fun sync_staking_pool(arg0: &mut 0x5ffa593f329dd0222a7bc2e87ebbc2b45a6bba3c49ce2586c718f518b89673e6::staking_pool::StakingPool, arg1: &0x5ffa593f329dd0222a7bc2e87ebbc2b45a6bba3c49ce2586c718f518b89673e6::ve_mmt::VeMMT, arg2: &0x2::clock::Clock) {
        0x5ffa593f329dd0222a7bc2e87ebbc2b45a6bba3c49ce2586c718f518b89673e6::version::assert_supported_version(0x5ffa593f329dd0222a7bc2e87ebbc2b45a6bba3c49ce2586c718f518b89673e6::ve_mmt::version(arg1));
        assert!(!0x5ffa593f329dd0222a7bc2e87ebbc2b45a6bba3c49ce2586c718f518b89673e6::ve_mmt::is_paused(arg1), 0x5ffa593f329dd0222a7bc2e87ebbc2b45a6bba3c49ce2586c718f518b89673e6::error::e_paused());
        0x5ffa593f329dd0222a7bc2e87ebbc2b45a6bba3c49ce2586c718f518b89673e6::staking_pool::sync_or_advance_epoch(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

