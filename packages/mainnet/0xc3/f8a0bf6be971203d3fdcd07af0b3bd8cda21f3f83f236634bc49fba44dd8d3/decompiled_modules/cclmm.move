module 0xc3f8a0bf6be971203d3fdcd07af0b3bd8cda21f3f83f236634bc49fba44dd8d3::cclmm {
    struct EE has copy, drop {
        e: u64,
        l: u64,
    }

    public fun elf<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &mut 0xe04b8f264c8a29e103e71980987d76a475c8565094b6646e368659a30a9c70ed::bm::CBM, arg2: &0x2::clock::Clock, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: u64, arg5: u64, arg6: u64, arg7: vector<bool>, arg8: vector<bool>, arg9: vector<u64>, arg10: vector<u64>, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xe691aeb328ba898b3374ed75fdffd3306619ad71bab29aa303b0227bf2bb0708::sq::ct(arg2, arg4, true);
        if (v0 != 0) {
            let v1 = EE{
                e : v0,
                l : 232,
            };
            0x2::event::emit<EE>(v1);
            return
        };
        let v2 = 0xe04b8f264c8a29e103e71980987d76a475c8565094b6646e368659a30a9c70ed::bm::balance<T0>(arg1);
        let v3 = 0xe04b8f264c8a29e103e71980987d76a475c8565094b6646e368659a30a9c70ed::bm::balance<T1>(arg1);
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
            let (v12, v13) = vbac<T0, T1>(arg0, v5, v7, v9, v10, *0x1::vector::borrow<u64>(&arg9, v8), v11);
            if (v12 != 0xc3f8a0bf6be971203d3fdcd07af0b3bd8cda21f3f83f236634bc49fba44dd8d3::ct::e_no_error()) {
                let v14 = EE{
                    e : v12,
                    l : 268,
                };
                0x2::event::emit<EE>(v14);
                v8 = v8 + 1;
                continue
            };
            let v15 = if (v10) {
                0xc3f8a0bf6be971203d3fdcd07af0b3bd8cda21f3f83f236634bc49fba44dd8d3::ct::cmnsp()
            } else {
                0xc3f8a0bf6be971203d3fdcd07af0b3bd8cda21f3f83f236634bc49fba44dd8d3::ct::cmxsp()
            };
            let (v16, v17, v18, v19, v20) = if (v9) {
                sei<T0, T1>(arg1, arg3, arg0, v10, v13, v11, v15, arg2, arg11)
            } else {
                seo<T0, T1>(arg1, arg3, arg0, v10, v13, v11, v15, arg2, arg11)
            };
            if (v16 != 0xc3f8a0bf6be971203d3fdcd07af0b3bd8cda21f3f83f236634bc49fba44dd8d3::ct::e_no_error()) {
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

    fun sei<T0, T1>(arg0: &mut 0xe04b8f264c8a29e103e71980987d76a475c8565094b6646e368659a30a9c70ed::bm::CBM, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: bool, arg4: u64, arg5: u64, arg6: u128, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, u64, u64) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, arg3, true, arg4, arg6, arg7);
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
        assert!(v8 >= arg5, 0xc3f8a0bf6be971203d3fdcd07af0b3bd8cda21f3f83f236634bc49fba44dd8d3::ct::e_amount_out_too_low());
        let v9 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3);
        let (v10, v11) = if (arg3) {
            (v9, 0)
        } else {
            (0, v9)
        };
        let (v12, v13) = if (arg3) {
            (0xe04b8f264c8a29e103e71980987d76a475c8565094b6646e368659a30a9c70ed::bm::wd<T0>(arg0, v9, arg8), 0x2::coin::zero<T1>(arg8))
        } else {
            (0x2::coin::zero<T0>(arg8), 0xe04b8f264c8a29e103e71980987d76a475c8565094b6646e368659a30a9c70ed::bm::wd<T1>(arg0, v9, arg8))
        };
        let v14 = v13;
        let v15 = v12;
        let (v16, v17) = if (arg3) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v15, v9, arg8)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v14, v9, arg8)))
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, v16, v17, v3);
        0x2::coin::join<T0>(&mut v15, 0x2::coin::from_balance<T0>(v5, arg8));
        0x2::coin::join<T1>(&mut v14, 0x2::coin::from_balance<T1>(v4, arg8));
        0xe04b8f264c8a29e103e71980987d76a475c8565094b6646e368659a30a9c70ed::bm::dp<T0>(arg0, v15, arg8);
        0xe04b8f264c8a29e103e71980987d76a475c8565094b6646e368659a30a9c70ed::bm::dp<T1>(arg0, v14, arg8);
        (0xc3f8a0bf6be971203d3fdcd07af0b3bd8cda21f3f83f236634bc49fba44dd8d3::ct::e_no_error(), v10, v11, v6, v7)
    }

    fun seo<T0, T1>(arg0: &mut 0xe04b8f264c8a29e103e71980987d76a475c8565094b6646e368659a30a9c70ed::bm::CBM, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: bool, arg4: u64, arg5: u64, arg6: u128, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, u64, u64) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, arg3, false, arg4, arg6, arg7);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3);
        assert!(v6 <= arg5, 0xc3f8a0bf6be971203d3fdcd07af0b3bd8cda21f3f83f236634bc49fba44dd8d3::ct::e_amount_in_too_high());
        let (v7, v8) = if (arg3) {
            (v6, 0)
        } else {
            (0, v6)
        };
        let (v9, v10) = if (arg3) {
            (0xe04b8f264c8a29e103e71980987d76a475c8565094b6646e368659a30a9c70ed::bm::wd<T0>(arg0, v6, arg8), 0x2::coin::zero<T1>(arg8))
        } else {
            (0x2::coin::zero<T0>(arg8), 0xe04b8f264c8a29e103e71980987d76a475c8565094b6646e368659a30a9c70ed::bm::wd<T1>(arg0, v6, arg8))
        };
        let v11 = v10;
        let v12 = v9;
        let (v13, v14) = if (arg3) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v12, v6, arg8)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v11, v6, arg8)))
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, v13, v14, v3);
        0x2::coin::join<T0>(&mut v12, 0x2::coin::from_balance<T0>(v5, arg8));
        0x2::coin::join<T1>(&mut v11, 0x2::coin::from_balance<T1>(v4, arg8));
        0xe04b8f264c8a29e103e71980987d76a475c8565094b6646e368659a30a9c70ed::bm::dp<T0>(arg0, v12, arg8);
        0xe04b8f264c8a29e103e71980987d76a475c8565094b6646e368659a30a9c70ed::bm::dp<T1>(arg0, v11, arg8);
        (0xc3f8a0bf6be971203d3fdcd07af0b3bd8cda21f3f83f236634bc49fba44dd8d3::ct::e_no_error(), v7, v8, 0x2::balance::value<T0>(&v5), 0x2::balance::value<T1>(&v4))
    }

    fun vbac<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u64, arg2: u64, arg3: bool, arg4: bool, arg5: u64, arg6: u64) : (u64, u64) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg0, arg4, arg3, arg5);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_in(&v0) + 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_fee_amount(&v0);
        if (arg3) {
            if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v0) < arg6) {
                return (0xc3f8a0bf6be971203d3fdcd07af0b3bd8cda21f3f83f236634bc49fba44dd8d3::ct::e_amount_out_too_low(), 0)
            };
        } else if (v1 > arg6) {
            return (0xc3f8a0bf6be971203d3fdcd07af0b3bd8cda21f3f83f236634bc49fba44dd8d3::ct::e_amount_in_too_high(), 0)
        };
        if (arg4) {
            if (v1 > arg1) {
                return (0xc3f8a0bf6be971203d3fdcd07af0b3bd8cda21f3f83f236634bc49fba44dd8d3::ct::e_insufficient_input_balance(), 0)
            };
        } else if (v1 > arg2) {
            return (0xc3f8a0bf6be971203d3fdcd07af0b3bd8cda21f3f83f236634bc49fba44dd8d3::ct::e_insufficient_input_balance(), 0)
        };
        (0xc3f8a0bf6be971203d3fdcd07af0b3bd8cda21f3f83f236634bc49fba44dd8d3::ct::e_no_error(), arg5)
    }

    // decompiled from Move bytecode v6
}

