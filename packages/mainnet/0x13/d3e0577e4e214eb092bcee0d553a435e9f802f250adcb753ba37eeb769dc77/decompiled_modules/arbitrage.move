module 0x13d3e0577e4e214eb092bcee0d553a435e9f802f250adcb753ba37eeb769dc77::arbitrage {
    struct ProfitCheck {
        expected_min: u64,
    }

    public fun end_arb<T0>(arg0: ProfitCheck, arg1: &0x2::coin::Coin<T0>) {
        let ProfitCheck { expected_min: v0 } = arg0;
        assert!(0x2::coin::value<T0>(arg1) >= v0, 1337);
    }

    public fun start_arb(arg0: u64) : ProfitCheck {
        ProfitCheck{expected_min: arg0}
    }

    // decompiled from Move bytecode v7
}

