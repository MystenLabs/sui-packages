module 0x938308710e9b789e0e36b8b335c821abe778caf06dc5178f95492a9233ac53df::sl {
    fun finish<T0>(arg0: 0x2::balance::Balance<0x2::sui::SUI>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0) >= arg2, 2);
        send_or_destroy<0x2::sui::SUI>(arg0, arg3);
        send_or_destroy<T0>(0x2::coin::into_balance<T0>(arg1), arg3);
    }

    public fun liq_sui_1p<T0, T1>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, T1>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg7 > 0, 3);
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<0x2::sui::SUI, T1>(arg2, true, false, arg7, 4295048017, arg9, arg1, arg10);
        let v3 = v2;
        let v4 = 0x2::coin::from_balance<T1>(v1, arg10);
        let v5 = &mut v4;
        let v6 = seize_sui<T0, T1>(arg0, arg4, arg5, arg6, arg9, v5, arg3, arg10);
        let (v7, _) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v3);
        let v9 = 0x2::coin::into_balance<0x2::sui::SUI>(v6);
        0x2::balance::join<0x2::sui::SUI>(&mut v9, v0);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v9) >= v7, 1);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<0x2::sui::SUI, T1>(arg2, v3, 0x2::balance::split<0x2::sui::SUI>(&mut v9, v7), 0x2::balance::zero<T1>(), arg1, arg10);
        finish<T1>(v9, v4, arg8, arg10);
    }

    public fun liq_sui_1p_r<T0, T1>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, 0x2::sui::SUI>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg7 > 0, 3);
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T1, 0x2::sui::SUI>(arg2, false, false, arg7, 79226673515401279992447579055, arg9, arg1, arg10);
        let v3 = v2;
        let v4 = 0x2::coin::from_balance<T1>(v0, arg10);
        let v5 = &mut v4;
        let v6 = seize_sui<T0, T1>(arg0, arg4, arg5, arg6, arg9, v5, arg3, arg10);
        let (_, v8) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v3);
        let v9 = 0x2::coin::into_balance<0x2::sui::SUI>(v6);
        0x2::balance::join<0x2::sui::SUI>(&mut v9, v1);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v9) >= v8, 1);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T1, 0x2::sui::SUI>(arg2, v3, 0x2::balance::zero<T1>(), 0x2::balance::split<0x2::sui::SUI>(&mut v9, v8), arg1, arg10);
        finish<T1>(v9, v4, arg8, arg10);
    }

    public fun liq_sui_2p<T0, T1, T2>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T2>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, T2>, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg8 > 0, 3);
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T1, T2>(arg2, false, false, arg8, 79226673515401279992447579055, arg10, arg1, arg11);
        let v3 = v2;
        let v4 = 0x2::coin::from_balance<T1>(v0, arg11);
        let v5 = &mut v4;
        let v6 = seize_sui<T0, T1>(arg0, arg5, arg6, arg7, arg10, v5, arg4, arg11);
        let (_, v8) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v3);
        let (v9, v10, v11) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<0x2::sui::SUI, T2>(arg3, true, false, v8, 4295048017, arg10, arg1, arg11);
        let v12 = v11;
        let v13 = v10;
        0x2::balance::join<T2>(&mut v13, v1);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T1, T2>(arg2, v3, 0x2::balance::zero<T1>(), 0x2::balance::split<T2>(&mut v13, v8), arg1, arg11);
        let (v14, _) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v12);
        let v16 = 0x2::coin::into_balance<0x2::sui::SUI>(v6);
        0x2::balance::join<0x2::sui::SUI>(&mut v16, v9);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v16) >= v14, 1);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<0x2::sui::SUI, T2>(arg3, v12, 0x2::balance::split<0x2::sui::SUI>(&mut v16, v14), 0x2::balance::zero<T2>(), arg1, arg11);
        send_or_destroy<T2>(v13, arg11);
        finish<T1>(v16, v4, arg9, arg11);
    }

    fun seize_sui<T0, T1>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::coin::Coin<T1>, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let (v0, v1) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<T0, T1, 0x2::sui::SUI>(arg0, arg1, arg2, arg3, arg4, arg5, arg7);
        let v2 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity_request<T0, 0x2::sui::SUI>(arg0, arg3, arg4, v0, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, 0x2::sui::SUI>>(v1), arg7);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::unstake_sui_from_staker<T0>(arg0, arg3, &v2, arg6, arg7);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<T0, 0x2::sui::SUI>(arg0, arg3, v2, arg7)
    }

    fun send_or_destroy<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    // decompiled from Move bytecode v7
}

