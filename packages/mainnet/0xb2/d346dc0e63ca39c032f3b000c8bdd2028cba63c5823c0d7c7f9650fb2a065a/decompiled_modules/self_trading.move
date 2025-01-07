module 0xb2d346dc0e63ca39c032f3b000c8bdd2028cba63c5823c0d7c7f9650fb2a065a::self_trading {
    public entry fun trade<T0, T1>(arg0: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg1: &mut 0x6a93eb91e12983d073c1b6755d3d40e21bb59e3aca45e425d26fd9c804b83ee5::super_account::Treasury, arg2: u64, arg3: u64, arg4: u8, arg5: u8, arg6: &0x2::clock::Clock, arg7: &0xdee9::custodian_v2::AccountCap, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xdee9::clob_v2::get_market_price<T0, T1>(arg0);
        let v2 = v1;
        let v3 = v0;
        assert!(0x1::option::is_some<u64>(&v3) && 0x1::option::is_some<u64>(&v2), 404);
        0xdee9::clob_v2::deposit_base<T0, T1>(arg0, 0x6a93eb91e12983d073c1b6755d3d40e21bb59e3aca45e425d26fd9c804b83ee5::super_account::withdraw<T0>(arg1, arg3, arg8), arg7);
        let (_, _, _, _) = 0xdee9::clob_v2::place_limit_order<T0, T1>(arg0, arg2, 0x1::option::destroy_some<u64>(v2) - 0xdee9::clob_v2::tick_size<T0, T1>(arg0), arg3, arg4, false, 0x2::clock::timestamp_ms(arg6) + 1000, arg5, arg6, arg7, arg8);
    }

    // decompiled from Move bytecode v6
}

