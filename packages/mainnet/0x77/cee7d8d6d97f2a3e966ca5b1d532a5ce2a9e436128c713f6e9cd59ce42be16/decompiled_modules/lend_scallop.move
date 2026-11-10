module 0xad68f9ed18db8c69c48343d33a7e7e528ddb1d05fcd03786e50cdc44597470fe::lend_scallop {
    public fun liquidate<T0, T1>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: 0x2::balance::Balance<T0>, arg4: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let (v0, v1) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T0, T1>(arg0, arg1, arg2, 0x2::coin::from_balance<T0>(arg3, arg7), arg4, arg5, arg6, arg7);
        0xad68f9ed18db8c69c48343d33a7e7e528ddb1d05fcd03786e50cdc44597470fe::sweep::coin_to_bank<T0>(v0);
        0x2::coin::into_balance<T1>(v1)
    }

    // decompiled from Move bytecode v7
}

