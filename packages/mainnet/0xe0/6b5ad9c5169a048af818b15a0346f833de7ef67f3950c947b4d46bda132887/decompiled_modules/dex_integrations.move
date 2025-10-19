module 0xe06b5ad9c5169a048af818b15a0346f833de7ef67f3950c947b4d46bda132887::dex_integrations {
    public fun calculate_min_output(arg0: u64, arg1: u64) : u64 {
        arg0 - arg0 * arg1 / 10000
    }

    public fun estimate_price_impact(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = arg0 * arg3 / (arg2 + arg0);
        if (arg1 >= v0) {
            0
        } else {
            (v0 - arg1) * 10000 / v0
        }
    }

    public fun swap_aftermath<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x2::coin::value<T0>(&arg0) > 0, 1);
        abort 2
    }

    public fun swap_bluefin<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x2::coin::value<T0>(&arg0) > 0, 1);
        abort 2
    }

    public fun swap_cetus<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x2::coin::value<T0>(&arg0) > 0, 1);
        abort 2
    }

    public fun swap_kriya<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x2::coin::value<T0>(&arg0) > 0, 1);
        abort 2
    }

    public fun swap_turbos<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x2::coin::value<T0>(&arg0) > 0, 1);
        abort 2
    }

    // decompiled from Move bytecode v6
}

