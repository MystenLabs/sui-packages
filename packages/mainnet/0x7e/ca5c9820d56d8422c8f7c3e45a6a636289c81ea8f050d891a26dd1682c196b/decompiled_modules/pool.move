module 0x7eca5c9820d56d8422c8f7c3e45a6a636289c81ea8f050d891a26dd1682c196b::pool {
    struct LP<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        reserve_a: 0x2::balance::Balance<T0>,
        reserve_b: 0x2::balance::Balance<T1>,
        lp_supply: 0x2::balance::Supply<LP<T0, T1>>,
        total_fee_a: u64,
        total_fee_b: u64,
        total_swaps: u64,
    }

    struct PoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
    }

    struct SwapExecuted has copy, drop {
        pool_id: 0x2::object::ID,
        sender: address,
        a_to_b: bool,
        amount_in: u64,
        amount_out: u64,
        fee: u64,
    }

    struct LiquidityChanged has copy, drop {
        pool_id: 0x2::object::ID,
        provider: address,
        lp_amount: u64,
        a_amount: u64,
        b_amount: u64,
        is_add: bool,
    }

    public fun add_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<LP<T0, T1>> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = 0x2::coin::value<T1>(&arg2);
        assert!(v0 > 0 && v1 > 0, 1);
        let v2 = 0x2::balance::value<T0>(&arg0.reserve_a);
        let v3 = 0x2::balance::value<T1>(&arg0.reserve_b);
        assert!(v2 > 0 && v3 > 0, 5);
        let v4 = 0x2::balance::supply_value<LP<T0, T1>>(&arg0.lp_supply);
        let v5 = (v0 as u128) * (v4 as u128) / (v2 as u128);
        let v6 = (v1 as u128) * (v4 as u128) / (v3 as u128);
        let v7 = if (v5 < v6) {
            (v5 as u64)
        } else {
            (v6 as u64)
        };
        assert!(v7 > 0, 2);
        0x2::balance::join<T0>(&mut arg0.reserve_a, 0x2::coin::into_balance<T0>(arg1));
        0x2::balance::join<T1>(&mut arg0.reserve_b, 0x2::coin::into_balance<T1>(arg2));
        let v8 = LiquidityChanged{
            pool_id   : 0x2::object::id<Pool<T0, T1>>(arg0),
            provider  : 0x2::tx_context::sender(arg3),
            lp_amount : v7,
            a_amount  : v0,
            b_amount  : v1,
            is_add    : true,
        };
        0x2::event::emit<LiquidityChanged>(v8);
        0x2::coin::from_balance<LP<T0, T1>>(0x2::balance::increase_supply<LP<T0, T1>>(&mut arg0.lp_supply, v7), arg3)
    }

    public fun create_pool<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<LP<T0, T1>> {
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 > 0 && v1 > 0, 1);
        let v2 = 0x1::u64::sqrt(v0) * 0x1::u64::sqrt(v1);
        assert!(v2 > 1000, 2);
        let v3 = LP<T0, T1>{dummy_field: false};
        let v4 = 0x2::balance::create_supply<LP<T0, T1>>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<LP<T0, T1>>>(0x2::coin::from_balance<LP<T0, T1>>(0x2::balance::increase_supply<LP<T0, T1>>(&mut v4, 1000), arg2), @0x0);
        let v5 = Pool<T0, T1>{
            id          : 0x2::object::new(arg2),
            reserve_a   : 0x2::coin::into_balance<T0>(arg0),
            reserve_b   : 0x2::coin::into_balance<T1>(arg1),
            lp_supply   : v4,
            total_fee_a : 0,
            total_fee_b : 0,
            total_swaps : 0,
        };
        let v6 = PoolCreated{pool_id: 0x2::object::id<Pool<T0, T1>>(&v5)};
        0x2::event::emit<PoolCreated>(v6);
        0x2::transfer::share_object<Pool<T0, T1>>(v5);
        0x2::coin::from_balance<LP<T0, T1>>(0x2::balance::increase_supply<LP<T0, T1>>(&mut v4, v2 - 1000), arg2)
    }

    public fun fee_bps() : u64 {
        10
    }

    public fun lp_supply<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0x2::balance::supply_value<LP<T0, T1>>(&arg0.lp_supply)
    }

    public fun remove_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<LP<T0, T1>>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::value<LP<T0, T1>>(&arg1);
        assert!(v0 > 0, 1);
        let v1 = 0x2::balance::supply_value<LP<T0, T1>>(&arg0.lp_supply);
        let v2 = (((v0 as u128) * (0x2::balance::value<T0>(&arg0.reserve_a) as u128) / (v1 as u128)) as u64);
        let v3 = (((v0 as u128) * (0x2::balance::value<T1>(&arg0.reserve_b) as u128) / (v1 as u128)) as u64);
        assert!(v2 > 0 && v3 > 0, 4);
        0x2::balance::decrease_supply<LP<T0, T1>>(&mut arg0.lp_supply, 0x2::coin::into_balance<LP<T0, T1>>(arg1));
        let v4 = LiquidityChanged{
            pool_id   : 0x2::object::id<Pool<T0, T1>>(arg0),
            provider  : 0x2::tx_context::sender(arg2),
            lp_amount : v0,
            a_amount  : v2,
            b_amount  : v3,
            is_add    : false,
        };
        0x2::event::emit<LiquidityChanged>(v4);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reserve_a, v2), arg2), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.reserve_b, v3), arg2))
    }

    public fun reserves<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.reserve_a), 0x2::balance::value<T1>(&arg0.reserve_b))
    }

    public fun stats<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64, u64) {
        (arg0.total_fee_a, arg0.total_fee_b, arg0.total_swaps)
    }

    public fun swap_a_to_b<T0, T1, T2: drop>(arg0: &mut Pool<T0, T1>, arg1: T2, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 1);
        let v1 = v0 * 10 / 10000;
        let v2 = v0 - v1;
        let v3 = (((0x2::balance::value<T1>(&arg0.reserve_b) as u128) * (v2 as u128) / ((0x2::balance::value<T0>(&arg0.reserve_a) as u128) + (v2 as u128))) as u64);
        assert!(v3 >= arg3, 3);
        assert!(v3 > 0, 4);
        0x2::balance::join<T0>(&mut arg0.reserve_a, 0x2::coin::into_balance<T0>(arg2));
        arg0.total_fee_a = arg0.total_fee_a + v1;
        arg0.total_swaps = arg0.total_swaps + 1;
        let v4 = SwapExecuted{
            pool_id    : 0x2::object::id<Pool<T0, T1>>(arg0),
            sender     : 0x2::tx_context::sender(arg4),
            a_to_b     : true,
            amount_in  : v0,
            amount_out : v3,
            fee        : v1,
        };
        0x2::event::emit<SwapExecuted>(v4);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.reserve_b, v3), arg4)
    }

    public fun swap_b_to_a<T0, T1, T2: drop>(arg0: &mut Pool<T0, T1>, arg1: T2, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T1>(&arg2);
        assert!(v0 > 0, 1);
        let v1 = v0 * 10 / 10000;
        let v2 = v0 - v1;
        let v3 = (((0x2::balance::value<T0>(&arg0.reserve_a) as u128) * (v2 as u128) / ((0x2::balance::value<T1>(&arg0.reserve_b) as u128) + (v2 as u128))) as u64);
        assert!(v3 >= arg3, 3);
        assert!(v3 > 0, 4);
        0x2::balance::join<T1>(&mut arg0.reserve_b, 0x2::coin::into_balance<T1>(arg2));
        arg0.total_fee_b = arg0.total_fee_b + v1;
        arg0.total_swaps = arg0.total_swaps + 1;
        let v4 = SwapExecuted{
            pool_id    : 0x2::object::id<Pool<T0, T1>>(arg0),
            sender     : 0x2::tx_context::sender(arg4),
            a_to_b     : false,
            amount_in  : v0,
            amount_out : v3,
            fee        : v1,
        };
        0x2::event::emit<SwapExecuted>(v4);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reserve_a, v3), arg4)
    }

    // decompiled from Move bytecode v6
}

