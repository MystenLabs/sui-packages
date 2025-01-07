module 0x82bfa7a6c43ae6ee446f053ba7064937c3da00b2c89c02ef565212943c56c74c::cetus {
    struct Swap has copy, drop {
        protocol: 0x1::string::String,
        input_coin_type: 0x1::type_name::TypeName,
        input_amount: u64,
        output_coin_type: 0x1::type_name::TypeName,
        output_amount: u64,
    }

    public fun swap<T0, T1, T2, T3, T4>(arg0: &mut 0x82bfa7a6c43ae6ee446f053ba7064937c3da00b2c89c02ef565212943c56c74c::fund::Take_1_Liquidity_For_2_Liquidity_Request<T0, T1, T2>, arg1: &mut 0x2::balance::Balance<T3>, arg2: &mut 0x2::balance::Balance<T4>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T4>, arg5: bool, arg6: bool, arg7: &0x2::clock::Clock) {
        let v0 = if (0x2::balance::value<T3>(arg1) == 0) {
            0x2::balance::value<T4>(arg2);
            0x1::type_name::get<T4>()
        } else {
            0x2::balance::value<T3>(arg1);
            0x1::type_name::get<T3>()
        };
        let v1 = if (arg6) {
            0x2::balance::value<T3>(arg1)
        } else {
            0x2::balance::value<T4>(arg2)
        };
        let v2 = if (arg5) {
            4295048016
        } else {
            79226673515401279992447579055
        };
        let (v3, v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T3, T4>(arg3, arg4, arg5, arg6, v1, v2, arg7);
        let v6 = v5;
        let v7 = v4;
        let v8 = v3;
        if (arg5) {
        };
        let (v9, v10) = if (arg5) {
            (0x2::balance::split<T3>(arg1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T3, T4>(&v6)), 0x2::balance::zero<T4>())
        } else {
            (0x2::balance::zero<T3>(), 0x2::balance::split<T4>(arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T3, T4>(&v6)))
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T3, T4>(arg3, arg4, v9, v10, v6);
        0x2::balance::join<T3>(arg1, v8);
        0x2::balance::join<T4>(arg2, v7);
        let (v11, v12, v13) = if (0x2::balance::value<T3>(arg1) < 0x2::balance::value<T4>(arg2)) {
            (0x2::balance::value<T3>(arg1), 0x2::balance::value<T4>(arg2), 0x1::type_name::get<T4>())
        } else {
            (0x2::balance::value<T4>(arg2), 0x2::balance::value<T3>(arg1), 0x1::type_name::get<T3>())
        };
        0x82bfa7a6c43ae6ee446f053ba7064937c3da00b2c89c02ef565212943c56c74c::fund::supported_defi_confirm_1l_for_2l<T0, T1, T2>(arg0, v11, v12);
        let v14 = Swap{
            protocol         : 0x1::string::utf8(b"Cetus"),
            input_coin_type  : v0,
            input_amount     : v11,
            output_coin_type : v13,
            output_amount    : v12,
        };
        0x2::event::emit<Swap>(v14);
    }

    public fun drop_zero_balance<T0>(arg0: 0x2::balance::Balance<T0>) {
        0x2::balance::destroy_zero<T0>(arg0);
    }

    public fun take_zero_balance<T0>() : 0x2::balance::Balance<T0> {
        0x2::balance::zero<T0>()
    }

    // decompiled from Move bytecode v6
}

