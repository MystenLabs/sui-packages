module 0xe951c91ad0b9432350273472209741ec23eb3111a08979145af13199bfe57c1a::swap {
    struct Swapping {
        id: 0x2::object::ID,
        from_coin_type: 0x1::type_name::TypeName,
        total_from_amount: u64,
        remaining_from_amount: u64,
        to_coin_type: 0x1::type_name::TypeName,
        accumulated_to_amount: u64,
        min_to_amount: u64,
        middle_coin_type: 0x1::type_name::TypeName,
        middle_amount: u64,
    }

    public fun after_swap<T0>(arg0: 0x2::coin::Coin<T0>, arg1: Swapping) : 0x2::coin::Coin<T0> {
        let Swapping {
            id                    : _,
            from_coin_type        : _,
            total_from_amount     : _,
            remaining_from_amount : v3,
            to_coin_type          : v4,
            accumulated_to_amount : v5,
            min_to_amount         : v6,
            middle_coin_type      : _,
            middle_amount         : v8,
        } = arg1;
        assert!(v4 == 0x1::type_name::get<T0>(), 30002);
        assert!(v3 == 0, 30003);
        let v9 = 0x2::coin::value<T0>(&arg0);
        assert!(v5 == v9, 30004);
        assert!(v9 >= v6, 30001);
        assert!(v8 == 0, 30005);
        arg0
    }

    public fun before_swap<T0, T1>(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Swapping {
        let v0 = 0x1::type_name::get<T0>();
        Swapping{
            id                    : 0x2::object::id_from_address(0x2::tx_context::fresh_object_address(arg2)),
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

    public fun bluefin_check_version(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig) {
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::verify_version(arg0);
    }

    public fun bluefin_swap_a2b<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: Swapping, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, Swapping) {
        let v0 = 0x3239061b389dcc35be021bb13d174da82fafcc87bf3d8e176e6c62619311a90c::bluefin::swap_a2b<T0, T1>(arg1, arg2, arg3, arg0, arg5);
        let v1 = &mut arg4;
        update_swapping<T0, T1>(v1, 0x2::coin::value<T0>(&arg3), 0x2::coin::value<T1>(&v0));
        (v0, arg4)
    }

    public fun bluefin_swap_b2a<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T1>, arg4: Swapping, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Swapping) {
        let v0 = 0x3239061b389dcc35be021bb13d174da82fafcc87bf3d8e176e6c62619311a90c::bluefin::swap_b2a<T0, T1>(arg1, arg2, arg3, arg0, arg5);
        let v1 = &mut arg4;
        update_swapping<T1, T0>(v1, 0x2::coin::value<T1>(&arg3), 0x2::coin::value<T0>(&v0));
        (v0, arg4)
    }

    public fun cetus_check_version(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig) {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::checked_package_version(arg0);
    }

    public fun cetus_swap_a2b<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: 0x2::coin::Coin<T0>, arg5: Swapping, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, Swapping) {
        let v0 = 0x3239061b389dcc35be021bb13d174da82fafcc87bf3d8e176e6c62619311a90c::cetus::swap_a2b<T0, T1>(arg1, arg3, arg2, arg4, arg0, arg6);
        let v1 = &mut arg5;
        update_swapping<T0, T1>(v1, 0x2::coin::value<T0>(&arg4), 0x2::coin::value<T1>(&v0));
        (v0, arg5)
    }

    public fun cetus_swap_b2a<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: 0x2::coin::Coin<T1>, arg5: Swapping, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Swapping) {
        let v0 = 0x3239061b389dcc35be021bb13d174da82fafcc87bf3d8e176e6c62619311a90c::cetus::swap_b2a<T0, T1>(arg1, arg3, arg2, arg4, arg0, arg6);
        let v1 = &mut arg5;
        update_swapping<T1, T0>(v1, 0x2::coin::value<T1>(&arg4), 0x2::coin::value<T0>(&v0));
        (v0, arg5)
    }

    public fun flowx_check_version(arg0: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned) {
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::check_version(arg0);
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::check_pause(arg0);
    }

    public fun flowx_swap_a2b<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg2: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: Swapping, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, Swapping) {
        let v0 = 0x3239061b389dcc35be021bb13d174da82fafcc87bf3d8e176e6c62619311a90c::flowx_clmm::swap_a2b<T0, T1>(arg2, arg3, arg4, arg1, arg0, arg6);
        let v1 = &mut arg5;
        update_swapping<T0, T1>(v1, 0x2::coin::value<T0>(&arg4), 0x2::coin::value<T1>(&v0));
        (v0, arg5)
    }

    public fun flowx_swap_b2a<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg2: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg3: u64, arg4: 0x2::coin::Coin<T1>, arg5: Swapping, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Swapping) {
        let v0 = 0x3239061b389dcc35be021bb13d174da82fafcc87bf3d8e176e6c62619311a90c::flowx_clmm::swap_b2a<T0, T1>(arg2, arg3, arg4, arg1, arg0, arg6);
        let v1 = &mut arg5;
        update_swapping<T1, T0>(v1, 0x2::coin::value<T1>(&arg4), 0x2::coin::value<T0>(&v0));
        (v0, arg5)
    }

    public fun get_swapping_id(arg0: &Swapping) : 0x2::object::ID {
        arg0.id
    }

    public fun momentum_check_version(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version) {
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::assert_supported_version(arg0);
    }

    public fun momentum_swap_a2b<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: Swapping, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, Swapping) {
        let v0 = 0x3239061b389dcc35be021bb13d174da82fafcc87bf3d8e176e6c62619311a90c::momentum::swap_a2b<T0, T1>(arg2, arg3, arg1, arg0, arg5);
        let v1 = &mut arg4;
        update_swapping<T0, T1>(v1, 0x2::coin::value<T0>(&arg3), 0x2::coin::value<T1>(&v0));
        (v0, arg4)
    }

    public fun momentum_swap_b2a<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T1>, arg4: Swapping, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Swapping) {
        let v0 = 0x3239061b389dcc35be021bb13d174da82fafcc87bf3d8e176e6c62619311a90c::momentum::swap_b2a<T0, T1>(arg2, arg3, arg1, arg0, arg5);
        let v1 = &mut arg4;
        update_swapping<T1, T0>(v1, 0x2::coin::value<T1>(&arg3), 0x2::coin::value<T0>(&v0));
        (v0, arg4)
    }

    public fun obric_swap_a2b<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: &mut 0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::TradingPair<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: Swapping, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, Swapping) {
        let v0 = 0x3239061b389dcc35be021bb13d174da82fafcc87bf3d8e176e6c62619311a90c::obric::swap_a2b<T0, T1>(arg2, arg3, arg1, arg4, arg5, arg0, arg7);
        let v1 = &mut arg6;
        update_swapping<T0, T1>(v1, 0x2::coin::value<T0>(&arg3), 0x2::coin::value<T1>(&v0));
        (v0, arg6)
    }

    public fun obric_swap_b2a<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: &mut 0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::TradingPair<T0, T1>, arg3: 0x2::coin::Coin<T1>, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: Swapping, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Swapping) {
        let v0 = 0x3239061b389dcc35be021bb13d174da82fafcc87bf3d8e176e6c62619311a90c::obric::swap_b2a<T0, T1>(arg2, arg3, arg1, arg4, arg5, arg0, arg7);
        let v1 = &mut arg6;
        update_swapping<T1, T0>(v1, 0x2::coin::value<T1>(&arg3), 0x2::coin::value<T0>(&v0));
        (v0, arg6)
    }

    public fun turbos_check_version(arg0: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::check_version(arg0);
    }

    public fun turbos_swap_a2b<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: 0x2::coin::Coin<T0>, arg4: Swapping, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, Swapping) {
        let v0 = 0x3239061b389dcc35be021bb13d174da82fafcc87bf3d8e176e6c62619311a90c::turbos::swap_a2b<T0, T1, T2>(arg2, arg3, arg0, arg1, arg5);
        let v1 = &mut arg4;
        update_swapping<T0, T1>(v1, 0x2::coin::value<T0>(&arg3), 0x2::coin::value<T1>(&v0));
        (v0, arg4)
    }

    public fun turbos_swap_b2a<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: 0x2::coin::Coin<T1>, arg4: Swapping, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Swapping) {
        let v0 = 0x3239061b389dcc35be021bb13d174da82fafcc87bf3d8e176e6c62619311a90c::turbos::swap_b2a<T0, T1, T2>(arg2, arg3, arg0, arg1, arg5);
        let v1 = &mut arg4;
        update_swapping<T1, T0>(v1, 0x2::coin::value<T1>(&arg3), 0x2::coin::value<T0>(&v0));
        (v0, arg4)
    }

    fun update_swapping<T0, T1>(arg0: &mut Swapping, arg1: u64, arg2: u64) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        assert!(v0 != v1, 30006);
        assert!(v1 != arg0.from_coin_type, 30002);
        assert!(v0 != arg0.to_coin_type, 30007);
        if (v0 == arg0.from_coin_type) {
            arg0.remaining_from_amount = arg0.remaining_from_amount - arg1;
        } else {
            assert!(v0 == arg0.middle_coin_type, 30008);
            assert!(arg1 == arg0.middle_amount, 30009);
            arg0.middle_amount = 0;
        };
        assert!(arg0.middle_amount == 0, 30005);
        if (v1 == arg0.to_coin_type) {
            arg0.accumulated_to_amount = arg0.accumulated_to_amount + arg2;
        } else {
            arg0.middle_coin_type = v1;
            arg0.middle_amount = arg2;
        };
    }

    // decompiled from Move bytecode v6
}

