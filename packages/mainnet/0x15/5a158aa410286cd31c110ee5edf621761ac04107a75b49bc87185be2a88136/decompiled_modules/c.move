module 0x155a158aa410286cd31c110ee5edf621761ac04107a75b49bc87185be2a88136::c {
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
    }

    public fun add_wl(arg0: &mut AccessList, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, arg2), 1);
        assert!(!0x1::vector::contains<0x2::object::ID>(&arg0.wl, &arg1), 2);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.wl, arg1);
    }

    public fun bluefin_a2b<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut AccessList, arg4: &mut Bank<T0>, arg5: &mut Bank<T1>, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(is_trader(arg3, arg8), 1);
        assert!(is_pool_wl(arg3, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg1)), 2);
        deposit<T1>(arg5, 0x2::coin::from_balance<T1>(0x155a158aa410286cd31c110ee5edf621761ac04107a75b49bc87185be2a88136::d::bluefin_a2b<T0, T1>(arg2, arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::take<T0>(&mut arg4.balance, arg6, arg8)), arg8), arg8), arg7);
    }

    public fun bluefin_b2a<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut AccessList, arg4: &mut Bank<T1>, arg5: &mut Bank<T0>, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(is_trader(arg3, arg8), 1);
        assert!(is_pool_wl(arg3, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg1)), 2);
        deposit<T0>(arg5, 0x2::coin::from_balance<T0>(0x155a158aa410286cd31c110ee5edf621761ac04107a75b49bc87185be2a88136::d::bluefin_b2a<T0, T1>(arg2, arg0, arg1, 0x2::coin::into_balance<T1>(0x2::coin::take<T1>(&mut arg4.balance, arg6, arg8)), arg8), arg8), arg7);
    }

    public fun cetus_a2b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut AccessList, arg4: &mut Bank<T0>, arg5: &mut Bank<T1>, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(is_trader(arg3, arg8), 1);
        is_pool_wl(arg3, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1));
        deposit<T1>(arg5, 0x2::coin::from_balance<T1>(0x155a158aa410286cd31c110ee5edf621761ac04107a75b49bc87185be2a88136::d::cetus_a2b<T0, T1>(arg2, arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::take<T0>(&mut arg4.balance, arg6, arg8)), arg8), arg8), arg7);
    }

    public fun cetus_b2a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut AccessList, arg4: &mut Bank<T1>, arg5: &mut Bank<T0>, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(is_trader(arg3, arg8), 1);
        assert!(is_pool_wl(arg3, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1)), 2);
        deposit<T0>(arg5, 0x2::coin::from_balance<T0>(0x155a158aa410286cd31c110ee5edf621761ac04107a75b49bc87185be2a88136::d::cetus_b2a<T0, T1>(arg2, arg0, arg1, 0x2::coin::into_balance<T1>(0x2::coin::take<T1>(&mut arg4.balance, arg6, arg8)), arg8), arg8), arg7);
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
        deposit<T1>(arg5, 0x2::coin::from_balance<T1>(0x155a158aa410286cd31c110ee5edf621761ac04107a75b49bc87185be2a88136::d::momentum_a2b<T0, T1>(arg2, arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::take<T0>(&mut arg4.balance, arg6, arg8)), arg8), arg8), arg7);
    }

    public fun momentum_b2a<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut AccessList, arg4: &mut Bank<T1>, arg5: &mut Bank<T0>, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(is_trader(arg3, arg8), 1);
        assert!(is_pool_wl(arg3, 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg1)), 2);
        deposit<T0>(arg5, 0x2::coin::from_balance<T0>(0x155a158aa410286cd31c110ee5edf621761ac04107a75b49bc87185be2a88136::d::momentum_b2a<T0, T1>(arg2, arg0, arg1, 0x2::coin::into_balance<T1>(0x2::coin::take<T1>(&mut arg4.balance, arg6, arg8)), arg8), arg8), arg7);
    }

    public fun new_access_list(arg0: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x151401db5d86088134dbcab1f7ab6dd013550f474de69210128de58a0c7401c3, 1);
        let v0 = AccessList{
            id     : 0x2::object::new(arg0),
            admin  : 0x2::tx_context::sender(arg0),
            trader : @0x523e985be976a6f4923a4c4c4a0bc401a2c1ff5dd6caec1a3e0bcbd89aecfd49,
            wl     : 0x1::vector::empty<0x2::object::ID>(),
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

    public fun turbos_a2b<T0, T1, T2>(arg0: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: &0x2::clock::Clock, arg3: &mut AccessList, arg4: &mut Bank<T0>, arg5: &mut Bank<T1>, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(is_trader(arg3, arg8), 1);
        assert!(is_pool_wl(arg3, 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg1)), 2);
        deposit<T1>(arg5, 0x2::coin::from_balance<T1>(0x155a158aa410286cd31c110ee5edf621761ac04107a75b49bc87185be2a88136::d::turbos_a2b<T0, T1, T2>(arg1, 0x2::coin::into_balance<T0>(0x2::coin::take<T0>(&mut arg4.balance, arg6, arg8)), arg2, arg0, arg8), arg8), arg7);
    }

    public fun turbos_b2a<T0, T1, T2>(arg0: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: &0x2::clock::Clock, arg3: &mut AccessList, arg4: &mut Bank<T1>, arg5: &mut Bank<T0>, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(is_trader(arg3, arg8), 1);
        assert!(is_pool_wl(arg3, 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg1)), 2);
        deposit<T0>(arg5, 0x2::coin::from_balance<T0>(0x155a158aa410286cd31c110ee5edf621761ac04107a75b49bc87185be2a88136::d::turbos_b2a<T0, T1, T2>(arg1, 0x2::coin::into_balance<T1>(0x2::coin::take<T1>(&mut arg4.balance, arg6, arg8)), arg2, arg0, arg8), arg8), arg7);
    }

    public fun withdraw_admin<T0>(arg0: &mut AccessList, arg1: &mut Bank<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(is_admin(arg0, arg3), 1);
        0x2::coin::take<T0>(&mut arg1.balance, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

