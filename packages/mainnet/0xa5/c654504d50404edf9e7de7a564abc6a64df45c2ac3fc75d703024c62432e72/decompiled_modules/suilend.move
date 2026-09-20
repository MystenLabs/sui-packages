module 0xa5c654504d50404edf9e7de7a564abc6a64df45c2ac3fc75d703024c62432e72::suilend {
    public fun liquidate_flash_loan_repay_withdraw<T0, T1, T2>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg8: &mut 0x3::sui_system::SuiSystemState, arg9: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg10: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg11: u64, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(arg11 > 0, 0xa5c654504d50404edf9e7de7a564abc6a64df45c2ac3fc75d703024c62432e72::errors::repay_zero());
        let (v0, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_loan_with_ctx_v2<T1>(arg6, arg7, arg11, arg8, arg13);
        let v2 = 0x2::coin::from_balance<T1>(v0, arg13);
        let (v3, v4) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, &mut v2, arg13);
        let v5 = 0x2::coin::into_balance<T2>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<T0, T2>(arg0, arg3, arg4, v3, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T2>>(v4), arg13));
        let v6 = 0x2::coin::into_balance<T1>(v2);
        let v7 = arg11 - 0x2::balance::value<T1>(&v6);
        if (v7 > 0) {
            let (v8, v9) = 0xa5c654504d50404edf9e7de7a564abc6a64df45c2ac3fc75d703024c62432e72::swap::borrow_exact_a<T1, T2>(arg9, arg10, v7, arg4);
            let v10 = v9;
            let v11 = 0xa5c654504d50404edf9e7de7a564abc6a64df45c2ac3fc75d703024c62432e72::swap::pay_amount<T1, T2>(&v10);
            assert!(0x2::balance::value<T2>(&v5) >= v11, 0xa5c654504d50404edf9e7de7a564abc6a64df45c2ac3fc75d703024c62432e72::errors::not_enough_seized());
            0xa5c654504d50404edf9e7de7a564abc6a64df45c2ac3fc75d703024c62432e72::swap::repay_with_b<T1, T2>(arg9, arg10, 0x2::balance::split<T2>(&mut v5, v11), v10);
            0x2::balance::join<T1>(&mut v6, v8);
        };
        assert!(0x2::balance::value<T2>(&v5) >= arg12, 0xa5c654504d50404edf9e7de7a564abc6a64df45c2ac3fc75d703024c62432e72::errors::net_below_min());
        let v12 = 0x2::tx_context::sender(arg13);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v5, arg13), v12);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_repay_with_ctx<T1>(arg4, arg5, arg7, v1, v6, arg13), arg13), v12);
    }

    public fun liquidate_flash_loan_withdraw_repay<T0, T1, T2>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg8: &mut 0x3::sui_system::SuiSystemState, arg9: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg10: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg11: u64, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(arg11 > 0, 0xa5c654504d50404edf9e7de7a564abc6a64df45c2ac3fc75d703024c62432e72::errors::repay_zero());
        let (v0, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_loan_with_ctx_v2<T1>(arg6, arg7, arg11, arg8, arg13);
        let v2 = 0x2::coin::from_balance<T1>(v0, arg13);
        let (v3, v4) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, &mut v2, arg13);
        let v5 = 0x2::coin::into_balance<T2>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<T0, T2>(arg0, arg3, arg4, v3, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T2>>(v4), arg13));
        let v6 = 0x2::coin::into_balance<T1>(v2);
        let v7 = arg11 - 0x2::balance::value<T1>(&v6);
        if (v7 > 0) {
            let (v8, v9) = 0xa5c654504d50404edf9e7de7a564abc6a64df45c2ac3fc75d703024c62432e72::swap::borrow_exact_b<T2, T1>(arg9, arg10, v7, arg4);
            let v10 = v9;
            let v11 = 0xa5c654504d50404edf9e7de7a564abc6a64df45c2ac3fc75d703024c62432e72::swap::pay_amount<T2, T1>(&v10);
            assert!(0x2::balance::value<T2>(&v5) >= v11, 0xa5c654504d50404edf9e7de7a564abc6a64df45c2ac3fc75d703024c62432e72::errors::not_enough_seized());
            0xa5c654504d50404edf9e7de7a564abc6a64df45c2ac3fc75d703024c62432e72::swap::repay_with_a<T2, T1>(arg9, arg10, 0x2::balance::split<T2>(&mut v5, v11), v10);
            0x2::balance::join<T1>(&mut v6, v8);
        };
        assert!(0x2::balance::value<T2>(&v5) >= arg12, 0xa5c654504d50404edf9e7de7a564abc6a64df45c2ac3fc75d703024c62432e72::errors::net_below_min());
        let v12 = 0x2::tx_context::sender(arg13);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v5, arg13), v12);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_repay_with_ctx<T1>(arg4, arg5, arg7, v1, v6, arg13), arg13), v12);
    }

    public fun refresh_reserve<T0>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject) {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price_pro_compatible<T0>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

