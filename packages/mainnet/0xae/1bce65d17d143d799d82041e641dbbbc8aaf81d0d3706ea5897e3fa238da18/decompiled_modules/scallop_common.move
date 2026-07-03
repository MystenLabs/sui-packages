module 0xae1bce65d17d143d799d82041e641dbbbc8aaf81d0d3706ea5897e3fa238da18::scallop_common {
    public(friend) fun select_scoin_withdraw_amount<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg1: u128, arg2: u64) : u64 {
        let (v0, v1) = 0xae1bce65d17d143d799d82041e641dbbbc8aaf81d0d3706ea5897e3fa238da18::scallop_adapter::get_exchange_rate<T0>(arg0);
        0xae1bce65d17d143d799d82041e641dbbbc8aaf81d0d3706ea5897e3fa238da18::scallop_adapter::select_scoin_withdraw_amount(arg1, arg2, v0, v1, 0xae1bce65d17d143d799d82041e641dbbbc8aaf81d0d3706ea5897e3fa238da18::scallop_adapter::get_available_liquidity<T0>(arg0))
    }

    public(friend) fun query_underlying_from_scoin_amount<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg1: u64) : u128 {
        0xae1bce65d17d143d799d82041e641dbbbc8aaf81d0d3706ea5897e3fa238da18::scallop_adapter::get_underlying_balance<T0>(arg0, arg1)
    }

    public(friend) fun trigger_accrue_if_needed<T0, T1>(arg0: &0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_pool::LLVPool<T0, T1>, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0x2::clock::Clock) {
        if (0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_pool::should_trigger_accrue<T0, T1>(arg0, 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_allocation_plan::PROTOCOL_SCALLOP(), arg3)) {
            0xae1bce65d17d143d799d82041e641dbbbc8aaf81d0d3706ea5897e3fa238da18::scallop_adapter::trigger_accrue(arg1, arg2, arg3);
        };
    }

    // decompiled from Move bytecode v7
}

