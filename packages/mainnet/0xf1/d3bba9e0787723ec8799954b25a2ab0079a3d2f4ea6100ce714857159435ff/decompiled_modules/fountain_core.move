module 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
        fountain_id: 0x2::object::ID,
    }

    struct Fountain<phantom T0, phantom T1> has store, key {
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

    struct StakeProof<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        fountain_id: 0x2::object::ID,
        stake_amount: u64,
        start_uint: u128,
        stake_weight: u64,
        lock_until: u64,
    }

    struct PenaltyKey has copy, drop, store {
        dummy_field: bool,
    }

    struct PenaltyVault<phantom T0> has store {
        max_penalty_rate: u64,
        vault: 0x2::balance::Balance<T0>,
    }

    struct StakeEvent<phantom T0, phantom T1> has copy, drop {
        fountain_id: 0x2::object::ID,
        stake_amount: u64,
        stake_weight: u64,
        lock_time: u64,
        start_time: u64,
    }

    struct ClaimEvent<phantom T0, phantom T1> has copy, drop {
        fountain_id: 0x2::object::ID,
        reward_amount: u64,
        claim_time: u64,
    }

    struct UnstakeEvent<phantom T0, phantom T1> has copy, drop {
        fountain_id: 0x2::object::ID,
        unstake_amount: u64,
        unstake_weigth: u64,
        end_time: u64,
    }

    struct PenaltyEvent<phantom T0> has copy, drop {
        fountain_id: 0x2::object::ID,
        penalty_amount: u64,
    }

    struct SupplyEvent<phantom T0> has copy, drop {
        fountain_id: 0x2::object::ID,
        amount: u64,
    }

    struct WithdrawEvent<phantom T0> has copy, drop {
        fountain_id: 0x2::object::ID,
        amount: u64,
    }

    struct FlowRateUpdated<phantom T0> has copy, drop {
        fountain_id: 0x2::object::ID,
        flow_amount: u64,
        flow_interval: u64,
    }

    struct MaxPenaltyRateUpdated<phantom T0> has copy, drop {
        fountain_id: 0x2::object::ID,
        max_penalty_rate: u64,
    }

    struct PenaltyClaimed<phantom T0> has copy, drop {
        fountain_id: 0x2::object::ID,
        amount: u64,
    }

    public fun airdrop<T0, T1>(arg0: &mut Fountain<T0, T1>, arg1: 0x2::balance::Balance<T1>) {
        collect_resource<T0, T1>(arg0, arg1);
    }

    fun borrow_mut_penalty_vault<T0, T1>(arg0: &mut Fountain<T0, T1>) : &mut PenaltyVault<T0> {
        let v0 = PenaltyKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_with_type<PenaltyKey, PenaltyVault<T0>>(&arg0.id, v0), 4);
        0x2::dynamic_field::borrow_mut<PenaltyKey, PenaltyVault<T0>>(&mut arg0.id, v0)
    }

    fun borrow_penalty_vault<T0, T1>(arg0: &Fountain<T0, T1>) : &PenaltyVault<T0> {
        let v0 = PenaltyKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_with_type<PenaltyKey, PenaltyVault<T0>>(&arg0.id, v0), 4);
        0x2::dynamic_field::borrow<PenaltyKey, PenaltyVault<T0>>(&arg0.id, v0)
    }

    fun check_admin_cap<T0, T1>(arg0: &AdminCap, arg1: &Fountain<T0, T1>) {
        assert!(arg0.fountain_id == 0x2::object::id<Fountain<T0, T1>>(arg1), 2);
    }

    fun check_proof<T0, T1>(arg0: &Fountain<T0, T1>, arg1: &StakeProof<T0, T1>) {
        assert!(0x2::object::id<Fountain<T0, T1>>(arg0) == arg1.fountain_id, 1);
    }

    public fun claim<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut Fountain<T0, T1>, arg2: &mut StakeProof<T0, T1>) : 0x2::balance::Balance<T1> {
        check_proof<T0, T1>(arg1, arg2);
        source_to_pool<T0, T1>(arg1, arg0);
        let v0 = (0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::math::mul_factor_u128((arg2.stake_weight as u128), arg1.cumulative_unit - arg2.start_uint, 18446744073709551616) as u64);
        if (v0 > 0) {
            let v1 = ClaimEvent<T0, T1>{
                fountain_id   : arg2.fountain_id,
                reward_amount : v0,
                claim_time    : 0x2::clock::timestamp_ms(arg0),
            };
            0x2::event::emit<ClaimEvent<T0, T1>>(v1);
        };
        arg2.start_uint = arg1.cumulative_unit;
        0x2::balance::split<T1>(&mut arg1.pool, v0)
    }

    public fun claim_penalty<T0, T1>(arg0: &AdminCap, arg1: &mut Fountain<T0, T1>) : 0x2::balance::Balance<T0> {
        check_admin_cap<T0, T1>(arg0, arg1);
        let v0 = PenaltyKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_with_type<PenaltyKey, PenaltyVault<T0>>(&arg1.id, v0), 4);
        let v1 = 0x2::dynamic_field::borrow_mut<PenaltyKey, PenaltyVault<T0>>(&mut arg1.id, v0);
        let v2 = 0x2::balance::value<T0>(&v1.vault);
        let v3 = 0x2::balance::split<T0>(&mut v1.vault, v2);
        let v4 = PenaltyClaimed<T0>{
            fountain_id : 0x2::object::id<Fountain<T0, T1>>(arg1),
            amount      : v2,
        };
        0x2::event::emit<PenaltyClaimed<T0>>(v4);
        v3
    }

    fun collect_resource<T0, T1>(arg0: &mut Fountain<T0, T1>, arg1: 0x2::balance::Balance<T1>) {
        let v0 = 0x2::balance::value<T1>(&arg1);
        if (v0 > 0) {
            0x2::balance::join<T1>(&mut arg0.pool, arg1);
            arg0.cumulative_unit = arg0.cumulative_unit + 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::math::mul_factor_u128((v0 as u128), 18446744073709551616, (arg0.total_weight as u128));
        } else {
            0x2::balance::destroy_zero<T1>(arg1);
        };
    }

    public fun force_unstake<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut Fountain<T0, T1>, arg2: StakeProof<T0, T1>) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        check_proof<T0, T1>(arg1, &arg2);
        source_to_pool<T0, T1>(arg1, arg0);
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let v1 = &mut arg2;
        let v2 = claim<T0, T1>(arg0, arg1, v1);
        let v3 = get_penalty_amount<T0, T1>(arg1, &arg2, v0);
        let StakeProof {
            id           : v4,
            fountain_id  : v5,
            stake_amount : v6,
            start_uint   : _,
            stake_weight : v8,
            lock_until   : _,
        } = arg2;
        0x2::object::delete(v4);
        arg1.total_weight = arg1.total_weight - v8;
        let v10 = 0x2::balance::split<T0>(&mut arg1.staked, v6);
        0x2::balance::join<T0>(&mut borrow_mut_penalty_vault<T0, T1>(arg1).vault, 0x2::balance::split<T0>(&mut v10, v3));
        let v11 = UnstakeEvent<T0, T1>{
            fountain_id    : v5,
            unstake_amount : 0x2::balance::value<T0>(&v10),
            unstake_weigth : v8,
            end_time       : v0,
        };
        0x2::event::emit<UnstakeEvent<T0, T1>>(v11);
        if (v3 > 0) {
            let v12 = PenaltyEvent<T0>{
                fountain_id    : v5,
                penalty_amount : v3,
            };
            0x2::event::emit<PenaltyEvent<T0>>(v12);
        };
        (v10, v2)
    }

    public fun get_cumulative_unit<T0, T1>(arg0: &Fountain<T0, T1>) : u128 {
        arg0.cumulative_unit
    }

    public fun get_flow_rate<T0, T1>(arg0: &Fountain<T0, T1>) : (u64, u64) {
        (arg0.flow_amount, arg0.flow_interval)
    }

    public fun get_latest_release_time<T0, T1>(arg0: &Fountain<T0, T1>) : u64 {
        arg0.latest_release_time
    }

    public fun get_lock_time_range<T0, T1>(arg0: &Fountain<T0, T1>) : (u64, u64) {
        (arg0.min_lock_time, arg0.max_lock_time)
    }

    public fun get_max_penalty_rate<T0, T1>(arg0: &Fountain<T0, T1>) : u64 {
        borrow_penalty_vault<T0, T1>(arg0).max_penalty_rate
    }

    public fun get_penalty_amount<T0, T1>(arg0: &Fountain<T0, T1>, arg1: &StakeProof<T0, T1>, arg2: u64) : u64 {
        check_proof<T0, T1>(arg0, arg1);
        if (arg2 >= arg1.lock_until) {
            0
        } else {
            mul(mul(arg1.stake_amount, get_max_penalty_rate<T0, T1>(arg0), 1000000), mul(arg1.stake_amount, arg1.lock_until - arg2, arg0.max_lock_time), arg1.stake_weight)
        }
    }

    public fun get_penalty_rate_precision() : u64 {
        1000000
    }

    public fun get_penalty_vault_balance<T0, T1>(arg0: &Fountain<T0, T1>) : u64 {
        0x2::balance::value<T0>(&borrow_penalty_vault<T0, T1>(arg0).vault)
    }

    public fun get_pool_balance<T0, T1>(arg0: &Fountain<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.pool)
    }

    public fun get_proof_lock_until<T0, T1>(arg0: &StakeProof<T0, T1>) : u64 {
        arg0.lock_until
    }

    public fun get_proof_stake_amount<T0, T1>(arg0: &StakeProof<T0, T1>) : u64 {
        arg0.stake_amount
    }

    public fun get_proof_stake_weight<T0, T1>(arg0: &StakeProof<T0, T1>) : u64 {
        arg0.stake_weight
    }

    public fun get_reward_amount<T0, T1>(arg0: &Fountain<T0, T1>, arg1: &StakeProof<T0, T1>, arg2: u64) : u64 {
        (0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::math::mul_factor_u128((arg1.stake_weight as u128), arg0.cumulative_unit + 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::math::mul_factor_u128((get_virtual_released_amount<T0, T1>(arg0, arg2) as u128), 18446744073709551616, (arg0.total_weight as u128)) - arg1.start_uint, 18446744073709551616) as u64)
    }

    public fun get_source_balance<T0, T1>(arg0: &Fountain<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.source)
    }

    public fun get_staked_balance<T0, T1>(arg0: &Fountain<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.staked)
    }

    public fun get_total_weight<T0, T1>(arg0: &Fountain<T0, T1>) : u64 {
        arg0.total_weight
    }

    public fun get_virtual_released_amount<T0, T1>(arg0: &Fountain<T0, T1>, arg1: u64) : u64 {
        if (arg1 > arg0.latest_release_time) {
            let v1 = 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::math::mul_factor(arg0.flow_amount, arg1 - arg0.latest_release_time, arg0.flow_interval);
            let v2 = v1;
            let v3 = get_source_balance<T0, T1>(arg0);
            if (v1 > v3) {
                v2 = v3;
            };
            v2
        } else {
            0
        }
    }

    fun mul(arg0: u64, arg1: u64, arg2: u64) : u64 {
        ((((arg0 as u128) * (arg1 as u128) + (arg2 as u128) / 2) / (arg2 as u128)) as u64)
    }

    public fun new_fountain<T0, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : Fountain<T0, T1> {
        assert!(arg3 > arg2, 6);
        Fountain<T0, T1>{
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
        }
    }

    public fun new_fountain_with_admin_cap<T0, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (Fountain<T0, T1>, AdminCap) {
        let v0 = new_fountain<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        let v1 = AdminCap{
            id          : 0x2::object::new(arg5),
            fountain_id : 0x2::object::id<Fountain<T0, T1>>(&v0),
        };
        (v0, v1)
    }

    public fun new_penalty_vault<T0, T1>(arg0: &AdminCap, arg1: &mut Fountain<T0, T1>, arg2: u64) {
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

    fun release_resource<T0, T1>(arg0: &mut Fountain<T0, T1>, arg1: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 > arg0.latest_release_time) {
            let v2 = 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::math::mul_factor(arg0.flow_amount, v0 - arg0.latest_release_time, arg0.flow_interval);
            let v3 = v2;
            let v4 = get_source_balance<T0, T1>(arg0);
            if (v2 > v4) {
                v3 = v4;
            };
            arg0.latest_release_time = v0;
            0x2::balance::split<T1>(&mut arg0.source, v3)
        } else {
            0x2::balance::zero<T1>()
        }
    }

    fun source_to_pool<T0, T1>(arg0: &mut Fountain<T0, T1>, arg1: &0x2::clock::Clock) {
        if (get_source_balance<T0, T1>(arg0) > 0 && get_total_weight<T0, T1>(arg0) > 0) {
            let v0 = release_resource<T0, T1>(arg0, arg1);
            collect_resource<T0, T1>(arg0, v0);
        } else {
            let v1 = 0x2::clock::timestamp_ms(arg1);
            if (v1 > arg0.latest_release_time) {
                arg0.latest_release_time = v1;
            };
        };
    }

    public fun stake<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut Fountain<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : StakeProof<T0, T1> {
        source_to_pool<T0, T1>(arg1, arg0);
        let v0 = 0x2::balance::value<T0>(&arg2);
        0x2::balance::join<T0>(&mut arg1.staked, arg2);
        let v1 = 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::math::compute_weight(v0, arg3, arg1.min_lock_time, arg1.max_lock_time);
        arg1.total_weight = arg1.total_weight + v1;
        let v2 = 0x2::object::id<Fountain<T0, T1>>(arg1);
        let v3 = 0x2::clock::timestamp_ms(arg0);
        let v4 = StakeEvent<T0, T1>{
            fountain_id  : v2,
            stake_amount : v0,
            stake_weight : v1,
            lock_time    : arg3,
            start_time   : v3,
        };
        0x2::event::emit<StakeEvent<T0, T1>>(v4);
        StakeProof<T0, T1>{
            id           : 0x2::object::new(arg4),
            fountain_id  : v2,
            stake_amount : v0,
            start_uint   : arg1.cumulative_unit,
            stake_weight : v1,
            lock_until   : v3 + arg3,
        }
    }

    public fun supply<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut Fountain<T0, T1>, arg2: 0x2::balance::Balance<T1>) {
        source_to_pool<T0, T1>(arg1, arg0);
        let v0 = SupplyEvent<T1>{
            fountain_id : 0x2::object::id<Fountain<T0, T1>>(arg1),
            amount      : 0x2::balance::value<T1>(&arg2),
        };
        0x2::event::emit<SupplyEvent<T1>>(v0);
        0x2::balance::join<T1>(&mut arg1.source, arg2);
    }

    public fun tune<T0, T1>(arg0: &mut Fountain<T0, T1>, arg1: 0x2::balance::Balance<T1>) {
        0x2::balance::join<T1>(&mut arg0.pool, arg1);
    }

    public fun unstake<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut Fountain<T0, T1>, arg2: StakeProof<T0, T1>) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        check_proof<T0, T1>(arg1, &arg2);
        source_to_pool<T0, T1>(arg1, arg0);
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let v1 = &mut arg2;
        let v2 = claim<T0, T1>(arg0, arg1, v1);
        let StakeProof {
            id           : v3,
            fountain_id  : v4,
            stake_amount : v5,
            start_uint   : _,
            stake_weight : v7,
            lock_until   : v8,
        } = arg2;
        assert!(v0 >= v8, 0);
        0x2::object::delete(v3);
        arg1.total_weight = arg1.total_weight - v7;
        let v9 = UnstakeEvent<T0, T1>{
            fountain_id    : v4,
            unstake_amount : v5,
            unstake_weigth : v7,
            end_time       : v0,
        };
        0x2::event::emit<UnstakeEvent<T0, T1>>(v9);
        (0x2::balance::split<T0>(&mut arg1.staked, v5), v2)
    }

    public entry fun update_flow_rate<T0, T1>(arg0: &AdminCap, arg1: &0x2::clock::Clock, arg2: &mut Fountain<T0, T1>, arg3: u64, arg4: u64) {
        check_admin_cap<T0, T1>(arg0, arg2);
        source_to_pool<T0, T1>(arg2, arg1);
        arg2.flow_amount = arg3;
        arg2.flow_interval = arg4;
        let v0 = FlowRateUpdated<T1>{
            fountain_id   : 0x2::object::id<Fountain<T0, T1>>(arg2),
            flow_amount   : arg3,
            flow_interval : arg4,
        };
        0x2::event::emit<FlowRateUpdated<T1>>(v0);
    }

    public entry fun update_max_penalty_rate<T0, T1>(arg0: &AdminCap, arg1: &mut Fountain<T0, T1>, arg2: u64) {
        assert!(arg2 <= 1000000, 5);
        check_admin_cap<T0, T1>(arg0, arg1);
        let v0 = borrow_mut_penalty_vault<T0, T1>(arg1);
        v0.max_penalty_rate = arg2;
        let v1 = MaxPenaltyRateUpdated<T0>{
            fountain_id      : 0x2::object::id<Fountain<T0, T1>>(arg1),
            max_penalty_rate : arg2,
        };
        0x2::event::emit<MaxPenaltyRateUpdated<T0>>(v1);
    }

    public fun withdraw_from_source<T0, T1>(arg0: &AdminCap, arg1: &mut Fountain<T0, T1>, arg2: u64) : 0x2::balance::Balance<T1> {
        check_admin_cap<T0, T1>(arg0, arg1);
        let v0 = WithdrawEvent<T1>{
            fountain_id : 0x2::object::id<Fountain<T0, T1>>(arg1),
            amount      : arg2,
        };
        0x2::event::emit<WithdrawEvent<T1>>(v0);
        0x2::balance::split<T1>(&mut arg1.source, arg2)
    }

    // decompiled from Move bytecode v6
}

