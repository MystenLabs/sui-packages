module 0x9061b55fb56339c06e1fa7da1c24c78e65b7b0abbe0d33477b483a4190d0954::self_trading {
    public entry fun trade<T0, T1>(arg0: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg1: &mut 0x6a93eb91e12983d073c1b6755d3d40e21bb59e3aca45e425d26fd9c804b83ee5::super_account::Treasury, arg2: u64, arg3: u64, arg4: u8, arg5: u8, arg6: &0x2::clock::Clock, arg7: &0xdee9::custodian_v2::AccountCap, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xdee9::clob_v2::get_market_price<T0, T1>(arg0);
        let v2 = v1;
        let v3 = v0;
        assert!(0x1::option::is_some<u64>(&v3) && 0x1::option::is_some<u64>(&v2), 404);
        let v4 = 0x1::option::destroy_some<u64>(v2) - 0xdee9::clob_v2::tick_size<T0, T1>(arg0);
        let v5 = false;
        0xdee9::clob_v2::deposit_base<T0, T1>(arg0, 0x6a93eb91e12983d073c1b6755d3d40e21bb59e3aca45e425d26fd9c804b83ee5::super_account::withdraw<T0>(arg1, arg3, arg8), arg7);
        let (_, _, _, _) = 0xdee9::clob_v2::place_limit_order<T0, T1>(arg0, arg2, v4, arg3, arg4, v5, 0x2::clock::timestamp_ms(arg6) + 1000, arg5, arg6, arg7, arg8);
        let (v10, v11) = 0xdee9::clob_v2::place_market_order<T0, T1>(arg0, arg7, arg2, arg3, v5, 0x2::coin::zero<T0>(arg8), 0x6a93eb91e12983d073c1b6755d3d40e21bb59e3aca45e425d26fd9c804b83ee5::super_account::withdraw<T1>(arg1, arg3 * v4 + arg3 * v4 * 2 / 100, arg8), arg6, arg8);
        0x6a93eb91e12983d073c1b6755d3d40e21bb59e3aca45e425d26fd9c804b83ee5::super_account::deposit<T0>(arg1, v10);
        0x6a93eb91e12983d073c1b6755d3d40e21bb59e3aca45e425d26fd9c804b83ee5::super_account::deposit<T1>(arg1, v11);
        let (v12, _, v14, _) = 0xdee9::clob_v2::account_balance<T0, T1>(arg0, arg7);
        0x6a93eb91e12983d073c1b6755d3d40e21bb59e3aca45e425d26fd9c804b83ee5::super_account::deposit<T1>(arg1, 0xdee9::clob_v2::withdraw_quote<T0, T1>(arg0, v14, arg7, arg8));
        0x6a93eb91e12983d073c1b6755d3d40e21bb59e3aca45e425d26fd9c804b83ee5::super_account::deposit<T0>(arg1, 0xdee9::clob_v2::withdraw_base<T0, T1>(arg0, v12, arg7, arg8));
    }

    // decompiled from Move bytecode v6
}

