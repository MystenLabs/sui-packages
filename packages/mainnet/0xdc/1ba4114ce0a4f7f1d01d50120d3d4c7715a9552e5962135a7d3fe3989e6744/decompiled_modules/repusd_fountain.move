module 0xdc1ba4114ce0a4f7f1d01d50120d3d4c7715a9552e5962135a7d3fe3989e6744::repusd_fountain {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
        fountain_id: 0x2::object::ID,
    }

    struct RepUSDFountain<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        source: 0x2::balance::Balance<T1>,
        flow_rate: u64,
        pool: 0x2::balance::Balance<T1>,
        staked: 0x2::balance::Balance<T0>,
        total_weight: u64,
        cumulative_unit: u128,
        latest_release_time: u64,
        is_paused: bool,
    }

    struct StakePosition<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        fountain_id: 0x2::object::ID,
        stake_amount: u64,
        start_unit: u128,
        stake_weight: u64,
        lock_until: u64,
        lock_period: u64,
    }

    struct StakeEvent has copy, drop {
        position_id: 0x2::object::ID,
        staker: address,
        amount: u64,
        lock_period: u64,
        weight: u64,
        lock_until: u64,
    }

    struct UnstakeEvent has copy, drop {
        position_id: 0x2::object::ID,
        staker: address,
        amount: u64,
        rewards_claimed: u64,
    }

    struct ClaimEvent has copy, drop {
        position_id: 0x2::object::ID,
        staker: address,
        amount: u64,
    }

    struct SupplyEvent has copy, drop {
        fountain_id: 0x2::object::ID,
        amount: u64,
        new_total: u64,
    }

    fun calculate_rewards<T0, T1>(arg0: &RepUSDFountain<T0, T1>, arg1: &StakePosition<T0, T1>) : u64 {
        (((arg1.stake_weight as u128) * (arg0.cumulative_unit - arg1.start_unit) / 18446744073709551616) as u64)
    }

    fun calculate_virtual_cumulative_unit<T0, T1>(arg0: &RepUSDFountain<T0, T1>, arg1: &0x2::clock::Clock) : u128 {
        if (arg0.total_weight == 0) {
            return arg0.cumulative_unit
        };
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 <= arg0.latest_release_time) {
            return arg0.cumulative_unit
        };
        arg0.cumulative_unit + (0x1::u64::min(arg0.flow_rate * (v0 - arg0.latest_release_time), 0x2::balance::value<T1>(&arg0.source)) as u128) * 18446744073709551616 / (arg0.total_weight as u128)
    }

    fun calculate_weight(arg0: u64, arg1: u64) : u64 {
        let v0 = if (arg1 == 0) {
            3333
        } else if (arg1 == 2592000000) {
            5833
        } else if (arg1 == 7776000000) {
            8333
        } else {
            10000
        };
        arg0 * v0 / 10000
    }

    public fun claim_rewards<T0, T1>(arg0: &mut RepUSDFountain<T0, T1>, arg1: &mut StakePosition<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(arg1.fountain_id == 0x2::object::id<RepUSDFountain<T0, T1>>(arg0), 2);
        release_rewards<T0, T1>(arg0, arg2);
        let v0 = calculate_rewards<T0, T1>(arg0, arg1);
        arg1.start_unit = arg0.cumulative_unit;
        assert!(0x2::balance::value<T1>(&arg0.pool) >= v0, 3);
        let v1 = ClaimEvent{
            position_id : 0x2::object::id<StakePosition<T0, T1>>(arg1),
            staker      : 0x2::tx_context::sender(arg3),
            amount      : v0,
        };
        0x2::event::emit<ClaimEvent>(v1);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.pool, v0), arg3)
    }

    public fun create_fountain<T0, T1>(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : AdminCap {
        let v0 = RepUSDFountain<T0, T1>{
            id                  : 0x2::object::new(arg1),
            source              : 0x2::balance::zero<T1>(),
            flow_rate           : arg0,
            pool                : 0x2::balance::zero<T1>(),
            staked              : 0x2::balance::zero<T0>(),
            total_weight        : 0,
            cumulative_unit     : 0,
            latest_release_time : 0,
            is_paused           : false,
        };
        let v1 = AdminCap{
            id          : 0x2::object::new(arg1),
            fountain_id : 0x2::object::id<RepUSDFountain<T0, T1>>(&v0),
        };
        0x2::transfer::share_object<RepUSDFountain<T0, T1>>(v0);
        v1
    }

    public fun get_apr_for_lock_period(arg0: u64) : u64 {
        if (arg0 == 0) {
            400
        } else if (arg0 == 2592000000) {
            700
        } else if (arg0 == 7776000000) {
            1000
        } else if (arg0 == 15552000000) {
            1200
        } else {
            0
        }
    }

    public fun get_fountain_stats<T0, T1>(arg0: &RepUSDFountain<T0, T1>) : (u64, u64, u64, u64) {
        (0x2::balance::value<T0>(&arg0.staked), 0x2::balance::value<T1>(&arg0.source), 0x2::balance::value<T1>(&arg0.pool), arg0.total_weight)
    }

    public fun get_pending_rewards<T0, T1>(arg0: &RepUSDFountain<T0, T1>, arg1: &StakePosition<T0, T1>, arg2: &0x2::clock::Clock) : u64 {
        (((arg1.stake_weight as u128) * (calculate_virtual_cumulative_unit<T0, T1>(arg0, arg2) - arg1.start_unit) / 18446744073709551616) as u64)
    }

    public fun get_position_info<T0, T1>(arg0: &StakePosition<T0, T1>) : (u64, u64, u64) {
        (arg0.stake_amount, arg0.stake_weight, arg0.lock_until)
    }

    fun release_rewards<T0, T1>(arg0: &mut RepUSDFountain<T0, T1>, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 <= arg0.latest_release_time || arg0.total_weight == 0) {
            arg0.latest_release_time = v0;
            return
        };
        let v1 = 0x1::u64::min(arg0.flow_rate * (v0 - arg0.latest_release_time), 0x2::balance::value<T1>(&arg0.source));
        if (v1 > 0) {
            0x2::balance::join<T1>(&mut arg0.pool, 0x2::balance::split<T1>(&mut arg0.source, v1));
            arg0.cumulative_unit = arg0.cumulative_unit + (v1 as u128) * 18446744073709551616 / (arg0.total_weight as u128);
        };
        arg0.latest_release_time = v0;
    }

    public fun set_paused<T0, T1>(arg0: &AdminCap, arg1: &mut RepUSDFountain<T0, T1>, arg2: bool) {
        assert!(arg0.fountain_id == 0x2::object::id<RepUSDFountain<T0, T1>>(arg1), 2);
        arg1.is_paused = arg2;
    }

    public fun stake<T0, T1>(arg0: &mut RepUSDFountain<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : StakePosition<T0, T1> {
        assert!(!arg0.is_paused, 2);
        let v0 = if (arg2 == 0) {
            true
        } else if (arg2 == 2592000000) {
            true
        } else if (arg2 == 7776000000) {
            true
        } else {
            arg2 == 15552000000
        };
        assert!(v0, 0);
        let v1 = 0x2::coin::value<T0>(&arg1);
        assert!(v1 > 0, 4);
        release_rewards<T0, T1>(arg0, arg3);
        let v2 = calculate_weight(v1, arg2);
        0x2::balance::join<T0>(&mut arg0.staked, 0x2::coin::into_balance<T0>(arg1));
        arg0.total_weight = arg0.total_weight + v2;
        let v3 = if (arg2 == 0) {
            0
        } else {
            0x2::clock::timestamp_ms(arg3) + arg2
        };
        let v4 = StakePosition<T0, T1>{
            id           : 0x2::object::new(arg4),
            fountain_id  : 0x2::object::id<RepUSDFountain<T0, T1>>(arg0),
            stake_amount : v1,
            start_unit   : arg0.cumulative_unit,
            stake_weight : v2,
            lock_until   : v3,
            lock_period  : arg2,
        };
        let v5 = StakeEvent{
            position_id : 0x2::object::id<StakePosition<T0, T1>>(&v4),
            staker      : 0x2::tx_context::sender(arg4),
            amount      : v1,
            lock_period : arg2,
            weight      : v2,
            lock_until  : v3,
        };
        0x2::event::emit<StakeEvent>(v5);
        v4
    }

    public fun supply_rewards<T0, T1>(arg0: &mut RepUSDFountain<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::clock::Clock) {
        if (arg0.latest_release_time == 0) {
            arg0.latest_release_time = 0x2::clock::timestamp_ms(arg2);
        } else {
            release_rewards<T0, T1>(arg0, arg2);
        };
        0x2::balance::join<T1>(&mut arg0.source, 0x2::coin::into_balance<T1>(arg1));
        let v0 = SupplyEvent{
            fountain_id : 0x2::object::id<RepUSDFountain<T0, T1>>(arg0),
            amount      : 0x2::coin::value<T1>(&arg1),
            new_total   : 0x2::balance::value<T1>(&arg0.source),
        };
        0x2::event::emit<SupplyEvent>(v0);
    }

    public fun unstake<T0, T1>(arg0: &mut RepUSDFountain<T0, T1>, arg1: StakePosition<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = calculate_rewards<T0, T1>(arg0, &arg1);
        let StakePosition {
            id           : v1,
            fountain_id  : v2,
            stake_amount : v3,
            start_unit   : _,
            stake_weight : v5,
            lock_until   : v6,
            lock_period  : _,
        } = arg1;
        let v8 = v1;
        assert!(v2 == 0x2::object::id<RepUSDFountain<T0, T1>>(arg0), 2);
        assert!(0x2::clock::timestamp_ms(arg2) >= v6, 1);
        release_rewards<T0, T1>(arg0, arg2);
        arg0.total_weight = arg0.total_weight - v5;
        let v9 = if (v0 > 0) {
            assert!(0x2::balance::value<T1>(&arg0.pool) >= v0, 3);
            0x2::balance::split<T1>(&mut arg0.pool, v0)
        } else {
            0x2::balance::zero<T1>()
        };
        0x2::object::delete(v8);
        let v10 = UnstakeEvent{
            position_id     : 0x2::object::uid_to_inner(&v8),
            staker          : 0x2::tx_context::sender(arg3),
            amount          : v3,
            rewards_claimed : v0,
        };
        0x2::event::emit<UnstakeEvent>(v10);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.staked, v3), arg3), 0x2::coin::from_balance<T1>(v9, arg3))
    }

    public fun update_flow_rate<T0, T1>(arg0: &AdminCap, arg1: &mut RepUSDFountain<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock) {
        assert!(arg0.fountain_id == 0x2::object::id<RepUSDFountain<T0, T1>>(arg1), 2);
        release_rewards<T0, T1>(arg1, arg3);
        arg1.flow_rate = arg2;
    }

    // decompiled from Move bytecode v6
}

