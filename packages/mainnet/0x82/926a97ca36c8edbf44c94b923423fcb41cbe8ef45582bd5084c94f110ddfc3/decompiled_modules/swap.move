module 0x82926a97ca36c8edbf44c94b923423fcb41cbe8ef45582bd5084c94f110ddfc3::swap {
    struct Swaping {
        from_coin_type: 0x1::type_name::TypeName,
        total_from_amount: u64,
        remaining_from_amount: u64,
        to_coin_type: 0x1::type_name::TypeName,
        accumulated_to_amount: u64,
        min_to_amount: u64,
        middle_coin_type: 0x1::type_name::TypeName,
        middle_amount: u64,
    }

    public fun after_swap<T0>(arg0: 0x2::coin::Coin<T0>, arg1: Swaping) : (0x2::coin::Coin<T0>, 0x1::type_name::TypeName, u64) {
        let Swaping {
            from_coin_type        : v0,
            total_from_amount     : v1,
            remaining_from_amount : v2,
            to_coin_type          : v3,
            accumulated_to_amount : v4,
            min_to_amount         : v5,
            middle_coin_type      : _,
            middle_amount         : v7,
        } = arg1;
        assert!(v3 == 0x1::type_name::get<T0>(), 30003);
        assert!(v2 == 0, 30004);
        let v8 = 0x2::coin::value<T0>(&arg0);
        assert!(v4 == v8, 30005);
        assert!(v8 >= v5, 30001);
        assert!(v7 == 0, 30006);
        (arg0, v0, v1)
    }

    public fun before_swap<T0, T1>(arg0: u64, arg1: u64) : Swaping {
        let v0 = 0x1::type_name::get<T0>();
        Swaping{
            from_coin_type        : v0,
            total_from_amount     : arg0,
            remaining_from_amount : arg0,
            to_coin_type          : 0x1::type_name::get<T1>(),
            accumulated_to_amount : 0,
            min_to_amount         : arg1,
            middle_coin_type      : v0,
            middle_amount         : 0,
        }
    }

    public fun bluefin_swap_a2b<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: Swaping, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, Swaping) {
        let v0 = 0x3239061b389dcc35be021bb13d174da82fafcc87bf3d8e176e6c62619311a90c::bluefin::swap_a2b<T0, T1>(arg1, arg2, arg3, arg0, arg5);
        let v1 = &mut arg4;
        update_swaping<T0, T1>(v1, 0x2::coin::value<T0>(&arg3), 0x2::coin::value<T1>(&v0));
        (v0, arg4)
    }

    public fun bluefin_swap_b2a<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T1>, arg4: Swaping, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Swaping) {
        let v0 = 0x3239061b389dcc35be021bb13d174da82fafcc87bf3d8e176e6c62619311a90c::bluefin::swap_b2a<T0, T1>(arg1, arg2, arg3, arg0, arg5);
        let v1 = &mut arg4;
        update_swaping<T1, T0>(v1, 0x2::coin::value<T1>(&arg3), 0x2::coin::value<T0>(&v0));
        (v0, arg4)
    }

    public fun cetus_swap_a2b<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: 0x2::coin::Coin<T0>, arg5: Swaping, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, Swaping) {
        let v0 = 0x3239061b389dcc35be021bb13d174da82fafcc87bf3d8e176e6c62619311a90c::cetus::swap_a2b<T0, T1>(arg1, arg3, arg2, arg4, arg0, arg6);
        let v1 = &mut arg5;
        update_swaping<T0, T1>(v1, 0x2::coin::value<T0>(&arg4), 0x2::coin::value<T1>(&v0));
        (v0, arg5)
    }

    public fun cetus_swap_b2a<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: 0x2::coin::Coin<T1>, arg5: Swaping, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Swaping) {
        let v0 = 0x3239061b389dcc35be021bb13d174da82fafcc87bf3d8e176e6c62619311a90c::cetus::swap_b2a<T0, T1>(arg1, arg3, arg2, arg4, arg0, arg6);
        let v1 = &mut arg5;
        update_swaping<T1, T0>(v1, 0x2::coin::value<T1>(&arg4), 0x2::coin::value<T0>(&v0));
        (v0, arg5)
    }

    public fun flowx_swap_a2b<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg2: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: Swaping, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, Swaping) {
        let v0 = 0x3239061b389dcc35be021bb13d174da82fafcc87bf3d8e176e6c62619311a90c::flowx_clmm::swap_a2b<T0, T1>(arg2, arg3, arg4, arg1, arg0, arg6);
        let v1 = &mut arg5;
        update_swaping<T0, T1>(v1, 0x2::coin::value<T0>(&arg4), 0x2::coin::value<T1>(&v0));
        (v0, arg5)
    }

    public fun flowx_swap_b2a<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg2: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg3: u64, arg4: 0x2::coin::Coin<T1>, arg5: Swaping, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Swaping) {
        let v0 = 0x3239061b389dcc35be021bb13d174da82fafcc87bf3d8e176e6c62619311a90c::flowx_clmm::swap_b2a<T0, T1>(arg2, arg3, arg4, arg1, arg0, arg6);
        let v1 = &mut arg5;
        update_swaping<T1, T0>(v1, 0x2::coin::value<T1>(&arg4), 0x2::coin::value<T0>(&v0));
        (v0, arg5)
    }

    public fun momentum_swap_a2b<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: Swaping, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, Swaping) {
        let v0 = 0x3239061b389dcc35be021bb13d174da82fafcc87bf3d8e176e6c62619311a90c::momentum::swap_a2b<T0, T1>(arg2, arg3, arg1, arg0, arg5);
        let v1 = &mut arg4;
        update_swaping<T0, T1>(v1, 0x2::coin::value<T0>(&arg3), 0x2::coin::value<T1>(&v0));
        (v0, arg4)
    }

    public fun momentum_swap_b2a<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T1>, arg4: Swaping, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Swaping) {
        let v0 = 0x3239061b389dcc35be021bb13d174da82fafcc87bf3d8e176e6c62619311a90c::momentum::swap_b2a<T0, T1>(arg2, arg3, arg1, arg0, arg5);
        let v1 = &mut arg4;
        update_swaping<T1, T0>(v1, 0x2::coin::value<T1>(&arg3), 0x2::coin::value<T0>(&v0));
        (v0, arg4)
    }

    public fun obric_swap_a2b<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: &mut 0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::TradingPair<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: Swaping, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, Swaping) {
        let v0 = 0x3239061b389dcc35be021bb13d174da82fafcc87bf3d8e176e6c62619311a90c::obric::swap_a2b<T0, T1>(arg2, arg3, arg1, arg4, arg5, arg0, arg7);
        let v1 = &mut arg6;
        update_swaping<T0, T1>(v1, 0x2::coin::value<T0>(&arg3), 0x2::coin::value<T1>(&v0));
        (v0, arg6)
    }

    public fun obric_swap_b2a<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: &mut 0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::TradingPair<T0, T1>, arg3: 0x2::coin::Coin<T1>, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: Swaping, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Swaping) {
        let v0 = 0x3239061b389dcc35be021bb13d174da82fafcc87bf3d8e176e6c62619311a90c::obric::swap_b2a<T0, T1>(arg2, arg3, arg1, arg4, arg5, arg0, arg7);
        let v1 = &mut arg6;
        update_swaping<T1, T0>(v1, 0x2::coin::value<T1>(&arg3), 0x2::coin::value<T0>(&v0));
        (v0, arg6)
    }

    fun update_swaping<T0, T1>(arg0: &mut Swaping, arg1: u64, arg2: u64) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        assert!(v0 != v1, 30007);
        assert!(v1 != arg0.from_coin_type, 30003);
        assert!(v0 != arg0.to_coin_type, 30008);
        if (v0 == arg0.from_coin_type) {
            arg0.remaining_from_amount = arg0.remaining_from_amount - arg1;
        } else {
            assert!(v0 == arg0.middle_coin_type, 30009);
            assert!(arg1 == arg0.middle_amount, 30010);
            arg0.middle_amount = 0;
        };
        assert!(arg0.middle_amount == 0, 30006);
        if (v1 == arg0.to_coin_type) {
            arg0.accumulated_to_amount = arg0.accumulated_to_amount + arg2;
        } else {
            arg0.middle_coin_type = v1;
            arg0.middle_amount = arg2;
        };
    }

    // decompiled from Move bytecode v6
}

