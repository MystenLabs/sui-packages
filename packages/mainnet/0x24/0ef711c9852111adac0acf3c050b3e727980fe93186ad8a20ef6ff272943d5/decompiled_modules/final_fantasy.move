module 0x240ef711c9852111adac0acf3c050b3e727980fe93186ad8a20ef6ff272943d5::final_fantasy {
    fun destroy_account_cap<T0, T1>(arg0: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg1: 0xdee9::custodian_v2::AccountCap, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, _, v2, _) = 0xdee9::clob_v2::account_balance<T0, T1>(arg0, &arg1);
        let v4 = if (v2 > 0) {
            0xdee9::clob_v2::withdraw_quote<T0, T1>(arg0, v2, &arg1, arg2)
        } else {
            0x2::coin::zero<T1>(arg2)
        };
        let v5 = if (v0 > 0) {
            0xdee9::clob_v2::withdraw_base<T0, T1>(arg0, v0, &arg1, arg2)
        } else {
            0x2::coin::zero<T0>(arg2)
        };
        0xdee9::custodian_v2::delete_account_cap(arg1);
        (v5, v4)
    }

    public entry fun trade<T0, T1>(arg0: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: u64, arg4: u64, arg5: u8, arg6: u8, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xdee9::clob_v2::get_market_price<T0, T1>(arg0);
        let v2 = v1;
        let v3 = v0;
        assert!(0x1::option::is_some<u64>(&v3) && 0x1::option::is_some<u64>(&v2), 404);
        let v4 = 0x1::option::destroy_some<u64>(v2);
        let v5 = 0xdee9::clob_v2::tick_size<T0, T1>(arg0);
        assert!(v4 - 0x1::option::destroy_some<u64>(v3) > v5, 408);
        let v6 = v4 - v5;
        let v7 = 0xdee9::clob_v2::create_account(arg8);
        let (v8, v9) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::flash_loan::borrow_flash_loan<T0>(arg2, arg1, arg4, arg8);
        0xdee9::clob_v2::deposit_base<T0, T1>(arg0, v8, &mut v7);
        let (_, _, _, _) = 0xdee9::clob_v2::place_limit_order<T0, T1>(arg0, arg3, v6, arg4, arg5, false, 0x2::clock::timestamp_ms(arg7) + 1000, arg6, arg7, &v7, arg8);
        let (v14, v15) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::flash_loan::borrow_flash_loan<T1>(arg2, arg1, (arg4 * v6 + arg4 * v6 * 2 / 100) / 1000000000, arg8);
        let v16 = 0xdee9::clob_v2::create_account(arg8);
        let (v17, v18) = 0xdee9::clob_v2::place_market_order<T0, T1>(arg0, &v16, arg3, arg4, true, 0x2::coin::zero<T0>(arg8), v14, arg7, arg8);
        let v19 = v18;
        let v20 = v17;
        let (v21, v22) = destroy_account_cap<T0, T1>(arg0, v7, arg8);
        0x2::coin::join<T0>(&mut v20, v21);
        0x2::coin::join<T1>(&mut v19, v22);
        let (v23, v24) = destroy_account_cap<T0, T1>(arg0, v16, arg8);
        0x2::coin::join<T0>(&mut v20, v23);
        0x2::coin::join<T1>(&mut v19, v24);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::flash_loan::repay_flash_loan<T0>(arg2, arg1, v20, v9, arg8);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::flash_loan::repay_flash_loan<T1>(arg2, arg1, v19, v15, arg8);
    }

    // decompiled from Move bytecode v6
}

