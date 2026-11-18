module 0x2ca35d8bcfb9b47138a37fde2d665d2c3f4a42cf49a538c1eccb239db1a40576::pool {
    struct LP<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        reserve_a: 0x2::balance::Balance<T0>,
        reserve_b: 0x2::balance::Balance<T1>,
        lp_supply: 0x2::balance::Supply<LP<T0, T1>>,
        locked_lp: 0x2::balance::Balance<LP<T0, T1>>,
        fee_bps: u64,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        pools: 0x2::table::Table<PairKey, 0x2::object::ID>,
    }

    struct PairKey has copy, drop, store {
        low: 0x1::type_name::TypeName,
        high: 0x1::type_name::TypeName,
    }

    struct PoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        coin_a: 0x1::type_name::TypeName,
        coin_b: 0x1::type_name::TypeName,
        amount_a: u64,
        amount_b: u64,
        lp_minted: u64,
        fee_bps: u64,
    }

    struct LiquidityAdded has copy, drop {
        pool_id: 0x2::object::ID,
        amount_a: u64,
        amount_b: u64,
        lp_minted: u64,
    }

    struct LiquidityRemoved has copy, drop {
        pool_id: 0x2::object::ID,
        amount_a: u64,
        amount_b: u64,
        lp_burned: u64,
    }

    struct Swapped has copy, drop {
        pool_id: 0x2::object::ID,
        a_to_b: bool,
        amount_in: u64,
        amount_out: u64,
        sender: address,
    }

    public fun add_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<LP<T0, T1>> {
        assert!(arg3 > 0 && arg4 > 0, 0);
        let (v0, v1) = reserves<T0, T1>(arg0);
        let v2 = 0x2::balance::supply_value<LP<T0, T1>>(&arg0.lp_supply);
        let v3 = 0x1::u64::min(mul_div(arg3, v2, v0), mul_div(arg4, v2, v1));
        assert!(v3 > 0, 0);
        assert!(v3 >= arg5, 4);
        let v4 = mul_div_up(v3, v0, v2);
        let v5 = mul_div_up(v3, v1, v2);
        0x2::balance::join<T0>(&mut arg0.reserve_a, 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(arg1), v4));
        0x2::balance::join<T1>(&mut arg0.reserve_b, 0x2::balance::split<T1>(0x2::coin::balance_mut<T1>(arg2), v5));
        let v6 = LiquidityAdded{
            pool_id   : 0x2::object::id<Pool<T0, T1>>(arg0),
            amount_a  : v4,
            amount_b  : v5,
            lp_minted : v3,
        };
        0x2::event::emit<LiquidityAdded>(v6);
        0x2::coin::from_balance<LP<T0, T1>>(0x2::balance::increase_supply<LP<T0, T1>>(&mut arg0.lp_supply, v3), arg6)
    }

    public fun create_pool<T0, T1>(arg0: &mut Registry, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<LP<T0, T1>> {
        assert!(arg3 > 0 && arg3 <= 1000, 1);
        let v0 = pair_key<T0, T1>();
        assert!(!0x2::table::contains<PairKey, 0x2::object::ID>(&arg0.pools, v0), 3);
        let v1 = 0x2::coin::value<T0>(&arg1);
        let v2 = 0x2::coin::value<T1>(&arg2);
        assert!(v1 > 0 && v2 > 0, 0);
        let v3 = (0x1::u128::sqrt((v1 as u128) * (v2 as u128)) as u64);
        assert!(v3 > 1000, 5);
        let v4 = LP<T0, T1>{dummy_field: false};
        let v5 = 0x2::balance::create_supply<LP<T0, T1>>(v4);
        let v6 = v3 - 1000;
        let v7 = Pool<T0, T1>{
            id        : 0x2::object::new(arg4),
            reserve_a : 0x2::coin::into_balance<T0>(arg1),
            reserve_b : 0x2::coin::into_balance<T1>(arg2),
            lp_supply : v5,
            locked_lp : 0x2::balance::increase_supply<LP<T0, T1>>(&mut v5, 1000),
            fee_bps   : arg3,
        };
        let v8 = 0x2::object::id<Pool<T0, T1>>(&v7);
        0x2::table::add<PairKey, 0x2::object::ID>(&mut arg0.pools, v0, v8);
        let v9 = PoolCreated{
            pool_id   : v8,
            coin_a    : 0x1::type_name::with_defining_ids<T0>(),
            coin_b    : 0x1::type_name::with_defining_ids<T1>(),
            amount_a  : v1,
            amount_b  : v2,
            lp_minted : v6,
            fee_bps   : arg3,
        };
        0x2::event::emit<PoolCreated>(v9);
        0x2::transfer::share_object<Pool<T0, T1>>(v7);
        0x2::coin::from_balance<LP<T0, T1>>(0x2::balance::increase_supply<LP<T0, T1>>(&mut v5, v6), arg4)
    }

    fun emit_swap<T0, T1>(arg0: &Pool<T0, T1>, arg1: bool, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        let v0 = Swapped{
            pool_id    : 0x2::object::id<Pool<T0, T1>>(arg0),
            a_to_b     : arg1,
            amount_in  : arg2,
            amount_out : arg3,
            sender     : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<Swapped>(v0);
    }

    public fun fee_bps<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.fee_bps
    }

    public fun get_amount_out(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = (arg0 as u256) * ((10000 - arg3) as u256);
        ((v0 * (arg2 as u256) / ((arg1 as u256) * (10000 as u256) + v0)) as u64)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id    : 0x2::object::new(arg0),
            pools : 0x2::table::new<PairKey, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    public fun lp_supply<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0x2::balance::supply_value<LP<T0, T1>>(&arg0.lp_supply)
    }

    fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u256) * (arg1 as u256) / (arg2 as u256)) as u64)
    }

    fun mul_div_up(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg2 as u256);
        ((((arg0 as u256) * (arg1 as u256) + v0 - 1) / v0) as u64)
    }

    fun pair_key<T0, T1>() : PairKey {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        assert!(v0 != v1, 2);
        if (sorts_before(0x1::ascii::as_bytes(0x1::type_name::as_string(&v0)), 0x1::ascii::as_bytes(0x1::type_name::as_string(&v1)))) {
            PairKey{low: v0, high: v1}
        } else {
            PairKey{low: v1, high: v0}
        }
    }

    public fun pool_id<T0, T1>(arg0: &Registry) : 0x1::option::Option<0x2::object::ID> {
        let v0 = pair_key<T0, T1>();
        if (0x2::table::contains<PairKey, 0x2::object::ID>(&arg0.pools, v0)) {
            0x1::option::some<0x2::object::ID>(*0x2::table::borrow<PairKey, 0x2::object::ID>(&arg0.pools, v0))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    public fun quote_a_to_b<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64) : u64 {
        let (v0, v1) = reserves<T0, T1>(arg0);
        get_amount_out(arg1, v0, v1, arg0.fee_bps)
    }

    public fun quote_b_to_a<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64) : u64 {
        let (v0, v1) = reserves<T0, T1>(arg0);
        get_amount_out(arg1, v1, v0, arg0.fee_bps)
    }

    public fun remove_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<LP<T0, T1>>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::value<LP<T0, T1>>(&arg1);
        assert!(v0 > 0, 0);
        let (v1, v2) = reserves<T0, T1>(arg0);
        let v3 = 0x2::balance::supply_value<LP<T0, T1>>(&arg0.lp_supply);
        let v4 = mul_div(v0, v1, v3);
        let v5 = mul_div(v0, v2, v3);
        assert!(v4 >= arg2 && v5 >= arg3, 4);
        0x2::balance::decrease_supply<LP<T0, T1>>(&mut arg0.lp_supply, 0x2::coin::into_balance<LP<T0, T1>>(arg1));
        let v6 = LiquidityRemoved{
            pool_id   : 0x2::object::id<Pool<T0, T1>>(arg0),
            amount_a  : v4,
            amount_b  : v5,
            lp_burned : v0,
        };
        0x2::event::emit<LiquidityRemoved>(v6);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reserve_a, v4), arg4), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.reserve_b, v5), arg4))
    }

    public fun reserves<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.reserve_a), 0x2::balance::value<T1>(&arg0.reserve_b))
    }

    fun sorts_before(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg0);
        let v1 = 0x1::vector::length<u8>(arg1);
        let v2 = 0;
        while (v2 < v0 && v2 < v1) {
            if (*0x1::vector::borrow<u8>(arg0, v2) != *0x1::vector::borrow<u8>(arg1, v2)) {
                return *0x1::vector::borrow<u8>(arg0, v2) < *0x1::vector::borrow<u8>(arg1, v2)
            };
            v2 = v2 + 1;
        };
        v0 < v1
    }

    public fun swap_a_to_b<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = quote_a_to_b<T0, T1>(arg0, v0);
        assert!(v1 > 0, 5);
        assert!(v1 >= arg2, 4);
        0x2::balance::join<T0>(&mut arg0.reserve_a, 0x2::coin::into_balance<T0>(arg1));
        emit_swap<T0, T1>(arg0, true, v0, v1, arg3);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.reserve_b, v1), arg3)
    }

    public fun swap_b_to_a<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T1>(&arg1);
        let v1 = quote_b_to_a<T0, T1>(arg0, v0);
        assert!(v1 > 0, 5);
        assert!(v1 >= arg2, 4);
        0x2::balance::join<T1>(&mut arg0.reserve_b, 0x2::coin::into_balance<T1>(arg1));
        emit_swap<T0, T1>(arg0, false, v0, v1, arg3);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reserve_a, v1), arg3)
    }

    // decompiled from Move bytecode v7
}

