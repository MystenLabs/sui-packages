module 0xd88ebdabeaead893d6ce24259bf596627ff4d209b9e1541c2eb7997fa90651d2::slippage {
    struct HopSwapEvent<phantom T0, phantom T1> has copy, drop {
        amount_in: u64,
        amount_out: u64,
    }

    public fun check_slippage<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 1);
    }

    public fun check_slippage_v2<T0, T1>(arg0: &0x2::coin::Coin<T1>, arg1: u64, arg2: u64) {
        check_slippage<T1>(arg0, arg1);
        let v0 = HopSwapEvent<T0, T1>{
            amount_in  : arg2,
            amount_out : 0x2::coin::value<T1>(arg0),
        };
        0x2::event::emit<HopSwapEvent<T0, T1>>(v0);
    }

    // decompiled from Move bytecode v6
}

