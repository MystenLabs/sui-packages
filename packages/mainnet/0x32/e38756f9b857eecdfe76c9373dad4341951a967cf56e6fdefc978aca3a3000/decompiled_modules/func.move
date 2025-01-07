module 0x32e38756f9b857eecdfe76c9373dad4341951a967cf56e6fdefc978aca3a3000::func {
    struct TestEvent has copy, drop {
        value: u64,
    }

    public fun get_rate_by_epoch(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &0x2::object::ID, arg2: u64) {
        let v0 = 0x2::table::borrow<u64, 0x3::staking_pool::PoolTokenExchangeRate>(0x3::sui_system::pool_exchange_rates(arg0, arg1), arg2);
        let v1 = TestEvent{value: 0x3::staking_pool::pool_token_amount(v0)};
        0x2::event::emit<TestEvent>(v1);
        let v2 = TestEvent{value: 0x3::staking_pool::sui_amount(v0)};
        0x2::event::emit<TestEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

