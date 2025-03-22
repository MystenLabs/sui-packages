module 0xd62e8294c8157f2d209afb87ed30c2dffd5e77f88040cd698593af52a8ed4f5a::liquidity_pool {
    struct LiquidityPool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        reserve_x: 0x2::balance::Balance<T0>,
        reserve_y: 0x2::balance::Balance<T1>,
        lp_supply: u64,
        fee_percent: u64,
        coin_x_type: 0x1::string::String,
        coin_y_type: 0x1::string::String,
    }

    struct LPCoin<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        amount: u64,
    }

    struct PoolCreatedEvent has copy, drop {
        pool_id: address,
        coin_x_type: 0x1::string::String,
        coin_y_type: 0x1::string::String,
    }

    struct LiquidityAddedEvent has copy, drop {
        provider: address,
        pool_id: address,
        amount_x: u64,
        amount_y: u64,
        lp_tokens: u64,
    }

    struct LiquidityRemovedEvent has copy, drop {
        provider: address,
        pool_id: address,
        amount_x: u64,
        amount_y: u64,
        lp_tokens: u64,
    }

    public fun add_liquidity<T0, T1>(arg0: &mut LiquidityPool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) : (LPCoin<T0, T1>, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = 0x2::coin::value<T1>(&arg2);
        assert!(v0 > 0 && v1 > 0, 0);
        let v2 = 0x2::balance::value<T0>(&arg0.reserve_x);
        let v3 = 0x2::balance::value<T1>(&arg0.reserve_y);
        assert!(v2 > 0 && v3 > 0, 1);
        let v4 = (v2 as u128);
        let v5 = (v3 as u128);
        let v6 = (v0 as u128) * v5 / v4;
        let v7 = if (v6 > 18446744073709551615) {
            18446744073709551615
        } else {
            (v6 as u64)
        };
        let (v8, v9) = if (v7 <= v1) {
            (v0, v7)
        } else {
            let v10 = (v1 as u128) * v4 / v5;
            let v11 = if (v10 > 18446744073709551615) {
                18446744073709551615
            } else {
                (v10 as u64)
            };
            (v11, v1)
        };
        let v12 = 0x1::u128::sqrt((v8 as u128) * (v9 as u128));
        let v13 = if (v12 > 18446744073709551615) {
            18446744073709551615
        } else {
            (v12 as u64)
        };
        let v14 = if (v8 == v0) {
            let v14 = arg1;
            arg1 = 0x2::coin::zero<T0>(arg3);
            v14
        } else {
            0x2::coin::split<T0>(&mut arg1, v8, arg3)
        };
        let v15 = if (v9 == v1) {
            let v15 = arg2;
            arg2 = 0x2::coin::zero<T1>(arg3);
            v15
        } else {
            0x2::coin::split<T1>(&mut arg2, v9, arg3)
        };
        let v16 = 0x2::coin::into_balance<T0>(v14);
        let v17 = 0x2::coin::into_balance<T1>(v15);
        0x2::balance::join<T0>(&mut arg0.reserve_x, v16);
        0x2::balance::join<T1>(&mut arg0.reserve_y, v17);
        arg0.lp_supply = arg0.lp_supply + v13;
        let v18 = LPCoin<T0, T1>{
            id     : 0x2::object::new(arg3),
            amount : v13,
        };
        let v19 = LiquidityAddedEvent{
            provider  : 0x2::tx_context::sender(arg3),
            pool_id   : 0x2::object::uid_to_address(&arg0.id),
            amount_x  : 0x2::balance::value<T0>(&v16),
            amount_y  : 0x2::balance::value<T1>(&v17),
            lp_tokens : v13,
        };
        0x2::event::emit<LiquidityAddedEvent>(v19);
        (v18, arg1, arg2)
    }

    public fun calculate_lp_profit<T0, T1>(arg0: &LiquidityPool<T0, T1>, arg1: u64, arg2: u64, arg3: u64) : (u64, u64, bool, bool) {
        let (v0, v1) = calculate_lp_value<T0, T1>(arg0, arg1);
        let v2 = if (v0 > arg2) {
            v0 - arg2
        } else {
            0
        };
        let v3 = if (v1 > arg3) {
            v1 - arg3
        } else {
            0
        };
        (v2, v3, v0 > arg2, v1 > arg3)
    }

    public fun calculate_lp_value<T0, T1>(arg0: &LiquidityPool<T0, T1>, arg1: u64) : (u64, u64) {
        let v0 = arg0.lp_supply;
        if (v0 == 0) {
            return (0, 0)
        };
        (arg1 * 0x2::balance::value<T0>(&arg0.reserve_x) / v0, arg1 * 0x2::balance::value<T1>(&arg0.reserve_y) / v0)
    }

    public fun create_pool<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : LiquidityPool<T0, T1> {
        assert!(arg2 <= 500, 4);
        assert!(!is_same_type<T0, T1>(), 6);
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 > 0 && v1 > 0, 0);
        let v2 = 0x2::object::new(arg3);
        let v3 = 0x1::u128::sqrt((v0 as u128) * (v1 as u128));
        let v4 = if (v3 > 18446744073709551615) {
            18446744073709551615
        } else {
            (v3 as u64)
        };
        let v5 = LiquidityPool<T0, T1>{
            id          : v2,
            reserve_x   : 0x2::coin::into_balance<T0>(arg0),
            reserve_y   : 0x2::coin::into_balance<T1>(arg1),
            lp_supply   : v4,
            fee_percent : arg2,
            coin_x_type : get_coin_name<T0>(),
            coin_y_type : get_coin_name<T1>(),
        };
        let v6 = PoolCreatedEvent{
            pool_id     : 0x2::object::uid_to_address(&v2),
            coin_x_type : get_coin_name<T0>(),
            coin_y_type : get_coin_name<T1>(),
        };
        0x2::event::emit<PoolCreatedEvent>(v6);
        v5
    }

    fun get_coin_name<T0>() : 0x1::string::String {
        0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())))
    }

    public fun get_fee_percent<T0, T1>(arg0: &LiquidityPool<T0, T1>) : u64 {
        arg0.fee_percent
    }

    public fun get_lp_amount<T0, T1>(arg0: &LPCoin<T0, T1>) : u64 {
        arg0.amount
    }

    public fun get_lp_supply<T0, T1>(arg0: &LiquidityPool<T0, T1>) : u64 {
        arg0.lp_supply
    }

    public fun get_pool_id<T0, T1>(arg0: &LiquidityPool<T0, T1>) : &0x2::object::UID {
        &arg0.id
    }

    public fun get_reserves<T0, T1>(arg0: &LiquidityPool<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.reserve_x), 0x2::balance::value<T1>(&arg0.reserve_y))
    }

    fun is_same_type<T0, T1>() : bool {
        get_coin_name<T0>() == get_coin_name<T1>()
    }

    public fun remove_liquidity<T0, T1>(arg0: &mut LiquidityPool<T0, T1>, arg1: LPCoin<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = arg1.amount;
        let LPCoin {
            id     : v1,
            amount : _,
        } = arg1;
        0x2::object::delete(v1);
        assert!(v0 > 0, 0);
        assert!(v0 <= arg0.lp_supply, 1);
        let v3 = (v0 as u128);
        let v4 = (arg0.lp_supply as u128);
        let v5 = v3 * (0x2::balance::value<T0>(&arg0.reserve_x) as u128) / v4;
        let v6 = v3 * (0x2::balance::value<T1>(&arg0.reserve_y) as u128) / v4;
        let v7 = if (v5 > 18446744073709551615) {
            18446744073709551615
        } else {
            (v5 as u64)
        };
        let v8 = if (v6 > 18446744073709551615) {
            18446744073709551615
        } else {
            (v6 as u64)
        };
        assert!(v7 > 0, 2);
        assert!(v8 > 0, 3);
        arg0.lp_supply = arg0.lp_supply - v0;
        let v9 = LiquidityRemovedEvent{
            provider  : 0x2::tx_context::sender(arg2),
            pool_id   : 0x2::object::uid_to_address(&arg0.id),
            amount_x  : v7,
            amount_y  : v8,
            lp_tokens : v0,
        };
        0x2::event::emit<LiquidityRemovedEvent>(v9);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reserve_x, v7), arg2), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.reserve_y, v8), arg2))
    }

    public fun swap_x_to_y<T0, T1>(arg0: &mut LiquidityPool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x2::coin::value<T0>(&arg1) > 0, 0);
        assert!(arg2 > 0, 0);
        let v0 = 0x2::balance::value<T0>(&arg0.reserve_x);
        let v1 = 0x2::balance::value<T1>(&arg0.reserve_y);
        assert!(v0 > 0 && v1 > 0, 1);
        assert!(arg2 < v1, 3);
        0x2::balance::join<T0>(&mut arg0.reserve_x, 0x2::coin::into_balance<T0>(arg1));
        assert!((0x2::balance::value<T0>(&arg0.reserve_x) as u128) * (0x2::balance::value<T1>(&arg0.reserve_y) as u128) >= (v0 as u128) * (v1 as u128), 5);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.reserve_y, arg2), arg3)
    }

    public fun swap_y_to_x<T0, T1>(arg0: &mut LiquidityPool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::coin::value<T1>(&arg1) > 0, 0);
        assert!(arg2 > 0, 0);
        let v0 = 0x2::balance::value<T0>(&arg0.reserve_x);
        let v1 = 0x2::balance::value<T1>(&arg0.reserve_y);
        assert!(v0 > 0 && v1 > 0, 1);
        assert!(arg2 < v0, 2);
        0x2::balance::join<T1>(&mut arg0.reserve_y, 0x2::coin::into_balance<T1>(arg1));
        assert!((0x2::balance::value<T0>(&arg0.reserve_x) as u128) * (0x2::balance::value<T1>(&arg0.reserve_y) as u128) >= (v0 as u128) * (v1 as u128), 5);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reserve_x, arg2), arg3)
    }

    // decompiled from Move bytecode v6
}

