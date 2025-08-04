module 0x70461b8062deab4fd0b5a929c874fe631881eff03d5669049aba49fcde160b59::mclmm {
    struct EE has copy, drop {
        e: u64,
        l: u64,
    }

    public fun elf<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &mut 0xa3e3162fb175b3068eee9c18a91c72aba52d1a2b69b68fcda1d34c629da6376a::bm::CBM, arg2: &0x2::clock::Clock, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: u64, arg5: u64, arg6: u64, arg7: vector<bool>, arg8: vector<bool>, arg9: vector<u64>, arg10: vector<u64>, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xe691aeb328ba898b3374ed75fdffd3306619ad71bab29aa303b0227bf2bb0708::sq::ct(arg2, arg4, true);
        if (v0 != 0) {
            let v1 = EE{
                e : v0,
                l : 232,
            };
            0x2::event::emit<EE>(v1);
            return
        };
        let v2 = 0xa3e3162fb175b3068eee9c18a91c72aba52d1a2b69b68fcda1d34c629da6376a::bm::balance<T0>(arg1);
        let v3 = 0xa3e3162fb175b3068eee9c18a91c72aba52d1a2b69b68fcda1d34c629da6376a::bm::balance<T1>(arg1);
        let v4 = if (v2 > arg5) {
            v2 - arg5
        } else {
            0
        };
        let v5 = v4;
        let v6 = if (v3 > arg6) {
            v3 - arg6
        } else {
            0
        };
        let v7 = v6;
        let v8 = 0;
        while (v8 < 0x1::vector::length<bool>(&arg7)) {
            let v9 = *0x1::vector::borrow<bool>(&arg7, v8);
            let v10 = *0x1::vector::borrow<bool>(&arg8, v8);
            let v11 = *0x1::vector::borrow<u64>(&arg10, v8);
            let v12 = if (v10) {
                0x70461b8062deab4fd0b5a929c874fe631881eff03d5669049aba49fcde160b59::ct::cmnsp() + 1
            } else {
                0x70461b8062deab4fd0b5a929c874fe631881eff03d5669049aba49fcde160b59::ct::cmxsp() - 1
            };
            let (v13, v14) = vbac<T0, T1>(arg0, v5, v7, v9, v10, *0x1::vector::borrow<u64>(&arg9, v8), v11, v12);
            if (v13 != 0x70461b8062deab4fd0b5a929c874fe631881eff03d5669049aba49fcde160b59::ct::e_no_error()) {
                let v15 = EE{
                    e : v13,
                    l : 268,
                };
                0x2::event::emit<EE>(v15);
                v8 = v8 + 1;
                continue
            };
            let (v16, v17, v18, v19, v20) = if (v9) {
                sei<T0, T1>(arg1, arg3, arg0, v10, v14, v11, v12, arg2, arg11)
            } else {
                seo<T0, T1>(arg1, arg3, arg0, v10, v14, v11, v12, arg2, arg11)
            };
            if (v16 != 0x70461b8062deab4fd0b5a929c874fe631881eff03d5669049aba49fcde160b59::ct::e_no_error()) {
                let v21 = EE{
                    e : v16,
                    l : 306,
                };
                0x2::event::emit<EE>(v21);
                v8 = v8 + 1;
                continue
            };
            let v22 = v5 + v19;
            v5 = v22 - v17;
            let v23 = v7 + v20;
            v7 = v23 - v18;
            v8 = v8 + 1;
        };
    }

    fun sei<T0, T1>(arg0: &mut 0xa3e3162fb175b3068eee9c18a91c72aba52d1a2b69b68fcda1d34c629da6376a::bm::CBM, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: bool, arg4: u64, arg5: u64, arg6: u128, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, u64, u64) {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg2, arg3, true, arg4, arg6, arg7, arg1, arg8);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        let v6 = 0x2::balance::value<T0>(&v5);
        let v7 = 0x2::balance::value<T1>(&v4);
        let v8 = if (arg3) {
            v7
        } else {
            v6
        };
        assert!(v8 >= arg5, 0x70461b8062deab4fd0b5a929c874fe631881eff03d5669049aba49fcde160b59::ct::e_amount_out_too_low());
        let (v9, v10) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v3);
        let (v11, v12) = if (arg3) {
            (0xa3e3162fb175b3068eee9c18a91c72aba52d1a2b69b68fcda1d34c629da6376a::bm::wd<T0>(arg0, v9, arg8), 0x2::coin::zero<T1>(arg8))
        } else {
            (0x2::coin::zero<T0>(arg8), 0xa3e3162fb175b3068eee9c18a91c72aba52d1a2b69b68fcda1d34c629da6376a::bm::wd<T1>(arg0, v10, arg8))
        };
        let v13 = v12;
        let v14 = v11;
        let (v15, v16) = if (arg3) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v14, v9, arg8)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v13, v10, arg8)))
        };
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg2, v3, v15, v16, arg1, arg8);
        0x2::coin::join<T0>(&mut v14, 0x2::coin::from_balance<T0>(v5, arg8));
        0x2::coin::join<T1>(&mut v13, 0x2::coin::from_balance<T1>(v4, arg8));
        0xa3e3162fb175b3068eee9c18a91c72aba52d1a2b69b68fcda1d34c629da6376a::bm::dp<T0>(arg0, v14, arg8);
        0xa3e3162fb175b3068eee9c18a91c72aba52d1a2b69b68fcda1d34c629da6376a::bm::dp<T1>(arg0, v13, arg8);
        (0x70461b8062deab4fd0b5a929c874fe631881eff03d5669049aba49fcde160b59::ct::e_no_error(), v9, v10, v6, v7)
    }

    fun seo<T0, T1>(arg0: &mut 0xa3e3162fb175b3068eee9c18a91c72aba52d1a2b69b68fcda1d34c629da6376a::bm::CBM, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: bool, arg4: u64, arg5: u64, arg6: u128, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, u64, u64) {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg2, arg3, false, arg4, arg6, arg7, arg1, arg8);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        let (v6, v7) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v3);
        let v8 = if (arg3) {
            v6
        } else {
            v7
        };
        assert!(v8 <= arg5, 0x70461b8062deab4fd0b5a929c874fe631881eff03d5669049aba49fcde160b59::ct::e_amount_in_too_high());
        let (v9, v10) = if (arg3) {
            (0xa3e3162fb175b3068eee9c18a91c72aba52d1a2b69b68fcda1d34c629da6376a::bm::wd<T0>(arg0, v6, arg8), 0x2::coin::zero<T1>(arg8))
        } else {
            (0x2::coin::zero<T0>(arg8), 0xa3e3162fb175b3068eee9c18a91c72aba52d1a2b69b68fcda1d34c629da6376a::bm::wd<T1>(arg0, v7, arg8))
        };
        let v11 = v10;
        let v12 = v9;
        let (v13, v14) = if (arg3) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v12, v8, arg8)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v11, v8, arg8)))
        };
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg2, v3, v13, v14, arg1, arg8);
        0x2::coin::join<T0>(&mut v12, 0x2::coin::from_balance<T0>(v5, arg8));
        0x2::coin::join<T1>(&mut v11, 0x2::coin::from_balance<T1>(v4, arg8));
        0xa3e3162fb175b3068eee9c18a91c72aba52d1a2b69b68fcda1d34c629da6376a::bm::dp<T0>(arg0, v12, arg8);
        0xa3e3162fb175b3068eee9c18a91c72aba52d1a2b69b68fcda1d34c629da6376a::bm::dp<T1>(arg0, v11, arg8);
        (0x70461b8062deab4fd0b5a929c874fe631881eff03d5669049aba49fcde160b59::ct::e_no_error(), v6, v7, 0x2::balance::value<T0>(&v5), 0x2::balance::value<T1>(&v4))
    }

    fun vbac<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: u64, arg2: u64, arg3: bool, arg4: bool, arg5: u64, arg6: u64, arg7: u128) : (u64, u64) {
        let v0 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::compute_swap_result<T0, T1>(arg0, arg4, arg3, arg7, arg5);
        let (v1, v2) = if (arg3) {
            (arg5, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_calculated(&v0))
        } else {
            (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_calculated(&v0), arg5)
        };
        if (arg3) {
            if (v2 < arg6) {
                return (0x70461b8062deab4fd0b5a929c874fe631881eff03d5669049aba49fcde160b59::ct::e_amount_out_too_low(), 0)
            };
        } else if (v1 > arg6) {
            return (0x70461b8062deab4fd0b5a929c874fe631881eff03d5669049aba49fcde160b59::ct::e_amount_in_too_high(), 0)
        };
        if (arg4) {
            if (v1 > arg1) {
                return (0x70461b8062deab4fd0b5a929c874fe631881eff03d5669049aba49fcde160b59::ct::e_insufficient_input_balance(), 0)
            };
        } else if (v1 > arg2) {
            return (0x70461b8062deab4fd0b5a929c874fe631881eff03d5669049aba49fcde160b59::ct::e_insufficient_input_balance(), 0)
        };
        (0x70461b8062deab4fd0b5a929c874fe631881eff03d5669049aba49fcde160b59::ct::e_no_error(), arg5)
    }

    // decompiled from Move bytecode v6
}

