module 0x4342299897150e43ed71c09aeee9b66c9f0f324cdf7e3a4089b786f513666842::liquidator_suilend_bluefin_flash_v2 {
    struct LiqDoneSuiDebt has copy, drop {
        user: address,
        repay_used: u64,
        coll_seized: u64,
        sui_after_redeem: u64,
        flash_amount: u64,
        flash_debt: u64,
        final_payout: u64,
        push_phase0: bool,
    }

    public fun bluefin_flash_liq_suilend_sprsui_sui_debt_keeper_ride<T0, T1: drop, T2>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, T2>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T1>, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: 0x2::object::ID, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        run_bluefin_lst_liq_sui_debt<T0, T1, T2>(false, arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    fun run_bluefin_lst_liq_sui_debt<T0, T1: drop, T2>(arg0: bool, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, T2>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T1>, arg5: &mut 0x3::sui_system::SuiSystemState, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: 0x2::object::ID, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_obligation<T0>(arg3, arg10, arg12);
        assert!(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::is_liquidatable<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg3, arg10)), 102);
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_loan<0x2::sui::SUI, T2>(arg1, arg8, 0, arg2, arg13);
        let v3 = v2;
        let v4 = v1;
        assert!(0x2::balance::value<T2>(&v4) == 0, 103);
        0x2::balance::destroy_zero<T2>(v4);
        let v5 = 0x2::coin::from_balance<0x2::sui::SUI>(v0, arg13);
        let v6 = 0x2::coin::split<0x2::sui::SUI>(&mut v5, arg11, arg13);
        let (v7, v8) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<T0, 0x2::sui::SUI, T1>(arg3, arg10, arg6, arg7, arg12, &mut v6, arg13);
        0x2::coin::join<0x2::sui::SUI>(&mut v5, v6);
        let v9 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<T0, T1>(arg3, arg7, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity_request<T0, T1>(arg3, arg7, arg12, v7, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>(v8), arg13), arg13);
        let v10 = 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::redeem<T1>(arg4, v9, arg5, arg13);
        0x2::coin::join<0x2::sui::SUI>(&mut v5, v10);
        let (v11, v12) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_receipt_debts(&v3);
        assert!(v12 == 0, 103);
        assert!(0x2::coin::value<0x2::sui::SUI>(&v5) >= v11 + arg9, 100);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_loan<0x2::sui::SUI, T2>(arg1, v3, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v5, v11, arg13)), 0x2::balance::zero<T2>(), arg2, arg13);
        let v13 = 0x2::coin::value<0x2::sui::SUI>(&v5);
        if (v13 >= arg9) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v5, 0x2::tx_context::sender(arg13));
            let v14 = LiqDoneSuiDebt{
                user             : 0x2::object::id_to_address(&arg10),
                repay_used       : 0x2::coin::value<0x2::sui::SUI>(&v6) - 0x2::coin::value<0x2::sui::SUI>(&v6),
                coll_seized      : 0x2::coin::value<T1>(&v9),
                sui_after_redeem : 0x2::coin::value<0x2::sui::SUI>(&v10),
                flash_amount     : arg8,
                flash_debt       : v11,
                final_payout     : v13,
                push_phase0      : arg0,
            };
            0x2::event::emit<LiqDoneSuiDebt>(v14);
            return
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v5, 0x2::tx_context::sender(arg13));
            abort 101
        };
    }

    // decompiled from Move bytecode v7
}

