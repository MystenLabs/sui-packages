module 0xc97c77d00e9178f9eecab82583d82b8bfaddec0a2e8309853a3c011f8ae75090::l {
    fun dispose_residue<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, @0x30e0784ba08efa30b34f32638aea14b00b2e52136729c1780d7aea65d001f738);
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    public fun scl<T0, T1>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: 0x2::balance::Balance<T0>, arg4: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let (v0, v1) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T0, T1>(arg0, arg1, arg2, 0x2::coin::from_balance<T0>(arg3, arg7), arg4, arg5, arg6, arg7);
        dispose_residue<T0>(v0, arg7);
        0x2::coin::into_balance<T1>(v1)
    }

    // decompiled from Move bytecode v6
}

