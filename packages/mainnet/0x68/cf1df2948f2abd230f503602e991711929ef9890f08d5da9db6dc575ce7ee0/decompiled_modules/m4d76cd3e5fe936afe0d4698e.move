module 0x68cf1df2948f2abd230f503602e991711929ef9890f08d5da9db6dc575ce7ee0::m4d76cd3e5fe936afe0d4698e {
    public(friend) fun f1ad62257703307c46df10aa3<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, 0x2::coin::value<T0>(&arg2), arg4, arg5);
        let v3 = v2;
        let v4 = v1;
        0x2::balance::destroy_zero<T0>(v0);
        assert!(0x2::balance::value<T1>(&v4) >= arg3, 0);
        let v5 = 0x2::coin::into_balance<T0>(arg2);
        0x2::balance::destroy_zero<T0>(v5);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v5, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3)), 0x2::balance::zero<T1>(), v3);
        0x2::coin::from_balance<T1>(v4, arg6)
    }

    public(friend) fun fa486197dfb38e04d01f2cce5<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, 0x2::coin::value<T1>(&arg2), arg4, arg5);
        let v3 = v2;
        let v4 = v0;
        0x2::balance::destroy_zero<T1>(v1);
        assert!(0x2::balance::value<T0>(&v4) >= arg3, 0);
        let v5 = 0x2::coin::into_balance<T1>(arg2);
        0x2::balance::destroy_zero<T1>(v5);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v5, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3)), v3);
        0x2::coin::from_balance<T0>(v4, arg6)
    }

    // decompiled from Move bytecode v7
}

