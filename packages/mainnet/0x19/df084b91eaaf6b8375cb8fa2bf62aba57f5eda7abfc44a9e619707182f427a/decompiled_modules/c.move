module 0x7d5a5749d7c37f5219d90d1c665f1d480b11d83dc5f09db487c6d7377a6a82c5::c {
    struct Bank<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        owner: address,
    }

    struct AccessList has store, key {
        id: 0x2::object::UID,
        admin: address,
        trader: address,
        wl: vector<0x2::object::ID>,
        positions: 0x2::table::Table<0x2::object::ID, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>,
    }

    public fun add_liquidity<T0, T1>(arg0: &mut AccessList, arg1: &0x2::clock::Clock, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: &mut Bank<T0>, arg9: &mut Bank<T1>, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(is_trader(arg0, arg10), 1);
        assert!(is_pool_wl(arg0, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2)), 2);
        let v0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg2));
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg3, arg2, v0, v0 + 1, arg10);
        let (_, _, v4, v5) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg1, arg3, arg2, &mut v1, 0x2::coin::into_balance<T0>(0x2::coin::take<T0>(&mut arg8.balance, arg5, arg10)), 0x2::coin::into_balance<T1>(0x2::coin::take<T1>(&mut arg9.balance, arg6, arg10)), arg4, arg7);
        deposit<T0>(arg8, 0x2::coin::from_balance<T0>(v4, arg10), 0);
        deposit<T1>(arg9, 0x2::coin::from_balance<T1>(v5, arg10), 0);
        0x2::table::add<0x2::object::ID, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.positions, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&v1), v1);
    }

    public fun add_wl(arg0: &mut AccessList, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, arg2), 1);
        assert!(!0x1::vector::contains<0x2::object::ID>(&arg0.wl, &arg1), 2);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.wl, arg1);
    }

    public fun bluefin_a2b<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut AccessList, arg4: &mut Bank<T0>, arg5: &mut Bank<T1>, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(is_trader(arg3, arg8), 1);
        assert!(is_pool_wl(arg3, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg1)), 2);
        deposit<T1>(arg5, 0x2::coin::from_balance<T1>(0x7d5a5749d7c37f5219d90d1c665f1d480b11d83dc5f09db487c6d7377a6a82c5::d::bluefin_a2b<T0, T1>(arg2, arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::take<T0>(&mut arg4.balance, arg6, arg8)), arg8), arg8), arg7);
    }

    public fun bluefin_b2a<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut AccessList, arg4: &mut Bank<T1>, arg5: &mut Bank<T0>, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(is_trader(arg3, arg8), 1);
        assert!(is_pool_wl(arg3, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg1)), 2);
        deposit<T0>(arg5, 0x2::coin::from_balance<T0>(0x7d5a5749d7c37f5219d90d1c665f1d480b11d83dc5f09db487c6d7377a6a82c5::d::bluefin_b2a<T0, T1>(arg2, arg0, arg1, 0x2::coin::into_balance<T1>(0x2::coin::take<T1>(&mut arg4.balance, arg6, arg8)), arg8), arg8), arg7);
    }

    public fun cetus_a2b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut AccessList, arg4: &mut Bank<T0>, arg5: &mut Bank<T1>, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(is_trader(arg3, arg8), 1);
        is_pool_wl(arg3, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1));
        deposit<T1>(arg5, 0x2::coin::from_balance<T1>(0x7d5a5749d7c37f5219d90d1c665f1d480b11d83dc5f09db487c6d7377a6a82c5::d::cetus_a2b<T0, T1>(arg2, arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::take<T0>(&mut arg4.balance, arg6, arg8)), arg8), arg8), arg7);
    }

    public fun cetus_b2a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut AccessList, arg4: &mut Bank<T1>, arg5: &mut Bank<T0>, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(is_trader(arg3, arg8), 1);
        assert!(is_pool_wl(arg3, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1)), 2);
        deposit<T0>(arg5, 0x2::coin::from_balance<T0>(0x7d5a5749d7c37f5219d90d1c665f1d480b11d83dc5f09db487c6d7377a6a82c5::d::cetus_b2a<T0, T1>(arg2, arg0, arg1, 0x2::coin::into_balance<T1>(0x2::coin::take<T1>(&mut arg4.balance, arg6, arg8)), arg8), arg8), arg7);
    }

    public fun close_position<T0, T1, T2, T3>(arg0: &mut AccessList, arg1: &0x2::clock::Clock, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: 0x2::object::ID, arg5: &mut Bank<T0>, arg6: &mut Bank<T1>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(is_trader(arg0, arg7), 1);
        let v0 = 0x2::table::remove<0x2::object::ID, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.positions, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T2>(arg1, arg3, arg2, &mut v0), arg7), arg0.admin);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T3>(arg1, arg3, arg2, &mut v0), arg7), arg0.admin);
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&v0);
        let (v2, v3) = if (v1 > 0) {
            let (_, _, v6, v7) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::remove_liquidity<T0, T1>(arg3, arg2, &mut v0, v1, arg1);
            (v6, v7)
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        };
        let v8 = v3;
        let v9 = v2;
        let (_, _, v12, v13) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T0, T1>(arg1, arg3, arg2, &mut v0);
        0x2::balance::join<T0>(&mut v9, v12);
        0x2::balance::join<T1>(&mut v8, v13);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::close_position_v2<T0, T1>(arg1, arg3, arg2, v0);
        deposit<T0>(arg5, 0x2::coin::from_balance<T0>(v9, arg7), 0);
        deposit<T1>(arg6, 0x2::coin::from_balance<T1>(v8, arg7), 0);
    }

    public fun deposit<T0>(arg0: &mut Bank<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64) {
        assert!(0x2::coin::value<T0>(&arg1) >= arg2, 2);
        0x2::coin::put<T0>(&mut arg0.balance, arg1);
    }

    fun is_admin(arg0: &AccessList, arg1: &0x2::tx_context::TxContext) : bool {
        arg0.admin == 0x2::tx_context::sender(arg1)
    }

    fun is_pool_wl(arg0: &AccessList, arg1: 0x2::object::ID) : bool {
        0x1::vector::contains<0x2::object::ID>(&arg0.wl, &arg1)
    }

    fun is_trader(arg0: &AccessList, arg1: &0x2::tx_context::TxContext) : bool {
        arg0.trader == 0x2::tx_context::sender(arg1)
    }

    public fun momentum_a2b<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut AccessList, arg4: &mut Bank<T0>, arg5: &mut Bank<T1>, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(is_trader(arg3, arg8), 1);
        assert!(is_pool_wl(arg3, 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg1)), 2);
        deposit<T1>(arg5, 0x2::coin::from_balance<T1>(0x7d5a5749d7c37f5219d90d1c665f1d480b11d83dc5f09db487c6d7377a6a82c5::d::momentum_a2b<T0, T1>(arg2, arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::take<T0>(&mut arg4.balance, arg6, arg8)), arg8), arg8), arg7);
    }

    public fun momentum_b2a<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut AccessList, arg4: &mut Bank<T1>, arg5: &mut Bank<T0>, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(is_trader(arg3, arg8), 1);
        assert!(is_pool_wl(arg3, 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg1)), 2);
        deposit<T0>(arg5, 0x2::coin::from_balance<T0>(0x7d5a5749d7c37f5219d90d1c665f1d480b11d83dc5f09db487c6d7377a6a82c5::d::momentum_b2a<T0, T1>(arg2, arg0, arg1, 0x2::coin::into_balance<T1>(0x2::coin::take<T1>(&mut arg4.balance, arg6, arg8)), arg8), arg8), arg7);
    }

    public fun new_access_list(arg0: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x58e50d7f8f4cb0411d3ceb34f0251cf409dd213820c160beded983e9a0b60fd3, 1);
        let v0 = AccessList{
            id        : 0x2::object::new(arg0),
            admin     : 0x2::tx_context::sender(arg0),
            trader    : @0x58e50d7f8f4cb0411d3ceb34f0251cf409dd213820c160beded983e9a0b60fd3,
            wl        : 0x1::vector::empty<0x2::object::ID>(),
            positions : 0x2::table::new<0x2::object::ID, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg0),
        };
        0x2::transfer::share_object<AccessList>(v0);
    }

    public fun new_b<T0>(arg0: &mut AccessList, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, arg2), 1);
        let v0 = Bank<T0>{
            id      : 0x2::object::new(arg2),
            balance : 0x2::coin::into_balance<T0>(arg1),
            owner   : 0x2::tx_context::sender(arg2),
        };
        0x2::transfer::share_object<Bank<T0>>(v0);
    }

    public fun obric_x2y<T0, T1>(arg0: &mut 0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::TradingPair<T0, T1>, arg1: &mut AccessList, arg2: &0x2::clock::Clock, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut Bank<T0>, arg7: &mut Bank<T1>, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(is_trader(arg1, arg10), 1);
        assert!(is_pool_wl(arg1, 0x2::object::id<0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::TradingPair<T0, T1>>(arg0)), 2);
        deposit<T1>(arg7, 0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::swap_x_to_y<T0, T1>(arg0, arg2, arg3, arg4, arg5, 0x2::coin::take<T0>(&mut arg6.balance, arg8, arg10), arg10), arg9);
    }

    public fun obric_y2x<T0, T1>(arg0: &mut 0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::TradingPair<T0, T1>, arg1: &mut AccessList, arg2: &0x2::clock::Clock, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut Bank<T1>, arg7: &mut Bank<T0>, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(is_trader(arg1, arg10), 1);
        assert!(is_pool_wl(arg1, 0x2::object::id<0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::TradingPair<T0, T1>>(arg0)), 2);
        deposit<T0>(arg7, 0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::swap_y_to_x<T0, T1>(arg0, arg2, arg3, arg4, arg5, 0x2::coin::take<T1>(&mut arg6.balance, arg8, arg10), arg10), arg9);
    }

    public fun turbos_a2b<T0, T1, T2>(arg0: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: &0x2::clock::Clock, arg3: &mut AccessList, arg4: &mut Bank<T0>, arg5: &mut Bank<T1>, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(is_trader(arg3, arg8), 1);
        assert!(is_pool_wl(arg3, 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg1)), 2);
        deposit<T1>(arg5, 0x2::coin::from_balance<T1>(0x7d5a5749d7c37f5219d90d1c665f1d480b11d83dc5f09db487c6d7377a6a82c5::d::turbos_a2b<T0, T1, T2>(arg1, 0x2::coin::into_balance<T0>(0x2::coin::take<T0>(&mut arg4.balance, arg6, arg8)), arg2, arg0, arg8), arg8), arg7);
    }

    public fun turbos_b2a<T0, T1, T2>(arg0: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: &0x2::clock::Clock, arg3: &mut AccessList, arg4: &mut Bank<T1>, arg5: &mut Bank<T0>, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(is_trader(arg3, arg8), 1);
        assert!(is_pool_wl(arg3, 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg1)), 2);
        deposit<T0>(arg5, 0x2::coin::from_balance<T0>(0x7d5a5749d7c37f5219d90d1c665f1d480b11d83dc5f09db487c6d7377a6a82c5::d::turbos_b2a<T0, T1, T2>(arg1, 0x2::coin::into_balance<T1>(0x2::coin::take<T1>(&mut arg4.balance, arg6, arg8)), arg2, arg0, arg8), arg8), arg7);
    }

    public fun withdraw_admin<T0>(arg0: &mut AccessList, arg1: &mut Bank<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, arg3), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.balance, arg2, arg3), @0x58e50d7f8f4cb0411d3ceb34f0251cf409dd213820c160beded983e9a0b60fd3);
    }

    // decompiled from Move bytecode v6
}

