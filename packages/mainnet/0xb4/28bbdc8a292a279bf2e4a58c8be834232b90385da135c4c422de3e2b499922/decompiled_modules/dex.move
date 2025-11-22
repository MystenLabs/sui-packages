module 0xb428bbdc8a292a279bf2e4a58c8be834232b90385da135c4c422de3e2b499922::dex {
    struct Pool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        coin_a: 0x2::balance::Balance<T0>,
        coin_b: 0x2::balance::Balance<T1>,
        lp_supply: 0x2::balance::Supply<LP<T0, T1>>,
        fee_rate: u64,
        treasury_address: address,
    }

    struct LP<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PoolRegistry has key {
        id: 0x2::object::UID,
        pools: vector<address>,
    }

    struct PoolCreated has copy, drop {
        pool_id: address,
        coin_a_type: vector<u8>,
        coin_b_type: vector<u8>,
        initial_a: u64,
        initial_b: u64,
        fee_rate: u64,
    }

    struct LiquidityAdded has copy, drop {
        pool_id: address,
        provider: address,
        amount_a: u64,
        amount_b: u64,
        lp_tokens: u64,
    }

    struct LiquidityRemoved has copy, drop {
        pool_id: address,
        provider: address,
        amount_a: u64,
        amount_b: u64,
        lp_tokens: u64,
    }

    struct TokenSwap has copy, drop {
        pool_id: address,
        trader: address,
        amount_in: u64,
        amount_out: u64,
        coin_in_type: vector<u8>,
        coin_out_type: vector<u8>,
        fee_amount: u64,
    }

    public fun add_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<LP<T0, T1>> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = 0x2::coin::value<T1>(&arg2);
        assert!(v0 > 0 && v1 > 0, 5);
        let v2 = 0x2::balance::value<T0>(&arg0.coin_a);
        let v3 = 0x2::balance::value<T1>(&arg0.coin_b);
        let v4 = 0x2::balance::supply_value<LP<T0, T1>>(&arg0.lp_supply);
        let v5 = v0 * v3 / v2;
        let (v6, v7) = if (v5 <= v1) {
            (v0, v5)
        } else {
            (v1 * v2 / v3, v1)
        };
        let v8 = 0x2::math::min(v6 * v4 / v2, v7 * v4 / v3);
        assert!(v8 >= arg3, 4);
        0x2::balance::join<T0>(&mut arg0.coin_a, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, v6, arg4)));
        0x2::balance::join<T1>(&mut arg0.coin_b, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg2, v7, arg4)));
        if (0x2::coin::value<T0>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg4));
        } else {
            0x2::coin::destroy_zero<T0>(arg1);
        };
        if (0x2::coin::value<T1>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg2, 0x2::tx_context::sender(arg4));
        } else {
            0x2::coin::destroy_zero<T1>(arg2);
        };
        let v9 = LiquidityAdded{
            pool_id   : 0x2::object::uid_to_address(&arg0.id),
            provider  : 0x2::tx_context::sender(arg4),
            amount_a  : v6,
            amount_b  : v7,
            lp_tokens : v8,
        };
        0x2::event::emit<LiquidityAdded>(v9);
        0x2::coin::from_balance<LP<T0, T1>>(0x2::balance::increase_supply<LP<T0, T1>>(&mut arg0.lp_supply, v8), arg4)
    }

    public fun create_pair<T0, T1>(arg0: &mut PoolRegistry, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: 0x1::option::Option<u64>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<LP<T0, T1>> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = 0x2::coin::value<T1>(&arg2);
        assert!(v0 > 0 && v1 > 0, 5);
        assert!(arg3 == 0x1::option::none<u64>() || *0x1::option::borrow<u64>(&arg3) <= 1000, 2);
        let v2 = if (0x1::option::is_some<u64>(&arg3)) {
            *0x1::option::borrow<u64>(&arg3)
        } else {
            30
        };
        let v3 = LP<T0, T1>{dummy_field: false};
        let v4 = 0x2::math::sqrt(v0) * 0x2::math::sqrt(v1);
        assert!(v4 >= 1000, 0);
        let v5 = Pool<T0, T1>{
            id               : 0x2::object::new(arg5),
            coin_a           : 0x2::coin::into_balance<T0>(arg1),
            coin_b           : 0x2::coin::into_balance<T1>(arg2),
            lp_supply        : 0x2::balance::create_supply<LP<T0, T1>>(v3),
            fee_rate         : v2,
            treasury_address : arg4,
        };
        let v6 = 0x2::object::uid_to_address(&v5.id);
        0x1::vector::push_back<address>(&mut arg0.pools, v6);
        let v7 = PoolCreated{
            pool_id     : v6,
            coin_a_type : b"CoinA",
            coin_b_type : b"CoinB",
            initial_a   : v0,
            initial_b   : v1,
            fee_rate    : v2,
        };
        0x2::event::emit<PoolCreated>(v7);
        0x2::transfer::share_object<Pool<T0, T1>>(v5);
        0x2::coin::from_balance<LP<T0, T1>>(0x2::balance::increase_supply<LP<T0, T1>>(&mut v5.lp_supply, v4), arg5)
    }

    fun get_amount_out(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = if (arg0 > 0) {
            if (arg1 > 0) {
                arg2 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0);
        let v1 = arg0 * (10000 - arg3);
        v1 * arg2 / (arg1 * 10000 + v1)
    }

    public fun get_fee_rate<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.fee_rate
    }

    public fun get_lp_supply<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0x2::balance::supply_value<LP<T0, T1>>(&arg0.lp_supply)
    }

    public fun get_reserves<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.coin_a), 0x2::balance::value<T1>(&arg0.coin_b))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = PoolRegistry{
            id    : 0x2::object::new(arg0),
            pools : 0x1::vector::empty<address>(),
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<PoolRegistry>(v1);
    }

    public fun quote_add_liquidity<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64) : u64 {
        let v0 = 0x2::balance::value<T0>(&arg0.coin_a);
        if (v0 == 0) {
            0
        } else {
            arg1 * 0x2::balance::value<T1>(&arg0.coin_b) / v0
        }
    }

    public fun quote_swap<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64, arg2: bool) : u64 {
        let (v0, v1) = if (arg2) {
            (0x2::balance::value<T0>(&arg0.coin_a), 0x2::balance::value<T1>(&arg0.coin_b))
        } else {
            (0x2::balance::value<T1>(&arg0.coin_b), 0x2::balance::value<T0>(&arg0.coin_a))
        };
        get_amount_out(arg1, v0, v1, arg0.fee_rate)
    }

    public fun remove_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<LP<T0, T1>>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::value<LP<T0, T1>>(&arg1);
        assert!(v0 > 0, 5);
        let v1 = 0x2::balance::supply_value<LP<T0, T1>>(&arg0.lp_supply);
        let v2 = v0 * 0x2::balance::value<T0>(&arg0.coin_a) / v1;
        let v3 = v0 * 0x2::balance::value<T1>(&arg0.coin_b) / v1;
        assert!(v2 >= arg2 && v3 >= arg3, 4);
        0x2::balance::decrease_supply<LP<T0, T1>>(&mut arg0.lp_supply, 0x2::coin::into_balance<LP<T0, T1>>(arg1));
        let v4 = LiquidityRemoved{
            pool_id   : 0x2::object::uid_to_address(&arg0.id),
            provider  : 0x2::tx_context::sender(arg4),
            amount_a  : v2,
            amount_b  : v3,
            lp_tokens : v0,
        };
        0x2::event::emit<LiquidityRemoved>(v4);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.coin_a, v2), arg4), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.coin_b, v3), arg4))
    }

    public fun swap_a_to_b<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 5);
        let v1 = v0 * arg0.fee_rate / 10000;
        let v2 = v1 * 5 / arg0.fee_rate;
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, v2, arg3), arg0.treasury_address);
        };
        let v3 = get_amount_out(v0 - v2, 0x2::balance::value<T0>(&arg0.coin_a), 0x2::balance::value<T1>(&arg0.coin_b), arg0.fee_rate);
        assert!(v3 >= arg2, 4);
        0x2::balance::join<T0>(&mut arg0.coin_a, 0x2::coin::into_balance<T0>(arg1));
        let v4 = TokenSwap{
            pool_id       : 0x2::object::uid_to_address(&arg0.id),
            trader        : 0x2::tx_context::sender(arg3),
            amount_in     : v0,
            amount_out    : v3,
            coin_in_type  : b"CoinA",
            coin_out_type : b"CoinB",
            fee_amount    : v1,
        };
        0x2::event::emit<TokenSwap>(v4);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.coin_b, v3), arg3)
    }

    public fun swap_b_to_a<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 > 0, 5);
        let v1 = v0 * arg0.fee_rate / 10000;
        let v2 = v1 * 5 / arg0.fee_rate;
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg1, v2, arg3), arg0.treasury_address);
        };
        let v3 = get_amount_out(v0 - v2, 0x2::balance::value<T1>(&arg0.coin_b), 0x2::balance::value<T0>(&arg0.coin_a), arg0.fee_rate);
        assert!(v3 >= arg2, 4);
        0x2::balance::join<T1>(&mut arg0.coin_b, 0x2::coin::into_balance<T1>(arg1));
        let v4 = TokenSwap{
            pool_id       : 0x2::object::uid_to_address(&arg0.id),
            trader        : 0x2::tx_context::sender(arg3),
            amount_in     : v0,
            amount_out    : v3,
            coin_in_type  : b"CoinB",
            coin_out_type : b"CoinA",
            fee_amount    : v1,
        };
        0x2::event::emit<TokenSwap>(v4);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.coin_a, v3), arg3)
    }

    public fun update_fee_rate<T0, T1>(arg0: &AdminCap, arg1: &mut Pool<T0, T1>, arg2: u64) {
        assert!(arg2 <= 1000, 2);
        arg1.fee_rate = arg2;
    }

    // decompiled from Move bytecode v6
}

