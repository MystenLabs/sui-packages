module 0xa09f1a1d4930f10bf96a02cac1ac5cfa122ab8912cc6a940f3aba7b24f3e8aa::curves {
    public fun calculate_add_liquidity_cost(arg0: u64, arg1: u64, arg2: u64) : 0x1::option::Option<u64> {
        let v0 = (arg0 as u256);
        let v1 = (arg1 as u256);
        let v2 = v1 - (arg2 as u256);
        assert!(v2 > 0, 100);
        0x1::u256::try_as_u64(v0 * v1 / v2 - v0)
    }

    public fun calculate_remove_liquidity_return(arg0: u64, arg1: u64, arg2: u64) : 0x1::option::Option<u64> {
        let v0 = (arg0 as u256);
        let v1 = (arg1 as u256);
        0x1::u256::try_as_u64(v1 - v0 * v1 / (v0 + (arg2 as u256)))
    }

    public fun calculate_token_amount_received(arg0: u64, arg1: u64, arg2: u64) : 0x1::option::Option<u64> {
        let v0 = (arg0 as u256);
        let v1 = (arg1 as u256);
        0x1::u256::try_as_u64(v1 - v0 * v1 / (v0 + (arg2 as u256)))
    }

    // decompiled from Move bytecode v6
}

