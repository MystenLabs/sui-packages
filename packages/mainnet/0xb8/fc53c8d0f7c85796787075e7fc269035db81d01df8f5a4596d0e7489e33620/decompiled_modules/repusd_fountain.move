module 0xb8fc53c8d0f7c85796787075e7fc269035db81d01df8f5a4596d0e7489e33620::repusd_fountain {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
        fountain_id: 0x2::object::ID,
    }

    struct RepUSDFountain<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        source: 0x2::balance::Balance<T1>,
        flow_amount: u64,
        flow_interval: u64,
        pool: 0x2::balance::Balance<T1>,
        staked: 0x2::balance::Balance<T0>,
        total_weight: u64,
        cumulative_unit: u128,
        latest_release_time: u64,
        min_lock_time: u64,
        max_lock_time: u64,
    }

    struct PenaltyKey has copy, drop, store {
        dummy_field: bool,
    }

    struct PenaltyVault<phantom T0> has store {
        max_penalty_rate: u64,
        vault: 0x2::balance::Balance<T0>,
    }

    struct StakeProof<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        fountain_id: 0x2::object::ID,
        stake_amount: u64,
        start_unit: u128,
        stake_weight: u64,
        lock_until: u64,
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

    struct PenaltyEvent<phantom T0> has copy, drop {
        fountain_id: 0x2::object::ID,
        penalty_amount: u64,
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

    fun borrow_mut_penalty_vault<T0, T1>(arg0: &mut RepUSDFountain<T0, T1>) : &mut PenaltyVault<T0> {
        let v0 = PenaltyKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_with_type<PenaltyKey, PenaltyVault<T0>>(&arg0.id, v0), 4);
        0x2::dynamic_field::borrow_mut<PenaltyKey, PenaltyVault<T0>>(&mut arg0.id, v0)
    }

    fun borrow_penalty_vault<T0, T1>(arg0: &RepUSDFountain<T0, T1>) : &PenaltyVault<T0> {
        let v0 = PenaltyKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_with_type<PenaltyKey, PenaltyVault<T0>>(&arg0.id, v0), 4);
        0x2::dynamic_field::borrow<PenaltyKey, PenaltyVault<T0>>(&arg0.id, v0)
    }

    fun calculate_rewards<T0, T1>(arg0: &RepUSDFountain<T0, T1>, arg1: &StakeProof<T0, T1>) : u64 {
        (mul_factor_u128((arg1.stake_weight as u128), arg0.cumulative_unit - arg1.start_unit, 18446744073709551616) as u64)
    }

    fun calculate_virtual_cumulative_unit<T0, T1>(arg0: &RepUSDFountain<T0, T1>, arg1: &0x2::clock::Clock) : u128 {
        if (arg0.total_weight == 0) {
            return arg0.cumulative_unit
        };
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 <= arg0.latest_release_time) {
            return arg0.cumulative_unit
        };
        let v1 = (v0 - arg0.latest_release_time) / arg0.flow_interval;
        let v2 = if (v1 > 0) {
            arg0.flow_amount * v1
        } else {
            0
        };
        arg0.cumulative_unit + (0x1::u64::min(v2, 0x2::balance::value<T1>(&arg0.source)) as u128) * 18446744073709551616 / (arg0.total_weight as u128)
    }

    fun check_admin_cap<T0, T1>(arg0: &AdminCap, arg1: &RepUSDFountain<T0, T1>) {
        assert!(arg0.fountain_id == 0x2::object::id<RepUSDFountain<T0, T1>>(arg1), 2);
    }

    fun check_proof<T0, T1>(arg0: &RepUSDFountain<T0, T1>, arg1: &StakeProof<T0, T1>) {
        assert!(arg1.fountain_id == 0x2::object::id<RepUSDFountain<T0, T1>>(arg0), 1);
    }

    public fun claim<T0, T1>(arg0: &mut RepUSDFountain<T0, T1>, arg1: &mut StakeProof<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        check_proof<T0, T1>(arg0, arg1);
        source_to_pool<T0, T1>(arg0, arg2);
        let v0 = calculate_rewards<T0, T1>(arg0, arg1);
        arg1.start_unit = arg0.cumulative_unit;
        if (v0 > 0) {
            let v1 = ClaimEvent{
                position_id : 0x2::object::id<StakeProof<T0, T1>>(arg1),
                staker      : 0x2::tx_context::sender(arg3),
                amount      : v0,
            };
            0x2::event::emit<ClaimEvent>(v1);
        };
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.pool, v0), arg3)
    }

    public fun claim_penalty<T0, T1>(arg0: &AdminCap, arg1: &mut RepUSDFountain<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        check_admin_cap<T0, T1>(arg0, arg1);
        let v0 = PenaltyKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_with_type<PenaltyKey, PenaltyVault<T0>>(&arg1.id, v0), 4);
        let v1 = 0x2::dynamic_field::borrow_mut<PenaltyKey, PenaltyVault<T0>>(&mut arg1.id, v0);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v1.vault, 0x2::balance::value<T0>(&v1.vault)), arg2)
    }

    fun compute_weight(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        assert!(arg1 >= arg2 && arg1 <= arg3, 7);
        let v0 = mul_factor(arg0, arg1, arg3);
        assert!(v0 > 0, 8);
        v0
    }

    public fun create_fountain<T0, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : AdminCap {
        assert!(arg3 > arg2, 6);
        let v0 = RepUSDFountain<T0, T1>{
            id                  : 0x2::object::new(arg5),
            source              : 0x2::balance::zero<T1>(),
            flow_amount         : arg0,
            flow_interval       : arg1,
            pool                : 0x2::balance::zero<T1>(),
            staked              : 0x2::balance::zero<T0>(),
            total_weight        : 0,
            cumulative_unit     : 0,
            latest_release_time : arg4,
            min_lock_time       : arg2,
            max_lock_time       : arg3,
        };
        let v1 = AdminCap{
            id          : 0x2::object::new(arg5),
            fountain_id : 0x2::object::id<RepUSDFountain<T0, T1>>(&v0),
        };
        0x2::transfer::share_object<RepUSDFountain<T0, T1>>(v0);
        v1
    }

    public fun force_unstake<T0, T1>(arg0: &mut RepUSDFountain<T0, T1>, arg1: StakeProof<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        check_proof<T0, T1>(arg0, &arg1);
        source_to_pool<T0, T1>(arg0, arg2);
        let v0 = &mut arg1;
        let v1 = claim<T0, T1>(arg0, v0, arg2, arg3);
        let v2 = get_penalty_amount<T0, T1>(arg0, &arg1, 0x2::clock::timestamp_ms(arg2));
        let StakeProof {
            id           : v3,
            fountain_id  : v4,
            stake_amount : v5,
            start_unit   : _,
            stake_weight : v7,
            lock_until   : _,
        } = arg1;
        0x2::object::delete(v3);
        arg0.total_weight = arg0.total_weight - v7;
        let v9 = 0x2::balance::split<T0>(&mut arg0.staked, v5);
        let v10 = borrow_mut_penalty_vault<T0, T1>(arg0);
        0x2::balance::join<T0>(&mut v10.vault, 0x2::balance::split<T0>(&mut v9, v2));
        let v11 = UnstakeEvent{
            position_id     : v4,
            staker          : 0x2::tx_context::sender(arg3),
            amount          : 0x2::balance::value<T0>(&v9),
            rewards_claimed : 0x2::coin::value<T1>(&v1),
        };
        0x2::event::emit<UnstakeEvent>(v11);
        if (v2 > 0) {
            let v12 = PenaltyEvent<T0>{
                fountain_id    : 0x2::object::id<RepUSDFountain<T0, T1>>(arg0),
                penalty_amount : v2,
            };
            0x2::event::emit<PenaltyEvent<T0>>(v12);
        };
        (0x2::coin::from_balance<T0>(v9, arg3), v1)
    }

    public fun get_flow_rate<T0, T1>(arg0: &RepUSDFountain<T0, T1>) : (u64, u64) {
        (arg0.flow_amount, arg0.flow_interval)
    }

    public fun get_fountain_stats<T0, T1>(arg0: &RepUSDFountain<T0, T1>) : (u64, u64, u64, u64) {
        (0x2::balance::value<T0>(&arg0.staked), 0x2::balance::value<T1>(&arg0.source), 0x2::balance::value<T1>(&arg0.pool), arg0.total_weight)
    }

    public fun get_lock_time_range<T0, T1>(arg0: &RepUSDFountain<T0, T1>) : (u64, u64) {
        (arg0.min_lock_time, arg0.max_lock_time)
    }

    fun get_penalty_amount<T0, T1>(arg0: &RepUSDFountain<T0, T1>, arg1: &StakeProof<T0, T1>, arg2: u64) : u64 {
        if (arg2 >= arg1.lock_until) {
            return 0
        };
        mul_factor(mul_factor(arg1.stake_amount, borrow_penalty_vault<T0, T1>(arg0).max_penalty_rate, 1000000), arg1.lock_until - arg2, arg1.lock_until - arg0.latest_release_time)
    }

    public fun get_pending_rewards<T0, T1>(arg0: &RepUSDFountain<T0, T1>, arg1: &StakeProof<T0, T1>, arg2: &0x2::clock::Clock) : u64 {
        (((arg1.stake_weight as u128) * (calculate_virtual_cumulative_unit<T0, T1>(arg0, arg2) - arg1.start_unit) / 18446744073709551616) as u64)
    }

    public fun get_proof_info<T0, T1>(arg0: &StakeProof<T0, T1>) : (u64, u64, u64) {
        (arg0.stake_amount, arg0.stake_weight, arg0.lock_until)
    }

    fun mul_factor(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > 0, 9);
        ((((arg0 as u128) * (arg1 as u128) + (arg2 as u128) / 2) / (arg2 as u128)) as u64)
    }

    fun mul_factor_u128(arg0: u128, arg1: u128, arg2: u128) : u128 {
        assert!(arg2 > 0, 9);
        (arg0 * arg1 + arg2 / 2) / arg2
    }

    public fun new_penalty_vault<T0, T1>(arg0: &AdminCap, arg1: &mut RepUSDFountain<T0, T1>, arg2: u64) {
        check_admin_cap<T0, T1>(arg0, arg1);
        assert!(arg2 <= 1000000, 5);
        let v0 = PenaltyKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists_with_type<PenaltyKey, PenaltyVault<T0>>(&arg1.id, v0), 3);
        let v1 = PenaltyVault<T0>{
            max_penalty_rate : arg2,
            vault            : 0x2::balance::zero<T0>(),
        };
        0x2::dynamic_field::add<PenaltyKey, PenaltyVault<T0>>(&mut arg1.id, v0, v1);
    }

    fun source_to_pool<T0, T1>(arg0: &mut RepUSDFountain<T0, T1>, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 <= arg0.latest_release_time || arg0.total_weight == 0) {
            arg0.latest_release_time = v0;
            return
        };
        let v1 = 0x1::u64::min(arg0.flow_amount * (v0 - arg0.latest_release_time) / arg0.flow_interval, 0x2::balance::value<T1>(&arg0.source));
        if (v1 > 0) {
            0x2::balance::join<T1>(&mut arg0.pool, 0x2::balance::split<T1>(&mut arg0.source, v1));
            arg0.cumulative_unit = arg0.cumulative_unit + (v1 as u128) * 18446744073709551616 / (arg0.total_weight as u128);
        };
        arg0.latest_release_time = v0;
    }

    public fun stake<T0, T1>(arg0: &mut RepUSDFountain<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : StakeProof<T0, T1> {
        assert!(arg2 >= arg0.min_lock_time && arg2 <= arg0.max_lock_time, 7);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 9);
        source_to_pool<T0, T1>(arg0, arg3);
        let v1 = compute_weight(v0, arg2, arg0.min_lock_time, arg0.max_lock_time);
        0x2::balance::join<T0>(&mut arg0.staked, 0x2::coin::into_balance<T0>(arg1));
        arg0.total_weight = arg0.total_weight + v1;
        let v2 = 0x2::clock::timestamp_ms(arg3) + arg2;
        let v3 = StakeProof<T0, T1>{
            id           : 0x2::object::new(arg4),
            fountain_id  : 0x2::object::id<RepUSDFountain<T0, T1>>(arg0),
            stake_amount : v0,
            start_unit   : arg0.cumulative_unit,
            stake_weight : v1,
            lock_until   : v2,
        };
        let v4 = StakeEvent{
            position_id : 0x2::object::id<StakeProof<T0, T1>>(&v3),
            staker      : 0x2::tx_context::sender(arg4),
            amount      : v0,
            lock_period : arg2,
            weight      : v1,
            lock_until  : v2,
        };
        0x2::event::emit<StakeEvent>(v4);
        v3
    }

    public fun supply_rewards<T0, T1>(arg0: &mut RepUSDFountain<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::clock::Clock) {
        if (arg0.latest_release_time == 0) {
            arg0.latest_release_time = 0x2::clock::timestamp_ms(arg2);
        } else {
            source_to_pool<T0, T1>(arg0, arg2);
        };
        0x2::balance::join<T1>(&mut arg0.source, 0x2::coin::into_balance<T1>(arg1));
        let v0 = SupplyEvent{
            fountain_id : 0x2::object::id<RepUSDFountain<T0, T1>>(arg0),
            amount      : 0x2::coin::value<T1>(&arg1),
            new_total   : 0x2::balance::value<T1>(&arg0.source),
        };
        0x2::event::emit<SupplyEvent>(v0);
    }

    public fun unstake<T0, T1>(arg0: &mut RepUSDFountain<T0, T1>, arg1: StakeProof<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        check_proof<T0, T1>(arg0, &arg1);
        source_to_pool<T0, T1>(arg0, arg2);
        let v0 = &mut arg1;
        let v1 = claim<T0, T1>(arg0, v0, arg2, arg3);
        let StakeProof {
            id           : v2,
            fountain_id  : v3,
            stake_amount : v4,
            start_unit   : _,
            stake_weight : v6,
            lock_until   : v7,
        } = arg1;
        assert!(0x2::clock::timestamp_ms(arg2) >= v7, 0);
        0x2::object::delete(v2);
        arg0.total_weight = arg0.total_weight - v6;
        let v8 = UnstakeEvent{
            position_id     : v3,
            staker          : 0x2::tx_context::sender(arg3),
            amount          : v4,
            rewards_claimed : 0x2::coin::value<T1>(&v1),
        };
        0x2::event::emit<UnstakeEvent>(v8);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.staked, v4), arg3), v1)
    }

    public fun update_flow_rate<T0, T1>(arg0: &AdminCap, arg1: &mut RepUSDFountain<T0, T1>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
        check_admin_cap<T0, T1>(arg0, arg1);
        source_to_pool<T0, T1>(arg1, arg4);
        arg1.flow_amount = arg2;
        arg1.flow_interval = arg3;
    }

    public fun update_max_penalty_rate<T0, T1>(arg0: &AdminCap, arg1: &mut RepUSDFountain<T0, T1>, arg2: u64) {
        assert!(arg2 <= 1000000, 5);
        check_admin_cap<T0, T1>(arg0, arg1);
        borrow_mut_penalty_vault<T0, T1>(arg1).max_penalty_rate = arg2;
    }

    // decompiled from Move bytecode v6
}

