module 0xee235bc78354f9ae169aa94137402227a25585daac8612572a85337880665cd8::typus_cetus {
    struct TYPUS_CETUS has drop {
        dummy_field: bool,
    }

    struct VERSION has drop {
        dummy_field: bool,
    }

    public fun swap<T0, T1>(arg0: &mut 0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::Version, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>, arg5: bool, arg6: bool, arg7: u64, arg8: u128, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_authority(arg0, arg10);
        let v0 = VERSION{dummy_field: false};
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_witness<VERSION>(arg0, v0);
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_version(arg0, 1);
        if (arg5 && 0x2::balance::value<T0>(&arg3) == 0 || !arg5 && 0x2::balance::value<T1>(&arg4) == 0) {
            0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::charge_fee<T0>(arg0, 0x2::balance::withdraw_all<T0>(&mut arg3));
            0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::charge_fee<T1>(arg0, 0x2::balance::withdraw_all<T1>(&mut arg4));
            return (arg3, arg4)
        };
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg2, arg5, arg6, arg7);
        if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v1) == 0) {
            0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::charge_fee<T0>(arg0, 0x2::balance::withdraw_all<T0>(&mut arg3));
            0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::charge_fee<T1>(arg0, 0x2::balance::withdraw_all<T1>(&mut arg4));
            (arg3, arg4)
        } else {
            let v4 = 0x2::coin::from_balance<T0>(arg3, arg10);
            let v5 = 0x2::coin::from_balance<T1>(arg4, arg10);
            let (v6, v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, arg5, arg6, arg7, arg8, arg9);
            let v9 = v8;
            let v10 = v7;
            let v11 = v6;
            if (arg5) {
            };
            let (v12, v13) = if (arg5) {
                (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v9), arg10)), 0x2::balance::zero<T1>())
            } else {
                (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v5, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v9), arg10)))
            };
            0x2::coin::join<T1>(&mut v5, 0x2::coin::from_balance<T1>(v10, arg10));
            0x2::coin::join<T0>(&mut v4, 0x2::coin::from_balance<T0>(v11, arg10));
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, v12, v13, v9);
            (0x2::coin::into_balance<T0>(v4), 0x2::coin::into_balance<T1>(v5))
        }
    }

    fun init(arg0: TYPUS_CETUS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = VERSION{dummy_field: false};
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::issue_version<TYPUS_CETUS, VERSION>(&arg0, v0, arg1);
    }

    // decompiled from Move bytecode v6
}

