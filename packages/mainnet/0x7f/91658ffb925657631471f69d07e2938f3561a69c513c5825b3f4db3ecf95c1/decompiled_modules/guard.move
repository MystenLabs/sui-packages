module 0x7f91658ffb925657631471f69d07e2938f3561a69c513c5825b3f4db3ecf95c1::guard {
    struct ProfitGuardPassed<phantom T0> has copy, drop {
        amount: u64,
        min_amount: u64,
    }

    public fun assert_min_profit<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        let v0 = 0x2::coin::value<T0>(arg0);
        assert!(v0 >= arg1, 0);
        let v1 = ProfitGuardPassed<T0>{
            amount     : v0,
            min_amount : arg1,
        };
        0x2::event::emit<ProfitGuardPassed<T0>>(v1);
    }

    // decompiled from Move bytecode v7
}

