module 0x3d445784ed3ca7a152aa5ac768e0294afc502270cfd3b1882437927e95d7beb1::fr {
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

    public fun bee<T0, T1>(arg0: &mut 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>, arg1: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T0>, arg2: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T1>, arg3: &0x2::clock::Clock, arg4: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::config::GlobalConfig, arg5: u64, arg6: vector<bool>, arg7: vector<u64>, arg8: vector<u64>, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x3d445784ed3ca7a152aa5ac768e0294afc502270cfd3b1882437927e95d7beb1::ut::check_deadline(arg3, arg5);
        if (v0 != 0) {
            let v1 = EE{
                ec : v0,
                ph : 1,
            };
            0x2::event::emit<EE>(v1);
            return
        };
        let v2 = 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::balance_of<T0>(arg1);
        let v3 = 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::balance_of<T1>(arg2);
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        let v9 = 0;
        let v10 = 0x1::vector::length<bool>(&arg6);
        while (v9 < v10) {
            let v11 = *0x1::vector::borrow<bool>(&arg6, v9);
            let v12 = *0x1::vector::borrow<u64>(&arg8, v9);
            if (v11) {
            };
            let (v13, v14) = vs<T0, T1>(arg0, arg3, v2, v3, v11, *0x1::vector::borrow<u64>(&arg7, v9), v12);
            if (v13 != 0x3d445784ed3ca7a152aa5ac768e0294afc502270cfd3b1882437927e95d7beb1::ct::good()) {
                let v15 = EE{
                    ec : v13,
                    ph : 2,
                };
                0x2::event::emit<EE>(v15);
                break
            };
            let (v16, v17, v18, v19, v20) = do<T0, T1>(arg1, arg2, arg4, arg0, v11, v14, v12, arg3, arg9);
            if (v16 != 0x3d445784ed3ca7a152aa5ac768e0294afc502270cfd3b1882437927e95d7beb1::ct::good()) {
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
            v8 = v8 + v12;
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
            let v25 = if (v10 > 0 && *0x1::vector::borrow<bool>(&arg6, 0)) {
                1
            } else {
                0
            };
            let v26 = SSE<T0, T1>{
                d   : v25,
                tit : v4 + v5,
                tot : v6 + v7,
                l   : v8,
            };
            0x2::event::emit<SSE<T0, T1>>(v26);
        };
    }

    fun do<T0, T1>(arg0: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T0>, arg1: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T1>, arg2: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::config::GlobalConfig, arg3: &mut 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>, arg4: bool, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, u64, u64) {
        let v0 = if (arg4) {
            0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::withdraw_coin<T0>(arg0, arg5, arg8)
        } else {
            0x2::coin::zero<T0>(arg8)
        };
        let v1 = if (arg4) {
            0x2::coin::zero<T1>(arg8)
        } else {
            0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::withdraw_coin<T1>(arg1, arg5, arg8)
        };
        let (v2, v3) = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::swap<T0, T1>(arg2, arg3, arg4, arg6, v0, v1, arg7, arg8);
        let v4 = v3;
        let v5 = v2;
        let v6 = 0x2::coin::value<T0>(&v5);
        let v7 = 0x2::coin::value<T1>(&v4);
        let (v8, v9) = if (arg4) {
            (arg5, 0)
        } else {
            (0, arg5)
        };
        if (v6 > 0) {
            0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::deposit_coin<T0>(arg0, v5);
        } else {
            0x2::coin::destroy_zero<T0>(v5);
        };
        if (v7 > 0) {
            0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::deposit_coin<T1>(arg1, v4);
        } else {
            0x2::coin::destroy_zero<T1>(v4);
        };
        (0x3d445784ed3ca7a152aa5ac768e0294afc502270cfd3b1882437927e95d7beb1::ct::good(), v8, v9, v6, v7)
    }

    fun vs<T0, T1>(arg0: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64, arg4: bool, arg5: u64, arg6: u64) : (u64, u64) {
        let (v0, v1, _) = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::get_swap_out<T0, T1>(arg0, arg5, arg4, arg1);
        if (arg5 - v0 == 0 || v1 == 0) {
            return (0x3d445784ed3ca7a152aa5ac768e0294afc502270cfd3b1882437927e95d7beb1::ct::e_inp(), 0)
        };
        if (v1 < arg6) {
            return (0x3d445784ed3ca7a152aa5ac768e0294afc502270cfd3b1882437927e95d7beb1::ct::e_slip(), 0)
        };
        (0x3d445784ed3ca7a152aa5ac768e0294afc502270cfd3b1882437927e95d7beb1::ct::good(), arg5)
    }

    // decompiled from Move bytecode v6
}

