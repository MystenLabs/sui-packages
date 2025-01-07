module 0x2917e31f6f2e84cbbc0e92ab110a402e8a5d08a6544badd903f34c5edd35b95c::cetus {
    struct Swap has copy, drop {
        protocol: 0x1::string::String,
        input_coin_type: 0x1::type_name::TypeName,
        input_amount: u64,
        output_coin_type: 0x1::type_name::TypeName,
        output_amount: u64,
    }

    public fun swap<T0, T1>(arg0: &mut 0x2917e31f6f2e84cbbc0e92ab110a402e8a5d08a6544badd903f34c5edd35b95c::fund::Take_1_Liquidity_For_1_Liquidity_Request<T0, T1>, arg1: &mut 0x2::balance::Balance<T0>, arg2: &mut 0x2::balance::Balance<T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: bool, arg6: bool, arg7: &0x2::clock::Clock) {
        let (v0, v1) = if (0x2::balance::value<T0>(arg1) == 0) {
            (0x2::balance::value<T1>(arg2), 0x1::type_name::get<T1>())
        } else {
            (0x2::balance::value<T0>(arg1), 0x1::type_name::get<T0>())
        };
        let v2 = if (arg6) {
            0x2::balance::value<T0>(arg1)
        } else {
            0x2::balance::value<T1>(arg2)
        };
        let v3 = if (arg5) {
            4295048016
        } else {
            79226673515401279992447579055
        };
        let (v4, v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg3, arg4, arg5, arg6, v2, v3, arg7);
        let v7 = v6;
        let v8 = v5;
        let v9 = v4;
        if (arg5) {
        };
        let (v10, v11) = if (arg5) {
            (0x2::balance::split<T0>(arg1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v7)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::split<T1>(arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v7)))
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg3, arg4, v10, v11, v7);
        0x2::balance::join<T0>(arg1, v9);
        0x2::balance::join<T1>(arg2, v8);
        0x2917e31f6f2e84cbbc0e92ab110a402e8a5d08a6544badd903f34c5edd35b95c::fund::supported_defi_confirm_1l_for_1l<T0, T1>(arg0, 0x2::balance::value<T1>(arg2));
        let (v12, v13) = if (0x2::balance::value<T0>(arg1) == 0) {
            (0x2::balance::value<T1>(arg2), 0x1::type_name::get<T1>())
        } else {
            (0x2::balance::value<T0>(arg1), 0x1::type_name::get<T0>())
        };
        let v14 = Swap{
            protocol         : 0x1::string::utf8(b"Cetus"),
            input_coin_type  : v1,
            input_amount     : v0,
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

