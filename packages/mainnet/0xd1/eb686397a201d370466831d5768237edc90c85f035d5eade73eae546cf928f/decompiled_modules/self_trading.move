module 0xd1eb686397a201d370466831d5768237edc90c85f035d5eade73eae546cf928f::self_trading {
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
        let v4 = 0x1::option::destroy_some<u64>(v2) - 0xdee9::clob_v2::tick_size<T0, T1>(arg0);
        let v5 = 0xdee9::clob_v2::create_account(arg7);
        0xdee9::clob_v2::deposit_base<T0, T1>(arg0, 0x6a93eb91e12983d073c1b6755d3d40e21bb59e3aca45e425d26fd9c804b83ee5::super_account::withdraw<T0>(arg1, arg3, arg7), &mut v5);
        let (_, _, _, _) = 0xdee9::clob_v2::place_limit_order<T0, T1>(arg0, arg2, v4, arg3, arg4, false, 0x2::clock::timestamp_ms(arg6) + 1000, arg5, arg6, &v5, arg7);
        let v10 = 0xdee9::clob_v2::create_account(arg7);
        let (v11, v12) = 0xdee9::clob_v2::place_market_order<T0, T1>(arg0, &v10, arg2, arg3, true, 0x2::coin::zero<T0>(arg7), 0x6a93eb91e12983d073c1b6755d3d40e21bb59e3aca45e425d26fd9c804b83ee5::super_account::withdraw<T1>(arg1, (arg3 * v4 + arg3 * v4 * 2 / 100) / 1000000000, arg7), arg6, arg7);
        0x6a93eb91e12983d073c1b6755d3d40e21bb59e3aca45e425d26fd9c804b83ee5::super_account::deposit<T0>(arg1, v11);
        0x6a93eb91e12983d073c1b6755d3d40e21bb59e3aca45e425d26fd9c804b83ee5::super_account::deposit<T1>(arg1, v12);
        destroy_account_cap<T0, T1>(arg0, v5, arg1, arg7);
        destroy_account_cap<T0, T1>(arg0, v10, arg1, arg7);
    }

    // decompiled from Move bytecode v6
}

