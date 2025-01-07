module 0x6b110dd5431735d62444bb617822067e0fe5fbc0fdcba8f26e52270015254a9b::self_trading {
    public entry fun trade<T0, T1>(arg0: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg1: &mut 0x6a93eb91e12983d073c1b6755d3d40e21bb59e3aca45e425d26fd9c804b83ee5::super_account::Treasury, arg2: u64, arg3: u64, arg4: u8, arg5: u8, arg6: &0x2::clock::Clock, arg7: &0xdee9::custodian_v2::AccountCap, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xdee9::clob_v2::get_market_price<T0, T1>(arg0);
        let v2 = v1;
        let v3 = v0;
        assert!(0x1::option::is_some<u64>(&v3) && 0x1::option::is_some<u64>(&v2), 404);
        let v4 = 0x1::option::destroy_some<u64>(v2);
        let (v5, v6) = 0xdee9::clob_v2::place_market_order<T0, T1>(arg0, arg7, arg2, arg3, true, 0x2::coin::zero<T0>(arg8), 0x6a93eb91e12983d073c1b6755d3d40e21bb59e3aca45e425d26fd9c804b83ee5::super_account::withdraw<T1>(arg1, (arg3 * v4 + arg3 * v4 * 2 / 100) / 1000000000, arg8), arg6, arg8);
        0x6a93eb91e12983d073c1b6755d3d40e21bb59e3aca45e425d26fd9c804b83ee5::super_account::deposit<T0>(arg1, v5);
        0x6a93eb91e12983d073c1b6755d3d40e21bb59e3aca45e425d26fd9c804b83ee5::super_account::deposit<T1>(arg1, v6);
    }

    // decompiled from Move bytecode v6
}

