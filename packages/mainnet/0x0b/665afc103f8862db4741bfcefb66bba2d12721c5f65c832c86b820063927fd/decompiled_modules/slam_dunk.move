module 0xb665afc103f8862db4741bfcefb66bba2d12721c5f65c832c86b820063927fd::slam_dunk {
    fun destroy_account_cap<T0, T1>(arg0: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg1: 0xdee9::custodian_v2::AccountCap, arg2: &mut 0x6a93eb91e12983d073c1b6755d3d40e21bb59e3aca45e425d26fd9c804b83ee5::super_account::Treasury, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, _, v2, _) = 0xdee9::clob_v2::account_balance<T0, T1>(arg0, &arg1);
        if (v2 > 0) {
            0x6a93eb91e12983d073c1b6755d3d40e21bb59e3aca45e425d26fd9c804b83ee5::super_account::deposit<T1>(arg2, 0xdee9::clob_v2::withdraw_quote<T0, T1>(arg0, v2, &arg1, arg3));
        };
        if (v0 > 0) {
            0x6a93eb91e12983d073c1b6755d3d40e21bb59e3aca45e425d26fd9c804b83ee5::super_account::deposit<T0>(arg2, 0xdee9::clob_v2::withdraw_base<T0, T1>(arg0, v0, &arg1, arg3));
        };
        0xdee9::custodian_v2::delete_account_cap(arg1);
    }

    public entry fun trade<T0, T1>(arg0: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg1: &mut 0x6a93eb91e12983d073c1b6755d3d40e21bb59e3aca45e425d26fd9c804b83ee5::super_account::Treasury, arg2: u64, arg3: u64, arg4: u8, arg5: u8, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xdee9::clob_v2::get_market_price<T0, T1>(arg0);
        let v2 = v1;
        let v3 = v0;
        assert!(0x1::option::is_some<u64>(&v3) && 0x1::option::is_some<u64>(&v2), 404);
        let v4 = 0x1::option::destroy_some<u64>(v2);
        let v5 = 0xdee9::clob_v2::tick_size<T0, T1>(arg0);
        assert!(v4 - 0x1::option::destroy_some<u64>(v3) > v5, 408);
        let v6 = v4 - v5;
        let v7 = 0xdee9::clob_v2::create_account(arg7);
        0xdee9::clob_v2::deposit_base<T0, T1>(arg0, 0x6a93eb91e12983d073c1b6755d3d40e21bb59e3aca45e425d26fd9c804b83ee5::super_account::withdraw<T0>(arg1, arg3, arg7), &mut v7);
        let (_, _, _, _) = 0xdee9::clob_v2::place_limit_order<T0, T1>(arg0, arg2, v6, arg3, arg4, false, 0x2::clock::timestamp_ms(arg6) + 1000, arg5, arg6, &v7, arg7);
        let v12 = 0xdee9::clob_v2::create_account(arg7);
        let (v13, v14) = 0xdee9::clob_v2::place_market_order<T0, T1>(arg0, &v12, arg2, arg3, true, 0x2::coin::zero<T0>(arg7), 0x6a93eb91e12983d073c1b6755d3d40e21bb59e3aca45e425d26fd9c804b83ee5::super_account::withdraw<T1>(arg1, (arg3 * v6 + arg3 * v6 * 2 / 100) / 1000000000, arg7), arg6, arg7);
        0x6a93eb91e12983d073c1b6755d3d40e21bb59e3aca45e425d26fd9c804b83ee5::super_account::deposit<T0>(arg1, v13);
        0x6a93eb91e12983d073c1b6755d3d40e21bb59e3aca45e425d26fd9c804b83ee5::super_account::deposit<T1>(arg1, v14);
        destroy_account_cap<T0, T1>(arg0, v7, arg1, arg7);
        destroy_account_cap<T0, T1>(arg0, v12, arg1, arg7);
    }

    // decompiled from Move bytecode v6
}

