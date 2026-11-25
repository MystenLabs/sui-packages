module 0x16798bfb0e18076e4aa756d2474e21359f696d3447621681aebe5a765a23c79a::steamm {
    public fun swap<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x908d14a365b07c0576ff3d6b662df3673667da4951eaf72e9f67cba843963e84::router::SwapContext, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T5>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg4: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: u64, arg6: bool, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        if (arg6) {
            swap_a2b<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, arg4, arg5, arg7, arg8);
        } else {
            swap_b2a<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, arg4, arg5, arg7, arg8);
        };
    }

    fun link_switchboard(arg0: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator) {
    }

    fun settle_btoken_remainder<T0, T1, T2>(arg0: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T2>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: 0x2::coin::Coin<T2>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T2>(&arg2);
        if (v0 == 0) {
            0x2::coin::destroy_zero<T2>(arg2);
            return
        };
        0x2::coin::destroy_zero<T2>(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::burn_btoken<T0, T1, T2>(arg0, arg1, &mut arg2, v0, arg3, arg4), 0x2::tx_context::sender(arg4));
    }

    fun swap_a2b<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x908d14a365b07c0576ff3d6b662df3673667da4951eaf72e9f67cba843963e84::router::SwapContext, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T5>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg4: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x908d14a365b07c0576ff3d6b662df3673667da4951eaf72e9f67cba843963e84::router::take_balance<T1>(arg0, arg5);
        let v1 = 0x2::balance::value<T1>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T1>(v0);
            return
        };
        let v2 = 0x2::coin::from_balance<T1>(v0, arg7);
        let v3 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::mint_btoken<T0, T1, T3>(arg2, arg4, &mut v2, v1, arg6, arg7);
        0x2::coin::destroy_zero<T1>(v2);
        let v4 = 0x2::coin::zero<T4>(arg7);
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::swap<T3, T4, T5>(arg1, &mut v3, &mut v4, true, 0x2::coin::value<T3>(&v3), 0, arg7);
        settle_btoken_remainder<T0, T1, T3>(arg2, arg4, v3, arg6, arg7);
        let v5 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::burn_btoken<T0, T2, T4>(arg3, arg4, &mut v4, 0x2::coin::value<T4>(&v4), arg6, arg7);
        0x2::coin::destroy_zero<T4>(v4);
        0x908d14a365b07c0576ff3d6b662df3673667da4951eaf72e9f67cba843963e84::router::merge_balance<T2>(arg0, 0x2::coin::into_balance<T2>(v5));
        0x908d14a365b07c0576ff3d6b662df3673667da4951eaf72e9f67cba843963e84::router::emit_swap_event<T1, T2>(arg0, b"STEAMM", 0x2::object::id<0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T5>>(arg1), v1, 0x2::coin::value<T2>(&v5), 0);
    }

    fun swap_b2a<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x908d14a365b07c0576ff3d6b662df3673667da4951eaf72e9f67cba843963e84::router::SwapContext, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T5>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg4: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x908d14a365b07c0576ff3d6b662df3673667da4951eaf72e9f67cba843963e84::router::take_balance<T2>(arg0, arg5);
        let v1 = 0x2::balance::value<T2>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T2>(v0);
            return
        };
        let v2 = 0x2::coin::from_balance<T2>(v0, arg7);
        let v3 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::mint_btoken<T0, T2, T4>(arg3, arg4, &mut v2, v1, arg6, arg7);
        0x2::coin::destroy_zero<T2>(v2);
        let v4 = 0x2::coin::zero<T3>(arg7);
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::swap<T3, T4, T5>(arg1, &mut v4, &mut v3, false, 0x2::coin::value<T4>(&v3), 0, arg7);
        settle_btoken_remainder<T0, T2, T4>(arg3, arg4, v3, arg6, arg7);
        let v5 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::burn_btoken<T0, T1, T3>(arg2, arg4, &mut v4, 0x2::coin::value<T3>(&v4), arg6, arg7);
        0x2::coin::destroy_zero<T3>(v4);
        0x908d14a365b07c0576ff3d6b662df3673667da4951eaf72e9f67cba843963e84::router::merge_balance<T1>(arg0, 0x2::coin::into_balance<T1>(v5));
        0x908d14a365b07c0576ff3d6b662df3673667da4951eaf72e9f67cba843963e84::router::emit_swap_event<T2, T1>(arg0, b"STEAMM", 0x2::object::id<0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T5>>(arg1), v1, 0x2::coin::value<T1>(&v5), 0);
    }

    // decompiled from Move bytecode v7
}

