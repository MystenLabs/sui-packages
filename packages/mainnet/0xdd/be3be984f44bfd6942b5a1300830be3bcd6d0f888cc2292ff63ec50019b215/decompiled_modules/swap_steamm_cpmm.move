module 0x70dcf63182f0755c02ac3c8e448777320998c8fd2400fa3b6d1847296b0d5f81::swap_steamm_cpmm {
    fun cleanup_swap<T0, T1, T2, T3, T4>(arg0: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &mut 0x2::coin::Coin<T1>, arg4: &mut 0x2::coin::Coin<T2>, arg5: 0x2::coin::Coin<T3>, arg6: 0x2::coin::Coin<T4>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T3>(&arg5);
        let v1 = 0x2::coin::value<T4>(&arg6);
        if (v0 > 0) {
            0x2::coin::join<T1>(arg3, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::burn_btoken<T0, T1, T3>(arg0, arg2, &mut arg5, v0, arg7, arg8));
        };
        if (v1 > 0) {
            0x2::coin::join<T2>(arg4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::burn_btoken<T0, T2, T4>(arg1, arg2, &mut arg6, v1, arg7, arg8));
        };
        0x1a830340e1caed73881c51f13fd3c1409153879493b56688118012c25b658512::utils::transfer_or_destroy<T3>(arg5, arg8);
        0x1a830340e1caed73881c51f13fd3c1409153879493b56688118012c25b658512::utils::transfer_or_destroy<T4>(arg6, arg8);
    }

    public fun cpmm_swap_v2<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T5>, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &mut 0x2::coin::Coin<T1>, arg5: &mut 0x2::coin::Coin<T2>, arg6: bool, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = to_btokens<T0, T1, T2, T3, T4>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg9, arg10);
        let v3 = v1;
        let v4 = v0;
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::swap<T3, T4, T5>(arg0, &mut v4, &mut v3, arg6, v2, arg8, arg10);
        cleanup_swap<T0, T1, T2, T3, T4>(arg1, arg2, arg3, arg4, arg5, v4, v3, arg9, arg10);
    }

    public fun swap_a2b<T0, T1, T2, T3, T4, T5: drop, T6, T7>(arg0: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T5>, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: 0x2::coin::Coin<T1>, arg5: &0x2::clock::Clock, arg6: &0x1a830340e1caed73881c51f13fd3c1409153879493b56688118012c25b658512::swap_transaction::SwapTransaction<T6, T7>, arg7: &0x1a830340e1caed73881c51f13fd3c1409153879493b56688118012c25b658512::state::State, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let v0 = 0x2::coin::zero<T2>(arg8);
        let (v1, v2) = swap_v2<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, arg4, v0, true, arg5, arg8);
        let v3 = v2;
        0x1a830340e1caed73881c51f13fd3c1409153879493b56688118012c25b658512::utils::transfer_or_destroy<T1>(v1, arg8);
        let v4 = 0x2::object::id<0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T5>>(arg0);
        0x70dcf63182f0755c02ac3c8e448777320998c8fd2400fa3b6d1847296b0d5f81::swap_event::emit_common_swap<T1, T2>(0x1a830340e1caed73881c51f13fd3c1409153879493b56688118012c25b658512::consts::DEX_STEAMM_CPMM(), 0x2::object::id_to_address(&v4), true, 0x2::coin::value<T1>(&arg4), 0x2::coin::value<T2>(&v3), true);
        v3
    }

    public fun swap_b2a<T0, T1, T2, T3, T4, T5: drop, T6, T7>(arg0: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T5>, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: 0x2::coin::Coin<T2>, arg5: &0x2::clock::Clock, arg6: &0x1a830340e1caed73881c51f13fd3c1409153879493b56688118012c25b658512::swap_transaction::SwapTransaction<T6, T7>, arg7: &0x1a830340e1caed73881c51f13fd3c1409153879493b56688118012c25b658512::state::State, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::zero<T1>(arg8);
        let (v1, v2) = swap_v2<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, v0, arg4, false, arg5, arg8);
        let v3 = v1;
        0x1a830340e1caed73881c51f13fd3c1409153879493b56688118012c25b658512::utils::transfer_or_destroy<T2>(v2, arg8);
        let v4 = 0x2::object::id<0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T5>>(arg0);
        0x70dcf63182f0755c02ac3c8e448777320998c8fd2400fa3b6d1847296b0d5f81::swap_event::emit_common_swap<T1, T2>(0x1a830340e1caed73881c51f13fd3c1409153879493b56688118012c25b658512::consts::DEX_STEAMM_CPMM(), 0x2::object::id_to_address(&v4), false, 0x2::coin::value<T2>(&arg4), 0x2::coin::value<T1>(&v3), true);
        v3
    }

    public fun swap_v2<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T5>, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: 0x2::coin::Coin<T1>, arg5: 0x2::coin::Coin<T2>, arg6: bool, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>) {
        let v0 = if (arg6) {
            0x2::coin::value<T1>(&arg4)
        } else {
            0x2::coin::value<T2>(&arg5)
        };
        let v1 = 0x2::coin::from_balance<T1>(0x2::coin::into_balance<T1>(arg4), arg8);
        let v2 = 0x2::coin::from_balance<T2>(0x2::coin::into_balance<T2>(arg5), arg8);
        let v3 = &mut v1;
        let v4 = &mut v2;
        cpmm_swap_v2<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, v3, v4, arg6, v0, 0, arg7, arg8);
        (v1, v2)
    }

    fun to_btokens<T0, T1, T2, T3, T4>(arg0: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &mut 0x2::coin::Coin<T1>, arg4: &mut 0x2::coin::Coin<T2>, arg5: bool, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T3>, 0x2::coin::Coin<T4>, u64) {
        let (v0, v1) = if (arg5) {
            (0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::mint_btoken<T0, T1, T3>(arg0, arg2, arg3, arg6, arg7, arg8), 0x2::coin::zero<T4>(arg8))
        } else {
            (0x2::coin::zero<T3>(arg8), 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::mint_btoken<T0, T2, T4>(arg1, arg2, arg4, arg6, arg7, arg8))
        };
        let v2 = v1;
        let v3 = v0;
        let v4 = if (arg5) {
            0x2::coin::value<T3>(&v3)
        } else {
            0x2::coin::value<T4>(&v2)
        };
        (v3, v2, v4)
    }

    // decompiled from Move bytecode v6
}

