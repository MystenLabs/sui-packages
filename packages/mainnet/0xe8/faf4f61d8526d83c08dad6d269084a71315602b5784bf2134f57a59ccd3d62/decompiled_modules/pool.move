module 0xe8faf4f61d8526d83c08dad6d269084a71315602b5784bf2134f57a59ccd3d62::pool {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        reserve_a: 0x2::balance::Balance<T0>,
        reserve_b: 0x2::balance::Balance<T1>,
        lp_supply: 0x2::balance::Supply<0xe8faf4f61d8526d83c08dad6d269084a71315602b5784bf2134f57a59ccd3d62::lp_coin::LP<T0, T1>>,
        locked_lp: 0x2::balance::Balance<0xe8faf4f61d8526d83c08dad6d269084a71315602b5784bf2134f57a59ccd3d62::lp_coin::LP<T0, T1>>,
        fee_collector: address,
        lp_fee_numerator: u64,
        project_fee_numerator: u64,
        fee_denominator: u64,
        add_liquidity_fee: u64,
        remove_liquidity_fee: u64,
        burn_lock_fee: u64,
        is_paused: bool,
        total_volume_a: u128,
        total_volume_b: u128,
        total_lp_fees_a: u128,
        total_lp_fees_b: u128,
        total_project_fees: u64,
        total_swaps: u64,
        created_at: u64,
        last_update_time: u64,
        price_cumulative_a: u128,
        price_cumulative_b: u128,
    }

    struct PoolCreated has copy, drop {
        pool_id: address,
        creator: address,
        initial_reserve_a: u64,
        initial_reserve_b: u64,
        initial_lp: u64,
        lp_fee_bps: u64,
        project_fee_bps: u64,
    }

    struct LiquidityAdded has copy, drop {
        pool_id: address,
        provider: address,
        amount_a: u64,
        amount_b: u64,
        lp_minted: u64,
        total_supply: u64,
        share_percent: u64,
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
        lp_fee: u64,
        project_fee: u64,
        is_a_to_b: bool,
        reserve_a_after: u64,
        reserve_b_after: u64,
        price_impact_bps: u64,
    }

    struct LiquidityBurnedLocked has copy, drop {
        pool_id: address,
        burner: address,
        lp_burned: u64,
        locked_value_a: u64,
        locked_value_b: u64,
        remaining_supply: u64,
        timestamp: u64,
    }

    struct PoolConfigUpdated has copy, drop {
        pool_id: address,
        lp_fee_bps: u64,
        project_fee_bps: u64,
        updated_by: address,
    }

    struct PoolPauseToggled has copy, drop {
        pool_id: address,
        is_paused: bool,
        timestamp: u64,
    }

    struct Sync has copy, drop {
        pool_id: address,
        reserve_a: u64,
        reserve_b: u64,
        lp_supply: u64,
    }

    public fun add_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<0xe8faf4f61d8526d83c08dad6d269084a71315602b5784bf2134f57a59ccd3d62::lp_coin::LP<T0, T1>>) {
        assert!(!arg0.is_paused, 10);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= arg0.add_liquidity_fee, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, arg0.fee_collector);
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = 0x2::coin::value<T1>(&arg2);
        assert!(v0 > 0 && v1 > 0, 7);
        let v2 = 0x2::balance::value<T0>(&arg0.reserve_a);
        let v3 = 0x2::balance::value<T1>(&arg0.reserve_b);
        let v4 = 0x2::balance::supply_value<0xe8faf4f61d8526d83c08dad6d269084a71315602b5784bf2134f57a59ccd3d62::lp_coin::LP<T0, T1>>(&arg0.lp_supply);
        assert!(v2 > 0 && v3 > 0, 0);
        let v5 = quote(v0, v2, v3);
        let (v6, v7) = if (v5 <= v1) {
            (v0, v5)
        } else {
            let v8 = quote(v1, v3, v2);
            assert!(v8 <= v0, 1);
            (v8, v1)
        };
        let v9 = (min_u128((v6 as u128) * (v4 as u128) / (v2 as u128), (v7 as u128) * (v4 as u128) / (v3 as u128)) as u64);
        assert!(v9 > 0, 0);
        assert!(v9 >= arg4, 2);
        0x2::balance::join<T0>(&mut arg0.reserve_a, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, v6, arg5)));
        0x2::balance::join<T1>(&mut arg0.reserve_b, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg2, v7, arg5)));
        let v10 = 0x2::balance::supply_value<0xe8faf4f61d8526d83c08dad6d269084a71315602b5784bf2134f57a59ccd3d62::lp_coin::LP<T0, T1>>(&arg0.lp_supply);
        let v11 = LiquidityAdded{
            pool_id       : 0x2::object::id_address<Pool<T0, T1>>(arg0),
            provider      : 0x2::tx_context::sender(arg5),
            amount_a      : v6,
            amount_b      : v7,
            lp_minted     : v9,
            total_supply  : v10,
            share_percent : (((v9 as u128) * 10000 / (v10 as u128)) as u64),
        };
        0x2::event::emit<LiquidityAdded>(v11);
        emit_sync<T0, T1>(arg0);
        (arg1, arg2, 0x2::coin::from_balance<0xe8faf4f61d8526d83c08dad6d269084a71315602b5784bf2134f57a59ccd3d62::lp_coin::LP<T0, T1>>(0x2::balance::increase_supply<0xe8faf4f61d8526d83c08dad6d269084a71315602b5784bf2134f57a59ccd3d62::lp_coin::LP<T0, T1>>(&mut arg0.lp_supply, v9), arg5))
    }

    public fun burn_liquidity_lock<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<0xe8faf4f61d8526d83c08dad6d269084a71315602b5784bf2134f57a59ccd3d62::lp_coin::LP<T0, T1>>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= arg0.burn_lock_fee, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, arg0.fee_collector);
        let v0 = 0x2::coin::value<0xe8faf4f61d8526d83c08dad6d269084a71315602b5784bf2134f57a59ccd3d62::lp_coin::LP<T0, T1>>(&arg1);
        assert!(v0 > 0, 7);
        let (v1, v2, v3) = get_amounts<T0, T1>(arg0);
        0x2::balance::decrease_supply<0xe8faf4f61d8526d83c08dad6d269084a71315602b5784bf2134f57a59ccd3d62::lp_coin::LP<T0, T1>>(&mut arg0.lp_supply, 0x2::coin::into_balance<0xe8faf4f61d8526d83c08dad6d269084a71315602b5784bf2134f57a59ccd3d62::lp_coin::LP<T0, T1>>(arg1));
        let v4 = LiquidityBurnedLocked{
            pool_id          : 0x2::object::id_address<Pool<T0, T1>>(arg0),
            burner           : 0x2::tx_context::sender(arg4),
            lp_burned        : v0,
            locked_value_a   : (((v0 as u128) * (v1 as u128) / (v3 as u128)) as u64),
            locked_value_b   : (((v0 as u128) * (v2 as u128) / (v3 as u128)) as u64),
            remaining_supply : 0x2::balance::supply_value<0xe8faf4f61d8526d83c08dad6d269084a71315602b5784bf2134f57a59ccd3d62::lp_coin::LP<T0, T1>>(&arg0.lp_supply),
            timestamp        : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<LiquidityBurnedLocked>(v4);
    }

    fun calculate_price_impact(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = (arg3 as u128) * 1000000000000 / (arg2 as u128);
        let v1 = (arg1 as u128) * 1000000000000 / (arg0 as u128);
        if (v0 > v1) {
            (((v0 - v1) * 10000 / v0) as u64)
        } else {
            0
        }
    }

    public fun create_pool<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (Pool<T0, T1>, 0x2::coin::Coin<0xe8faf4f61d8526d83c08dad6d269084a71315602b5784bf2134f57a59ccd3d62::lp_coin::LP<T0, T1>>) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 > 0 && v1 > 0, 1);
        let v2 = sqrt_u128((v0 as u128) * (v1 as u128));
        assert!(v2 >= 1000 * 10, 0);
        let v3 = 0x2::balance::create_supply<0xe8faf4f61d8526d83c08dad6d269084a71315602b5784bf2134f57a59ccd3d62::lp_coin::LP<T0, T1>>(0xe8faf4f61d8526d83c08dad6d269084a71315602b5784bf2134f57a59ccd3d62::lp_coin::create_witness<T0, T1>());
        let v4 = 0x2::balance::increase_supply<0xe8faf4f61d8526d83c08dad6d269084a71315602b5784bf2134f57a59ccd3d62::lp_coin::LP<T0, T1>>(&mut v3, v2);
        let v5 = 0x2::clock::timestamp_ms(arg3);
        let v6 = Pool<T0, T1>{
            id                    : 0x2::object::new(arg4),
            reserve_a             : 0x2::coin::into_balance<T0>(arg0),
            reserve_b             : 0x2::coin::into_balance<T1>(arg1),
            lp_supply             : v3,
            locked_lp             : 0x2::balance::split<0xe8faf4f61d8526d83c08dad6d269084a71315602b5784bf2134f57a59ccd3d62::lp_coin::LP<T0, T1>>(&mut v4, 1000),
            fee_collector         : arg2,
            lp_fee_numerator      : 100,
            project_fee_numerator : 50,
            fee_denominator       : 10000,
            add_liquidity_fee     : 2000000000,
            remove_liquidity_fee  : 2000000000,
            burn_lock_fee         : 3000000000,
            is_paused             : false,
            total_volume_a        : 0,
            total_volume_b        : 0,
            total_lp_fees_a       : 0,
            total_lp_fees_b       : 0,
            total_project_fees    : 0,
            total_swaps           : 0,
            created_at            : v5,
            last_update_time      : v5,
            price_cumulative_a    : 0,
            price_cumulative_b    : 0,
        };
        let v7 = PoolCreated{
            pool_id           : 0x2::object::id_address<Pool<T0, T1>>(&v6),
            creator           : 0x2::tx_context::sender(arg4),
            initial_reserve_a : v0,
            initial_reserve_b : v1,
            initial_lp        : v2 - 1000,
            lp_fee_bps        : 100,
            project_fee_bps   : 50,
        };
        0x2::event::emit<PoolCreated>(v7);
        (v6, 0x2::coin::from_balance<0xe8faf4f61d8526d83c08dad6d269084a71315602b5784bf2134f57a59ccd3d62::lp_coin::LP<T0, T1>>(v4, arg4))
    }

    fun emit_sync<T0, T1>(arg0: &Pool<T0, T1>) {
        let v0 = Sync{
            pool_id   : 0x2::object::id_address<Pool<T0, T1>>(arg0),
            reserve_a : 0x2::balance::value<T0>(&arg0.reserve_a),
            reserve_b : 0x2::balance::value<T1>(&arg0.reserve_b),
            lp_supply : 0x2::balance::supply_value<0xe8faf4f61d8526d83c08dad6d269084a71315602b5784bf2134f57a59ccd3d62::lp_coin::LP<T0, T1>>(&arg0.lp_supply),
        };
        0x2::event::emit<Sync>(v0);
    }

    public fun get_add_liquidity_amounts<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64, arg2: u64) : (u64, u64, u64) {
        assert!(arg1 > 0 && arg2 > 0, 1);
        let (v0, v1, v2) = get_amounts<T0, T1>(arg0);
        let v3 = if (v0 > 0) {
            if (v1 > 0) {
                v2 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v3, 0);
        let v4 = quote(arg1, v0, v1);
        let (v5, v6) = if (v4 <= arg2) {
            (arg1, v4)
        } else {
            (quote(arg2, v1, v0), arg2)
        };
        (v5, v6, (min_u128((v5 as u128) * (v2 as u128) / (v0 as u128), (v6 as u128) * (v2 as u128) / (v1 as u128)) as u64))
    }

    public fun get_add_liquidity_fee<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.add_liquidity_fee
    }

    fun get_amount_out(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        assert!(arg0 > 0, 3);
        assert!(arg1 > 0 && arg2 > 0, 0);
        let v0 = (arg4 as u256);
        let v1 = (arg0 as u256) * (v0 - (arg3 as u256));
        ((v1 * (arg2 as u256) / ((arg1 as u256) * v0 + v1)) as u64)
    }

    public fun get_amount_out_a_to_b<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64) : u64 {
        let (v0, v1, _) = get_amounts<T0, T1>(arg0);
        get_amount_out(arg1, v0, v1, arg0.lp_fee_numerator + arg0.project_fee_numerator, arg0.fee_denominator)
    }

    public fun get_amount_out_b_to_a<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64) : u64 {
        let (v0, v1, _) = get_amounts<T0, T1>(arg0);
        get_amount_out(arg1, v1, v0, arg0.lp_fee_numerator + arg0.project_fee_numerator, arg0.fee_denominator)
    }

    public fun get_amounts<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64, u64) {
        (0x2::balance::value<T0>(&arg0.reserve_a), 0x2::balance::value<T1>(&arg0.reserve_b), 0x2::balance::supply_value<0xe8faf4f61d8526d83c08dad6d269084a71315602b5784bf2134f57a59ccd3d62::lp_coin::LP<T0, T1>>(&arg0.lp_supply))
    }

    public fun get_burn_lock_fee<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.burn_lock_fee
    }

    public fun get_lp_rewards<T0, T1>(arg0: &Pool<T0, T1>) : (u128, u128) {
        (arg0.total_lp_fees_a, arg0.total_lp_fees_b)
    }

    public fun get_pool_stats<T0, T1>(arg0: &Pool<T0, T1>) : (u128, u128, u64, u64) {
        (arg0.total_volume_a, arg0.total_volume_b, arg0.total_project_fees, arg0.total_swaps)
    }

    public fun get_remove_liquidity_fee<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.remove_liquidity_fee
    }

    public fun get_reserves<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.reserve_a), 0x2::balance::value<T1>(&arg0.reserve_b))
    }

    public fun get_swap_fees<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64, u64) {
        (arg0.lp_fee_numerator, arg0.project_fee_numerator, arg0.fee_denominator)
    }

    public fun get_total_swap_fee_bps<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.lp_fee_numerator + arg0.project_fee_numerator
    }

    public fun get_twap_data<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64, u128, u128) {
        (arg0.created_at, arg0.last_update_time, arg0.price_cumulative_a, arg0.price_cumulative_b)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_paused<T0, T1>(arg0: &Pool<T0, T1>) : bool {
        arg0.is_paused
    }

    fun min_u128(arg0: u128, arg1: u128) : u128 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    fun quote(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg0 > 0, 1);
        assert!(arg1 > 0 && arg2 > 0, 0);
        (((arg0 as u256) * (arg2 as u256) / (arg1 as u256)) as u64)
    }

    public fun remove_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<0xe8faf4f61d8526d83c08dad6d269084a71315602b5784bf2134f57a59ccd3d62::lp_coin::LP<T0, T1>>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= arg0.remove_liquidity_fee, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, arg0.fee_collector);
        let v0 = 0x2::coin::value<0xe8faf4f61d8526d83c08dad6d269084a71315602b5784bf2134f57a59ccd3d62::lp_coin::LP<T0, T1>>(&arg1);
        assert!(v0 > 0, 7);
        let v1 = 0x2::balance::supply_value<0xe8faf4f61d8526d83c08dad6d269084a71315602b5784bf2134f57a59ccd3d62::lp_coin::LP<T0, T1>>(&arg0.lp_supply);
        assert!(v1 > 0, 0);
        assert!(v0 <= v1, 1);
        let v2 = (((v0 as u128) * (0x2::balance::value<T0>(&arg0.reserve_a) as u128) / (v1 as u128)) as u64);
        let v3 = (((v0 as u128) * (0x2::balance::value<T1>(&arg0.reserve_b) as u128) / (v1 as u128)) as u64);
        assert!(v2 >= arg3 && v3 >= arg4, 2);
        0x2::balance::decrease_supply<0xe8faf4f61d8526d83c08dad6d269084a71315602b5784bf2134f57a59ccd3d62::lp_coin::LP<T0, T1>>(&mut arg0.lp_supply, 0x2::coin::into_balance<0xe8faf4f61d8526d83c08dad6d269084a71315602b5784bf2134f57a59ccd3d62::lp_coin::LP<T0, T1>>(arg1));
        let v4 = LiquidityRemoved{
            pool_id      : 0x2::object::id_address<Pool<T0, T1>>(arg0),
            provider     : 0x2::tx_context::sender(arg5),
            lp_burned    : v0,
            amount_a     : v2,
            amount_b     : v3,
            total_supply : 0x2::balance::supply_value<0xe8faf4f61d8526d83c08dad6d269084a71315602b5784bf2134f57a59ccd3d62::lp_coin::LP<T0, T1>>(&arg0.lp_supply),
        };
        0x2::event::emit<LiquidityRemoved>(v4);
        emit_sync<T0, T1>(arg0);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reserve_a, v2), arg5), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.reserve_b, v3), arg5))
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

    public fun swap_a_for_b<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(!arg0.is_paused, 10);
        assert!(0x2::clock::timestamp_ms(arg3) <= arg4, 8);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 3);
        let v1 = 0x2::balance::value<T0>(&arg0.reserve_a);
        let v2 = 0x2::balance::value<T1>(&arg0.reserve_b);
        update_twap<T0, T1>(arg0, arg3);
        let v3 = (((v0 as u128) * (arg0.lp_fee_numerator as u128) / (arg0.fee_denominator as u128)) as u64);
        let v4 = (((v0 as u128) * (arg0.project_fee_numerator as u128) / (arg0.fee_denominator as u128)) as u64);
        let v5 = get_amount_out(v0, v1, v2, arg0.lp_fee_numerator + arg0.project_fee_numerator, arg0.fee_denominator);
        assert!(v5 >= arg2, 2);
        assert!(v5 < v2, 0);
        let v6 = 0x2::coin::into_balance<T0>(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v6, v4), arg5), arg0.fee_collector);
        0x2::balance::join<T0>(&mut arg0.reserve_a, v6);
        let v7 = 0x2::balance::value<T0>(&arg0.reserve_a);
        let v8 = 0x2::balance::value<T1>(&arg0.reserve_b);
        assert!((v7 as u256) * (v8 as u256) >= (v1 as u256) * (v2 as u256), 11);
        arg0.total_volume_a = arg0.total_volume_a + (v0 as u128);
        arg0.total_lp_fees_a = arg0.total_lp_fees_a + (v3 as u128);
        arg0.total_project_fees = arg0.total_project_fees + v4;
        arg0.total_swaps = arg0.total_swaps + 1;
        let v9 = Swapped{
            pool_id          : 0x2::object::id_address<Pool<T0, T1>>(arg0),
            trader           : 0x2::tx_context::sender(arg5),
            amount_in        : v0,
            amount_out       : v5,
            lp_fee           : v3,
            project_fee      : v4,
            is_a_to_b        : true,
            reserve_a_after  : v7,
            reserve_b_after  : v8,
            price_impact_bps : calculate_price_impact(v0, v5, v1, v2),
        };
        0x2::event::emit<Swapped>(v9);
        emit_sync<T0, T1>(arg0);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.reserve_b, v5), arg5)
    }

    public fun swap_b_for_a<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(!arg0.is_paused, 10);
        assert!(0x2::clock::timestamp_ms(arg3) <= arg4, 8);
        let v0 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 > 0, 3);
        let v1 = 0x2::balance::value<T0>(&arg0.reserve_a);
        let v2 = 0x2::balance::value<T1>(&arg0.reserve_b);
        update_twap<T0, T1>(arg0, arg3);
        let v3 = (((v0 as u128) * (arg0.lp_fee_numerator as u128) / (arg0.fee_denominator as u128)) as u64);
        let v4 = (((v0 as u128) * (arg0.project_fee_numerator as u128) / (arg0.fee_denominator as u128)) as u64);
        let v5 = get_amount_out(v0, v2, v1, arg0.lp_fee_numerator + arg0.project_fee_numerator, arg0.fee_denominator);
        assert!(v5 >= arg2, 2);
        assert!(v5 < v1, 0);
        let v6 = 0x2::coin::into_balance<T1>(arg1);
        0x2::balance::join<T1>(&mut arg0.reserve_b, 0x2::balance::split<T1>(&mut v6, v4));
        0x2::balance::join<T1>(&mut arg0.reserve_b, v6);
        let v7 = 0x2::balance::value<T0>(&arg0.reserve_a);
        let v8 = 0x2::balance::value<T1>(&arg0.reserve_b);
        assert!((v7 as u256) * (v8 as u256) >= (v1 as u256) * (v2 as u256), 11);
        arg0.total_volume_b = arg0.total_volume_b + (v0 as u128);
        arg0.total_lp_fees_b = arg0.total_lp_fees_b + (v3 as u128);
        arg0.total_project_fees = arg0.total_project_fees + v4;
        arg0.total_swaps = arg0.total_swaps + 1;
        let v9 = Swapped{
            pool_id          : 0x2::object::id_address<Pool<T0, T1>>(arg0),
            trader           : 0x2::tx_context::sender(arg5),
            amount_in        : v0,
            amount_out       : v5,
            lp_fee           : v3,
            project_fee      : v4,
            is_a_to_b        : false,
            reserve_a_after  : v7,
            reserve_b_after  : v8,
            price_impact_bps : calculate_price_impact(v0, v5, v2, v1),
        };
        0x2::event::emit<Swapped>(v9);
        emit_sync<T0, T1>(arg0);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reserve_a, v5), arg5)
    }

    public entry fun toggle_pause<T0, T1>(arg0: &AdminCap, arg1: &mut Pool<T0, T1>, arg2: &0x2::clock::Clock) {
        arg1.is_paused = !arg1.is_paused;
        let v0 = PoolPauseToggled{
            pool_id   : 0x2::object::id_address<Pool<T0, T1>>(arg1),
            is_paused : arg1.is_paused,
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<PoolPauseToggled>(v0);
    }

    public entry fun update_fee_collector<T0, T1>(arg0: &AdminCap, arg1: &mut Pool<T0, T1>, arg2: address) {
        arg1.fee_collector = arg2;
    }

    public entry fun update_platform_fees<T0, T1>(arg0: &AdminCap, arg1: &mut Pool<T0, T1>, arg2: u64, arg3: u64, arg4: u64) {
        arg1.add_liquidity_fee = arg2;
        arg1.remove_liquidity_fee = arg3;
        arg1.burn_lock_fee = arg4;
    }

    public entry fun update_pool_fees<T0, T1>(arg0: &AdminCap, arg1: &mut Pool<T0, T1>, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert!(arg2 + arg3 <= 300, 13);
        arg1.lp_fee_numerator = arg2;
        arg1.project_fee_numerator = arg3;
        let v0 = PoolConfigUpdated{
            pool_id         : 0x2::object::id_address<Pool<T0, T1>>(arg1),
            lp_fee_bps      : arg2,
            project_fee_bps : arg3,
            updated_by      : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<PoolConfigUpdated>(v0);
    }

    fun update_twap<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = v0 - arg0.last_update_time;
        if (v1 > 0) {
            let v2 = 0x2::balance::value<T0>(&arg0.reserve_a);
            let v3 = 0x2::balance::value<T1>(&arg0.reserve_b);
            if (v2 > 0 && v3 > 0) {
                arg0.price_cumulative_a = arg0.price_cumulative_a + (v3 as u128) * 1000000000000 / (v2 as u128) * (v1 as u128);
                arg0.price_cumulative_b = arg0.price_cumulative_b + (v2 as u128) * 1000000000000 / (v3 as u128) * (v1 as u128);
            };
            arg0.last_update_time = v0;
        };
    }

    // decompiled from Move bytecode v6
}

