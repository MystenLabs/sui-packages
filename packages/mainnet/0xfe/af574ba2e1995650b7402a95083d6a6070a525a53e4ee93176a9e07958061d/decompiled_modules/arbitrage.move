module 0xfeaf574ba2e1995650b7402a95083d6a6070a525a53e4ee93176a9e07958061d::arbitrage {
    struct BestPoolEvent has copy, drop {
        step0_pool: u16,
        step1_pool: u16,
    }

    struct CalculatedAmountEvent has copy, drop {
        amount_in: u64,
        earning: u64,
    }

    public fun arbitrage<T0, T1>(arg0: &mut 0x1::option::Option<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>, arg1: &mut 0x1::option::Option<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>, arg2: &mut 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>, arg3: &mut 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>, arg4: &mut 0x1::option::Option<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>, arg5: &mut 0x2::coin::Coin<T0>, arg6: &mut 0x2::coin::Coin<T1>, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg9: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg10: &0x2::clock::Clock, arg11: u64, arg12: u64, arg13: bool, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = 57005;
        if (0x1::option::is_some<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg0)) {
            if (0xfeaf574ba2e1995650b7402a95083d6a6070a525a53e4ee93176a9e07958061d::bluefin::calculate<T0, T1>(0x1::option::borrow<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg0), arg13, arg11) > 0) {
                v0 = 0;
            };
        };
        let v1 = BestPoolEvent{
            step0_pool : v0,
            step1_pool : 57005,
        };
        0x2::event::emit<BestPoolEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

