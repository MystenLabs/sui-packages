module 0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::breaker {
    public fun funding_bank<T0, T1>(arg0: &0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::manage::ACL, arg1: &0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::core::Setting, arg2: &mut 0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::core::Bank<T0, T1>, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::manage::is_breaker(arg0, 0x2::tx_context::sender(arg4)), 1);
        0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::core::assert_version(arg1);
        0xd5b301aae5f5bbd01d7cc067efd1ea27f566aaa2f62e504aac60dd0062ebfd97::core::funding_bank<T0, T1>(arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

