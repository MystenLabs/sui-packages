module 0xc27ac6a65d68266c9cb0a983ab6da62ef7f041d71223f9d44214d2079bad2b39::mm {
    struct EE has copy, drop {
        ec: u64,
        ph: u64,
    }

    struct SSE<phantom T0, phantom T1> has copy, drop {
        tit0: u64,
        tit1: u64,
        tot0: u64,
        tot1: u64,
    }

    public fun bee<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T0>, arg3: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T1>, arg4: &0x2::clock::Clock, arg5: u64, arg6: vector<bool>, arg7: vector<u64>, arg8: vector<u64>, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xc27ac6a65d68266c9cb0a983ab6da62ef7f041d71223f9d44214d2079bad2b39::ut::check_deadline(arg4, arg5);
        if (v0 != 0) {
            let v1 = EE{
                ec : v0,
                ph : 1,
            };
            0x2::event::emit<EE>(v1);
            return
        };
        let v2 = 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::balance_of<T0>(arg2);
        let v3 = 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::balance_of<T1>(arg3);
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        while (v8 < 0x1::vector::length<bool>(&arg6)) {
            let v9 = *0x1::vector::borrow<bool>(&arg6, v8);
            let v10 = *0x1::vector::borrow<u64>(&arg8, v8);
            let v11 = if (v9) {
                0xc27ac6a65d68266c9cb0a983ab6da62ef7f041d71223f9d44214d2079bad2b39::ct::min_sp() + 1
            } else {
                0xc27ac6a65d68266c9cb0a983ab6da62ef7f041d71223f9d44214d2079bad2b39::ct::max_sp() - 1
            };
            let (v12, v13) = vs<T0, T1>(arg0, v2, v3, v9, *0x1::vector::borrow<u64>(&arg7, v8), v10, v11);
            if (v12 != 0xc27ac6a65d68266c9cb0a983ab6da62ef7f041d71223f9d44214d2079bad2b39::ct::good()) {
                let v14 = EE{
                    ec : v12,
                    ph : 2,
                };
                0x2::event::emit<EE>(v14);
                v8 = v8 + 1;
                continue
            };
            let (v15, v16, v17, v18, v19) = do<T0, T1>(arg0, arg1, arg2, arg3, v9, v13, v10, v11, arg4, arg9);
            if (v15 != 0xc27ac6a65d68266c9cb0a983ab6da62ef7f041d71223f9d44214d2079bad2b39::ct::good()) {
                let v20 = EE{
                    ec : v15,
                    ph : 3,
                };
                0x2::event::emit<EE>(v20);
                v8 = v8 + 1;
                continue
            };
            let v21 = v2 + v18;
            v2 = v21 - v16;
            let v22 = v3 + v19;
            v3 = v22 - v17;
            v4 = v4 + v16;
            v5 = v5 + v17;
            v6 = v6 + v18;
            v7 = v7 + v19;
            v8 = v8 + 1;
        };
        let v23 = if (v4 > 0) {
            true
        } else if (v5 > 0) {
            true
        } else if (v6 > 0) {
            true
        } else {
            v7 > 0
        };
        if (v23) {
            let v24 = SSE<T0, T1>{
                tit0 : v4,
                tit1 : v5,
                tot0 : v6,
                tot1 : v7,
            };
            0x2::event::emit<SSE<T0, T1>>(v24);
        };
    }

    fun do<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T0>, arg3: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T1>, arg4: bool, arg5: u64, arg6: u64, arg7: u128, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, u64, u64) {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg0, arg4, true, arg5, arg7, arg8, arg1, arg9);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        let v6 = 0x2::balance::value<T0>(&v5);
        let v7 = 0x2::balance::value<T1>(&v4);
        let v8 = if (arg4) {
            v7
        } else {
            v6
        };
        assert!(v8 >= arg6, 0xc27ac6a65d68266c9cb0a983ab6da62ef7f041d71223f9d44214d2079bad2b39::ct::e_slip());
        let (v9, v10) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v3);
        let (v11, v12) = if (arg4) {
            (0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::withdraw_coin<T0>(arg2, v9, arg9), 0x2::coin::zero<T1>(arg9))
        } else {
            (0x2::coin::zero<T0>(arg9), 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::withdraw_coin<T1>(arg3, v10, arg9))
        };
        let v13 = v12;
        let v14 = v11;
        let (v15, v16) = if (arg4) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v14, v9, arg9)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v13, v10, arg9)))
        };
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg0, v3, v15, v16, arg1, arg9);
        0x2::coin::join<T0>(&mut v14, 0x2::coin::from_balance<T0>(v5, arg9));
        0x2::coin::join<T1>(&mut v13, 0x2::coin::from_balance<T1>(v4, arg9));
        0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::deposit_coin<T0>(arg2, v14);
        0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::deposit_coin<T1>(arg3, v13);
        let (v17, v18) = if (arg4) {
            (v9, 0)
        } else {
            (0, v10)
        };
        (0xc27ac6a65d68266c9cb0a983ab6da62ef7f041d71223f9d44214d2079bad2b39::ct::good(), v17, v18, v6, v7)
    }

    fun vs<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: u64, arg2: u64, arg3: bool, arg4: u64, arg5: u64, arg6: u128) : (u64, u64) {
        let v0 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::compute_swap_result<T0, T1>(arg0, arg3, true, arg6, arg4);
        if (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_calculated(&v0) < arg5) {
            return (0xc27ac6a65d68266c9cb0a983ab6da62ef7f041d71223f9d44214d2079bad2b39::ct::e_slip(), 0)
        };
        if (arg3) {
            if (arg4 > arg1) {
                return (0xc27ac6a65d68266c9cb0a983ab6da62ef7f041d71223f9d44214d2079bad2b39::ct::e_inp(), 0)
            };
        } else if (arg4 > arg2) {
            return (0xc27ac6a65d68266c9cb0a983ab6da62ef7f041d71223f9d44214d2079bad2b39::ct::e_inp(), 0)
        };
        (0xc27ac6a65d68266c9cb0a983ab6da62ef7f041d71223f9d44214d2079bad2b39::ct::good(), arg4)
    }

    // decompiled from Move bytecode v6
}

