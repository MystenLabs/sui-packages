module 0x1d58d7073a11aa9c5aa54e85ce2ff4b6199a4974579c8c4d7a89030b099a1a20::typus_momentum {
    struct TYPUS_MOMENTUM has drop {
        dummy_field: bool,
    }

    struct VERSION has drop {
        dummy_field: bool,
    }

    struct SwapBalance<phantom T0, phantom T1> has store {
        balance_a: 0x2::balance::Balance<T0>,
        balance_b: 0x2::balance::Balance<T1>,
    }

    public fun swap<T0, T1, T2, T3>(arg0: &mut 0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::Version, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T2>, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T3>, arg5: u64, arg6: u128, arg7: u128, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T3>) {
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
                let (v8, v9) = swap_<T1, T2>(arg1, arg2, v5, 0x2::balance::zero<T2>(), true, false, arg5 - 0x2::balance::value<T2>(&v7), arg6, arg8, arg9);
                0x2::balance::join<T2>(&mut v7, v9);
                (v8, v7)
            } else {
                let v10 = v5;
                let (v11, v12) = swap_<T1, T2>(arg1, arg2, 0x2::balance::zero<T1>(), v7, false, true, 0x2::balance::value<T2>(&v7), arg7, arg8, arg9);
                let v13 = v12;
                if (0x2::balance::value<T2>(&v13) > 0) {
                    0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::charge_fee<T2>(arg0, v13);
                } else {
                    0x2::balance::destroy_zero<T2>(v13);
                };
                0x2::balance::join<T1>(&mut v10, v11);
                (v10, 0x2::balance::split<T2>(&mut v7, arg5))
            }
        } else {
            let v14 = SwapBalance<T3, T0>{
                balance_a : arg4,
                balance_b : arg3,
            };
            0x2::dynamic_field::add<vector<u8>, SwapBalance<T3, T0>>(&mut v1, b"SwapBalance", v14);
            let SwapBalance {
                balance_a : v15,
                balance_b : v16,
            } = 0x2::dynamic_field::remove<vector<u8>, SwapBalance<T1, T2>>(&mut v1, b"SwapBalance");
            let v17 = v15;
            if (0x2::balance::value<T1>(&v17) < arg5) {
                let (v18, v19) = swap_<T1, T2>(arg1, arg2, 0x2::balance::zero<T1>(), v16, false, false, arg5 - 0x2::balance::value<T1>(&v17), arg7, arg8, arg9);
                0x2::balance::join<T1>(&mut v17, v18);
                (v17, v19)
            } else {
                let v20 = v16;
                let (v21, v22) = swap_<T1, T2>(arg1, arg2, v17, 0x2::balance::zero<T2>(), true, true, 0x2::balance::value<T1>(&v17), arg6, arg8, arg9);
                let v23 = v21;
                if (0x2::balance::value<T1>(&v23) > 0) {
                    0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::charge_fee<T1>(arg0, v23);
                } else {
                    0x2::balance::destroy_zero<T1>(v23);
                };
                0x2::balance::join<T2>(&mut v20, v22);
                (0x2::balance::split<T1>(&mut v17, arg5), v20)
            }
        };
        if (0x1::type_name::get<T0>() == 0x1::type_name::get<T1>()) {
            let v24 = SwapBalance<T1, T2>{
                balance_a : v2,
                balance_b : v3,
            };
            0x2::dynamic_field::add<vector<u8>, SwapBalance<T1, T2>>(&mut v1, b"SwapBalance", v24);
        } else {
            let v25 = SwapBalance<T2, T1>{
                balance_a : v3,
                balance_b : v2,
            };
            0x2::dynamic_field::add<vector<u8>, SwapBalance<T2, T1>>(&mut v1, b"SwapBalance", v25);
        };
        let SwapBalance {
            balance_a : v26,
            balance_b : v27,
        } = 0x2::dynamic_field::remove<vector<u8>, SwapBalance<T0, T3>>(&mut v1, b"SwapBalance");
        0x2::object::delete(v1);
        (v26, v27)
    }

    public fun calculate_combined_swap_result<T0, T1, T2, T3>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T2>, arg1: &0x2::balance::Balance<T0>, arg2: &0x2::balance::Balance<T3>, arg3: u128) : u64 {
        let v0 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::compute_swap_result<T1, T2>(arg0, 0x1::type_name::get<T0>() == 0x1::type_name::get<T1>(), true, arg3, 0x2::balance::value<T0>(arg1));
        0x2::balance::value<T3>(arg2) + 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_calculated(&v0)
    }

    public fun calculate_swap_result<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: bool, arg2: bool, arg3: u64, arg4: u128) : u64 {
        let v0 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::compute_swap_result<T0, T1>(arg0, arg1, arg2, arg4, arg3);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_calculated(&v0)
    }

    fun init(arg0: TYPUS_MOMENTUM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = VERSION{dummy_field: false};
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::issue_version<TYPUS_MOMENTUM, VERSION>(&arg0, v0, arg1);
    }

    public fun swap_<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: bool, arg5: bool, arg6: u64, arg7: u128, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg1, arg4, arg5, arg6, arg7, arg8, arg0, arg9);
        let v3 = v2;
        0x2::balance::join<T0>(&mut arg2, v0);
        0x2::balance::join<T1>(&mut arg3, v1);
        let (v4, v5) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v3);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg1, v3, 0x2::balance::split<T0>(&mut arg2, v4), 0x2::balance::split<T1>(&mut arg3, v5), arg0, arg9);
        (arg2, arg3)
    }

    public fun swap_all<T0, T1, T2, T3>(arg0: &mut 0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::Version, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T2>, arg3: 0x2::balance::Balance<T0>, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T3> {
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
            let (v9, v10) = swap_<T1, T2>(arg1, arg2, v7, v6, v1, true, v8, arg4, arg5, arg6);
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

    public fun swap_all_with_dov_witness<T0, T1, T2, T3>(arg0: &mut 0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::Version, arg1: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T2>, arg4: 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::witness_lock::HotPotato<0x2::balance::Balance<T0>>, arg5: u128, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::witness_lock::HotPotato<0x2::balance::Balance<T3>> {
        let v0 = VERSION{dummy_field: false};
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_witness<VERSION>(arg0, v0);
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_version(arg0, 1);
        let v1 = VERSION{dummy_field: false};
        let v2 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::witness_lock::unwrap<0x2::balance::Balance<T0>, VERSION>(arg1, arg4, v1);
        if (0x2::balance::value<T0>(&v2) == 0) {
            0x2::balance::destroy_zero<T0>(v2);
            return 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::witness_lock::wrap<0x2::balance::Balance<T3>>(arg1, 0x2::balance::zero<T3>(), 0x1::string::utf8(b"41c2ce88ae16d1cb8e639a792df065aea5c08a90dfd7ac5d3c5cdc4d93c8916e::typus_dov_single::WITNESS"))
        };
        let v3 = 0x1::type_name::get<T0>() == 0x1::type_name::get<T1>();
        let v4 = if (calculate_swap_result<T1, T2>(arg3, v3, true, 0x2::balance::value<T0>(&v2), arg5) == 0) {
            0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::charge_fee<T0>(arg0, v2);
            0x2::balance::zero<T3>()
        } else {
            let v5 = 0x2::object::new(arg7);
            0x2::dynamic_field::add<vector<u8>, 0x2::balance::Balance<T0>>(&mut v5, b"IN_TOKEN", v2);
            let (v6, v7) = if (v3) {
                (0x2::dynamic_field::remove<vector<u8>, 0x2::balance::Balance<T1>>(&mut v5, b"IN_TOKEN"), 0x2::balance::zero<T2>())
            } else {
                (0x2::balance::zero<T1>(), 0x2::dynamic_field::remove<vector<u8>, 0x2::balance::Balance<T2>>(&mut v5, b"IN_TOKEN"))
            };
            let v8 = v7;
            let v9 = v6;
            let v10 = if (v3) {
                0x2::balance::value<T1>(&v9)
            } else {
                0x2::balance::value<T2>(&v8)
            };
            let (v11, v12) = swap_<T1, T2>(arg2, arg3, v9, v8, v3, true, v10, arg5, arg6, arg7);
            if (v3) {
                0x2::dynamic_field::add<vector<u8>, 0x2::balance::Balance<T2>>(&mut v5, b"OUT_TOKEN", v12);
                0x2::balance::destroy_zero<T1>(v11);
            } else {
                0x2::dynamic_field::add<vector<u8>, 0x2::balance::Balance<T1>>(&mut v5, b"OUT_TOKEN", v11);
                0x2::balance::destroy_zero<T2>(v12);
            };
            0x2::object::delete(v5);
            0x2::dynamic_field::remove<vector<u8>, 0x2::balance::Balance<T3>>(&mut v5, b"OUT_TOKEN")
        };
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::witness_lock::wrap<0x2::balance::Balance<T3>>(arg1, v4, 0x1::string::utf8(b"41c2ce88ae16d1cb8e639a792df065aea5c08a90dfd7ac5d3c5cdc4d93c8916e::typus_dov_single::WITNESS"))
    }

    // decompiled from Move bytecode v6
}

