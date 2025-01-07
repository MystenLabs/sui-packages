module 0x94f6aa9e0f279a0ff4adaed9068b40df2344ddff0dea7325fd2d95c78f8e602c::cetus {
    struct Swap has copy, drop {
        protocol: 0x1::string::String,
        fund: 0x2::object::ID,
        input_coin_type: 0x1::type_name::TypeName,
        input_amount: u64,
        output_coin_type: 0x1::type_name::TypeName,
        output_amount: u64,
    }

    public fun swap<T0, T1, T2, T3>(arg0: &mut 0x94f6aa9e0f279a0ff4adaed9068b40df2344ddff0dea7325fd2d95c78f8e602c::fund::Take_1_Liquidity_For_1_Liquidity_Request<T0, T1>, arg1: &mut 0x2::balance::Balance<T2>, arg2: &mut 0x2::balance::Balance<T3>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: bool, arg6: bool, arg7: &0x2::clock::Clock) {
        let (v0, v1) = if (0x2::balance::value<T2>(arg1) == 0) {
            (0x2::balance::value<T3>(arg2), 0x1::type_name::get<T3>())
        } else {
            (0x2::balance::value<T2>(arg1), 0x1::type_name::get<T2>())
        };
        let v2 = if (arg5) {
            0x2::balance::value<T2>(arg1)
        } else {
            0x2::balance::value<T3>(arg2)
        };
        let v3 = if (arg5) {
            4295048016
        } else {
            79226673515401279992447579055
        };
        let (v4, v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg3, arg4, arg5, arg6, v2, v3, arg7);
        let v7 = v6;
        let v8 = v5;
        let v9 = v4;
        if (arg5) {
        };
        let (v10, v11) = if (arg5) {
            (0x2::balance::split<T2>(arg1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T3>(&v7)), 0x2::balance::zero<T3>())
        } else {
            (0x2::balance::zero<T2>(), 0x2::balance::split<T3>(arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T3>(&v7)))
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg3, arg4, v10, v11, v7);
        0x2::balance::join<T2>(arg1, v9);
        0x2::balance::join<T3>(arg2, v8);
        let (v12, v13) = if (0x2::balance::value<T2>(arg1) < 0x2::balance::value<T3>(arg2)) {
            (0x2::balance::value<T3>(arg2), 0x1::type_name::get<T3>())
        } else {
            (0x2::balance::value<T2>(arg1), 0x1::type_name::get<T2>())
        };
        0x94f6aa9e0f279a0ff4adaed9068b40df2344ddff0dea7325fd2d95c78f8e602c::fund::supported_defi_confirm_1l_for_1l<T0, T1>(arg0, v12);
        let v14 = Swap{
            protocol         : 0x1::string::utf8(b"Cetus"),
            fund             : 0x94f6aa9e0f279a0ff4adaed9068b40df2344ddff0dea7325fd2d95c78f8e602c::fund::fund_id_of_1l_for_1l_req<T0, T1>(arg0),
            input_coin_type  : v1,
            input_amount     : v0,
            output_coin_type : v13,
            output_amount    : v12,
        };
        0x2::event::emit<Swap>(v14);
    }

    public fun close_position_and_remove_liquidity<T0: store, T1, T2, T3, T4>(arg0: &mut 0x94f6aa9e0f279a0ff4adaed9068b40df2344ddff0dea7325fd2d95c78f8e602c::fund::Take_1_NonLiquidity_For_2_Liquidity_Request<T0, T1, T2>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T4>, arg3: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg4: u128, arg5: &0x2::clock::Clock) : (0x2::balance::Balance<T3>, 0x2::balance::Balance<T4>) {
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T3, T4>(arg1, arg2, &mut arg3, arg4, arg5);
        let v2 = v1;
        let v3 = v0;
        let (v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T3, T4>(arg1, arg2, &arg3, false);
        0x2::balance::join<T3>(&mut v3, v4);
        0x2::balance::join<T4>(&mut v2, v5);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T3, T4>(arg1, arg2, arg3);
        0x94f6aa9e0f279a0ff4adaed9068b40df2344ddff0dea7325fd2d95c78f8e602c::fund::supported_defi_confirm_1nl_for_2l<T0, T1, T2>(arg0, 0x2::balance::value<T3>(&v3), 0x2::balance::value<T4>(&v2));
        (v3, v2)
    }

    public fun drop_zero_balance<T0>(arg0: 0x2::balance::Balance<T0>) {
        0x2::balance::destroy_zero<T0>(arg0);
    }

    public fun get_position_liquidity(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position) : u128 {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(arg0)
    }

    public fun open_position_and_add_liquidity<T0, T1, T2, T3, T4>(arg0: &mut 0x94f6aa9e0f279a0ff4adaed9068b40df2344ddff0dea7325fd2d95c78f8e602c::fund::Take_2_Liquidity_For_1_NonLiquidity_Request<T0, T1, T2>, arg1: 0x2::balance::Balance<T3>, arg2: 0x2::balance::Balance<T4>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T4>, arg5: u32, arg6: u32, arg7: u128, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T3, T4>(arg3, arg4, arg5, arg6, arg9);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T3, T4>(arg3, arg4, arg1, arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity<T3, T4>(arg3, arg4, &mut v0, arg7, arg8));
        0x94f6aa9e0f279a0ff4adaed9068b40df2344ddff0dea7325fd2d95c78f8e602c::fund::supported_defi_confirm_2l_for_1nl<T0, T1, T2>(arg0, 1);
        v0
    }

    public fun take_zero_balance<T0>() : 0x2::balance::Balance<T0> {
        0x2::balance::zero<T0>()
    }

    // decompiled from Move bytecode v6
}

