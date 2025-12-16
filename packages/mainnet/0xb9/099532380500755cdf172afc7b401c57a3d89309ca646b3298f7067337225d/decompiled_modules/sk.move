module 0xb9099532380500755cdf172afc7b401c57a3d89309ca646b3298f7067337225d::sk {
    fun ioh(arg0: &0x8c36ea167c5e6da8c3d60b4fc897416105dcb986471bd81cfbfd38720a4487c0::oracle::OracleConfig, arg1: &0x8c36ea167c5e6da8c3d60b4fc897416105dcb986471bd81cfbfd38720a4487c0::oracle::OracleConfig, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x2::clock::Clock) : 0x8c36ea167c5e6da8c3d60b4fc897416105dcb986471bd81cfbfd38720a4487c0::oracle::OracleHolder {
        let v0 = 0x8c36ea167c5e6da8c3d60b4fc897416105dcb986471bd81cfbfd38720a4487c0::oracle::new_holder();
        0x8c36ea167c5e6da8c3d60b4fc897416105dcb986471bd81cfbfd38720a4487c0::pyth::get_price(arg0, &mut v0, arg2, arg4);
        0x8c36ea167c5e6da8c3d60b4fc897416105dcb986471bd81cfbfd38720a4487c0::pyth::get_price(arg1, &mut v0, arg3, arg4);
        v0
    }

    public fun sxy<T0, T1, T2>(arg0: &mut 0x4142285db093ba0cf0623b3cbc07372fb4f5ed00af1fb62be6d55f49a42c0b0e::pool_v1::Pool<T0, T1, T2>, arg1: &0x8c36ea167c5e6da8c3d60b4fc897416105dcb986471bd81cfbfd38720a4487c0::oracle::OracleConfig, arg2: &0x8c36ea167c5e6da8c3d60b4fc897416105dcb986471bd81cfbfd38720a4487c0::oracle::OracleConfig, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: 0x2::coin::Coin<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = ioh(arg1, arg2, arg3, arg4, arg6);
        0x4142285db093ba0cf0623b3cbc07372fb4f5ed00af1fb62be6d55f49a42c0b0e::pool_v1::swap_x_to_y<T0, T1, T2>(arg0, &v0, arg5, 0, arg7)
    }

    public fun syx<T0, T1, T2>(arg0: &mut 0x4142285db093ba0cf0623b3cbc07372fb4f5ed00af1fb62be6d55f49a42c0b0e::pool_v1::Pool<T0, T1, T2>, arg1: &0x8c36ea167c5e6da8c3d60b4fc897416105dcb986471bd81cfbfd38720a4487c0::oracle::OracleConfig, arg2: &0x8c36ea167c5e6da8c3d60b4fc897416105dcb986471bd81cfbfd38720a4487c0::oracle::OracleConfig, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: 0x2::coin::Coin<T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = ioh(arg1, arg2, arg3, arg4, arg6);
        0x4142285db093ba0cf0623b3cbc07372fb4f5ed00af1fb62be6d55f49a42c0b0e::pool_v1::swap_y_to_x<T0, T1, T2>(arg0, &v0, arg5, 0, arg7)
    }

    // decompiled from Move bytecode v6
}

