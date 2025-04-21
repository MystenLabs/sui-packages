module 0x62d6b59a4711ed9bc10d6429eba9e4154614539029c06c1bed3ee93f400472bb::typus_cetus {
    struct TYPUS_CETUS has drop {
        dummy_field: bool,
    }

    struct VERSION has drop {
        dummy_field: bool,
    }

    public fun swap<T0, T1>(arg0: &mut 0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::Version, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>, arg5: bool, arg6: u128, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_authority(arg0, arg8);
        let v0 = VERSION{dummy_field: false};
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_witness<VERSION>(arg0, v0);
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_version(arg0, 1);
        if (arg5 && 0x2::balance::value<T0>(&arg3) == 0 || !arg5 && 0x2::balance::value<T1>(&arg4) == 0) {
            return (arg3, arg4)
        };
        let v1 = if (arg5) {
            0x2::balance::value<T0>(&arg3)
        } else {
            0x2::balance::value<T1>(&arg4)
        };
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg2, arg5, true, v1);
        let (v3, v4) = if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v2) == 0) {
            0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::charge_fee<T0>(arg0, 0x2::balance::withdraw_all<T0>(&mut arg3));
            0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::charge_fee<T1>(arg0, 0x2::balance::withdraw_all<T1>(&mut arg4));
            (arg4, arg3)
        } else {
            let v5 = 0x2::coin::from_balance<T0>(arg3, arg8);
            let v6 = 0x2::coin::from_balance<T1>(arg4, arg8);
            let (v7, v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, arg5, true, v1, arg6, arg7);
            let v10 = v9;
            let v11 = v8;
            let v12 = v7;
            if (arg5) {
            };
            let (v13, v14) = if (arg5) {
                (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v5, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v10), arg8)), 0x2::balance::zero<T1>())
            } else {
                (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v6, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v10), arg8)))
            };
            0x2::coin::join<T1>(&mut v6, 0x2::coin::from_balance<T1>(v11, arg8));
            0x2::coin::join<T0>(&mut v5, 0x2::coin::from_balance<T0>(v12, arg8));
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, v13, v14, v10);
            (0x2::coin::into_balance<T1>(v6), 0x2::coin::into_balance<T0>(v5))
        };
        (v4, v3)
    }

    fun init(arg0: TYPUS_CETUS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = VERSION{dummy_field: false};
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::issue_version<TYPUS_CETUS, VERSION>(&arg0, v0, arg1);
    }

    // decompiled from Move bytecode v6
}

