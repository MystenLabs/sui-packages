module 0xf112e69a09407599cf2eb7afeee36e07b8f99df654b12d28f81103185214b149::bclmm {
    struct EE has copy, drop {
        e: u64,
        l: u64,
    }

    public fun elf<T0, T1>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &mut 0xe04b8f264c8a29e103e71980987d76a475c8565094b6646e368659a30a9c70ed::bm::CBM, arg2: &0x2::clock::Clock, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: u64, arg5: u64, arg6: u64, arg7: vector<bool>, arg8: vector<bool>, arg9: vector<u64>, arg10: vector<u64>, arg11: &mut 0x2::tx_context::TxContext) {
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
            let v12 = if (v10) {
                0xf112e69a09407599cf2eb7afeee36e07b8f99df654b12d28f81103185214b149::ct::cmnsp() + 1
            } else {
                0xf112e69a09407599cf2eb7afeee36e07b8f99df654b12d28f81103185214b149::ct::cmxsp() - 1
            };
            let (v13, v14) = vbac<T0, T1>(arg0, v5, v7, v9, v10, *0x1::vector::borrow<u64>(&arg9, v8), v11, v12);
            if (v13 != 0xf112e69a09407599cf2eb7afeee36e07b8f99df654b12d28f81103185214b149::ct::e_no_error()) {
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
            if (v16 != 0xf112e69a09407599cf2eb7afeee36e07b8f99df654b12d28f81103185214b149::ct::e_no_error()) {
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

    fun sei<T0, T1>(arg0: &mut 0xe04b8f264c8a29e103e71980987d76a475c8565094b6646e368659a30a9c70ed::bm::CBM, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: bool, arg4: u64, arg5: u64, arg6: u128, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, u64, u64) {
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg7, arg1, arg2, arg3, true, arg4, arg6);
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
        assert!(v8 >= arg5, 0xf112e69a09407599cf2eb7afeee36e07b8f99df654b12d28f81103185214b149::ct::e_amount_out_too_low());
        let v9 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v3);
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
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, v16, v17, v3);
        0x2::coin::join<T0>(&mut v15, 0x2::coin::from_balance<T0>(v5, arg8));
        0x2::coin::join<T1>(&mut v14, 0x2::coin::from_balance<T1>(v4, arg8));
        0xe04b8f264c8a29e103e71980987d76a475c8565094b6646e368659a30a9c70ed::bm::dp<T0>(arg0, v15, arg8);
        0xe04b8f264c8a29e103e71980987d76a475c8565094b6646e368659a30a9c70ed::bm::dp<T1>(arg0, v14, arg8);
        (0xf112e69a09407599cf2eb7afeee36e07b8f99df654b12d28f81103185214b149::ct::e_no_error(), v10, v11, v6, v7)
    }

    fun seo<T0, T1>(arg0: &mut 0xe04b8f264c8a29e103e71980987d76a475c8565094b6646e368659a30a9c70ed::bm::CBM, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: bool, arg4: u64, arg5: u64, arg6: u128, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, u64, u64) {
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg7, arg1, arg2, arg3, false, arg4, arg6);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        let v6 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v3);
        assert!(v6 <= arg5, 0xf112e69a09407599cf2eb7afeee36e07b8f99df654b12d28f81103185214b149::ct::e_amount_in_too_high());
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
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v12, v7, arg8)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v11, v8, arg8)))
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, v13, v14, v3);
        0x2::coin::join<T0>(&mut v12, 0x2::coin::from_balance<T0>(v5, arg8));
        0x2::coin::join<T1>(&mut v11, 0x2::coin::from_balance<T1>(v4, arg8));
        0xe04b8f264c8a29e103e71980987d76a475c8565094b6646e368659a30a9c70ed::bm::dp<T0>(arg0, v12, arg8);
        0xe04b8f264c8a29e103e71980987d76a475c8565094b6646e368659a30a9c70ed::bm::dp<T1>(arg0, v11, arg8);
        (0xf112e69a09407599cf2eb7afeee36e07b8f99df654b12d28f81103185214b149::ct::e_no_error(), v7, v8, 0x2::balance::value<T0>(&v5), 0x2::balance::value<T1>(&v4))
    }

    fun vbac<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: u64, arg2: u64, arg3: bool, arg4: bool, arg5: u64, arg6: u64, arg7: u128) : (u64, u64) {
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T0, T1>(arg0, arg4, arg3, arg5, arg7);
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_specified(&v0);
        let (v2, v3) = if (arg3) {
            (v1, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v0))
        } else {
            (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v0), v1)
        };
        if (arg3) {
            if (v3 < arg6) {
                return (0xf112e69a09407599cf2eb7afeee36e07b8f99df654b12d28f81103185214b149::ct::e_amount_out_too_low(), 0)
            };
        } else if (v2 > arg6) {
            return (0xf112e69a09407599cf2eb7afeee36e07b8f99df654b12d28f81103185214b149::ct::e_amount_in_too_high(), 0)
        };
        if (arg4) {
            if (v2 > arg1) {
                return (0xf112e69a09407599cf2eb7afeee36e07b8f99df654b12d28f81103185214b149::ct::e_insufficient_input_balance(), 0)
            };
        } else if (v2 > arg2) {
            return (0xf112e69a09407599cf2eb7afeee36e07b8f99df654b12d28f81103185214b149::ct::e_insufficient_input_balance(), 0)
        };
        (0xf112e69a09407599cf2eb7afeee36e07b8f99df654b12d28f81103185214b149::ct::e_no_error(), v1)
    }

    // decompiled from Move bytecode v6
}

