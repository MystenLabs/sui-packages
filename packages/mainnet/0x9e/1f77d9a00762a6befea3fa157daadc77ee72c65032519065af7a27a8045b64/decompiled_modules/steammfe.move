module 0x9e1f77d9a00762a6befea3fa157daadc77ee72c65032519065af7a27a8045b64::steammfe {
    struct SteammSwapEvent has copy, drop, store {
        amount_in: u64,
        amount_out: u64,
        a2b: bool,
        by_amount_in: bool,
        coin_a: 0x1::type_name::TypeName,
        coin_b: 0x1::type_name::TypeName,
    }

    public fun swap<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T5>, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: 0x2::coin::Coin<T1>, arg5: 0x2::coin::Coin<T2>, arg6: bool, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>) {
        let v0 = if (arg6) {
            0x2::coin::value<T1>(&arg4)
        } else {
            0x2::coin::value<T2>(&arg5)
        };
        let v1 = 0x2::coin::from_balance<T1>(0x2::coin::into_balance<T1>(arg4), arg8);
        let v2 = 0x2::coin::from_balance<T2>(0x2::coin::into_balance<T2>(arg5), arg8);
        let v3 = &mut v1;
        let v4 = &mut v2;
        cpmm_swap<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, v3, v4, arg6, v0, 0, arg7, arg8);
        (v1, v2)
    }

    public fun cpmm_swap<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T5>, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &mut 0x2::coin::Coin<T1>, arg5: &mut 0x2::coin::Coin<T2>, arg6: bool, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = if (arg6) {
            (0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::mint_btokens<T0, T1, T3>(arg1, arg3, arg4, arg7, arg9, arg10), 0x2::coin::zero<T4>(arg10))
        } else {
            (0x2::coin::zero<T3>(arg10), 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::mint_btokens<T0, T2, T4>(arg2, arg3, arg5, arg7, arg9, arg10))
        };
        let v2 = v1;
        let v3 = v0;
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::swap<T3, T4, T5>(arg0, &mut v3, &mut v2, arg6, 0x2::coin::value<T3>(&v3) + 0x2::coin::value<T4>(&v2), arg8, arg10);
        let v4 = 0x2::coin::value<T3>(&v3);
        let v5 = 0x2::coin::value<T4>(&v2);
        if (v4 > 0) {
            0x2::coin::join<T1>(arg4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::burn_btokens<T0, T1, T3>(arg1, arg3, &mut v3, v4, arg9, arg10));
        };
        if (v5 > 0) {
            0x2::coin::join<T2>(arg5, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::burn_btokens<T0, T2, T4>(arg2, arg3, &mut v2, v5, arg9, arg10));
        };
        0x9e1f77d9a00762a6befea3fa157daadc77ee72c65032519065af7a27a8045b64::utils::transfer_or_destroy_coin<T3>(v3, arg10);
        0x9e1f77d9a00762a6befea3fa157daadc77ee72c65032519065af7a27a8045b64::utils::transfer_or_destroy_coin<T4>(v2, arg10);
    }

    public fun swap_a2b<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T5>, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: 0x2::coin::Coin<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let v0 = 0x2::coin::zero<T2>(arg6);
        let (v1, v2) = swap<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, arg4, v0, true, arg5, arg6);
        let v3 = v2;
        0x9e1f77d9a00762a6befea3fa157daadc77ee72c65032519065af7a27a8045b64::utils::transfer_or_destroy_coin<T1>(v1, arg6);
        let v4 = SteammSwapEvent{
            amount_in    : 0x2::coin::value<T1>(&arg4),
            amount_out   : 0x2::coin::value<T2>(&v3),
            a2b          : true,
            by_amount_in : true,
            coin_a       : 0x1::type_name::get<T1>(),
            coin_b       : 0x1::type_name::get<T2>(),
        };
        0x2::event::emit<SteammSwapEvent>(v4);
        v3
    }

    public fun swap_b2a<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T5>, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: 0x2::coin::Coin<T2>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::zero<T1>(arg6);
        let (v1, v2) = swap<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, v0, arg4, false, arg5, arg6);
        let v3 = v1;
        0x9e1f77d9a00762a6befea3fa157daadc77ee72c65032519065af7a27a8045b64::utils::transfer_or_destroy_coin<T2>(v2, arg6);
        let v4 = SteammSwapEvent{
            amount_in    : 0x2::coin::value<T2>(&arg4),
            amount_out   : 0x2::coin::value<T1>(&v3),
            a2b          : false,
            by_amount_in : true,
            coin_a       : 0x1::type_name::get<T1>(),
            coin_b       : 0x1::type_name::get<T2>(),
        };
        0x2::event::emit<SteammSwapEvent>(v4);
        v3
    }

    // decompiled from Move bytecode v6
}

