module 0x36e16a2b2b5072508cee656180592d036ceb3be94cbb76fecbdf96b9ebf65611::typus_cetus {
    struct TYPUS_CETUS has drop {
        dummy_field: bool,
    }

    struct VERSION has drop {
        dummy_field: bool,
    }

    public fun swap<T0, T1, T2, T3>(arg0: &mut 0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::Version, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: 0x2::balance::Balance<T0>, arg4: bool, arg5: u128, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T3> {
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_authority(arg0, arg7);
        let v0 = VERSION{dummy_field: false};
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_witness<VERSION>(arg0, v0);
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_version(arg0, 1);
        if (0x2::balance::value<T0>(&arg3) == 0) {
            0x2::balance::destroy_zero<T0>(arg3);
            return 0x2::balance::zero<T3>()
        };
        let v1 = 0x2::balance::value<T0>(&arg3);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T1, T2>(arg2, arg4, true, v1);
        if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v2) == 0) {
            0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::charge_fee<T0>(arg0, arg3);
            0x2::balance::zero<T3>()
        } else {
            let (v4, v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T2>(arg1, arg2, arg4, true, v1, arg5, arg6);
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
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T2>(arg1, arg2, v8, v9, v6);
            0x2::object::delete(v7);
            v10
        }
    }

    fun init(arg0: TYPUS_CETUS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = VERSION{dummy_field: false};
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::issue_version<TYPUS_CETUS, VERSION>(&arg0, v0, arg1);
    }

    // decompiled from Move bytecode v6
}

