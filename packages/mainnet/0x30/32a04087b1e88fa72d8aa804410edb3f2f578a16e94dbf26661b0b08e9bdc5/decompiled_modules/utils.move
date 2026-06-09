module 0x3032a04087b1e88fa72d8aa804410edb3f2f578a16e94dbf26661b0b08e9bdc5::utils {
    public fun cleanup_swap<T0, T1, T2, T3, T4>(arg0: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &mut 0x2::coin::Coin<T1>, arg4: &mut 0x2::coin::Coin<T2>, arg5: 0x2::coin::Coin<T3>, arg6: 0x2::coin::Coin<T4>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T3>(&arg5);
        let v1 = 0x2::coin::value<T4>(&arg6);
        if (v0 > 0) {
            0x2::coin::join<T1>(arg3, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::burn_btoken<T0, T1, T3>(arg0, arg2, &mut arg5, v0, arg7, arg8));
        };
        if (v1 > 0) {
            0x2::coin::join<T2>(arg4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::burn_btoken<T0, T2, T4>(arg1, arg2, &mut arg6, v1, arg7, arg8));
        };
        0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::transfer_or_destroy_coin<T3>(arg5, arg8);
        0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::transfer_or_destroy_coin<T4>(arg6, arg8);
    }

    public fun to_btokens<T0, T1, T2, T3, T4>(arg0: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &mut 0x2::coin::Coin<T1>, arg4: &mut 0x2::coin::Coin<T2>, arg5: bool, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T3>, 0x2::coin::Coin<T4>, u64) {
        if (arg5) {
            let v3 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::mint_btoken<T0, T1, T3>(arg0, arg2, arg3, arg6, arg7, arg8);
            (v3, 0x2::coin::zero<T4>(arg8), 0x2::coin::value<T3>(&v3))
        } else {
            let v4 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::mint_btoken<T0, T2, T4>(arg1, arg2, arg4, arg6, arg7, arg8);
            (0x2::coin::zero<T3>(arg8), v4, 0x2::coin::value<T4>(&v4))
        }
    }

    // decompiled from Move bytecode v7
}

