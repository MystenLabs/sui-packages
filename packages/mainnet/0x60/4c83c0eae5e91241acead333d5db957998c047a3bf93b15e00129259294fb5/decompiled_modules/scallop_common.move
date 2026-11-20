module 0x8c2fcc3af98331ee0f293bca262e26b6e2c8eeabc2042032d739cc83bd19697e::scallop_common {
    public(friend) fun query_underlying_from_scoin_amount<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg1: u64) : u128 {
        0x8c2fcc3af98331ee0f293bca262e26b6e2c8eeabc2042032d739cc83bd19697e::scallop_adapter::get_underlying_balance<T0>(arg0, arg1)
    }

    public(friend) fun select_scoin_withdraw_amount<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg1: u128, arg2: u64) : u64 {
        let (v0, v1) = 0x8c2fcc3af98331ee0f293bca262e26b6e2c8eeabc2042032d739cc83bd19697e::scallop_adapter::get_exchange_rate<T0>(arg0);
        0x8c2fcc3af98331ee0f293bca262e26b6e2c8eeabc2042032d739cc83bd19697e::scallop_adapter::select_scoin_withdraw_amount_floor(arg1, arg2, v0, v1, 0x8c2fcc3af98331ee0f293bca262e26b6e2c8eeabc2042032d739cc83bd19697e::scallop_adapter::get_available_liquidity<T0>(arg0))
    }

    public(friend) fun trigger_accrue_if_needed<T0, T1>(arg0: &0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_pool::VaultPool<T0, T1>, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0x2::clock::Clock) {
        if (0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_pool::should_trigger_accrue<T0, T1>(arg0, 0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_strategy::PROTOCOL_SCALLOP(), arg3)) {
            0x8c2fcc3af98331ee0f293bca262e26b6e2c8eeabc2042032d739cc83bd19697e::scallop_adapter::trigger_accrue(arg1, arg2, arg3);
        };
    }

    // decompiled from Move bytecode v7
}

