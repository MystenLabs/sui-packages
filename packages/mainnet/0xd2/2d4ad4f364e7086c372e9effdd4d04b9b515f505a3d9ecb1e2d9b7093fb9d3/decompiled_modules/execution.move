module 0xd22d4ad4f364e7086c372e9effdd4d04b9b515f505a3d9ecb1e2d9b7093fb9d3::execution {
    fun dispose<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        };
    }

    public fun maybe_cpmm_x_to_y<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T5>, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: 0x1::option::Option<0x2::coin::Coin<T1>>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T2>> {
        if (0x1::option::is_none<0x2::coin::Coin<T1>>(&arg4)) {
            0x1::option::destroy_none<0x2::coin::Coin<T1>>(arg4);
            return 0x1::option::none<0x2::coin::Coin<T2>>()
        };
        let v0 = 0x1::option::destroy_some<0x2::coin::Coin<T1>>(arg4);
        let v1 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::mint_btoken<T0, T1, T3>(arg1, arg3, &mut v0, 0x2::coin::value<T1>(&v0), arg5, arg6);
        let v2 = 0x2::coin::zero<T4>(arg6);
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::swap<T3, T4, T5>(arg0, &mut v1, &mut v2, true, 0x2::coin::value<T3>(&v1), 0, arg6);
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fee_crank::crank_fees<T0, T1, T2, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T5, T3, T4>(arg0, arg1, arg2);
        dispose<T1>(v0, arg6);
        dispose<T3>(v1, arg6);
        dispose<T4>(v2, arg6);
        0x1::option::some<0x2::coin::Coin<T2>>(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::burn_btoken<T0, T2, T4>(arg2, arg3, &mut v2, 0x2::coin::value<T4>(&v2), arg5, arg6))
    }

    public fun maybe_cpmm_y_to_x<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T5>, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: 0x1::option::Option<0x2::coin::Coin<T2>>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T1>> {
        if (0x1::option::is_none<0x2::coin::Coin<T2>>(&arg4)) {
            0x1::option::destroy_none<0x2::coin::Coin<T2>>(arg4);
            return 0x1::option::none<0x2::coin::Coin<T1>>()
        };
        let v0 = 0x1::option::destroy_some<0x2::coin::Coin<T2>>(arg4);
        let v1 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::mint_btoken<T0, T2, T4>(arg2, arg3, &mut v0, 0x2::coin::value<T2>(&v0), arg5, arg6);
        let v2 = 0x2::coin::zero<T3>(arg6);
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::swap<T3, T4, T5>(arg0, &mut v2, &mut v1, false, 0x2::coin::value<T4>(&v1), 0, arg6);
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fee_crank::crank_fees<T0, T1, T2, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T5, T3, T4>(arg0, arg1, arg2);
        dispose<T2>(v0, arg6);
        dispose<T3>(v2, arg6);
        dispose<T4>(v1, arg6);
        0x1::option::some<0x2::coin::Coin<T1>>(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::burn_btoken<T0, T1, T3>(arg1, arg3, &mut v2, 0x2::coin::value<T3>(&v2), arg5, arg6))
    }

    public fun maybe_omm_v2_x_to_y<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg5: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg6: 0x1::option::Option<0x2::coin::Coin<T1>>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T2>> {
        if (0x1::option::is_none<0x2::coin::Coin<T1>>(&arg6)) {
            0x1::option::destroy_none<0x2::coin::Coin<T1>>(arg6);
            return 0x1::option::none<0x2::coin::Coin<T2>>()
        };
        let v0 = 0x1::option::destroy_some<0x2::coin::Coin<T1>>(arg6);
        let v1 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::mint_btoken<T0, T1, T3>(arg1, arg3, &mut v0, 0x2::coin::value<T1>(&v0), arg7, arg8);
        let v2 = 0x2::coin::zero<T4>(arg8);
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::swap<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, arg4, arg5, &mut v1, &mut v2, true, 0x2::coin::value<T3>(&v1), 0, arg7, arg8);
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fee_crank::crank_fees<T0, T1, T2, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5, T3, T4>(arg0, arg1, arg2);
        dispose<T1>(v0, arg8);
        dispose<T3>(v1, arg8);
        dispose<T4>(v2, arg8);
        0x1::option::some<0x2::coin::Coin<T2>>(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::burn_btoken<T0, T2, T4>(arg2, arg3, &mut v2, 0x2::coin::value<T4>(&v2), arg7, arg8))
    }

    public fun maybe_omm_v2_y_to_x<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg5: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg6: 0x1::option::Option<0x2::coin::Coin<T2>>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T1>> {
        if (0x1::option::is_none<0x2::coin::Coin<T2>>(&arg6)) {
            0x1::option::destroy_none<0x2::coin::Coin<T2>>(arg6);
            return 0x1::option::none<0x2::coin::Coin<T1>>()
        };
        let v0 = 0x1::option::destroy_some<0x2::coin::Coin<T2>>(arg6);
        let v1 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::mint_btoken<T0, T2, T4>(arg2, arg3, &mut v0, 0x2::coin::value<T2>(&v0), arg7, arg8);
        let v2 = 0x2::coin::zero<T3>(arg8);
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::swap<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, arg4, arg5, &mut v2, &mut v1, false, 0x2::coin::value<T4>(&v1), 0, arg7, arg8);
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fee_crank::crank_fees<T0, T1, T2, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5, T3, T4>(arg0, arg1, arg2);
        dispose<T2>(v0, arg8);
        dispose<T3>(v2, arg8);
        dispose<T4>(v1, arg8);
        0x1::option::some<0x2::coin::Coin<T1>>(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::burn_btoken<T0, T1, T3>(arg1, arg3, &mut v2, 0x2::coin::value<T3>(&v2), arg7, arg8))
    }

    public fun maybe_omm_x_to_y<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm::OracleQuoter, T5>, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg5: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg6: 0x1::option::Option<0x2::coin::Coin<T1>>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T2>> {
        if (0x1::option::is_none<0x2::coin::Coin<T1>>(&arg6)) {
            0x1::option::destroy_none<0x2::coin::Coin<T1>>(arg6);
            return 0x1::option::none<0x2::coin::Coin<T2>>()
        };
        let v0 = 0x1::option::destroy_some<0x2::coin::Coin<T1>>(arg6);
        let v1 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::mint_btoken<T0, T1, T3>(arg1, arg3, &mut v0, 0x2::coin::value<T1>(&v0), arg7, arg8);
        let v2 = 0x2::coin::zero<T4>(arg8);
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm::swap<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, arg4, arg5, &mut v1, &mut v2, true, 0x2::coin::value<T3>(&v1), 0, arg7, arg8);
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fee_crank::crank_fees<T0, T1, T2, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm::OracleQuoter, T5, T3, T4>(arg0, arg1, arg2);
        dispose<T1>(v0, arg8);
        dispose<T3>(v1, arg8);
        dispose<T4>(v2, arg8);
        0x1::option::some<0x2::coin::Coin<T2>>(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::burn_btoken<T0, T2, T4>(arg2, arg3, &mut v2, 0x2::coin::value<T4>(&v2), arg7, arg8))
    }

    public fun maybe_omm_y_to_x<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm::OracleQuoter, T5>, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg5: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg6: 0x1::option::Option<0x2::coin::Coin<T2>>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T1>> {
        if (0x1::option::is_none<0x2::coin::Coin<T2>>(&arg6)) {
            0x1::option::destroy_none<0x2::coin::Coin<T2>>(arg6);
            return 0x1::option::none<0x2::coin::Coin<T1>>()
        };
        let v0 = 0x1::option::destroy_some<0x2::coin::Coin<T2>>(arg6);
        let v1 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::mint_btoken<T0, T2, T4>(arg2, arg3, &mut v0, 0x2::coin::value<T2>(&v0), arg7, arg8);
        let v2 = 0x2::coin::zero<T3>(arg8);
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm::swap<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, arg4, arg5, &mut v2, &mut v1, false, 0x2::coin::value<T4>(&v1), 0, arg7, arg8);
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fee_crank::crank_fees<T0, T1, T2, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm::OracleQuoter, T5, T3, T4>(arg0, arg1, arg2);
        dispose<T2>(v0, arg8);
        dispose<T3>(v2, arg8);
        dispose<T4>(v1, arg8);
        0x1::option::some<0x2::coin::Coin<T1>>(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::burn_btoken<T0, T1, T3>(arg1, arg3, &mut v2, 0x2::coin::value<T3>(&v2), arg7, arg8))
    }

    // decompiled from Move bytecode v7
}

