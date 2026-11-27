module 0x3e390b9922e0054df06bfec326bc6f0a957ba735e197a59768ed5696152eaff8::guard {
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

