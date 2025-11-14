module 0x4ffa40e2053a92842a487f4734ae4f7b11a27e3a5b7e66b16f2354776134eea::pool {
    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        reserve_a: 0x2::balance::Balance<T0>,
        reserve_b: 0x2::balance::Balance<T1>,
        lp_supply: 0x2::balance::Supply<0x4ffa40e2053a92842a487f4734ae4f7b11a27e3a5b7e66b16f2354776134eea::lp_coin::LP<T0, T1>>,
        locked_lp: 0x2::balance::Balance<0x4ffa40e2053a92842a487f4734ae4f7b11a27e3a5b7e66b16f2354776134eea::lp_coin::LP<T0, T1>>,
        fee_collector: address,
    }

    struct PoolCreated has copy, drop {
        pool_id: address,
        creator: address,
        initial_reserve_a: u64,
        initial_reserve_b: u64,
        initial_lp: u64,
    }

    struct LiquidityAdded has copy, drop {
        pool_id: address,
        provider: address,
        amount_a: u64,
        amount_b: u64,
        lp_minted: u64,
        total_supply: u64,
    }

    struct LiquidityRemoved has copy, drop {
        pool_id: address,
        provider: address,
        lp_burned: u64,
        amount_a: u64,
        amount_b: u64,
        total_supply: u64,
    }

    struct Swapped has copy, drop {
        pool_id: address,
        trader: address,
        amount_in: u64,
        amount_out: u64,
        fee_amount: u64,
        is_a_to_b: bool,
        reserve_a: u64,
        reserve_b: u64,
    }

    public fun add_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<0x4ffa40e2053a92842a487f4734ae4f7b11a27e3a5b7e66b16f2354776134eea::lp_coin::LP<T0, T1>>) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= 2000000000, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, arg0.fee_collector);
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = 0x2::coin::value<T1>(&arg2);
        let (v2, v3, v4) = get_amounts<T0, T1>(arg0);
        let v5 = quote(v0, v2, v3);
        let (v6, v7) = if (v5 <= v1) {
            (v0, v5)
        } else {
            let v8 = quote(v1, v3, v2);
            assert!(v8 <= v0, 1);
            (v8, v1)
        };
        let v9 = (v6 as u128) * (v4 as u128) / (v2 as u128);
        let v10 = (v7 as u128) * (v4 as u128) / (v3 as u128);
        let v11 = if (v9 < v10) {
            (v9 as u64)
        } else {
            (v10 as u64)
        };
        assert!(v11 >= arg4, 2);
        0x2::balance::join<T0>(&mut arg0.reserve_a, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, v6, arg5)));
        0x2::balance::join<T1>(&mut arg0.reserve_b, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg2, v7, arg5)));
        let v12 = LiquidityAdded{
            pool_id      : 0x2::object::id_address<Pool<T0, T1>>(arg0),
            provider     : 0x2::tx_context::sender(arg5),
            amount_a     : v6,
            amount_b     : v7,
            lp_minted    : v11,
            total_supply : 0x2::balance::supply_value<0x4ffa40e2053a92842a487f4734ae4f7b11a27e3a5b7e66b16f2354776134eea::lp_coin::LP<T0, T1>>(&arg0.lp_supply),
        };
        0x2::event::emit<LiquidityAdded>(v12);
        (arg1, arg2, 0x2::coin::from_balance<0x4ffa40e2053a92842a487f4734ae4f7b11a27e3a5b7e66b16f2354776134eea::lp_coin::LP<T0, T1>>(0x2::balance::increase_supply<0x4ffa40e2053a92842a487f4734ae4f7b11a27e3a5b7e66b16f2354776134eea::lp_coin::LP<T0, T1>>(&mut arg0.lp_supply, v11), arg5))
    }

    public fun create_pool<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : (Pool<T0, T1>, 0x2::coin::Coin<0x4ffa40e2053a92842a487f4734ae4f7b11a27e3a5b7e66b16f2354776134eea::lp_coin::LP<T0, T1>>) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 > 0 && v1 > 0, 1);
        let v2 = sqrt_u128((v0 as u128) * (v1 as u128));
        assert!(v2 > 1000, 0);
        let v3 = 0x2::balance::create_supply<0x4ffa40e2053a92842a487f4734ae4f7b11a27e3a5b7e66b16f2354776134eea::lp_coin::LP<T0, T1>>(0x4ffa40e2053a92842a487f4734ae4f7b11a27e3a5b7e66b16f2354776134eea::lp_coin::create_witness<T0, T1>());
        let v4 = 0x2::balance::increase_supply<0x4ffa40e2053a92842a487f4734ae4f7b11a27e3a5b7e66b16f2354776134eea::lp_coin::LP<T0, T1>>(&mut v3, v2);
        let v5 = Pool<T0, T1>{
            id            : 0x2::object::new(arg3),
            reserve_a     : 0x2::coin::into_balance<T0>(arg0),
            reserve_b     : 0x2::coin::into_balance<T1>(arg1),
            lp_supply     : v3,
            locked_lp     : 0x2::balance::split<0x4ffa40e2053a92842a487f4734ae4f7b11a27e3a5b7e66b16f2354776134eea::lp_coin::LP<T0, T1>>(&mut v4, 1000),
            fee_collector : arg2,
        };
        let v6 = PoolCreated{
            pool_id           : 0x2::object::id_address<Pool<T0, T1>>(&v5),
            creator           : 0x2::tx_context::sender(arg3),
            initial_reserve_a : v0,
            initial_reserve_b : v1,
            initial_lp        : v2 - 1000,
        };
        0x2::event::emit<PoolCreated>(v6);
        (v5, 0x2::coin::from_balance<0x4ffa40e2053a92842a487f4734ae4f7b11a27e3a5b7e66b16f2354776134eea::lp_coin::LP<T0, T1>>(v4, arg3))
    }

    public fun fee_collector<T0, T1>(arg0: &Pool<T0, T1>) : address {
        arg0.fee_collector
    }

    public fun get_add_liquidity_amounts<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64, arg2: u64) : (u64, u64, u64) {
        let (v0, v1, v2) = get_amounts<T0, T1>(arg0);
        let v3 = quote(arg1, v0, v1);
        let (v4, v5) = if (v3 <= arg2) {
            (arg1, v3)
        } else {
            (quote(arg2, v1, v0), arg2)
        };
        let v6 = (v4 as u128) * (v2 as u128) / (v0 as u128);
        let v7 = (v5 as u128) * (v2 as u128) / (v1 as u128);
        let v8 = if (v6 < v7) {
            (v6 as u64)
        } else {
            (v7 as u64)
        };
        (v4, v5, v8)
    }

    public fun get_add_liquidity_fee() : u64 {
        2000000000
    }

    fun get_amount_out(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg0 > 0, 3);
        assert!(arg1 > 0 && arg2 > 0, 0);
        let v0 = (arg0 as u128) * 99;
        ((v0 * (arg2 as u128) / ((arg1 as u128) * 100 + v0)) as u64)
    }

    public fun get_amount_out_a_to_b<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64) : u64 {
        let (v0, v1, _) = get_amounts<T0, T1>(arg0);
        get_amount_out(arg1, v0, v1)
    }

    public fun get_amount_out_b_to_a<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64) : u64 {
        let (v0, v1, _) = get_amounts<T0, T1>(arg0);
        get_amount_out(arg1, v1, v0)
    }

    public fun get_amounts<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64, u64) {
        (0x2::balance::value<T0>(&arg0.reserve_a), 0x2::balance::value<T1>(&arg0.reserve_b), 0x2::balance::supply_value<0x4ffa40e2053a92842a487f4734ae4f7b11a27e3a5b7e66b16f2354776134eea::lp_coin::LP<T0, T1>>(&arg0.lp_supply))
    }

    public fun get_minimum_liquidity() : u64 {
        1000
    }

    public fun get_remove_liquidity_fee() : u64 {
        2000000000
    }

    public fun get_reserves<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.reserve_a), 0x2::balance::value<T1>(&arg0.reserve_b))
    }

    public fun get_swap_fee_percent() : u64 {
        1
    }

    public fun locked_lp<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0x2::balance::value<0x4ffa40e2053a92842a487f4734ae4f7b11a27e3a5b7e66b16f2354776134eea::lp_coin::LP<T0, T1>>(&arg0.locked_lp)
    }

    public fun lp_supply<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0x2::balance::supply_value<0x4ffa40e2053a92842a487f4734ae4f7b11a27e3a5b7e66b16f2354776134eea::lp_coin::LP<T0, T1>>(&arg0.lp_supply)
    }

    fun quote(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = if (arg0 > 0) {
            if (arg1 > 0) {
                arg2 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1);
        (((arg0 as u128) * (arg2 as u128) / (arg1 as u128)) as u64)
    }

    public fun remove_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<0x4ffa40e2053a92842a487f4734ae4f7b11a27e3a5b7e66b16f2354776134eea::lp_coin::LP<T0, T1>>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= 2000000000, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, arg0.fee_collector);
        let v0 = 0x2::coin::value<0x4ffa40e2053a92842a487f4734ae4f7b11a27e3a5b7e66b16f2354776134eea::lp_coin::LP<T0, T1>>(&arg1);
        let (_, _, v3) = get_amounts<T0, T1>(arg0);
        let v4 = (((v0 as u128) * (0x2::balance::value<T0>(&arg0.reserve_a) as u128) / (v3 as u128)) as u64);
        let v5 = (((v0 as u128) * (0x2::balance::value<T1>(&arg0.reserve_b) as u128) / (v3 as u128)) as u64);
        assert!(v4 >= arg3 && v5 >= arg4, 2);
        0x2::balance::decrease_supply<0x4ffa40e2053a92842a487f4734ae4f7b11a27e3a5b7e66b16f2354776134eea::lp_coin::LP<T0, T1>>(&mut arg0.lp_supply, 0x2::coin::into_balance<0x4ffa40e2053a92842a487f4734ae4f7b11a27e3a5b7e66b16f2354776134eea::lp_coin::LP<T0, T1>>(arg1));
        let v6 = LiquidityRemoved{
            pool_id      : 0x2::object::id_address<Pool<T0, T1>>(arg0),
            provider     : 0x2::tx_context::sender(arg5),
            lp_burned    : v0,
            amount_a     : v4,
            amount_b     : v5,
            total_supply : 0x2::balance::supply_value<0x4ffa40e2053a92842a487f4734ae4f7b11a27e3a5b7e66b16f2354776134eea::lp_coin::LP<T0, T1>>(&arg0.lp_supply),
        };
        0x2::event::emit<LiquidityRemoved>(v6);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reserve_a, v4), arg5), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.reserve_b, v5), arg5))
    }

    public fun reserve_a<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.reserve_a)
    }

    public fun reserve_b<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.reserve_b)
    }

    public fun share_pool<T0, T1>(arg0: Pool<T0, T1>) {
        0x2::transfer::share_object<Pool<T0, T1>>(arg0);
    }

    fun sqrt_u128(arg0: u128) : u64 {
        if (arg0 < 4) {
            if (arg0 == 0) {
                0
            } else {
                1
            }
        } else {
            let v1 = arg0 / 2 + 1;
            while (v1 < arg0) {
                let v2 = arg0 / v1 + v1;
                v1 = v2 / 2;
            };
            (arg0 as u64)
        }
    }

    public fun swap_a_for_b<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 3);
        let (v1, v2, _) = get_amounts<T0, T1>(arg0);
        let v4 = get_amount_out(v0, v1, v2);
        assert!(v4 >= arg2, 2);
        let v5 = v0 * 1 / 100;
        let v6 = 0x2::coin::into_balance<T0>(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v6, v5), arg3), arg0.fee_collector);
        0x2::balance::join<T0>(&mut arg0.reserve_a, v6);
        let v7 = Swapped{
            pool_id    : 0x2::object::id_address<Pool<T0, T1>>(arg0),
            trader     : 0x2::tx_context::sender(arg3),
            amount_in  : v0,
            amount_out : v4,
            fee_amount : v5,
            is_a_to_b  : true,
            reserve_a  : 0x2::balance::value<T0>(&arg0.reserve_a),
            reserve_b  : 0x2::balance::value<T1>(&arg0.reserve_b),
        };
        0x2::event::emit<Swapped>(v7);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.reserve_b, v4), arg3)
    }

    public fun swap_b_for_a<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 > 0, 3);
        let (v1, v2, _) = get_amounts<T0, T1>(arg0);
        let v4 = get_amount_out(v0, v2, v1);
        assert!(v4 >= arg2, 2);
        let v5 = v0 * 1 / 100;
        let v6 = 0x2::coin::into_balance<T1>(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v6, v5), arg3), arg0.fee_collector);
        0x2::balance::join<T1>(&mut arg0.reserve_b, v6);
        let v7 = Swapped{
            pool_id    : 0x2::object::id_address<Pool<T0, T1>>(arg0),
            trader     : 0x2::tx_context::sender(arg3),
            amount_in  : v0,
            amount_out : v4,
            fee_amount : v5,
            is_a_to_b  : false,
            reserve_a  : 0x2::balance::value<T0>(&arg0.reserve_a),
            reserve_b  : 0x2::balance::value<T1>(&arg0.reserve_b),
        };
        0x2::event::emit<Swapped>(v7);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reserve_a, v4), arg3)
    }

    // decompiled from Move bytecode v6
}

