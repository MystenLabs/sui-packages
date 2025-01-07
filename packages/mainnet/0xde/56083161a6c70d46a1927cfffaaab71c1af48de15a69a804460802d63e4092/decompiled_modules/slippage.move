module 0xde56083161a6c70d46a1927cfffaaab71c1af48de15a69a804460802d63e4092::slippage {
    struct SwapEvent<phantom T0, phantom T1> has copy, drop {
        amount_in: u64,
        amount_out: u64,
        referral_code: u64,
    }

    public fun check_slippage_v2<T0, T1>(arg0: &0x2::coin::Coin<T1>, arg1: u64, arg2: u64, arg3: u64) {
        assert!(0x2::coin::value<T1>(arg0) >= arg1, 10001);
        let v0 = SwapEvent<T0, T1>{
            amount_in     : arg2,
            amount_out    : 0x2::coin::value<T1>(arg0),
            referral_code : arg3,
        };
        0x2::event::emit<SwapEvent<T0, T1>>(v0);
    }

    // decompiled from Move bytecode v6
}

