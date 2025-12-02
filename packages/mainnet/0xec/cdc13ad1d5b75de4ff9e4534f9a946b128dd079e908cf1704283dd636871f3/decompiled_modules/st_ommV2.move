module 0xeccdc13ad1d5b75de4ff9e4534f9a946b128dd079e908cf1704283dd636871f3::st_ommV2 {
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

    public fun bee<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg1: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg2: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: vector<0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate>, arg5: vector<0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate>, arg6: vector<0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate>, arg7: vector<0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate>, arg8: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T3>, arg9: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T4>, arg10: &0x2::clock::Clock, arg11: u64, arg12: vector<bool>, arg13: vector<u64>, arg14: vector<u64>, arg15: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xeccdc13ad1d5b75de4ff9e4534f9a946b128dd079e908cf1704283dd636871f3::ut::check_deadline(arg10, arg11);
        if (v0 != 0) {
            let v1 = EE{
                ec : v0,
                ph : 1,
            };
            0x2::event::emit<EE>(v1);
            return
        };
        assert!(0x1::vector::length<bool>(&arg12) == 0x1::vector::length<u64>(&arg13), 0xeccdc13ad1d5b75de4ff9e4534f9a946b128dd079e908cf1704283dd636871f3::ct::e_inp());
        assert!(0x1::vector::length<bool>(&arg12) == 0x1::vector::length<u64>(&arg14), 0xeccdc13ad1d5b75de4ff9e4534f9a946b128dd079e908cf1704283dd636871f3::ct::e_inp());
        assert!(0x1::vector::length<bool>(&arg12) == 0x1::vector::length<0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate>(&arg4), 0xeccdc13ad1d5b75de4ff9e4534f9a946b128dd079e908cf1704283dd636871f3::ct::e_inp());
        assert!(0x1::vector::length<bool>(&arg12) == 0x1::vector::length<0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate>(&arg5), 0xeccdc13ad1d5b75de4ff9e4534f9a946b128dd079e908cf1704283dd636871f3::ct::e_inp());
        assert!(0x1::vector::length<bool>(&arg12) == 0x1::vector::length<0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate>(&arg6), 0xeccdc13ad1d5b75de4ff9e4534f9a946b128dd079e908cf1704283dd636871f3::ct::e_inp());
        assert!(0x1::vector::length<bool>(&arg12) == 0x1::vector::length<0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate>(&arg7), 0xeccdc13ad1d5b75de4ff9e4534f9a946b128dd079e908cf1704283dd636871f3::ct::e_inp());
        let v2 = 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::balance_of<T3>(arg8);
        let v3 = 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::balance_of<T4>(arg9);
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        while (0x1::vector::length<bool>(&arg12) > 0) {
            let v9 = 0x1::vector::remove<bool>(&mut arg12, 0);
            let v10 = 0x1::vector::remove<u64>(&mut arg14, 0);
            let (v11, v12) = vs<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, v2, v3, v9, 0x1::vector::remove<u64>(&mut arg13, 0), v10, 0x1::vector::remove<0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate>(&mut arg4, 0), 0x1::vector::remove<0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate>(&mut arg5, 0), arg10);
            if (v11 != 0xeccdc13ad1d5b75de4ff9e4534f9a946b128dd079e908cf1704283dd636871f3::ct::good()) {
                let v13 = EE{
                    ec : v11,
                    ph : 2,
                };
                0x2::event::emit<EE>(v13);
                break
            };
            let (v14, v15, v16, v17, v18) = do_<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, arg8, arg9, v9, v12, v10, 0x1::vector::remove<0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate>(&mut arg6, 0), 0x1::vector::remove<0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate>(&mut arg7, 0), arg10, arg15);
            if (v14 != 0xeccdc13ad1d5b75de4ff9e4534f9a946b128dd079e908cf1704283dd636871f3::ct::good()) {
                let v19 = EE{
                    ec : v14,
                    ph : 3,
                };
                0x2::event::emit<EE>(v19);
                continue
            };
            let v20 = v2 + v17;
            v2 = v20 - v15;
            let v21 = v3 + v18;
            v3 = v21 - v16;
            v4 = v4 + v15;
            v5 = v5 + v16;
            v6 = v6 + v17;
            v7 = v7 + v18;
            v8 = v8 + v10;
        };
        let v22 = if (v4 > 0) {
            true
        } else if (v5 > 0) {
            true
        } else if (v6 > 0) {
            true
        } else {
            v7 > 0
        };
        if (v22) {
            let v23 = if (v4 > 0) {
                1
            } else {
                0
            };
            let v24 = SSE<T3, T4>{
                d   : v23,
                tit : v4 + v5,
                tot : v6 + v7,
                l   : v8,
            };
            0x2::event::emit<SSE<T3, T4>>(v24);
        };
    }

    fun do_<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg1: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg2: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T3>, arg5: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T4>, arg6: bool, arg7: u64, arg8: u64, arg9: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg10: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, u64, u64) {
        let v0 = if (arg6) {
            0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::withdraw_coin<T3>(arg4, arg7, arg12)
        } else {
            0x2::coin::zero<T3>(arg12)
        };
        let v1 = v0;
        let v2 = if (arg6) {
            0x2::coin::zero<T4>(arg12)
        } else {
            0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::withdraw_coin<T4>(arg5, arg7, arg12)
        };
        let v3 = v2;
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::swap<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, arg9, arg10, &mut v1, &mut v3, arg6, arg7, arg8, arg11, arg12);
        let v4 = 0x2::coin::value<T3>(&v1);
        let v5 = 0x2::coin::value<T4>(&v3);
        if (v4 == 0) {
            0x2::coin::destroy_zero<T3>(v1);
        } else {
            0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::deposit_coin<T3>(arg4, v1);
        };
        if (v5 == 0) {
            0x2::coin::destroy_zero<T4>(v3);
        } else {
            0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::deposit_coin<T4>(arg5, v3);
        };
        let (v6, v7) = if (arg6) {
            (arg7, 0)
        } else {
            (0, arg7)
        };
        (0xeccdc13ad1d5b75de4ff9e4534f9a946b128dd079e908cf1704283dd636871f3::ct::good(), v6, v7, v4, v5)
    }

    fun vs<T0, T1, T2, T3, T4, T5: drop>(arg0: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg1: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg2: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: u64, arg5: u64, arg6: bool, arg7: u64, arg8: u64, arg9: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg10: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg11: &0x2::clock::Clock) : (u64, u64) {
        if (arg7 == 0) {
            return (0xeccdc13ad1d5b75de4ff9e4534f9a946b128dd079e908cf1704283dd636871f3::ct::e_inp(), 0)
        };
        let v0 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::quote_swap<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, arg9, arg10, arg7, arg6, arg11);
        let v1 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::quote::amount_out(&v0);
        if (v1 < arg8 || v1 == 0) {
            return (0xeccdc13ad1d5b75de4ff9e4534f9a946b128dd079e908cf1704283dd636871f3::ct::e_slip(), 0)
        };
        if (arg6) {
            if (arg7 > arg4) {
                return (0xeccdc13ad1d5b75de4ff9e4534f9a946b128dd079e908cf1704283dd636871f3::ct::e_inp(), 0)
            };
        } else if (arg7 > arg5) {
            return (0xeccdc13ad1d5b75de4ff9e4534f9a946b128dd079e908cf1704283dd636871f3::ct::e_inp(), 0)
        };
        (0xeccdc13ad1d5b75de4ff9e4534f9a946b128dd079e908cf1704283dd636871f3::ct::good(), arg7)
    }

    // decompiled from Move bytecode v6
}

