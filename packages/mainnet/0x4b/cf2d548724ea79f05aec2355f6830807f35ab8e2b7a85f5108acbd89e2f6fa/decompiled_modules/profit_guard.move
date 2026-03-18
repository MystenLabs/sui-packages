module 0x4bcf2d548724ea79f05aec2355f6830807f35ab8e2b7a85f5108acbd89e2f6fa::profit_guard {
    struct ArbExecuted has copy, drop {
        start_amount: u64,
        end_amount: u64,
        profit: u64,
        gas_estimate: u64,
    }

    public fun assert_min_value<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 57005);
    }

    public fun emit_arb_result(arg0: u64, arg1: u64, arg2: u64) {
        let v0 = ArbExecuted{
            start_amount : arg0,
            end_amount   : arg1,
            profit       : arg1 - arg0,
            gas_estimate : arg2,
        };
        0x2::event::emit<ArbExecuted>(v0);
    }

    // decompiled from Move bytecode v6
}

