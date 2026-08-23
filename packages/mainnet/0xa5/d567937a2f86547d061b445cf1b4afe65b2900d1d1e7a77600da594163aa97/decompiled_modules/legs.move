module 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::legs {
    struct Leg<phantom T0, phantom T1> {
        a: 0x2::balance::Balance<T0>,
        b: 0x2::balance::Balance<T1>,
        owed: u64,
        receipt: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>,
    }

    struct BfLeg<phantom T0, phantom T1> {
        a: 0x2::balance::Balance<T0>,
        b: 0x2::balance::Balance<T1>,
        owed: u64,
        receipt: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>,
    }

    public fun bluefin_repay_a<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: BfLeg<T0, T1>, arg3: 0x2::balance::Balance<T0>) : 0x2::balance::Balance<T0> {
        let BfLeg {
            a       : v0,
            b       : v1,
            owed    : v2,
            receipt : v3,
        } = arg2;
        0x2::balance::destroy_zero<T0>(v0);
        0x2::balance::destroy_zero<T1>(v1);
        assert!(0x2::balance::value<T0>(&arg3) >= v2, 30);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut arg3, v2), 0x2::balance::zero<T1>(), v3);
        arg3
    }

    public fun bluefin_repay_b<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: BfLeg<T0, T1>, arg3: 0x2::balance::Balance<T1>) : 0x2::balance::Balance<T1> {
        let BfLeg {
            a       : v0,
            b       : v1,
            owed    : v2,
            receipt : v3,
        } = arg2;
        0x2::balance::destroy_zero<T0>(v0);
        0x2::balance::destroy_zero<T1>(v1);
        assert!(0x2::balance::value<T1>(&arg3) >= v2, 30);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg3, v2), v3);
        arg3
    }

    public fun bluefin_start<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: bool, arg3: u64, arg4: &0x2::clock::Clock) : BfLeg<T0, T1> {
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg4, arg0, arg1, arg2, true, arg3, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_price_limit(arg2));
        let v3 = v2;
        BfLeg<T0, T1>{
            a       : v0,
            b       : v1,
            owed    : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v3),
            receipt : v3,
        }
    }

    public fun bluefin_swap_ab<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg3, arg0, arg1, true, true, 0x2::balance::value<T0>(&arg2), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_price_limit(true));
        0x2::balance::destroy_zero<T0>(v0);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, arg2, 0x2::balance::zero<T1>(), v2);
        v1
    }

    public fun bluefin_swap_ba<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg3, arg0, arg1, false, true, 0x2::balance::value<T1>(&arg2), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::bluefin_price_limit(false));
        0x2::balance::destroy_zero<T1>(v1);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), arg2, v2);
        v0
    }

    public fun bluefin_take_a<T0, T1>(arg0: BfLeg<T0, T1>) : (BfLeg<T0, T1>, 0x2::balance::Balance<T0>) {
        let BfLeg {
            a       : v0,
            b       : v1,
            owed    : v2,
            receipt : v3,
        } = arg0;
        let v4 = BfLeg<T0, T1>{
            a       : 0x2::balance::zero<T0>(),
            b       : v1,
            owed    : v2,
            receipt : v3,
        };
        (v4, v0)
    }

    public fun bluefin_take_b<T0, T1>(arg0: BfLeg<T0, T1>) : (BfLeg<T0, T1>, 0x2::balance::Balance<T1>) {
        let BfLeg {
            a       : v0,
            b       : v1,
            owed    : v2,
            receipt : v3,
        } = arg0;
        let v4 = BfLeg<T0, T1>{
            a       : v0,
            b       : 0x2::balance::zero<T1>(),
            owed    : v2,
            receipt : v3,
        };
        (v4, v1)
    }

    public fun cetus_repay_a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: Leg<T0, T1>, arg3: 0x2::balance::Balance<T0>) : 0x2::balance::Balance<T0> {
        let Leg {
            a       : v0,
            b       : v1,
            owed    : v2,
            receipt : v3,
        } = arg2;
        0x2::balance::destroy_zero<T0>(v0);
        0x2::balance::destroy_zero<T1>(v1);
        assert!(0x2::balance::value<T0>(&arg3) >= v2, 30);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut arg3, v2), 0x2::balance::zero<T1>(), v3);
        arg3
    }

    public fun cetus_repay_b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: Leg<T0, T1>, arg3: 0x2::balance::Balance<T1>) : 0x2::balance::Balance<T1> {
        let Leg {
            a       : v0,
            b       : v1,
            owed    : v2,
            receipt : v3,
        } = arg2;
        0x2::balance::destroy_zero<T0>(v0);
        0x2::balance::destroy_zero<T1>(v1);
        assert!(0x2::balance::value<T1>(&arg3) >= v2, 30);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg3, v2), v3);
        arg3
    }

    public fun cetus_start<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: bool, arg3: u64, arg4: &0x2::clock::Clock) : Leg<T0, T1> {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, arg2, true, arg3, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::price_limit(arg2), arg4);
        let v3 = v2;
        Leg<T0, T1>{
            a       : v0,
            b       : v1,
            owed    : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3),
            receipt : v3,
        }
    }

    public fun cetus_swap_ab<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, 0x2::balance::value<T0>(&arg2), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::price_limit(true), arg3);
        0x2::balance::destroy_zero<T0>(v0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, arg2, 0x2::balance::zero<T1>(), v2);
        v1
    }

    public fun cetus_swap_ba<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, 0x2::balance::value<T1>(&arg2), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::quote::price_limit(false), arg3);
        0x2::balance::destroy_zero<T1>(v1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), arg2, v2);
        v0
    }

    public fun cetus_take_a<T0, T1>(arg0: Leg<T0, T1>) : (Leg<T0, T1>, 0x2::balance::Balance<T0>) {
        let Leg {
            a       : v0,
            b       : v1,
            owed    : v2,
            receipt : v3,
        } = arg0;
        let v4 = Leg<T0, T1>{
            a       : 0x2::balance::zero<T0>(),
            b       : v1,
            owed    : v2,
            receipt : v3,
        };
        (v4, v0)
    }

    public fun cetus_take_b<T0, T1>(arg0: Leg<T0, T1>) : (Leg<T0, T1>, 0x2::balance::Balance<T1>) {
        let Leg {
            a       : v0,
            b       : v1,
            owed    : v2,
            receipt : v3,
        } = arg0;
        let v4 = Leg<T0, T1>{
            a       : v0,
            b       : 0x2::balance::zero<T1>(),
            owed    : v2,
            receipt : v3,
        };
        (v4, v1)
    }

    public fun e_short_repay() : u64 {
        30
    }

    // decompiled from Move bytecode v7
}

