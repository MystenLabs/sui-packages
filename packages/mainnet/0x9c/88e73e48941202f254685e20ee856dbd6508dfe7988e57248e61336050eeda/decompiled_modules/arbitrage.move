module 0x9c88e73e48941202f254685e20ee856dbd6508dfe7988e57248e61336050eeda::arbitrage {
    struct BestPoolEvent has copy, drop {
        step0_pool: u16,
        step1_pool: u16,
    }

    struct CalculatedAmountEvent has copy, drop {
        amount_in: u64,
        earning: u64,
    }

    public fun arbitrage<T0, T1>(arg0: &mut 0x1::option::Option<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>, arg1: &mut 0x1::option::Option<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>, arg2: &mut 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>, arg3: &mut 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>, arg4: &mut 0x1::option::Option<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>, arg5: &mut 0x2::coin::Coin<T0>, arg6: &mut 0x2::coin::Coin<T1>, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg9: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg10: &0x2::clock::Clock, arg11: u64, arg12: u64, arg13: bool, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = BestPoolEvent{
            step0_pool : 57005,
            step1_pool : 57005,
        };
        0x2::event::emit<BestPoolEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

