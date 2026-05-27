module 0x4342299897150e43ed71c09aeee9b66c9f0f324cdf7e3a4089b786f513666842::liquidator_suilend_bluefin_flash_v3 {
    struct LiqDoneBside has copy, drop {
        user: address,
        repay_used: u64,
        coll_seized: u64,
        sui_after_redeem: u64,
        a_received_from_cetus: u64,
        flash_amount: u64,
        flash_debt: u64,
        final_payout: u64,
        push_phase0: bool,
    }

    public fun bluefin_flash_liq_suilend_sprsui_b_side_keeper_ride<T0, T1, T2, T3: drop>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T2>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, 0x2::sui::SUI>, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T3>, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: u64, arg8: u64, arg9: u64, arg10: u128, arg11: u64, arg12: 0x2::object::ID, arg13: u64, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        run_bluefin_lst_liq_b_side<T0, T1, T2, T3>(false, arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15);
    }

    fun run_bluefin_lst_liq_b_side<T0, T1, T2, T3: drop>(arg0: bool, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T2>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, 0x2::sui::SUI>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg6: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T3>, arg7: &mut 0x3::sui_system::SuiSystemState, arg8: u64, arg9: u64, arg10: u64, arg11: u128, arg12: u64, arg13: 0x2::object::ID, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_obligation<T0>(arg5, arg13, arg15);
        assert!(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::is_liquidatable<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg5, arg13)), 102);
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_loan<T1, T2>(arg1, 0, arg10, arg2, arg16);
        let v3 = v2;
        let v4 = v0;
        assert!(0x2::balance::value<T1>(&v4) == 0, 103);
        0x2::balance::destroy_zero<T1>(v4);
        let v5 = 0x2::coin::from_balance<T2>(v1, arg16);
        let v6 = 0x2::coin::split<T2>(&mut v5, arg14, arg16);
        let (v7, v8) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<T0, T2, T3>(arg5, arg13, arg8, arg9, arg15, &mut v6, arg16);
        0x2::coin::join<T2>(&mut v5, v6);
        let v9 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<T0, T3>(arg5, arg9, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity_request<T0, T3>(arg5, arg9, arg15, v7, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T3>>(v8), arg16), arg16);
        let v10 = 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::redeem<T3>(arg6, v9, arg7, arg16);
        let v11 = 0x2::coin::value<0x2::sui::SUI>(&v10);
        let v12 = 0x2::coin::into_balance<0x2::sui::SUI>(v10);
        let (v13, v14, v15) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, 0x2::sui::SUI>(arg3, arg4, false, true, v11, arg11, arg15);
        let v16 = v15;
        let v17 = v13;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v14);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, 0x2::sui::SUI>(arg3, arg4, 0x2::balance::zero<T2>(), 0x2::balance::split<0x2::sui::SUI>(&mut v12, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, 0x2::sui::SUI>(&v16)), v16);
        if (0x2::balance::value<0x2::sui::SUI>(&v12) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v12, arg16), 0x2::tx_context::sender(arg16));
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v12);
        };
        0x2::coin::join<T2>(&mut v5, 0x2::coin::from_balance<T2>(v17, arg16));
        let (v18, v19) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_receipt_debts(&v3);
        assert!(v18 == 0, 103);
        assert!(0x2::coin::value<T2>(&v5) >= v19 + arg12, 100);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_loan<T1, T2>(arg1, v3, 0x2::balance::zero<T1>(), 0x2::coin::into_balance<T2>(0x2::coin::split<T2>(&mut v5, v19, arg16)), arg2, arg16);
        let v20 = 0x2::coin::value<T2>(&v5);
        if (v20 >= arg12) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v5, 0x2::tx_context::sender(arg16));
            let v21 = LiqDoneBside{
                user                  : 0x2::object::id_to_address(&arg13),
                repay_used            : 0x2::coin::value<T2>(&v6) - 0x2::coin::value<T2>(&v6),
                coll_seized           : 0x2::coin::value<T3>(&v9),
                sui_after_redeem      : v11,
                a_received_from_cetus : 0x2::balance::value<T2>(&v17),
                flash_amount          : arg10,
                flash_debt            : v19,
                final_payout          : v20,
                push_phase0           : arg0,
            };
            0x2::event::emit<LiqDoneBside>(v21);
            return
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v5, 0x2::tx_context::sender(arg16));
            abort 101
        };
    }

    // decompiled from Move bytecode v7
}

