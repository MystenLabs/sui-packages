module 0x2c095db284a103869d08376ca600d4d0ecd0f1ed4ec59eed966d5c419d165238::slippage {
    struct SwapEvent<phantom T0, phantom T1> has copy, drop {
        amount_in: u64,
        amount_out: u64,
        min_amount_out: u64,
        referral_code: u64,
    }

    public fun check_slippage_v2<T0, T1>(arg0: &0x2::coin::Coin<T1>, arg1: u64, arg2: u64, arg3: u64) {
        assert!(0x2::coin::value<T1>(arg0) >= arg1, arg1);
        let v0 = SwapEvent<T0, T1>{
            amount_in      : arg2,
            amount_out     : 0x2::coin::value<T1>(arg0),
            min_amount_out : arg1,
            referral_code  : arg3,
        };
        0x2::event::emit<SwapEvent<T0, T1>>(v0);
    }

    // decompiled from Move bytecode v6
}

