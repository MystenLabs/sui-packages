module 0xd7aabe644acc2ef74377f7a0113189691dc7d031074bd4ec01af1023dc4c0686::pool {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        reserve_a: 0x2::balance::Balance<T0>,
        reserve_b: 0x2::balance::Balance<T1>,
        lp_supply: 0x2::balance::Supply<0xd7aabe644acc2ef74377f7a0113189691dc7d031074bd4ec01af1023dc4c0686::lp_coin::LP<T0, T1>>,
        locked_lp: 0x2::balance::Balance<0xd7aabe644acc2ef74377f7a0113189691dc7d031074bd4ec01af1023dc4c0686::lp_coin::LP<T0, T1>>,
        fee_collector: address,
        lp_fee: u64,
        project_fee: u64,
        add_liquidity_fee: u64,
        remove_liquidity_fee: u64,
        burn_lock_fee: u64,
        referral_percent: u64,
        is_paused: bool,
        created_at: u64,
        total_volume_a: u128,
        total_volume_b: u128,
        total_fees_earned_a: u128,
        total_fees_earned_b: u128,
        total_swaps: u64,
        volume_24h_a: u64,
        volume_24h_b: u64,
        last_24h_reset: u64,
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
        share_percent_bps: u64,
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
        referrer: 0x1::option::Option<address>,
        referral_reward: u64,
        is_a_to_b: bool,
        reserve_a_after: u64,
        reserve_b_after: u64,
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
        lp_fee: u64,
        project_fee: u64,
        referral_percent: u64,
    }

    struct Sync has copy, drop {
        pool_id: address,
        reserve_a: u64,
        reserve_b: u64,
        lp_supply: u64,
    }

    public fun add_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<0xd7aabe644acc2ef74377f7a0113189691dc7d031074bd4ec01af1023dc4c0686::lp_coin::LP<T0, T1>>) {
        assert!(!arg0.is_paused, 10);
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = 0x2::coin::value<T1>(&arg2);
        assert!(v0 > 0 && v1 > 0, 7);
        let v2 = 0x2::balance::value<T0>(&arg0.reserve_a);
        let v3 = 0x2::balance::value<T1>(&arg0.reserve_b);
        let v4 = 0x2::balance::supply_value<0xd7aabe644acc2ef74377f7a0113189691dc7d031074bd4ec01af1023dc4c0686::lp_coin::LP<T0, T1>>(&arg0.lp_supply);
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
        assert!(v9 >= arg3, 2);
        0x2::balance::join<T0>(&mut arg0.reserve_a, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, v6, arg4)));
        0x2::balance::join<T1>(&mut arg0.reserve_b, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg2, v7, arg4)));
        let v10 = 0x2::balance::supply_value<0xd7aabe644acc2ef74377f7a0113189691dc7d031074bd4ec01af1023dc4c0686::lp_coin::LP<T0, T1>>(&arg0.lp_supply);
        let v11 = LiquidityAdded{
            pool_id           : 0x2::object::id_address<Pool<T0, T1>>(arg0),
            provider          : 0x2::tx_context::sender(arg4),
            amount_a          : v6,
            amount_b          : v7,
            lp_minted         : v9,
            total_supply      : v10,
            share_percent_bps : (((v9 as u128) * 10000 / (v10 as u128)) as u64),
        };
        0x2::event::emit<LiquidityAdded>(v11);
        emit_sync<T0, T1>(arg0);
        (arg1, arg2, 0x2::coin::from_balance<0xd7aabe644acc2ef74377f7a0113189691dc7d031074bd4ec01af1023dc4c0686::lp_coin::LP<T0, T1>>(0x2::balance::increase_supply<0xd7aabe644acc2ef74377f7a0113189691dc7d031074bd4ec01af1023dc4c0686::lp_coin::LP<T0, T1>>(&mut arg0.lp_supply, v9), arg4))
    }

    public fun burn_liquidity_lock<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<0xd7aabe644acc2ef74377f7a0113189691dc7d031074bd4ec01af1023dc4c0686::lp_coin::LP<T0, T1>>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= arg0.burn_lock_fee, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, arg0.fee_collector);
        let v0 = 0x2::coin::value<0xd7aabe644acc2ef74377f7a0113189691dc7d031074bd4ec01af1023dc4c0686::lp_coin::LP<T0, T1>>(&arg1);
        assert!(v0 > 0, 7);
        let (v1, v2, v3) = get_amounts<T0, T1>(arg0);
        0x2::balance::decrease_supply<0xd7aabe644acc2ef74377f7a0113189691dc7d031074bd4ec01af1023dc4c0686::lp_coin::LP<T0, T1>>(&mut arg0.lp_supply, 0x2::coin::into_balance<0xd7aabe644acc2ef74377f7a0113189691dc7d031074bd4ec01af1023dc4c0686::lp_coin::LP<T0, T1>>(arg1));
        let v4 = LiquidityBurnedLocked{
            pool_id          : 0x2::object::id_address<Pool<T0, T1>>(arg0),
            burner           : 0x2::tx_context::sender(arg4),
            lp_burned        : v0,
            locked_value_a   : (((v0 as u128) * (v1 as u128) / (v3 as u128)) as u64),
            locked_value_b   : (((v0 as u128) * (v2 as u128) / (v3 as u128)) as u64),
            remaining_supply : 0x2::balance::supply_value<0xd7aabe644acc2ef74377f7a0113189691dc7d031074bd4ec01af1023dc4c0686::lp_coin::LP<T0, T1>>(&arg0.lp_supply),
            timestamp        : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<LiquidityBurnedLocked>(v4);
    }

    public fun create_pool<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (Pool<T0, T1>, 0x2::coin::Coin<0xd7aabe644acc2ef74377f7a0113189691dc7d031074bd4ec01af1023dc4c0686::lp_coin::LP<T0, T1>>) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 > 0 && v1 > 0, 1);
        let v2 = sqrt_u128((v0 as u128) * (v1 as u128));
        assert!(v2 >= 1000 * 10, 0);
        let v3 = 0x2::balance::create_supply<0xd7aabe644acc2ef74377f7a0113189691dc7d031074bd4ec01af1023dc4c0686::lp_coin::LP<T0, T1>>(0xd7aabe644acc2ef74377f7a0113189691dc7d031074bd4ec01af1023dc4c0686::lp_coin::create_witness<T0, T1>());
        let v4 = 0x2::balance::increase_supply<0xd7aabe644acc2ef74377f7a0113189691dc7d031074bd4ec01af1023dc4c0686::lp_coin::LP<T0, T1>>(&mut v3, v2);
        let v5 = 0x2::clock::timestamp_ms(arg3);
        let v6 = Pool<T0, T1>{
            id                   : 0x2::object::new(arg4),
            reserve_a            : 0x2::coin::into_balance<T0>(arg0),
            reserve_b            : 0x2::coin::into_balance<T1>(arg1),
            lp_supply            : v3,
            locked_lp            : 0x2::balance::split<0xd7aabe644acc2ef74377f7a0113189691dc7d031074bd4ec01af1023dc4c0686::lp_coin::LP<T0, T1>>(&mut v4, 1000),
            fee_collector        : arg2,
            lp_fee               : 100,
            project_fee          : 50,
            add_liquidity_fee    : 0,
            remove_liquidity_fee : 0,
            burn_lock_fee        : 1000000000,
            referral_percent     : 20,
            is_paused            : false,
            created_at           : v5,
            total_volume_a       : 0,
            total_volume_b       : 0,
            total_fees_earned_a  : 0,
            total_fees_earned_b  : 0,
            total_swaps          : 0,
            volume_24h_a         : 0,
            volume_24h_b         : 0,
            last_24h_reset       : v5,
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
        (v6, 0x2::coin::from_balance<0xd7aabe644acc2ef74377f7a0113189691dc7d031074bd4ec01af1023dc4c0686::lp_coin::LP<T0, T1>>(v4, arg4))
    }

    fun emit_sync<T0, T1>(arg0: &Pool<T0, T1>) {
        let v0 = Sync{
            pool_id   : 0x2::object::id_address<Pool<T0, T1>>(arg0),
            reserve_a : 0x2::balance::value<T0>(&arg0.reserve_a),
            reserve_b : 0x2::balance::value<T1>(&arg0.reserve_b),
            lp_supply : 0x2::balance::supply_value<0xd7aabe644acc2ef74377f7a0113189691dc7d031074bd4ec01af1023dc4c0686::lp_coin::LP<T0, T1>>(&arg0.lp_supply),
        };
        0x2::event::emit<Sync>(v0);
    }

    fun get_amount_out(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        assert!(arg0 > 0, 3);
        assert!(arg1 > 0 && arg2 > 0, 0);
        let v0 = (10000 as u256);
        let v1 = (arg0 as u256) * (v0 - (arg3 as u256));
        ((v1 * (arg2 as u256) / ((arg1 as u256) * v0 + v1)) as u64)
    }

    public fun get_amount_out_a_to_b<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64) : u64 {
        let (v0, v1, _) = get_amounts<T0, T1>(arg0);
        get_amount_out(arg1, v0, v1, arg0.lp_fee + arg0.project_fee)
    }

    public fun get_amount_out_b_to_a<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64) : u64 {
        let (v0, v1, _) = get_amounts<T0, T1>(arg0);
        get_amount_out(arg1, v1, v0, arg0.lp_fee + arg0.project_fee)
    }

    public fun get_amounts<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64, u64) {
        (0x2::balance::value<T0>(&arg0.reserve_a), 0x2::balance::value<T1>(&arg0.reserve_b), 0x2::balance::supply_value<0xd7aabe644acc2ef74377f7a0113189691dc7d031074bd4ec01af1023dc4c0686::lp_coin::LP<T0, T1>>(&arg0.lp_supply))
    }

    public fun get_created_at<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.created_at
    }

    public fun get_fees<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64, u64) {
        (arg0.lp_fee, arg0.project_fee, arg0.referral_percent)
    }

    public fun get_pool_stats<T0, T1>(arg0: &Pool<T0, T1>) : (u128, u128, u128, u128, u64) {
        (arg0.total_volume_a, arg0.total_volume_b, arg0.total_fees_earned_a, arg0.total_fees_earned_b, arg0.total_swaps)
    }

    public fun get_reserves<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.reserve_a), 0x2::balance::value<T1>(&arg0.reserve_b))
    }

    public fun get_volume_24h<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        (arg0.volume_24h_a, arg0.volume_24h_b)
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

    public fun remove_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<0xd7aabe644acc2ef74377f7a0113189691dc7d031074bd4ec01af1023dc4c0686::lp_coin::LP<T0, T1>>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::value<0xd7aabe644acc2ef74377f7a0113189691dc7d031074bd4ec01af1023dc4c0686::lp_coin::LP<T0, T1>>(&arg1);
        assert!(v0 > 0, 7);
        let v1 = 0x2::balance::supply_value<0xd7aabe644acc2ef74377f7a0113189691dc7d031074bd4ec01af1023dc4c0686::lp_coin::LP<T0, T1>>(&arg0.lp_supply);
        assert!(v1 > 0, 0);
        assert!(v0 <= v1, 1);
        let v2 = (((v0 as u128) * (0x2::balance::value<T0>(&arg0.reserve_a) as u128) / (v1 as u128)) as u64);
        let v3 = (((v0 as u128) * (0x2::balance::value<T1>(&arg0.reserve_b) as u128) / (v1 as u128)) as u64);
        assert!(v2 >= arg2 && v3 >= arg3, 2);
        0x2::balance::decrease_supply<0xd7aabe644acc2ef74377f7a0113189691dc7d031074bd4ec01af1023dc4c0686::lp_coin::LP<T0, T1>>(&mut arg0.lp_supply, 0x2::coin::into_balance<0xd7aabe644acc2ef74377f7a0113189691dc7d031074bd4ec01af1023dc4c0686::lp_coin::LP<T0, T1>>(arg1));
        let v4 = LiquidityRemoved{
            pool_id      : 0x2::object::id_address<Pool<T0, T1>>(arg0),
            provider     : 0x2::tx_context::sender(arg4),
            lp_burned    : v0,
            amount_a     : v2,
            amount_b     : v3,
            total_supply : 0x2::balance::supply_value<0xd7aabe644acc2ef74377f7a0113189691dc7d031074bd4ec01af1023dc4c0686::lp_coin::LP<T0, T1>>(&arg0.lp_supply),
        };
        0x2::event::emit<LiquidityRemoved>(v4);
        emit_sync<T0, T1>(arg0);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reserve_a, v2), arg4), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.reserve_b, v3), arg4))
    }

    public entry fun reset_24h_volume<T0, T1>(arg0: &AdminCap, arg1: &mut Pool<T0, T1>, arg2: &0x2::clock::Clock) {
        arg1.volume_24h_a = 0;
        arg1.volume_24h_b = 0;
        arg1.last_24h_reset = 0x2::clock::timestamp_ms(arg2);
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
        swap_a_for_b_internal<T0, T1>(arg0, arg1, arg2, 0x1::option::none<address>(), arg3, arg4, arg5)
    }

    fun swap_a_for_b_internal<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: 0x1::option::Option<address>, arg4: &0x2::clock::Clock, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(!arg0.is_paused, 10);
        assert!(0x2::clock::timestamp_ms(arg4) <= arg5, 8);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 3);
        let v1 = 0x2::balance::value<T0>(&arg0.reserve_a);
        let v2 = 0x2::balance::value<T1>(&arg0.reserve_b);
        let v3 = v0 * arg0.lp_fee / 10000;
        let v4 = v0 * arg0.project_fee / 10000;
        let v5 = if (0x1::option::is_some<address>(&arg3)) {
            v4 * arg0.referral_percent / 100
        } else {
            0
        };
        let v6 = get_amount_out(v0, v1, v2, arg0.lp_fee + arg0.project_fee);
        assert!(v6 >= arg2, 2);
        assert!(v6 < v2, 0);
        let v7 = 0x2::coin::into_balance<T0>(arg1);
        let v8 = v4 - v5;
        if (v8 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v7, v8), arg6), arg0.fee_collector);
        };
        if (v5 > 0 && 0x1::option::is_some<address>(&arg3)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v7, v5), arg6), *0x1::option::borrow<address>(&arg3));
        };
        0x2::balance::join<T0>(&mut arg0.reserve_a, v7);
        let v9 = 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.reserve_b, v6), arg6);
        let v10 = 0x2::balance::value<T0>(&arg0.reserve_a);
        let v11 = 0x2::balance::value<T1>(&arg0.reserve_b);
        assert!((v10 as u256) * (v11 as u256) >= (v1 as u256) * (v2 as u256), 11);
        update_stats<T0, T1>(arg0, v0, 0, v3, 0, arg4);
        let v12 = Swapped{
            pool_id         : 0x2::object::id_address<Pool<T0, T1>>(arg0),
            trader          : 0x2::tx_context::sender(arg6),
            amount_in       : v0,
            amount_out      : v6,
            lp_fee          : v3,
            project_fee     : v4,
            referrer        : arg3,
            referral_reward : v5,
            is_a_to_b       : true,
            reserve_a_after : v10,
            reserve_b_after : v11,
        };
        0x2::event::emit<Swapped>(v12);
        emit_sync<T0, T1>(arg0);
        v9
    }

    public fun swap_a_for_b_with_referral<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: address, arg4: &0x2::clock::Clock, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        swap_a_for_b_internal<T0, T1>(arg0, arg1, arg2, 0x1::option::some<address>(arg3), arg4, arg5, arg6)
    }

    public fun swap_b_for_a<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        swap_b_for_a_internal<T0, T1>(arg0, arg1, arg2, 0x1::option::none<address>(), arg3, arg4, arg5)
    }

    fun swap_b_for_a_internal<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: 0x1::option::Option<address>, arg4: &0x2::clock::Clock, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(!arg0.is_paused, 10);
        assert!(0x2::clock::timestamp_ms(arg4) <= arg5, 8);
        let v0 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 > 0, 3);
        let v1 = 0x2::balance::value<T0>(&arg0.reserve_a);
        let v2 = 0x2::balance::value<T1>(&arg0.reserve_b);
        let v3 = v0 * arg0.lp_fee / 10000;
        let v4 = v0 * arg0.project_fee / 10000;
        let v5 = if (0x1::option::is_some<address>(&arg3)) {
            v4 * arg0.referral_percent / 100
        } else {
            0
        };
        let v6 = get_amount_out(v0, v2, v1, arg0.lp_fee + arg0.project_fee);
        assert!(v6 >= arg2, 2);
        assert!(v6 < v1, 0);
        0x2::balance::join<T1>(&mut arg0.reserve_b, 0x2::coin::into_balance<T1>(arg1));
        let v7 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reserve_a, v6), arg6);
        let v8 = 0x2::balance::value<T0>(&arg0.reserve_a);
        let v9 = 0x2::balance::value<T1>(&arg0.reserve_b);
        assert!((v8 as u256) * (v9 as u256) >= (v1 as u256) * (v2 as u256), 11);
        update_stats<T0, T1>(arg0, 0, v0, 0, v3, arg4);
        let v10 = Swapped{
            pool_id         : 0x2::object::id_address<Pool<T0, T1>>(arg0),
            trader          : 0x2::tx_context::sender(arg6),
            amount_in       : v0,
            amount_out      : v6,
            lp_fee          : v3,
            project_fee     : v4,
            referrer        : arg3,
            referral_reward : v5,
            is_a_to_b       : false,
            reserve_a_after : v8,
            reserve_b_after : v9,
        };
        0x2::event::emit<Swapped>(v10);
        emit_sync<T0, T1>(arg0);
        v7
    }

    public fun swap_b_for_a_with_referral<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: address, arg4: &0x2::clock::Clock, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        swap_b_for_a_internal<T0, T1>(arg0, arg1, arg2, 0x1::option::some<address>(arg3), arg4, arg5, arg6)
    }

    public entry fun toggle_pause<T0, T1>(arg0: &AdminCap, arg1: &mut Pool<T0, T1>) {
        arg1.is_paused = !arg1.is_paused;
    }

    public entry fun update_fee_collector<T0, T1>(arg0: &AdminCap, arg1: &mut Pool<T0, T1>, arg2: address) {
        arg1.fee_collector = arg2;
    }

    public entry fun update_fees<T0, T1>(arg0: &AdminCap, arg1: &mut Pool<T0, T1>, arg2: u64, arg3: u64, arg4: u64) {
        assert!(arg4 <= 100, 12);
        arg1.lp_fee = arg2;
        arg1.project_fee = arg3;
        arg1.referral_percent = arg4;
        let v0 = PoolConfigUpdated{
            pool_id          : 0x2::object::id_address<Pool<T0, T1>>(arg1),
            lp_fee           : arg2,
            project_fee      : arg3,
            referral_percent : arg4,
        };
        0x2::event::emit<PoolConfigUpdated>(v0);
    }

    fun update_stats<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) {
        arg0.total_volume_a = arg0.total_volume_a + (arg1 as u128);
        arg0.total_volume_b = arg0.total_volume_b + (arg2 as u128);
        arg0.total_fees_earned_a = arg0.total_fees_earned_a + (arg3 as u128);
        arg0.total_fees_earned_b = arg0.total_fees_earned_b + (arg4 as u128);
        arg0.total_swaps = arg0.total_swaps + 1;
        let v0 = 0x2::clock::timestamp_ms(arg5);
        if (v0 - arg0.last_24h_reset > 86400000) {
            arg0.volume_24h_a = arg1;
            arg0.volume_24h_b = arg2;
            arg0.last_24h_reset = v0;
        } else {
            arg0.volume_24h_a = arg0.volume_24h_a + arg1;
            arg0.volume_24h_b = arg0.volume_24h_b + arg2;
        };
    }

    // decompiled from Move bytecode v6
}

