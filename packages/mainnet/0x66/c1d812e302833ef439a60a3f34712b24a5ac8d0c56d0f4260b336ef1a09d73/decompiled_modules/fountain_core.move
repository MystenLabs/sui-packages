module 0x66c1d812e302833ef439a60a3f34712b24a5ac8d0c56d0f4260b336ef1a09d73::fountain_core {
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

    public fun airdrop<T0, T1>(arg0: &mut Fountain<T0, T1>, arg1: 0x2::balance::Balance<T1>) {
        collect_resource<T0, T1>(arg0, arg1);
    }

    public fun claim<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut Fountain<T0, T1>, arg2: &mut StakeProof<T0, T1>) : 0x2::balance::Balance<T1> {
        source_to_pool<T0, T1>(arg1, arg0);
        let v0 = arg2.fountain_id;
        assert!(0x2::object::id<Fountain<T0, T1>>(arg1) == v0, 1);
        let v1 = (0x66c1d812e302833ef439a60a3f34712b24a5ac8d0c56d0f4260b336ef1a09d73::math::mul_factor_u128((arg2.stake_weight as u128), arg1.cumulative_unit - arg2.start_uint, 18446744073709551616) as u64);
        let v2 = ClaimEvent<T0, T1>{
            fountain_id   : v0,
            reward_amount : v1,
            claim_time    : 0x2::clock::timestamp_ms(arg0),
        };
        0x2::event::emit<ClaimEvent<T0, T1>>(v2);
        arg2.start_uint = arg1.cumulative_unit;
        0x2::balance::split<T1>(&mut arg1.pool, v1)
    }

    fun collect_resource<T0, T1>(arg0: &mut Fountain<T0, T1>, arg1: 0x2::balance::Balance<T1>) {
        0x2::balance::join<T1>(&mut arg0.pool, arg1);
        arg0.cumulative_unit = arg0.cumulative_unit + 0x66c1d812e302833ef439a60a3f34712b24a5ac8d0c56d0f4260b336ef1a09d73::math::mul_factor_u128((0x2::balance::value<T1>(&arg1) as u128), 18446744073709551616, (arg0.total_weight as u128));
    }

    public fun get_cumulative_unit<T0, T1>(arg0: &Fountain<T0, T1>) : u128 {
        arg0.cumulative_unit
    }

    public fun get_flow_rate<T0, T1>(arg0: &Fountain<T0, T1>) : (u64, u64) {
        (arg0.flow_amount, arg0.flow_interval)
    }

    public fun get_lock_time_range<T0, T1>(arg0: &Fountain<T0, T1>) : (u64, u64) {
        (arg0.min_lock_time, arg0.max_lock_time)
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

    public fun get_reward_amount<T0, T1>(arg0: &Fountain<T0, T1>, arg1: &StakeProof<T0, T1>) : u64 {
        (0x66c1d812e302833ef439a60a3f34712b24a5ac8d0c56d0f4260b336ef1a09d73::math::mul_factor_u128((arg1.stake_weight as u128), arg0.cumulative_unit - arg1.start_uint, 18446744073709551616) as u64)
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

    public fun new_fountain<T0, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : Fountain<T0, T1> {
        Fountain<T0, T1>{
            id                  : 0x2::object::new(arg4),
            source              : 0x2::balance::zero<T1>(),
            flow_amount         : arg0,
            flow_interval       : arg1,
            pool                : 0x2::balance::zero<T1>(),
            staked              : 0x2::balance::zero<T0>(),
            total_weight        : 0,
            cumulative_unit     : 0,
            latest_release_time : 0,
            min_lock_time       : arg2,
            max_lock_time       : arg3,
        }
    }

    fun release_resource<T0, T1>(arg0: &mut Fountain<T0, T1>, arg1: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = 0x66c1d812e302833ef439a60a3f34712b24a5ac8d0c56d0f4260b336ef1a09d73::math::mul_factor(arg0.flow_amount, v0 - arg0.latest_release_time, arg0.flow_interval);
        let v2 = v1;
        let v3 = get_source_balance<T0, T1>(arg0);
        if (v1 > v3) {
            v2 = v3;
        };
        arg0.latest_release_time = v0;
        0x2::balance::split<T1>(&mut arg0.source, v2)
    }

    fun source_to_pool<T0, T1>(arg0: &mut Fountain<T0, T1>, arg1: &0x2::clock::Clock) {
        if (get_source_balance<T0, T1>(arg0) > 0) {
            let v0 = release_resource<T0, T1>(arg0, arg1);
            collect_resource<T0, T1>(arg0, v0);
        };
    }

    public fun stake<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut Fountain<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : StakeProof<T0, T1> {
        source_to_pool<T0, T1>(arg1, arg0);
        let v0 = 0x2::balance::value<T0>(&arg2);
        0x2::balance::join<T0>(&mut arg1.staked, arg2);
        let v1 = 0x66c1d812e302833ef439a60a3f34712b24a5ac8d0c56d0f4260b336ef1a09d73::math::compute_weight(v0, arg3, arg1.min_lock_time, arg1.max_lock_time);
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
        0x2::balance::join<T1>(&mut arg1.source, arg2);
    }

    public fun tune<T0, T1>(arg0: &mut Fountain<T0, T1>, arg1: 0x2::balance::Balance<T1>) {
        0x2::balance::join<T1>(&mut arg0.pool, arg1);
    }

    public fun unstake<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut Fountain<T0, T1>, arg2: StakeProof<T0, T1>) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        source_to_pool<T0, T1>(arg1, arg0);
        let v0 = get_reward_amount<T0, T1>(arg1, &arg2);
        let StakeProof {
            id           : v1,
            fountain_id  : v2,
            stake_amount : v3,
            start_uint   : _,
            stake_weight : v5,
            lock_until   : v6,
        } = arg2;
        assert!(0x2::object::id<Fountain<T0, T1>>(arg1) == v2, 1);
        let v7 = 0x2::clock::timestamp_ms(arg0);
        assert!(v7 >= v6, 0);
        0x2::object::delete(v1);
        let v8 = ClaimEvent<T0, T1>{
            fountain_id   : v2,
            reward_amount : v0,
            claim_time    : v7,
        };
        0x2::event::emit<ClaimEvent<T0, T1>>(v8);
        let v9 = UnstakeEvent<T0, T1>{
            fountain_id    : v2,
            unstake_amount : v3,
            unstake_weigth : v5,
            end_time       : v7,
        };
        0x2::event::emit<UnstakeEvent<T0, T1>>(v9);
        (0x2::balance::split<T0>(&mut arg1.staked, v3), 0x2::balance::split<T1>(&mut arg1.pool, v0))
    }

    // decompiled from Move bytecode v6
}

