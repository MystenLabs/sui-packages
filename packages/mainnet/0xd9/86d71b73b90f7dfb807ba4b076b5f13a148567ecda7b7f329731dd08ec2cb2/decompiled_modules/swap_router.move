module 0xd986d71b73b90f7dfb807ba4b076b5f13a148567ecda7b7f329731dd08ec2cb2::swap_router {
    public fun swap<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T5>, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &mut 0x2::coin::Coin<T1>, arg5: &mut 0x2::coin::Coin<T2>, arg6: bool, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg6) {
            0x2::coin::value<T1>(arg4)
        } else {
            0x2::coin::value<T2>(arg5)
        };
        let (v1, v2) = if (arg6) {
            (0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::mint_btokens<T0, T1, T3>(arg1, arg3, arg4, v0, arg7, arg8), 0x2::coin::zero<T4>(arg8))
        } else {
            (0x2::coin::zero<T3>(arg8), 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::mint_btokens<T0, T2, T4>(arg2, arg3, arg5, v0, arg7, arg8))
        };
        let v3 = v2;
        let v4 = v1;
        let v5 = if (arg6) {
            0x2::coin::value<T3>(&v4)
        } else {
            0x2::coin::value<T4>(&v3)
        };
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::swap<T3, T4, T5>(arg0, &mut v4, &mut v3, arg6, v5, 0, arg8);
        if (arg6) {
            0x2::coin::join<T2>(arg5, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::burn_btokens<T0, T2, T4>(arg2, arg3, &mut v3, 0x2::coin::value<T4>(&v3), arg7, arg8));
        } else {
            0x2::coin::join<T1>(arg4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::burn_btokens<T0, T1, T3>(arg1, arg3, &mut v4, 0x2::coin::value<T3>(&v4), arg7, arg8));
        };
        0x2::coin::destroy_zero<T3>(v4);
        0x2::coin::destroy_zero<T4>(v3);
    }

    public fun swap_exact_x_to_y<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::universal_router::Route, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T5>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::universal_router::borrow_mut_current_path<T1, T2>(arg0);
        let v1 = 0x2::coin::zero<T2>(arg6);
        let v2 = 0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::universal_router::take_coin_in<T1, T2>(v0);
        let v3 = &mut v2;
        let v4 = &mut v1;
        swap<T0, T1, T2, T3, T4, T5>(arg1, arg2, arg3, arg4, v3, v4, true, arg5, arg6);
        0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::utils::refund_if_necessary<T1>(v2, 0x2::tx_context::sender(arg6));
        0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::universal_router::fill_coin_out<T1, T2>(v0, v1);
    }

    public fun swap_exact_y_to_x<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::universal_router::Route, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T5>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::universal_router::borrow_mut_current_path<T2, T1>(arg0);
        let v1 = 0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::universal_router::take_coin_in<T2, T1>(v0);
        let v2 = 0x2::coin::zero<T1>(arg6);
        let v3 = &mut v2;
        let v4 = &mut v1;
        swap<T0, T1, T2, T3, T4, T5>(arg1, arg2, arg3, arg4, v3, v4, false, arg5, arg6);
        0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::utils::refund_if_necessary<T2>(v1, 0x2::tx_context::sender(arg6));
        0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::universal_router::fill_coin_out<T2, T1>(v0, v2);
    }

    // decompiled from Move bytecode v6
}

