module 0xeccdc13ad1d5b75de4ff9e4534f9a946b128dd079e908cf1704283dd636871f3::st_cpmm {
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

    public fun bee<T0, T1, T2: drop>(arg0: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T0, T1, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T2>, arg1: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T0>, arg2: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T1>, arg3: &0x2::clock::Clock, arg4: u64, arg5: vector<bool>, arg6: vector<u64>, arg7: vector<u64>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xeccdc13ad1d5b75de4ff9e4534f9a946b128dd079e908cf1704283dd636871f3::ut::check_deadline(arg3, arg4);
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
        let v10 = 0x1::vector::length<bool>(&arg5);
        while (v9 < v10) {
            let v11 = *0x1::vector::borrow<bool>(&arg5, v9);
            let v12 = *0x1::vector::borrow<u64>(&arg7, v9);
            let (v13, v14) = vs<T0, T1, T2>(arg0, v2, v3, v11, *0x1::vector::borrow<u64>(&arg6, v9), v12);
            if (v13 != 0xeccdc13ad1d5b75de4ff9e4534f9a946b128dd079e908cf1704283dd636871f3::ct::good()) {
                let v15 = EE{
                    ec : v13,
                    ph : 2,
                };
                0x2::event::emit<EE>(v15);
                break
            };
            let (v16, v17, v18, v19, v20) = do_<T0, T1, T2>(arg0, arg1, arg2, v11, v14, v12, arg8);
            if (v16 != 0xeccdc13ad1d5b75de4ff9e4534f9a946b128dd079e908cf1704283dd636871f3::ct::good()) {
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
            let v25 = if (v10 > 0 && *0x1::vector::borrow<bool>(&arg5, 0)) {
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

    fun do_<T0, T1, T2: drop>(arg0: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T0, T1, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T2>, arg1: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T0>, arg2: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T1>, arg3: bool, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, u64, u64) {
        let v0 = if (arg3) {
            0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::withdraw_coin<T0>(arg1, arg4, arg6)
        } else {
            0x2::coin::zero<T0>(arg6)
        };
        let v1 = v0;
        let v2 = if (arg3) {
            0x2::coin::zero<T1>(arg6)
        } else {
            0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::withdraw_coin<T1>(arg2, arg4, arg6)
        };
        let v3 = v2;
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::swap<T0, T1, T2>(arg0, &mut v1, &mut v3, arg3, arg4, arg5, arg6);
        let v4 = 0x2::coin::value<T0>(&v1);
        let v5 = 0x2::coin::value<T1>(&v3);
        if (v4 == 0) {
            0x2::coin::destroy_zero<T0>(v1);
        } else {
            0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::deposit_coin<T0>(arg1, v1);
        };
        if (v5 == 0) {
            0x2::coin::destroy_zero<T1>(v3);
        } else {
            0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::deposit_coin<T1>(arg2, v3);
        };
        let (v6, v7) = if (arg3) {
            (arg4, 0)
        } else {
            (0, arg4)
        };
        (0xeccdc13ad1d5b75de4ff9e4534f9a946b128dd079e908cf1704283dd636871f3::ct::good(), v6, v7, v4, v5)
    }

    fun vs<T0, T1, T2: drop>(arg0: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T0, T1, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T2>, arg1: u64, arg2: u64, arg3: bool, arg4: u64, arg5: u64) : (u64, u64) {
        if (arg4 == 0) {
            return (0xeccdc13ad1d5b75de4ff9e4534f9a946b128dd079e908cf1704283dd636871f3::ct::e_inp(), 0)
        };
        let v0 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::quote_swap<T0, T1, T2>(arg0, arg4, arg3);
        let v1 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::quote::amount_out(&v0);
        if (v1 < arg5 || v1 == 0) {
            return (0xeccdc13ad1d5b75de4ff9e4534f9a946b128dd079e908cf1704283dd636871f3::ct::e_slip(), 0)
        };
        if (arg3) {
            if (arg4 > arg1) {
                return (0xeccdc13ad1d5b75de4ff9e4534f9a946b128dd079e908cf1704283dd636871f3::ct::e_inp(), 0)
            };
        } else if (arg4 > arg2) {
            return (0xeccdc13ad1d5b75de4ff9e4534f9a946b128dd079e908cf1704283dd636871f3::ct::e_inp(), 0)
        };
        (0xeccdc13ad1d5b75de4ff9e4534f9a946b128dd079e908cf1704283dd636871f3::ct::good(), arg4)
    }

    // decompiled from Move bytecode v6
}

