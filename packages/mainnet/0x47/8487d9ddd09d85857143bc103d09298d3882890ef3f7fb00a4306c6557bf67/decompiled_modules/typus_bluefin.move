module 0x478487d9ddd09d85857143bc103d09298d3882890ef3f7fb00a4306c6557bf67::typus_bluefin {
    struct TYPUS_BLUEFIN has drop {
        dummy_field: bool,
    }

    struct VERSION has drop {
        dummy_field: bool,
    }

    struct SwapBalance<phantom T0, phantom T1> has store {
        balance_a: 0x2::balance::Balance<T0>,
        balance_b: 0x2::balance::Balance<T1>,
    }

    public fun swap<T0, T1, T2, T3>(arg0: &mut 0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::Version, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T3>, arg5: u64, arg6: u128, arg7: u128, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T3>) {
        let v0 = VERSION{dummy_field: false};
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_witness<VERSION>(arg0, v0);
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_version(arg0, 1);
        let v1 = 0x2::object::new(arg9);
        let (v2, v3) = if (0x1::type_name::get<T0>() == 0x1::type_name::get<T1>()) {
            let v4 = SwapBalance<T0, T3>{
                balance_a : arg3,
                balance_b : arg4,
            };
            0x2::dynamic_field::add<vector<u8>, SwapBalance<T0, T3>>(&mut v1, b"SwapBalance", v4);
            let SwapBalance {
                balance_a : v5,
                balance_b : v6,
            } = 0x2::dynamic_field::remove<vector<u8>, SwapBalance<T1, T2>>(&mut v1, b"SwapBalance");
            let v7 = v6;
            if (0x2::balance::value<T2>(&v7) < arg5) {
                let v8 = arg5 - 0x2::balance::value<T2>(&v7);
                let (v9, v10) = swap_<T1, T2>(arg1, arg2, v5, 0x2::balance::zero<T2>(), true, false, v8, v8, arg6, arg8);
                0x2::balance::join<T2>(&mut v7, v10);
                (v9, v7)
            } else {
                let v11 = v5;
                let v12 = 0x2::balance::value<T2>(&v7);
                let (v13, v14) = swap_<T1, T2>(arg1, arg2, 0x2::balance::zero<T1>(), v7, false, true, v12, v12, arg7, arg8);
                let v15 = v14;
                if (0x2::balance::value<T2>(&v15) > 0) {
                    0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::charge_fee<T2>(arg0, v15);
                } else {
                    0x2::balance::destroy_zero<T2>(v15);
                };
                0x2::balance::join<T1>(&mut v11, v13);
                (v11, 0x2::balance::split<T2>(&mut v7, arg5))
            }
        } else {
            let v16 = SwapBalance<T3, T0>{
                balance_a : arg4,
                balance_b : arg3,
            };
            0x2::dynamic_field::add<vector<u8>, SwapBalance<T3, T0>>(&mut v1, b"SwapBalance", v16);
            let SwapBalance {
                balance_a : v17,
                balance_b : v18,
            } = 0x2::dynamic_field::remove<vector<u8>, SwapBalance<T1, T2>>(&mut v1, b"SwapBalance");
            let v19 = v17;
            if (0x2::balance::value<T1>(&v19) < arg5) {
                let v20 = arg5 - 0x2::balance::value<T1>(&v19);
                let (v21, v22) = swap_<T1, T2>(arg1, arg2, 0x2::balance::zero<T1>(), v18, false, false, v20, v20, arg7, arg8);
                0x2::balance::join<T1>(&mut v19, v21);
                (v19, v22)
            } else {
                let v23 = v18;
                let v24 = 0x2::balance::value<T1>(&v19);
                let (v25, v26) = swap_<T1, T2>(arg1, arg2, v19, 0x2::balance::zero<T2>(), true, true, v24, v24, arg6, arg8);
                let v27 = v25;
                if (0x2::balance::value<T1>(&v27) > 0) {
                    0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::charge_fee<T1>(arg0, v27);
                } else {
                    0x2::balance::destroy_zero<T1>(v27);
                };
                0x2::balance::join<T2>(&mut v23, v26);
                (0x2::balance::split<T1>(&mut v19, arg5), v23)
            }
        };
        if (0x1::type_name::get<T0>() == 0x1::type_name::get<T1>()) {
            let v28 = SwapBalance<T1, T2>{
                balance_a : v2,
                balance_b : v3,
            };
            0x2::dynamic_field::add<vector<u8>, SwapBalance<T1, T2>>(&mut v1, b"SwapBalance", v28);
        } else {
            let v29 = SwapBalance<T2, T1>{
                balance_a : v3,
                balance_b : v2,
            };
            0x2::dynamic_field::add<vector<u8>, SwapBalance<T2, T1>>(&mut v1, b"SwapBalance", v29);
        };
        let SwapBalance {
            balance_a : v30,
            balance_b : v31,
        } = 0x2::dynamic_field::remove<vector<u8>, SwapBalance<T0, T3>>(&mut v1, b"SwapBalance");
        0x2::object::delete(v1);
        (v30, v31)
    }

    public fun calculate_combined_swap_result<T0, T1, T2, T3>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg1: &0x2::balance::Balance<T0>, arg2: &0x2::balance::Balance<T3>, arg3: u128) : u64 {
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T1, T2>(arg0, 0x1::type_name::get<T0>() == 0x1::type_name::get<T1>(), true, 0x2::balance::value<T0>(arg1), arg3);
        0x2::balance::value<T3>(arg2) + 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v0)
    }

    public fun calculate_swap_result<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: bool, arg2: bool, arg3: u64, arg4: u128) : u64 {
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v0)
    }

    fun init(arg0: TYPUS_BLUEFIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = VERSION{dummy_field: false};
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::issue_version<TYPUS_BLUEFIN, VERSION>(&arg0, v0, arg1);
    }

    public fun swap_<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: bool, arg5: bool, arg6: u64, arg7: u64, arg8: u128, arg9: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg9, arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public fun swap_all<T0, T1, T2, T3>(arg0: &mut 0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::Version, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg3: 0x2::balance::Balance<T0>, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T3> {
        let v0 = VERSION{dummy_field: false};
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_witness<VERSION>(arg0, v0);
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_version(arg0, 1);
        if (0x2::balance::value<T0>(&arg3) == 0) {
            0x2::balance::destroy_zero<T0>(arg3);
            return 0x2::balance::zero<T3>()
        };
        let v1 = 0x1::type_name::get<T0>() == 0x1::type_name::get<T1>();
        if (calculate_swap_result<T1, T2>(arg2, v1, true, 0x2::balance::value<T0>(&arg3), arg4) == 0) {
            0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::charge_fee<T0>(arg0, arg3);
            0x2::balance::zero<T3>()
        } else {
            let v3 = 0x2::object::new(arg6);
            0x2::dynamic_field::add<vector<u8>, 0x2::balance::Balance<T0>>(&mut v3, b"IN_TOKEN", arg3);
            let (v4, v5) = if (v1) {
                (0x2::dynamic_field::remove<vector<u8>, 0x2::balance::Balance<T1>>(&mut v3, b"IN_TOKEN"), 0x2::balance::zero<T2>())
            } else {
                (0x2::balance::zero<T1>(), 0x2::dynamic_field::remove<vector<u8>, 0x2::balance::Balance<T2>>(&mut v3, b"IN_TOKEN"))
            };
            let v6 = v5;
            let v7 = v4;
            let v8 = if (v1) {
                0x2::balance::value<T1>(&v7)
            } else {
                0x2::balance::value<T2>(&v6)
            };
            let (v9, v10) = swap_<T1, T2>(arg1, arg2, v7, v6, v1, true, v8, v8, arg4, arg5);
            if (v1) {
                0x2::dynamic_field::add<vector<u8>, 0x2::balance::Balance<T2>>(&mut v3, b"OUT_TOKEN", v10);
                0x2::balance::destroy_zero<T1>(v9);
            } else {
                0x2::dynamic_field::add<vector<u8>, 0x2::balance::Balance<T1>>(&mut v3, b"OUT_TOKEN", v9);
                0x2::balance::destroy_zero<T2>(v10);
            };
            0x2::object::delete(v3);
            0x2::dynamic_field::remove<vector<u8>, 0x2::balance::Balance<T3>>(&mut v3, b"OUT_TOKEN")
        }
    }

    // decompiled from Move bytecode v6
}

