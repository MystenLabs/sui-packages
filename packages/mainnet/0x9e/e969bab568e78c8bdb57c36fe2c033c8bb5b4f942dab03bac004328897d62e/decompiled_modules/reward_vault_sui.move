module 0x11b6e7ab930578ee2468e9763c68a340b05b36cbdb4813ed3c612ff7d59a1a1f::reward_vault_sui {
    struct RewardVault has key {
        id: 0x2::object::UID,
        owner: address,
    }

    struct CoinType<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct AmtGuard<phantom T0, phantom T1> {
        nextCoin: CoinType<T0>,
        nextAmount: u64,
        finalCoinType: 0x1::ascii::String,
    }

    struct Promise<phantom T0> {
        repayCoinType: CoinType<T0>,
        repayAmount: u64,
    }

    public fun borrow<T0, T1>(arg0: &mut RewardVault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Promise<T1>) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        let v0 = CoinType<T0>{dummy_field: false};
        let v1 = CoinType<T1>{dummy_field: false};
        let v2 = Promise<T1>{
            repayCoinType : v1,
            repayAmount   : arg1,
        };
        (0x2::coin::split<T0>(0x2::dynamic_field::borrow_mut<CoinType<T0>, 0x2::coin::Coin<T0>>(&mut arg0.id, v0), arg1, arg2), v2)
    }

    public fun borrow_v2<T0, T1>(arg0: &mut RewardVault, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Promise<T1>) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 0);
        let v0 = CoinType<T0>{dummy_field: false};
        let v1 = CoinType<T1>{dummy_field: false};
        let v2 = Promise<T1>{
            repayCoinType : v1,
            repayAmount   : arg2,
        };
        (0x2::coin::split<T0>(0x2::dynamic_field::borrow_mut<CoinType<T0>, 0x2::coin::Coin<T0>>(&mut arg0.id, v0), arg1, arg3), v2)
    }

    public fun cetus_swap_a2b<T0, T1>(arg0: &mut RewardVault, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = CoinType<T0>{dummy_field: false};
        0x3239061b389dcc35be021bb13d174da82fafcc87bf3d8e176e6c62619311a90c::cetus::swap_a2b<T0, T1>(arg1, arg2, arg3, 0x2::coin::split<T0>(0x2::dynamic_field::borrow_mut<CoinType<T0>, 0x2::coin::Coin<T0>>(&mut arg0.id, v0), arg4, arg6), arg5, arg6)
    }

    public fun cetus_swap_a2b_v2<T0, T1, T2>(arg0: &mut RewardVault, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg4: AmtGuard<T0, T2>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<AmtGuard<T1, T2>> {
        let v0 = CoinType<T0>{dummy_field: false};
        let v1 = 0x3239061b389dcc35be021bb13d174da82fafcc87bf3d8e176e6c62619311a90c::cetus::swap_a2b<T0, T1>(arg1, arg2, arg3, 0x2::coin::split<T0>(0x2::dynamic_field::borrow_mut<CoinType<T0>, 0x2::coin::Coin<T0>>(&mut arg0.id, v0), arg4.nextAmount, arg6), arg5, arg6);
        join_coin<T1>(arg0, v1);
        let AmtGuard {
            nextCoin      : _,
            nextAmount    : _,
            finalCoinType : v4,
        } = arg4;
        if (v4 != 0x1::type_name::into_string(0x1::type_name::get<T1>())) {
            let v6 = CoinType<T1>{dummy_field: false};
            let v7 = AmtGuard<T1, T2>{
                nextCoin      : v6,
                nextAmount    : 0x2::coin::value<T1>(&v1),
                finalCoinType : v4,
            };
            0x1::option::some<AmtGuard<T1, T2>>(v7)
        } else {
            0x1::option::none<AmtGuard<T1, T2>>()
        }
    }

    public fun cetus_swap_a2b_v3<T0, T1, T2>(arg0: &mut RewardVault, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg4: AmtGuard<T0, T2>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : AmtGuard<T1, T2> {
        let v0 = CoinType<T0>{dummy_field: false};
        let v1 = 0x3239061b389dcc35be021bb13d174da82fafcc87bf3d8e176e6c62619311a90c::cetus::swap_a2b<T0, T1>(arg1, arg2, arg3, 0x2::coin::split<T0>(0x2::dynamic_field::borrow_mut<CoinType<T0>, 0x2::coin::Coin<T0>>(&mut arg0.id, v0), arg4.nextAmount, arg6), arg5, arg6);
        join_coin<T1>(arg0, v1);
        let AmtGuard {
            nextCoin      : _,
            nextAmount    : _,
            finalCoinType : v4,
        } = arg4;
        let v5 = CoinType<T1>{dummy_field: false};
        AmtGuard<T1, T2>{
            nextCoin      : v5,
            nextAmount    : 0x2::coin::value<T1>(&v1),
            finalCoinType : v4,
        }
    }

    public fun cetus_swap_b2a<T0, T1>(arg0: &mut RewardVault, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = CoinType<T1>{dummy_field: false};
        0x3239061b389dcc35be021bb13d174da82fafcc87bf3d8e176e6c62619311a90c::cetus::swap_b2a<T0, T1>(arg1, arg2, arg3, 0x2::coin::split<T1>(0x2::dynamic_field::borrow_mut<CoinType<T1>, 0x2::coin::Coin<T1>>(&mut arg0.id, v0), arg4, arg6), arg5, arg6)
    }

    public fun cetus_swap_b2a_v2<T0, T1, T2>(arg0: &mut RewardVault, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg4: AmtGuard<T1, T2>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<AmtGuard<T0, T2>> {
        let v0 = CoinType<T1>{dummy_field: false};
        assert!(arg4.nextCoin == v0, 1);
        let v1 = CoinType<T1>{dummy_field: false};
        let v2 = 0x3239061b389dcc35be021bb13d174da82fafcc87bf3d8e176e6c62619311a90c::cetus::swap_b2a<T0, T1>(arg1, arg2, arg3, 0x2::coin::split<T1>(0x2::dynamic_field::borrow_mut<CoinType<T1>, 0x2::coin::Coin<T1>>(&mut arg0.id, v1), arg4.nextAmount, arg6), arg5, arg6);
        join_coin<T0>(arg0, v2);
        let AmtGuard {
            nextCoin      : _,
            nextAmount    : _,
            finalCoinType : v5,
        } = arg4;
        if (v5 != 0x1::type_name::into_string(0x1::type_name::get<T0>())) {
            let v7 = CoinType<T0>{dummy_field: false};
            let v8 = AmtGuard<T0, T2>{
                nextCoin      : v7,
                nextAmount    : 0x2::coin::value<T0>(&v2),
                finalCoinType : v5,
            };
            0x1::option::some<AmtGuard<T0, T2>>(v8)
        } else {
            0x1::option::none<AmtGuard<T0, T2>>()
        }
    }

    public fun cetus_swap_b2a_v3<T0, T1, T2>(arg0: &mut RewardVault, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg4: AmtGuard<T1, T2>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : AmtGuard<T0, T2> {
        let v0 = CoinType<T1>{dummy_field: false};
        assert!(arg4.nextCoin == v0, 1);
        let v1 = CoinType<T1>{dummy_field: false};
        let v2 = 0x3239061b389dcc35be021bb13d174da82fafcc87bf3d8e176e6c62619311a90c::cetus::swap_b2a<T0, T1>(arg1, arg2, arg3, 0x2::coin::split<T1>(0x2::dynamic_field::borrow_mut<CoinType<T1>, 0x2::coin::Coin<T1>>(&mut arg0.id, v1), arg4.nextAmount, arg6), arg5, arg6);
        join_coin<T0>(arg0, v2);
        let AmtGuard {
            nextCoin      : _,
            nextAmount    : _,
            finalCoinType : v5,
        } = arg4;
        let v6 = CoinType<T0>{dummy_field: false};
        AmtGuard<T0, T2>{
            nextCoin      : v6,
            nextAmount    : 0x2::coin::value<T0>(&v2),
            finalCoinType : v5,
        }
    }

    public fun deposit<T0>(arg0: &mut RewardVault, arg1: 0x2::coin::Coin<T0>) {
        join_coin<T0>(arg0, arg1);
    }

    public fun done_swap<T0>(arg0: AmtGuard<T0, T0>) {
        let AmtGuard {
            nextCoin      : _,
            nextAmount    : _,
            finalCoinType : _,
        } = arg0;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RewardVault{
            id    : 0x2::object::new(arg0),
            owner : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<RewardVault>(v0);
    }

    public fun init_swap<T0, T1>(arg0: u64) : AmtGuard<T0, T1> {
        let v0 = CoinType<T0>{dummy_field: false};
        AmtGuard<T0, T1>{
            nextCoin      : v0,
            nextAmount    : arg0,
            finalCoinType : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
        }
    }

    fun join_coin<T0>(arg0: &mut RewardVault, arg1: 0x2::coin::Coin<T0>) {
        let v0 = CoinType<T0>{dummy_field: false};
        if (0x2::dynamic_field::exists_<CoinType<T0>>(&arg0.id, v0)) {
            0x2::coin::join<T0>(0x2::dynamic_field::borrow_mut<CoinType<T0>, 0x2::coin::Coin<T0>>(&mut arg0.id, v0), arg1);
        } else {
            0x2::dynamic_field::add<CoinType<T0>, 0x2::coin::Coin<T0>>(&mut arg0.id, v0, arg1);
        };
    }

    public fun repay<T0>(arg0: &mut RewardVault, arg1: Promise<T0>, arg2: 0x2::coin::Coin<T0>) {
        let Promise {
            repayCoinType : _,
            repayAmount   : v1,
        } = arg1;
        assert!(0x2::coin::value<T0>(&arg2) >= v1, 1);
        join_coin<T0>(arg0, arg2);
    }

    public fun transfer_ownership(arg0: &mut RewardVault, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        arg0.owner = arg1;
    }

    public fun withdraw<T0>(arg0: &mut RewardVault, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 0);
        let v0 = CoinType<T0>{dummy_field: false};
        0x2::dynamic_field::remove<CoinType<T0>, 0x2::coin::Coin<T0>>(&mut arg0.id, v0)
    }

    // decompiled from Move bytecode v6
}

