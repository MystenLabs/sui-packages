module 0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::xr {
    public fun kf0<T0, T1>(arg0: &mut 0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::Ht, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock) : (0x2::balance::Balance<T1>, 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>) {
        let v0 = 0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::bl(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2), true);
        if (!0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::ia(arg0)) {
            return (0x2::balance::zero<T1>(), 0x1::option::none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>())
        };
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, true, true, v0, 4295048017, arg3);
        let v4 = v3;
        0x2::balance::destroy_zero<T0>(v1);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4) == v0, 159);
        (v2, 0x1::option::some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>(v4))
    }

    public fun kf1<T0, T1>(arg0: &mut 0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::Ht, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>) {
        let v0 = 0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::bl(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2), false);
        if (!0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::ia(arg0)) {
            return (0x2::balance::zero<T0>(), 0x1::option::none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>())
        };
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, false, true, v0, 79226673515401279992447579054, arg3);
        let v4 = v3;
        0x2::balance::destroy_zero<T1>(v2);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4) == v0, 159);
        (v1, 0x1::option::some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>(v4))
    }

    public fun kg0<T0, T1>(arg0: &0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::Ht, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>, arg4: 0x2::balance::Balance<T0>) : 0x2::balance::Balance<T0> {
        if (!0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::ia(arg0)) {
            assert!(0x1::option::is_none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>(&arg3), 160);
            0x1::option::destroy_none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>(arg3);
            return arg4
        };
        assert!(0x1::option::is_some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>(&arg3), 160);
        let v0 = 0x1::option::destroy_some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>(arg3);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::tk<T0>(&mut arg4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v0)), 0x2::balance::zero<T1>(), v0);
        arg4
    }

    public fun kg1<T0, T1>(arg0: &0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::Ht, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>, arg4: 0x2::balance::Balance<T1>) : 0x2::balance::Balance<T1> {
        if (!0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::ia(arg0)) {
            assert!(0x1::option::is_none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>(&arg3), 160);
            0x1::option::destroy_none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>(arg3);
            return arg4
        };
        assert!(0x1::option::is_some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>(&arg3), 160);
        let v0 = 0x1::option::destroy_some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>(arg3);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), 0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::tk<T1>(&mut arg4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v0)), v0);
        arg4
    }

    public fun ks0<T0, T1>(arg0: &mut 0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::Ht, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T0>, arg4: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::bl(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2), true);
        if (!0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::ia(arg0)) {
            0x2::balance::destroy_zero<T0>(arg3);
            return 0x2::balance::zero<T1>()
        };
        let v0 = 0x2::balance::value<T0>(&arg3);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, true, true, v0, 4295048017, arg4);
        let v4 = v3;
        0x2::balance::destroy_zero<T0>(v1);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4) == v0, 159);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, arg3, 0x2::balance::zero<T1>(), v4);
        v2
    }

    public fun ks1<T0, T1>(arg0: &mut 0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::Ht, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T1>, arg4: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::bl(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2), false);
        if (!0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::ia(arg0)) {
            0x2::balance::destroy_zero<T1>(arg3);
            return 0x2::balance::zero<T0>()
        };
        let v0 = 0x2::balance::value<T1>(&arg3);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, false, true, v0, 79226673515401279992447579054, arg4);
        let v4 = v3;
        0x2::balance::destroy_zero<T1>(v2);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4) == v0, 159);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), arg3, v4);
        v1
    }

    public fun os0<T0, T1>(arg0: &mut 0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::Ht, arg1: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg2: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg3: 0x2::balance::Balance<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::bl(arg0, 0x2::object::id<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>>(arg1), true);
        if (!0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::ia(arg0)) {
            0x2::balance::destroy_zero<T0>(arg3);
            return 0x2::balance::zero<T1>()
        };
        0xedba532f241fb7482daa825457fca7577095dd5f575d9c573286dc7d58c8fad0::oracle_pool::a2b<T0, T1>(arg1, arg2, arg3, arg4, arg5)
    }

    public fun os1<T0, T1>(arg0: &mut 0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::Ht, arg1: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg2: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg3: 0x2::balance::Balance<T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::bl(arg0, 0x2::object::id<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>>(arg1), false);
        if (!0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::ia(arg0)) {
            0x2::balance::destroy_zero<T1>(arg3);
            return 0x2::balance::zero<T0>()
        };
        0xedba532f241fb7482daa825457fca7577095dd5f575d9c573286dc7d58c8fad0::oracle_pool::b2a<T0, T1>(arg1, arg2, arg3, arg4, arg5)
    }

    public fun pf0<T0, T1>(arg0: &mut 0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::Ht, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock) : (0x2::balance::Balance<T1>, 0x1::option::Option<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>) {
        let v0 = 0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::bl(arg0, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2), true);
        if (!0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::ia(arg0)) {
            return (0x2::balance::zero<T1>(), 0x1::option::none<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>())
        };
        let (v1, v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg3, arg1, arg2, true, true, v0, 4295048017);
        let v4 = v3;
        0x2::balance::destroy_zero<T0>(v1);
        assert!(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v4) == v0, 159);
        (v2, 0x1::option::some<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>(v4))
    }

    public fun pf1<T0, T1>(arg0: &mut 0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::Ht, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x1::option::Option<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>) {
        let v0 = 0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::bl(arg0, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2), false);
        if (!0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::ia(arg0)) {
            return (0x2::balance::zero<T0>(), 0x1::option::none<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>())
        };
        let (v1, v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg3, arg1, arg2, false, true, v0, 79226673515401279992447579054);
        let v4 = v3;
        0x2::balance::destroy_zero<T1>(v2);
        assert!(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v4) == v0, 159);
        (v1, 0x1::option::some<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>(v4))
    }

    public fun pg0<T0, T1>(arg0: &0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::Ht, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x1::option::Option<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>, arg4: 0x2::balance::Balance<T0>) : 0x2::balance::Balance<T0> {
        if (!0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::ia(arg0)) {
            assert!(0x1::option::is_none<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>(&arg3), 160);
            0x1::option::destroy_none<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>(arg3);
            return arg4
        };
        assert!(0x1::option::is_some<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>(&arg3), 160);
        let v0 = 0x1::option::destroy_some<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>(arg3);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::tk<T0>(&mut arg4, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v0)), 0x2::balance::zero<T1>(), v0);
        arg4
    }

    public fun pg1<T0, T1>(arg0: &0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::Ht, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x1::option::Option<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>, arg4: 0x2::balance::Balance<T1>) : 0x2::balance::Balance<T1> {
        if (!0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::ia(arg0)) {
            assert!(0x1::option::is_none<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>(&arg3), 160);
            0x1::option::destroy_none<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>(arg3);
            return arg4
        };
        assert!(0x1::option::is_some<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>(&arg3), 160);
        let v0 = 0x1::option::destroy_some<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>(arg3);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), 0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::tk<T1>(&mut arg4, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v0)), v0);
        arg4
    }

    public fun ps0<T0, T1>(arg0: &mut 0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::Ht, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T0>, arg4: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::bl(arg0, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2), true);
        if (!0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::ia(arg0)) {
            0x2::balance::destroy_zero<T0>(arg3);
            return 0x2::balance::zero<T1>()
        };
        let v0 = 0x2::balance::value<T0>(&arg3);
        let (v1, v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg4, arg1, arg2, true, true, v0, 4295048017);
        let v4 = v3;
        0x2::balance::destroy_zero<T0>(v1);
        assert!(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v4) == v0, 159);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, arg3, 0x2::balance::zero<T1>(), v4);
        v2
    }

    public fun ps1<T0, T1>(arg0: &mut 0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::Ht, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T1>, arg4: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::bl(arg0, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2), false);
        if (!0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::ia(arg0)) {
            0x2::balance::destroy_zero<T1>(arg3);
            return 0x2::balance::zero<T0>()
        };
        let v0 = 0x2::balance::value<T1>(&arg3);
        let (v1, v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg4, arg1, arg2, false, true, v0, 79226673515401279992447579054);
        let v4 = v3;
        0x2::balance::destroy_zero<T1>(v2);
        assert!(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v4) == v0, 159);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), arg3, v4);
        v1
    }

    public fun ss0<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::Ht, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T5>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg4: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: 0x2::balance::Balance<T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T2> {
        0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::bl(arg0, 0x2::object::id<0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T5>>(arg1), true);
        if (!0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::ia(arg0)) {
            0x2::balance::destroy_zero<T1>(arg5);
            return 0x2::balance::zero<T2>()
        };
        0xf8913d6fb01815aa3667f91acc6d3f09fcffff58567c531224729d650a354925::steamm::cpmm_a2b<T0, T1, T2, T3, T4, T5>(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public fun ss1<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::Ht, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T5>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg4: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: 0x2::balance::Balance<T2>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::bl(arg0, 0x2::object::id<0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T5>>(arg1), false);
        if (!0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::ia(arg0)) {
            0x2::balance::destroy_zero<T2>(arg5);
            return 0x2::balance::zero<T1>()
        };
        0xf8913d6fb01815aa3667f91acc6d3f09fcffff58567c531224729d650a354925::steamm::cpmm_b2a<T0, T1, T2, T3, T4, T5>(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public fun tf0<T0, T1>(arg0: &mut 0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::Ht, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x1::option::Option<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt>) {
        let v0 = 0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::bl(arg0, 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg1), true);
        if (!0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::ia(arg0)) {
            return (0x2::balance::zero<T1>(), 0x1::option::none<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt>())
        };
        let (v1, v2, v3) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg1, true, true, v0, 4295048017, arg2, arg3, arg4);
        let v4 = v3;
        0x2::balance::destroy_zero<T0>(v1);
        let (v5, _) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v4);
        assert!(v5 == v0, 159);
        (v2, 0x1::option::some<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt>(v4))
    }

    public fun tf1<T0, T1>(arg0: &mut 0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::Ht, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x1::option::Option<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt>) {
        let v0 = 0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::bl(arg0, 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg1), false);
        if (!0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::ia(arg0)) {
            return (0x2::balance::zero<T0>(), 0x1::option::none<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt>())
        };
        let (v1, v2, v3) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg1, false, true, v0, 79226673515401279992447579054, arg2, arg3, arg4);
        let v4 = v3;
        0x2::balance::destroy_zero<T1>(v2);
        let (_, v6) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v4);
        assert!(v6 == v0, 159);
        (v1, 0x1::option::some<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt>(v4))
    }

    public fun tg0<T0, T1>(arg0: &0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::Ht, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: 0x1::option::Option<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt>, arg3: 0x2::balance::Balance<T0>, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        if (!0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::ia(arg0)) {
            assert!(0x1::option::is_none<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt>(&arg2), 160);
            0x1::option::destroy_none<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt>(arg2);
            return arg3
        };
        assert!(0x1::option::is_some<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt>(&arg2), 160);
        let v0 = 0x1::option::destroy_some<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt>(arg2);
        let (v1, _) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v0);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg1, v0, 0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::tk<T0>(&mut arg3, v1), 0x2::balance::zero<T1>(), arg4, arg5);
        arg3
    }

    public fun tg1<T0, T1>(arg0: &0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::Ht, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: 0x1::option::Option<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt>, arg3: 0x2::balance::Balance<T1>, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        if (!0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::ia(arg0)) {
            assert!(0x1::option::is_none<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt>(&arg2), 160);
            0x1::option::destroy_none<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt>(arg2);
            return arg3
        };
        assert!(0x1::option::is_some<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt>(&arg2), 160);
        let v0 = 0x1::option::destroy_some<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt>(arg2);
        let (_, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v0);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg1, v0, 0x2::balance::zero<T0>(), 0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::tk<T1>(&mut arg3, v2), arg4, arg5);
        arg3
    }

    public fun ts0<T0, T1>(arg0: &mut 0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::Ht, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::bl(arg0, 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg1), true);
        if (!0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::ia(arg0)) {
            0x2::balance::destroy_zero<T0>(arg2);
            return 0x2::balance::zero<T1>()
        };
        let v0 = 0x2::balance::value<T0>(&arg2);
        let (v1, v2, v3) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg1, true, true, v0, 4295048017, arg3, arg4, arg5);
        let v4 = v3;
        0x2::balance::destroy_zero<T0>(v1);
        let (v5, _) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v4);
        assert!(v5 == v0, 159);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg1, v4, arg2, 0x2::balance::zero<T1>(), arg4, arg5);
        v2
    }

    public fun ts1<T0, T1>(arg0: &mut 0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::Ht, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::bl(arg0, 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg1), false);
        if (!0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::ia(arg0)) {
            0x2::balance::destroy_zero<T1>(arg2);
            return 0x2::balance::zero<T0>()
        };
        let v0 = 0x2::balance::value<T1>(&arg2);
        let (v1, v2, v3) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg1, false, true, v0, 79226673515401279992447579054, arg3, arg4, arg5);
        let v4 = v3;
        0x2::balance::destroy_zero<T1>(v2);
        let (_, v6) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v4);
        assert!(v6 == v0, 159);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg1, v4, 0x2::balance::zero<T0>(), arg2, arg4, arg5);
        v1
    }

    // decompiled from Move bytecode v7
}

