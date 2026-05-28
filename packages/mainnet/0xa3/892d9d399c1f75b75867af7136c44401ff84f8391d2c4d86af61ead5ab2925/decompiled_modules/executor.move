module 0x1af66cfc49852f6c896ab70c5832dca48db0965865c6698efbb678ed4894b501::executor {
    struct ArbExecuted has copy, drop {
        trader: address,
        coin_flash: 0x1::ascii::String,
        coin_mid: 0x1::ascii::String,
        borrow_amount: u64,
        gross_out: u64,
        net_profit: u64,
        cetus_pool_id: address,
        bluefin_pool_id: address,
        deepbook_pool_id: address,
    }

    public fun execute_2hop_bluefin_cetus<T0, T1, T2>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T2>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_base<T0, T2>(arg0, arg6, arg8);
        let (v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg5, arg3, arg4, 0x2::coin::into_balance<T0>(v0), 0x2::balance::zero<T1>(), true, true, arg6, 0, 4295048017);
        0x2::balance::destroy_zero<T0>(v2);
        let v4 = v3;
        let (v5, v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, false, true, 0x2::balance::value<T1>(&v4), 79226673515401279992447579055, arg5);
        0x2::balance::destroy_zero<T1>(v6);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), v4, v7);
        let v8 = v5;
        let v9 = 0x2::balance::value<T0>(&v8);
        assert!(v9 >= arg6, 2);
        let v10 = 0x2::coin::from_balance<T0>(v8, arg8);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_base<T0, T2>(arg0, 0x2::coin::split<T0>(&mut v10, arg6, arg8), v1);
        let v11 = 0x2::coin::value<T0>(&v10);
        assert!(v11 >= arg7, 1);
        let v12 = ArbExecuted{
            trader           : 0x2::tx_context::sender(arg8),
            coin_flash       : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            coin_mid         : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()),
            borrow_amount    : arg6,
            gross_out        : v9,
            net_profit       : v11,
            cetus_pool_id    : 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2),
            bluefin_pool_id  : 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg4),
            deepbook_pool_id : 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T2>>(arg0),
        };
        0x2::event::emit<ArbExecuted>(v12);
        v10
    }

    public fun execute_2hop_cetus_bluefin<T0, T1, T2>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T2>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_base<T0, T2>(arg0, arg6, arg8);
        let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, true, true, arg6, 4295048017, arg5);
        0x2::balance::destroy_zero<T0>(v2);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::coin::into_balance<T0>(v0), 0x2::balance::zero<T1>(), v4);
        let v5 = v3;
        let (v6, v7) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg5, arg3, arg4, 0x2::balance::zero<T0>(), v5, false, true, 0x2::balance::value<T1>(&v5), 0, 79226673515401279992447579054);
        let v8 = v6;
        0x2::balance::destroy_zero<T1>(v7);
        let v9 = 0x2::balance::value<T0>(&v8);
        assert!(v9 >= arg6, 2);
        let v10 = 0x2::coin::from_balance<T0>(v8, arg8);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_base<T0, T2>(arg0, 0x2::coin::split<T0>(&mut v10, arg6, arg8), v1);
        let v11 = 0x2::coin::value<T0>(&v10);
        assert!(v11 >= arg7, 1);
        let v12 = ArbExecuted{
            trader           : 0x2::tx_context::sender(arg8),
            coin_flash       : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            coin_mid         : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()),
            borrow_amount    : arg6,
            gross_out        : v9,
            net_profit       : v11,
            cetus_pool_id    : 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2),
            bluefin_pool_id  : 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg4),
            deepbook_pool_id : 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T2>>(arg0),
        };
        0x2::event::emit<ArbExecuted>(v12);
        v10
    }

    // decompiled from Move bytecode v7
}

