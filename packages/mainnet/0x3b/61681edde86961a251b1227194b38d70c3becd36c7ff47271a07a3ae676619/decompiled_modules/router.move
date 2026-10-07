module 0x3b61681edde86961a251b1227194b38d70c3becd36c7ff47271a07a3ae676619::router {
    public fun liquidate_a_to_b<T0, T1>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: u64, arg8: u64, arg9: u128, arg10: u64, arg11: u64, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x3b61681edde86961a251b1227194b38d70c3becd36c7ff47271a07a3ae676619::settlement::assert_deadline(0x2::clock::timestamp_ms(arg13), arg12);
        0x3b61681edde86961a251b1227194b38d70c3becd36c7ff47271a07a3ae676619::guard::assert_debt_at_least<T1>(arg1, arg8);
        assert!(arg7 > 0 && arg11 > 0, 3);
        let (v0, v1) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::flash_loan::borrow_flash_loan<T1>(arg0, arg2, arg7, arg14);
        let v2 = v1;
        let v3 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::flash_loan_loan_amount<T1>(&v2) + 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::flash_loan_fee<T1>(&v2);
        assert!(v3 <= arg10, 1);
        let (v4, v5) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T1, T0>(arg0, arg1, arg2, v0, arg3, arg4, arg13, arg14);
        let v6 = v5;
        let (v7, v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg5, arg6, true, true, 0x2::coin::value<T0>(&v6), arg9, arg13);
        let v10 = v9;
        let (v11, v12) = 0x3b61681edde86961a251b1227194b38d70c3becd36c7ff47271a07a3ae676619::swap_payment::split<T0>(0x2::coin::into_balance<T0>(v6), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v10));
        let v13 = v12;
        0x2::balance::destroy_zero<T0>(v7);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg5, arg6, v11, 0x2::balance::zero<T1>(), v10);
        let (v14, v15) = 0x3b61681edde86961a251b1227194b38d70c3becd36c7ff47271a07a3ae676619::settlement::settle<T1>(v4, 0x2::coin::from_balance<T1>(v8, arg14), v3, arg10, arg11, arg14);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::flash_loan::repay_flash_loan<T1>(arg0, arg2, v14, v2, arg14);
        if (0x2::balance::value<T0>(&v13) == 0) {
            0x2::balance::destroy_zero<T0>(v13);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v13, arg14), 0x2::tx_context::sender(arg14));
        };
        v15
    }

    // decompiled from Move bytecode v7
}

