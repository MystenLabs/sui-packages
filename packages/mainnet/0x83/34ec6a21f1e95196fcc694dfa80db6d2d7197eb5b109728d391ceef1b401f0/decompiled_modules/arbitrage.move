module 0x8334ec6a21f1e95196fcc694dfa80db6d2d7197eb5b109728d391ceef1b401f0::arbitrage {
    struct BestPoolEvent has copy, drop {
        step0_pool: u16,
        step1_pool: u16,
    }

    struct CalculatedAmountEvent has copy, drop {
        amount_in: u64,
        earning: u64,
    }

    public fun arbitrage<T0, T1>(arg0: &mut 0x1::option::Option<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>, arg1: &mut 0x1::option::Option<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>, arg2: &mut 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>, arg3: &mut 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>, arg4: &mut 0x1::option::Option<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>, arg5: &mut 0x2::coin::Coin<T0>, arg6: &mut 0x2::coin::Coin<T1>, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg9: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg10: &0x2::clock::Clock, arg11: u64, arg12: u64, arg13: bool, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        let v1 = v0;
        let v2 = 57005;
        if (0x1::option::is_some<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg0)) {
            let v3 = 0x8334ec6a21f1e95196fcc694dfa80db6d2d7197eb5b109728d391ceef1b401f0::bluefin::calculate<T0, T1>(0x1::option::borrow<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg0), arg13, arg11);
            if (v3 > v0) {
                v2 = 0;
                v1 = v3;
            };
        };
        if (0x1::option::is_some<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg1)) {
            let v4 = 0x8334ec6a21f1e95196fcc694dfa80db6d2d7197eb5b109728d391ceef1b401f0::bluefin::calculate<T0, T1>(0x1::option::borrow<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg1), arg13, arg11);
            if (v4 > v1) {
                v2 = 1;
                v1 = v4;
            };
        };
        if (0x1::option::is_some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2)) {
            let v5 = 0x8334ec6a21f1e95196fcc694dfa80db6d2d7197eb5b109728d391ceef1b401f0::cetus::calculate<T0, T1>(0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2), arg13, arg11);
            if (v5 > v1) {
                v2 = 2;
                v1 = v5;
            };
        };
        if (0x1::option::is_some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3)) {
            let v6 = 0x8334ec6a21f1e95196fcc694dfa80db6d2d7197eb5b109728d391ceef1b401f0::cetus::calculate<T0, T1>(0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3), arg13, arg11);
            if (v6 > v1) {
                v2 = 3;
                v1 = v6;
            };
        };
        if (0x1::option::is_some<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg4)) {
            if (0x8334ec6a21f1e95196fcc694dfa80db6d2d7197eb5b109728d391ceef1b401f0::mmt::calculate<T0, T1>(0x1::option::borrow<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg4), arg13, arg11) > v1) {
                v2 = 4;
            };
        };
        let v7 = BestPoolEvent{
            step0_pool : v2,
            step1_pool : 57005,
        };
        0x2::event::emit<BestPoolEvent>(v7);
    }

    // decompiled from Move bytecode v6
}

