module 0x9a5d1b72d884d4a0db7651a05c87dae08c5536ea584daab959443f56470c02e2::st_cpmm_v2 {
    struct EE has copy, drop {
        ec: u64,
        ph: u64,
    }

    struct SSE<phantom T0, phantom T1> has copy, drop {
        d: u64,
        tit: u64,
        tot: u64,
        l: u64,
    }

    public fun bee<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T5>, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T1>, arg5: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T2>, arg6: &0x2::clock::Clock, arg7: u64, arg8: vector<bool>, arg9: vector<u64>, arg10: vector<u64>, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x9a5d1b72d884d4a0db7651a05c87dae08c5536ea584daab959443f56470c02e2::ut::check_deadline(arg6, arg7);
        if (v0 != 0) {
            let v1 = EE{
                ec : v0,
                ph : 1,
            };
            0x2::event::emit<EE>(v1);
            return
        };
        let v2 = 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::balance_of<T1>(arg4);
        let v3 = 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::balance_of<T2>(arg5);
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        let v9 = 0;
        let v10 = 0x1::vector::length<bool>(&arg8);
        while (v9 < v10) {
            let v11 = *0x1::vector::borrow<bool>(&arg8, v9);
            let v12 = *0x1::vector::borrow<u64>(&arg9, v9);
            let v13 = *0x1::vector::borrow<u64>(&arg10, v9);
            if (v11) {
                if (v12 > v2) {
                    let v14 = EE{
                        ec : 0x9a5d1b72d884d4a0db7651a05c87dae08c5536ea584daab959443f56470c02e2::ct::e_inp(),
                        ph : 2,
                    };
                    0x2::event::emit<EE>(v14);
                    break
                };
            } else if (v12 > v3) {
                let v15 = EE{
                    ec : 0x9a5d1b72d884d4a0db7651a05c87dae08c5536ea584daab959443f56470c02e2::ct::e_inp(),
                    ph : 2,
                };
                0x2::event::emit<EE>(v15);
                break
            };
            let (v16, v17, v18, v19, v20) = do_checked_<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v11, v12, v13, arg11);
            if (v16 != 0x9a5d1b72d884d4a0db7651a05c87dae08c5536ea584daab959443f56470c02e2::ct::good()) {
                let v21 = EE{
                    ec : v16,
                    ph : 3,
                };
                0x2::event::emit<EE>(v21);
                v9 = v9 + 1;
                continue
            };
            let v22 = v2 + v19;
            v2 = v22 - v17;
            let v23 = v3 + v20;
            v3 = v23 - v18;
            v4 = v4 + v17;
            v5 = v5 + v18;
            v6 = v6 + v19;
            v7 = v7 + v20;
            v8 = v8 + v13;
            v9 = v9 + 1;
        };
        let v24 = if (v4 > 0) {
            true
        } else if (v5 > 0) {
            true
        } else if (v6 > 0) {
            true
        } else {
            v7 > 0
        };
        if (v24) {
            let v25 = if (v10 > 0 && *0x1::vector::borrow<bool>(&arg8, 0)) {
                1
            } else {
                0
            };
            let v26 = SSE<T1, T2>{
                d   : v25,
                tit : v4 + v5,
                tot : v6 + v7,
                l   : v8,
            };
            0x2::event::emit<SSE<T1, T2>>(v26);
        };
    }

    fun burn_all_btoken_into_under<T0, T1, T2>(arg0: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T2>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &mut 0x2::coin::Coin<T1>, arg3: &mut 0x2::coin::Coin<T2>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T2>(arg3);
        if (v0 > 0) {
            0x2::coin::join<T1>(arg2, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::burn_btoken<T0, T1, T2>(arg0, arg1, arg3, v0, arg4, arg5));
        };
    }

    fun ceil_div_u128(arg0: u128, arg1: u128) : u64 {
        (((arg0 + arg1 - 1) / arg1) as u64)
    }

    fun do_checked_<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T5>, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T1>, arg5: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T2>, arg6: &0x2::clock::Clock, arg7: bool, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, u64, u64) {
        if (arg8 == 0) {
            return (0x9a5d1b72d884d4a0db7651a05c87dae08c5536ea584daab959443f56470c02e2::ct::e_inp(), 0, 0, 0, 0)
        };
        let (v0, v1) = if (arg7) {
            (arg8, 0)
        } else {
            (0, arg8)
        };
        let v2 = if (arg7) {
            0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::withdraw_coin<T1>(arg4, arg8, arg10)
        } else {
            0x2::coin::zero<T1>(arg10)
        };
        let v3 = v2;
        let v4 = if (arg7) {
            0x2::coin::zero<T2>(arg10)
        } else {
            0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::withdraw_coin<T2>(arg5, arg8, arg10)
        };
        let v5 = v4;
        let v6 = if (arg7) {
            0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::mint_btoken<T0, T1, T3>(arg1, arg3, &mut v3, arg8, arg6, arg10)
        } else {
            0x2::coin::zero<T3>(arg10)
        };
        let v7 = v6;
        let v8 = if (arg7) {
            0x2::coin::zero<T4>(arg10)
        } else {
            0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::mint_btoken<T0, T2, T4>(arg2, arg3, &mut v5, arg8, arg6, arg10)
        };
        let v9 = v8;
        let v10 = if (arg7) {
            0x2::coin::value<T3>(&v7)
        } else {
            0x2::coin::value<T4>(&v9)
        };
        if (v10 == 0) {
            let v11 = &mut v3;
            let v12 = &mut v7;
            burn_all_btoken_into_under<T0, T1, T3>(arg1, arg3, v11, v12, arg6, arg10);
            let v13 = &mut v5;
            let v14 = &mut v9;
            burn_all_btoken_into_under<T0, T2, T4>(arg2, arg3, v13, v14, arg6, arg10);
            transfer_or_destroy_coin<T3>(v7, arg10);
            transfer_or_destroy_coin<T4>(v9, arg10);
            if (0x2::coin::value<T1>(&v3) == 0) {
                0x2::coin::destroy_zero<T1>(v3);
            } else {
                0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::deposit_coin<T1>(arg4, v3);
            };
            if (0x2::coin::value<T2>(&v5) == 0) {
                0x2::coin::destroy_zero<T2>(v5);
            } else {
                0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::deposit_coin<T2>(arg5, v5);
            };
            return (0x9a5d1b72d884d4a0db7651a05c87dae08c5536ea584daab959443f56470c02e2::ct::e_inp(), 0, 0, 0, 0)
        };
        let (v15, v16) = if (arg7) {
            min_out_btoken_from_under<T0, T2, T4>(arg2, arg3, arg5, arg6, arg9, arg10)
        } else {
            min_out_btoken_from_under<T0, T1, T3>(arg1, arg3, arg4, arg6, arg9, arg10)
        };
        if (v15 != 0x9a5d1b72d884d4a0db7651a05c87dae08c5536ea584daab959443f56470c02e2::ct::good()) {
            let v17 = &mut v3;
            let v18 = &mut v7;
            burn_all_btoken_into_under<T0, T1, T3>(arg1, arg3, v17, v18, arg6, arg10);
            let v19 = &mut v5;
            let v20 = &mut v9;
            burn_all_btoken_into_under<T0, T2, T4>(arg2, arg3, v19, v20, arg6, arg10);
            transfer_or_destroy_coin<T3>(v7, arg10);
            transfer_or_destroy_coin<T4>(v9, arg10);
            if (0x2::coin::value<T1>(&v3) == 0) {
                0x2::coin::destroy_zero<T1>(v3);
            } else {
                0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::deposit_coin<T1>(arg4, v3);
            };
            if (0x2::coin::value<T2>(&v5) == 0) {
                0x2::coin::destroy_zero<T2>(v5);
            } else {
                0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::deposit_coin<T2>(arg5, v5);
            };
            return (0x9a5d1b72d884d4a0db7651a05c87dae08c5536ea584daab959443f56470c02e2::ct::e_inp(), 0, 0, 0, 0)
        };
        let v21 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::quote_swap<T3, T4, T5>(arg0, v10, arg7);
        let v22 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::quote::amount_out(&v21);
        if (v22 == 0 || v22 < v16) {
            let v23 = &mut v3;
            let v24 = &mut v7;
            burn_all_btoken_into_under<T0, T1, T3>(arg1, arg3, v23, v24, arg6, arg10);
            let v25 = &mut v5;
            let v26 = &mut v9;
            burn_all_btoken_into_under<T0, T2, T4>(arg2, arg3, v25, v26, arg6, arg10);
            transfer_or_destroy_coin<T3>(v7, arg10);
            transfer_or_destroy_coin<T4>(v9, arg10);
            if (0x2::coin::value<T1>(&v3) == 0) {
                0x2::coin::destroy_zero<T1>(v3);
            } else {
                0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::deposit_coin<T1>(arg4, v3);
            };
            if (0x2::coin::value<T2>(&v5) == 0) {
                0x2::coin::destroy_zero<T2>(v5);
            } else {
                0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::deposit_coin<T2>(arg5, v5);
            };
            return (0x9a5d1b72d884d4a0db7651a05c87dae08c5536ea584daab959443f56470c02e2::ct::e_slip(), 0, 0, 0, 0)
        };
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::swap<T3, T4, T5>(arg0, &mut v7, &mut v9, arg7, v10, v16, arg10);
        let v27 = &mut v3;
        let v28 = &mut v7;
        burn_all_btoken_into_under<T0, T1, T3>(arg1, arg3, v27, v28, arg6, arg10);
        let v29 = &mut v5;
        let v30 = &mut v9;
        burn_all_btoken_into_under<T0, T2, T4>(arg2, arg3, v29, v30, arg6, arg10);
        transfer_or_destroy_coin<T3>(v7, arg10);
        transfer_or_destroy_coin<T4>(v9, arg10);
        let v31 = 0x2::coin::value<T1>(&v3);
        let v32 = 0x2::coin::value<T2>(&v5);
        if (v31 == 0) {
            0x2::coin::destroy_zero<T1>(v3);
        } else {
            0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::deposit_coin<T1>(arg4, v3);
        };
        if (v32 == 0) {
            0x2::coin::destroy_zero<T2>(v5);
        } else {
            0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::deposit_coin<T2>(arg5, v5);
        };
        (0x9a5d1b72d884d4a0db7651a05c87dae08c5536ea584daab959443f56470c02e2::ct::good(), v0, v1, v31, v32)
    }

    fun min_out_btoken_from_under<T0, T1, T2>(arg0: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T2>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T1>, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        if (arg4 == 0) {
            return (0x9a5d1b72d884d4a0db7651a05c87dae08c5536ea584daab959443f56470c02e2::ct::good(), 0)
        };
        let v0 = 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::balance_of<T1>(arg2);
        if (v0 == 0) {
            return (0x9a5d1b72d884d4a0db7651a05c87dae08c5536ea584daab959443f56470c02e2::ct::e_inp(), 0)
        };
        let v1 = if (v0 < arg4) {
            v0
        } else {
            arg4
        };
        if (v1 == 0) {
            return (0x9a5d1b72d884d4a0db7651a05c87dae08c5536ea584daab959443f56470c02e2::ct::e_inp(), 0)
        };
        let v2 = 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::withdraw_coin<T1>(arg2, v1, arg5);
        let v3 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::mint_btoken<T0, T1, T2>(arg0, arg1, &mut v2, v1, arg3, arg5);
        let v4 = 0x2::coin::value<T2>(&v3);
        if (v4 == 0) {
            if (0x2::coin::value<T1>(&v2) == 0) {
                0x2::coin::destroy_zero<T1>(v2);
            } else {
                0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::deposit_coin<T1>(arg2, v2);
            };
            transfer_or_destroy_coin<T2>(v3, arg5);
            return (0x9a5d1b72d884d4a0db7651a05c87dae08c5536ea584daab959443f56470c02e2::ct::e_inp(), 0)
        };
        let v5 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::burn_btoken<T0, T1, T2>(arg0, arg1, &mut v3, v4, arg3, arg5);
        let v6 = 0x2::coin::value<T1>(&v5);
        0x2::coin::join<T1>(&mut v2, v5);
        if (0x2::coin::value<T1>(&v2) == 0) {
            0x2::coin::destroy_zero<T1>(v2);
        } else {
            0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::deposit_coin<T1>(arg2, v2);
        };
        transfer_or_destroy_coin<T2>(v3, arg5);
        if (v6 == 0) {
            return (0x9a5d1b72d884d4a0db7651a05c87dae08c5536ea584daab959443f56470c02e2::ct::e_inp(), 0)
        };
        (0x9a5d1b72d884d4a0db7651a05c87dae08c5536ea584daab959443f56470c02e2::ct::good(), ceil_div_u128((arg4 as u128) * (v4 as u128), (v6 as u128)))
    }

    fun transfer_or_destroy_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        };
    }

    // decompiled from Move bytecode v6
}

