module 0x14044dc5ec6391b8afe6c2b1480e032fb2489b27966e68b9c3273343d0a71111::typus_mmt {
    struct TYPUS_MMT has drop {
        dummy_field: bool,
    }

    struct VERSION has drop {
        dummy_field: bool,
    }

    fun init(arg0: TYPUS_MMT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = VERSION{dummy_field: false};
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::issue_version<TYPUS_MMT, VERSION>(&arg0, v0, arg1);
    }

    public fun swap_dov<T0, T1, T2, T3>(arg0: &mut 0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::Version, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T2>, arg3: 0x2::balance::Balance<T0>, arg4: bool, arg5: u128, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T3> {
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_authority(arg0, arg7);
        let v0 = VERSION{dummy_field: false};
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_witness<VERSION>(arg0, v0);
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_version(arg0, 1);
        if (0x2::balance::value<T0>(&arg3) == 0) {
            0x2::balance::destroy_zero<T0>(arg3);
            return 0x2::balance::zero<T3>()
        };
        let v1 = 0x2::balance::value<T0>(&arg3);
        let v2 = swap_result<T1, T2>(arg2, arg4, true, v1, arg5);
        if (v2 == 0) {
            0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::charge_fee<T0>(arg0, arg3);
            0x2::balance::zero<T3>()
        } else {
            let (v4, v5, v6) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T1, T2>(arg2, arg4, true, v1, arg5, arg6, arg1, arg7);
            let v7 = 0x2::object::new(arg7);
            0x2::dynamic_field::add<vector<u8>, 0x2::balance::Balance<T0>>(&mut v7, b"IN_TOKEN", arg3);
            let (v8, v9, v10) = if (arg4) {
                0x2::dynamic_field::add<vector<u8>, 0x2::balance::Balance<T2>>(&mut v7, b"OUT_TOKEN", v5);
                0x2::balance::destroy_zero<T1>(v4);
                (0x2::dynamic_field::remove<vector<u8>, 0x2::balance::Balance<T1>>(&mut v7, b"IN_TOKEN"), 0x2::balance::zero<T2>(), 0x2::dynamic_field::remove<vector<u8>, 0x2::balance::Balance<T3>>(&mut v7, b"OUT_TOKEN"))
            } else {
                0x2::dynamic_field::add<vector<u8>, 0x2::balance::Balance<T1>>(&mut v7, b"OUT_TOKEN", v4);
                0x2::balance::destroy_zero<T2>(v5);
                (0x2::balance::zero<T1>(), 0x2::dynamic_field::remove<vector<u8>, 0x2::balance::Balance<T2>>(&mut v7, b"IN_TOKEN"), 0x2::dynamic_field::remove<vector<u8>, 0x2::balance::Balance<T3>>(&mut v7, b"OUT_TOKEN"))
            };
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T1, T2>(arg2, v6, v8, v9, arg1, arg7);
            0x2::object::delete(v7);
            v10
        }
    }

    public fun swap_result<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: bool, arg2: bool, arg3: u64, arg4: u128) : u64 {
        let v0 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::compute_swap_result<T0, T1>(arg0, arg1, arg2, arg4, arg3);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_calculated(&v0)
    }

    public fun swap_result_safu<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: bool, arg2: &0x2::balance::Balance<T0>, arg3: &0x2::balance::Balance<T1>, arg4: u128) : u64 {
        let v0 = if (arg1) {
            0x2::balance::value<T0>(arg2)
        } else {
            0x2::balance::value<T1>(arg3)
        };
        let v1 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::compute_swap_result<T0, T1>(arg0, arg1, true, arg4, v0);
        if (arg1) {
            0x2::balance::value<T1>(arg3) + 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_calculated(&v1)
        } else {
            0x2::balance::value<T0>(arg2) + 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_calculated(&v1)
        }
    }

    public fun swap_safu<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: bool, arg5: bool, arg6: u64, arg7: u128, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg1, arg4, arg5, arg6, arg7, arg8, arg0, arg9);
        let v3 = v2;
        0x2::balance::join<T0>(&mut arg2, v0);
        0x2::balance::join<T1>(&mut arg3, v1);
        let (v4, v5) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v3);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg1, v3, 0x2::balance::split<T0>(&mut arg2, v4), 0x2::balance::split<T1>(&mut arg3, v5), arg0, arg9);
        (arg2, arg3)
    }

    public fun swap_safu_to_bid_value<T0, T1>(arg0: &mut 0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::Version, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>, arg5: bool, arg6: u64, arg7: u128, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_authority(arg0, arg9);
        let v0 = VERSION{dummy_field: false};
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_witness<VERSION>(arg0, v0);
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_version(arg0, 1);
        if (arg5) {
            if (0x2::balance::value<T1>(&arg4) < arg6) {
                let (v3, v4) = swap_safu<T0, T1>(arg1, arg2, arg3, 0x2::balance::zero<T1>(), true, false, arg6 - 0x2::balance::value<T1>(&arg4), arg7, arg8, arg9);
                0x2::balance::join<T1>(&mut arg4, v4);
                (v3, arg4)
            } else {
                let (v5, v6) = swap_safu<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), arg4, false, true, 0x2::balance::value<T1>(&arg4), arg7, arg8, arg9);
                let v7 = v6;
                if (0x2::balance::value<T1>(&v7) > 0) {
                    0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::charge_fee<T1>(arg0, v7);
                } else {
                    0x2::balance::destroy_zero<T1>(v7);
                };
                0x2::balance::join<T0>(&mut arg3, v5);
                (arg3, 0x2::balance::split<T1>(&mut arg4, arg6))
            }
        } else if (0x2::balance::value<T0>(&arg3) < arg6) {
            let (v8, v9) = swap_safu<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), arg4, false, false, arg6 - 0x2::balance::value<T0>(&arg3), arg7, arg8, arg9);
            0x2::balance::join<T0>(&mut arg3, v8);
            (arg3, v9)
        } else {
            let (v10, v11) = swap_safu<T0, T1>(arg1, arg2, arg3, 0x2::balance::zero<T1>(), true, true, 0x2::balance::value<T0>(&arg3), arg7, arg8, arg9);
            let v12 = v10;
            if (0x2::balance::value<T0>(&v12) > 0) {
                0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::charge_fee<T0>(arg0, v12);
            } else {
                0x2::balance::destroy_zero<T0>(v12);
            };
            0x2::balance::join<T1>(&mut arg4, v11);
            (0x2::balance::split<T0>(&mut arg3, arg6), arg4)
        }
    }

    // decompiled from Move bytecode v6
}

