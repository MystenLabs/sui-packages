module 0x84936ef2d5f628f03267f4d0012982b4a1119fa5a029c92d17240aade9789ca::amm {
    struct LP<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        reserve_a: 0x2::balance::Balance<T0>,
        reserve_b: 0x2::balance::Balance<T1>,
        lp_supply: 0x2::balance::Supply<LP<T0, T1>>,
        lp_locked: 0x2::balance::Balance<LP<T0, T1>>,
    }

    struct PoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        amount_a: u64,
        amount_b: u64,
    }

    struct Swapped has copy, drop {
        pool_id: 0x2::object::ID,
        a_to_b: bool,
        amount_in: u64,
        amount_out: u64,
    }

    public fun add_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<LP<T0, T1>> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = 0x2::coin::value<T1>(&arg2);
        assert!(v0 > 0 && v1 > 0, 0);
        let v2 = 0x2::balance::supply_value<LP<T0, T1>>(&arg0.lp_supply);
        let v3 = mul_div(v0, v2, 0x2::balance::value<T0>(&arg0.reserve_a));
        let v4 = mul_div(v1, v2, 0x2::balance::value<T1>(&arg0.reserve_b));
        let v5 = if (v3 < v4) {
            v3
        } else {
            v4
        };
        assert!(v5 > 0, 1);
        0x2::balance::join<T0>(&mut arg0.reserve_a, 0x2::coin::into_balance<T0>(arg1));
        0x2::balance::join<T1>(&mut arg0.reserve_b, 0x2::coin::into_balance<T1>(arg2));
        0x2::coin::from_balance<LP<T0, T1>>(0x2::balance::increase_supply<LP<T0, T1>>(&mut arg0.lp_supply, v5), arg3)
    }

    public fun create_pool<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<LP<T0, T1>> {
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 > 0 && v1 > 0, 0);
        let v2 = sqrt((v0 as u128) * (v1 as u128));
        assert!(v2 > 1000, 1);
        let v3 = LP<T0, T1>{dummy_field: false};
        let v4 = 0x2::balance::create_supply<LP<T0, T1>>(v3);
        let v5 = 0x2::object::new(arg2);
        let v6 = Pool<T0, T1>{
            id        : v5,
            reserve_a : 0x2::coin::into_balance<T0>(arg0),
            reserve_b : 0x2::coin::into_balance<T1>(arg1),
            lp_supply : v4,
            lp_locked : 0x2::balance::increase_supply<LP<T0, T1>>(&mut v4, 1000),
        };
        0x2::transfer::share_object<Pool<T0, T1>>(v6);
        let v7 = PoolCreated{
            pool_id  : 0x2::object::uid_to_inner(&v5),
            amount_a : v0,
            amount_b : v1,
        };
        0x2::event::emit<PoolCreated>(v7);
        0x2::coin::from_balance<LP<T0, T1>>(0x2::balance::increase_supply<LP<T0, T1>>(&mut v4, v2 - 1000), arg2)
    }

    public fun get_amount_out(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg0 as u256) * ((10000 - 30) as u256);
        ((v0 * (arg2 as u256) / ((arg1 as u256) * (10000 as u256) + v0)) as u64)
    }

    public fun lp_total<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0x2::balance::supply_value<LP<T0, T1>>(&arg0.lp_supply)
    }

    fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun remove_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<LP<T0, T1>>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::value<LP<T0, T1>>(&arg1);
        assert!(v0 > 0, 0);
        let v1 = 0x2::balance::supply_value<LP<T0, T1>>(&arg0.lp_supply);
        0x2::balance::decrease_supply<LP<T0, T1>>(&mut arg0.lp_supply, 0x2::coin::into_balance<LP<T0, T1>>(arg1));
        (0x2::coin::take<T0>(&mut arg0.reserve_a, mul_div(v0, 0x2::balance::value<T0>(&arg0.reserve_a), v1), arg2), 0x2::coin::take<T1>(&mut arg0.reserve_b, mul_div(v0, 0x2::balance::value<T1>(&arg0.reserve_b), v1), arg2))
    }

    public fun reserves<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.reserve_a), 0x2::balance::value<T1>(&arg0.reserve_b))
    }

    fun sqrt(arg0: u128) : u64 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = (arg0 + 1) / 2;
        while (v0 < arg0) {
            let v1 = arg0 / v0 + v0;
            v0 = v1 / 2;
        };
        (arg0 as u64)
    }

    public fun swap_a_for_b<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 0);
        let v1 = 0x2::balance::value<T1>(&arg0.reserve_b);
        let v2 = get_amount_out(v0, 0x2::balance::value<T0>(&arg0.reserve_a), v1);
        assert!(v2 >= arg2, 2);
        assert!(v2 < v1, 1);
        0x2::balance::join<T0>(&mut arg0.reserve_a, 0x2::coin::into_balance<T0>(arg1));
        let v3 = Swapped{
            pool_id    : 0x2::object::uid_to_inner(&arg0.id),
            a_to_b     : true,
            amount_in  : v0,
            amount_out : v2,
        };
        0x2::event::emit<Swapped>(v3);
        0x2::coin::take<T1>(&mut arg0.reserve_b, v2, arg3)
    }

    public fun swap_b_for_a<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 > 0, 0);
        let v1 = 0x2::balance::value<T0>(&arg0.reserve_a);
        let v2 = get_amount_out(v0, 0x2::balance::value<T1>(&arg0.reserve_b), v1);
        assert!(v2 >= arg2, 2);
        assert!(v2 < v1, 1);
        0x2::balance::join<T1>(&mut arg0.reserve_b, 0x2::coin::into_balance<T1>(arg1));
        let v3 = Swapped{
            pool_id    : 0x2::object::uid_to_inner(&arg0.id),
            a_to_b     : false,
            amount_in  : v0,
            amount_out : v2,
        };
        0x2::event::emit<Swapped>(v3);
        0x2::coin::take<T0>(&mut arg0.reserve_a, v2, arg3)
    }

    // decompiled from Move bytecode v7
}

