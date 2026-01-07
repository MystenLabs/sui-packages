module 0x66f73158172cf41b1ea0e08bebb5fd1d3c9a3b96c0fee7fa18a8e6797097a347::swap_router {
    public fun swap_exact_x_to_y<T0, T1>(arg0: &mut 0x45984af615749ef02d9de10b870a99a8cff2a35a78920a48b267bc510b9d6cbf::universal_router::Route, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x45984af615749ef02d9de10b870a99a8cff2a35a78920a48b267bc510b9d6cbf::universal_router::borrow_mut_current_path<T0, T1>(arg0);
        let v1 = 0x45984af615749ef02d9de10b870a99a8cff2a35a78920a48b267bc510b9d6cbf::universal_router::take_coin_in<T0, T1>(v0);
        let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, true, true, 0x2::coin::value<T0>(&v1), arg3, arg4);
        let v5 = v4;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v5), arg5)), 0x2::balance::zero<T1>(), v5);
        0x2::coin::join<T0>(&mut v1, 0x2::coin::from_balance<T0>(v2, arg5));
        0x45984af615749ef02d9de10b870a99a8cff2a35a78920a48b267bc510b9d6cbf::utils::refund_if_necessary<T0>(v1, 0x2::tx_context::sender(arg5));
        0x45984af615749ef02d9de10b870a99a8cff2a35a78920a48b267bc510b9d6cbf::universal_router::fill_coin_out<T0, T1>(v0, 0x2::coin::from_balance<T1>(v3, arg5));
    }

    public fun swap_exact_y_to_x<T0, T1>(arg0: &mut 0x45984af615749ef02d9de10b870a99a8cff2a35a78920a48b267bc510b9d6cbf::universal_router::Route, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x45984af615749ef02d9de10b870a99a8cff2a35a78920a48b267bc510b9d6cbf::universal_router::borrow_mut_current_path<T1, T0>(arg0);
        let v1 = 0x45984af615749ef02d9de10b870a99a8cff2a35a78920a48b267bc510b9d6cbf::universal_router::take_coin_in<T1, T0>(v0);
        let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, false, true, 0x2::coin::value<T1>(&v1), arg3, arg4);
        let v5 = v4;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v5), arg5)), v5);
        0x2::coin::join<T1>(&mut v1, 0x2::coin::from_balance<T1>(v3, arg5));
        0x45984af615749ef02d9de10b870a99a8cff2a35a78920a48b267bc510b9d6cbf::utils::refund_if_necessary<T1>(v1, 0x2::tx_context::sender(arg5));
        0x45984af615749ef02d9de10b870a99a8cff2a35a78920a48b267bc510b9d6cbf::universal_router::fill_coin_out<T1, T0>(v0, 0x2::coin::from_balance<T0>(v2, arg5));
    }

    // decompiled from Move bytecode v6
}

