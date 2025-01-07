module 0x3d915ac1ebf76cb86d4e8dae76deb74d7997621da25b986f31e7f4a092316af3::farm {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct KriyaFarm<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        unharvested_rewards: 0x2::balance::Balance<T2>,
        reward_amount: u64,
        reward_interval: u64,
        harvested_rewards: 0x2::balance::Balance<T2>,
        staked: 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::KriyaLPToken<T0, T1>,
        total_weight: u64,
        cumulative_unit: u128,
        last_harvest_time: u64,
        min_lock_time: u64,
        max_lock_time: u64,
    }

    struct StakedPosition<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        farm_id: 0x2::object::ID,
        stake_amount: u64,
        start_unit: u128,
        stake_weight: u64,
        lock_until: u64,
    }

    struct StakeEvent<phantom T0, phantom T1, phantom T2> has copy, drop {
        farm_id: 0x2::object::ID,
        stake_amount: u64,
        stake_weight: u64,
        lock_time: u64,
        start_time: u64,
    }

    struct ClaimEvent<phantom T0, phantom T1, phantom T2> has copy, drop {
        farm_id: 0x2::object::ID,
        reward_amount: u64,
        claim_time: u64,
    }

    struct UnstakeEvent<phantom T0, phantom T1, phantom T2> has copy, drop {
        farm_id: 0x2::object::ID,
        unstake_amount: u64,
        unstake_weight: u64,
        end_time: u64,
    }

    public fun new<T0, T1, T2>(arg0: &AdminCap, arg1: 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::KriyaLPToken<T0, T1>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : KriyaFarm<T0, T1, T2> {
        KriyaFarm<T0, T1, T2>{
            id                  : 0x2::object::new(arg7),
            unharvested_rewards : 0x2::balance::zero<T2>(),
            reward_amount       : arg2,
            reward_interval     : arg3,
            harvested_rewards   : 0x2::balance::zero<T2>(),
            staked              : arg1,
            total_weight        : 0,
            cumulative_unit     : 0,
            last_harvest_time   : arg6,
            min_lock_time       : arg4,
            max_lock_time       : arg5,
        }
    }

    public fun airdrop<T0, T1, T2>(arg0: &mut KriyaFarm<T0, T1, T2>, arg1: 0x2::balance::Balance<T2>) {
        collect_rewards<T0, T1, T2>(arg0, arg1);
    }

    public fun claim<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut KriyaFarm<T0, T1, T2>, arg2: &mut StakedPosition<T0, T1, T2>) : 0x2::balance::Balance<T2> {
        harvest_rewards<T0, T1, T2>(arg1, arg0);
        let v0 = arg2.farm_id;
        assert!(0x2::object::id<KriyaFarm<T0, T1, T2>>(arg1) == v0, 1);
        let v1 = (0x3d915ac1ebf76cb86d4e8dae76deb74d7997621da25b986f31e7f4a092316af3::math::mul_factor_u128((arg2.stake_weight as u128), arg1.cumulative_unit - arg2.start_unit, 18446744073709551616) as u64);
        let v2 = ClaimEvent<T0, T1, T2>{
            farm_id       : v0,
            reward_amount : v1,
            claim_time    : 0x2::clock::timestamp_ms(arg0),
        };
        0x2::event::emit<ClaimEvent<T0, T1, T2>>(v2);
        arg2.start_unit = arg1.cumulative_unit;
        0x2::balance::split<T2>(&mut arg1.harvested_rewards, v1)
    }

    public entry fun claim_<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut KriyaFarm<T0, T1, T2>, arg2: &mut StakedPosition<T0, T1, T2>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = claim<T0, T1, T2>(arg0, arg1, arg2);
        if (0x2::balance::value<T2>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v0, arg3), 0x2::tx_context::sender(arg3));
        } else {
            0x2::balance::destroy_zero<T2>(v0);
        };
    }

    fun collect_rewards<T0, T1, T2>(arg0: &mut KriyaFarm<T0, T1, T2>, arg1: 0x2::balance::Balance<T2>) {
        let v0 = 0x2::balance::value<T2>(&arg1);
        if (v0 > 0) {
            0x2::balance::join<T2>(&mut arg0.harvested_rewards, arg1);
            arg0.cumulative_unit = arg0.cumulative_unit + 0x3d915ac1ebf76cb86d4e8dae76deb74d7997621da25b986f31e7f4a092316af3::math::mul_factor_u128((v0 as u128), 18446744073709551616, (arg0.total_weight as u128));
        } else {
            0x2::balance::destroy_zero<T2>(arg1);
        };
    }

    public fun get_cumulative_unit<T0, T1, T2>(arg0: &KriyaFarm<T0, T1, T2>) : u128 {
        arg0.cumulative_unit
    }

    public fun get_harvested_rewards_balance<T0, T1, T2>(arg0: &KriyaFarm<T0, T1, T2>) : u64 {
        0x2::balance::value<T2>(&arg0.harvested_rewards)
    }

    public fun get_last_harvest_time<T0, T1, T2>(arg0: &KriyaFarm<T0, T1, T2>) : u64 {
        arg0.last_harvest_time
    }

    public fun get_lock_time_range<T0, T1, T2>(arg0: &KriyaFarm<T0, T1, T2>) : (u64, u64) {
        (arg0.min_lock_time, arg0.max_lock_time)
    }

    public fun get_position_lock_until<T0, T1, T2>(arg0: &StakedPosition<T0, T1, T2>) : u64 {
        arg0.lock_until
    }

    public fun get_position_stake_amount<T0, T1, T2>(arg0: &StakedPosition<T0, T1, T2>) : u64 {
        arg0.stake_amount
    }

    public fun get_position_stake_weight<T0, T1, T2>(arg0: &StakedPosition<T0, T1, T2>) : u64 {
        arg0.stake_weight
    }

    public fun get_reward_amount<T0, T1, T2>(arg0: &KriyaFarm<T0, T1, T2>, arg1: &StakedPosition<T0, T1, T2>, arg2: u64) : u64 {
        (0x3d915ac1ebf76cb86d4e8dae76deb74d7997621da25b986f31e7f4a092316af3::math::mul_factor_u128((arg1.stake_weight as u128), arg0.cumulative_unit + 0x3d915ac1ebf76cb86d4e8dae76deb74d7997621da25b986f31e7f4a092316af3::math::mul_factor_u128((get_virtual_released_amount<T0, T1, T2>(arg0, arg2) as u128), 18446744073709551616, (arg0.total_weight as u128)) - arg1.start_unit, 18446744073709551616) as u64)
    }

    public fun get_reward_rate<T0, T1, T2>(arg0: &KriyaFarm<T0, T1, T2>) : (u64, u64) {
        (arg0.reward_amount, arg0.reward_interval)
    }

    public fun get_staked_balance<T0, T1, T2>(arg0: &KriyaFarm<T0, T1, T2>) : u64 {
        0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::lp_token_value<T0, T1>(&arg0.staked)
    }

    public fun get_total_weight<T0, T1, T2>(arg0: &KriyaFarm<T0, T1, T2>) : u64 {
        arg0.total_weight
    }

    public fun get_unharvested_rewards_balance<T0, T1, T2>(arg0: &KriyaFarm<T0, T1, T2>) : u64 {
        0x2::balance::value<T2>(&arg0.unharvested_rewards)
    }

    public fun get_virtual_released_amount<T0, T1, T2>(arg0: &KriyaFarm<T0, T1, T2>, arg1: u64) : u64 {
        if (arg1 > arg0.last_harvest_time) {
            let v1 = 0x3d915ac1ebf76cb86d4e8dae76deb74d7997621da25b986f31e7f4a092316af3::math::mul_factor(arg0.reward_amount, arg1 - arg0.last_harvest_time, arg0.reward_interval);
            let v2 = v1;
            let v3 = get_unharvested_rewards_balance<T0, T1, T2>(arg0);
            if (v1 > v3) {
                v2 = v3;
            };
            v2
        } else {
            0
        }
    }

    fun harvest_rewards<T0, T1, T2>(arg0: &mut KriyaFarm<T0, T1, T2>, arg1: &0x2::clock::Clock) {
        if (get_unharvested_rewards_balance<T0, T1, T2>(arg0) > 0) {
            let v0 = release_rewards<T0, T1, T2>(arg0, arg1);
            collect_rewards<T0, T1, T2>(arg0, v0);
        } else {
            let v1 = 0x2::clock::timestamp_ms(arg1);
            if (v1 > arg0.last_harvest_time) {
                arg0.last_harvest_time = v1;
            };
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun new_<T0, T1, T2>(arg0: &AdminCap, arg1: 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::KriyaLPToken<T0, T1>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<KriyaFarm<T0, T1, T2>>(new<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7));
    }

    fun release_rewards<T0, T1, T2>(arg0: &mut KriyaFarm<T0, T1, T2>, arg1: &0x2::clock::Clock) : 0x2::balance::Balance<T2> {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 > arg0.last_harvest_time) {
            let v2 = 0x3d915ac1ebf76cb86d4e8dae76deb74d7997621da25b986f31e7f4a092316af3::math::mul_factor(arg0.reward_amount, v0 - arg0.last_harvest_time, arg0.reward_interval);
            let v3 = v2;
            let v4 = get_unharvested_rewards_balance<T0, T1, T2>(arg0);
            if (v2 > v4) {
                v3 = v4;
            };
            arg0.last_harvest_time = v0;
            0x2::balance::split<T2>(&mut arg0.unharvested_rewards, v3)
        } else {
            0x2::balance::zero<T2>()
        }
    }

    public fun stake<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut KriyaFarm<T0, T1, T2>, arg2: 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::KriyaLPToken<T0, T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : StakedPosition<T0, T1, T2> {
        harvest_rewards<T0, T1, T2>(arg1, arg0);
        let v0 = 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::lp_token_value<T0, T1>(&arg2);
        0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::lp_token_join<T0, T1>(&mut arg1.staked, arg2);
        let v1 = 0x3d915ac1ebf76cb86d4e8dae76deb74d7997621da25b986f31e7f4a092316af3::math::compute_weight(v0, arg3, arg1.min_lock_time, arg1.max_lock_time);
        arg1.total_weight = arg1.total_weight + v1;
        let v2 = 0x2::object::id<KriyaFarm<T0, T1, T2>>(arg1);
        let v3 = 0x2::clock::timestamp_ms(arg0);
        let v4 = if (arg3 == 0) {
            0
        } else {
            v3
        };
        let v5 = StakeEvent<T0, T1, T2>{
            farm_id      : v2,
            stake_amount : v0,
            stake_weight : v1,
            lock_time    : arg3,
            start_time   : v4,
        };
        0x2::event::emit<StakeEvent<T0, T1, T2>>(v5);
        let v6 = if (arg3 == 0) {
            0
        } else {
            v3 + arg3
        };
        StakedPosition<T0, T1, T2>{
            id           : 0x2::object::new(arg4),
            farm_id      : v2,
            stake_amount : v0,
            start_unit   : arg1.cumulative_unit,
            stake_weight : v1,
            lock_until   : v6,
        }
    }

    public entry fun stake_<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut KriyaFarm<T0, T1, T2>, arg2: 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::KriyaLPToken<T0, T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = stake<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<StakedPosition<T0, T1, T2>>(v0, 0x2::tx_context::sender(arg4));
    }

    public fun supply<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut KriyaFarm<T0, T1, T2>, arg2: 0x2::balance::Balance<T2>) {
        harvest_rewards<T0, T1, T2>(arg1, arg0);
        0x2::balance::join<T2>(&mut arg1.unharvested_rewards, arg2);
    }

    public entry fun supply_<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut KriyaFarm<T0, T1, T2>, arg2: 0x2::coin::Coin<T2>) {
        supply<T0, T1, T2>(arg0, arg1, 0x2::coin::into_balance<T2>(arg2));
    }

    public fun tune<T0, T1, T2>(arg0: &AdminCap, arg1: &mut KriyaFarm<T0, T1, T2>, arg2: 0x2::balance::Balance<T2>) {
        0x2::balance::join<T2>(&mut arg1.harvested_rewards, arg2);
    }

    public entry fun tune_<T0, T1, T2>(arg0: &AdminCap, arg1: &mut KriyaFarm<T0, T1, T2>, arg2: 0x2::coin::Coin<T2>) {
        tune<T0, T1, T2>(arg0, arg1, 0x2::coin::into_balance<T2>(arg2));
    }

    public fun unstake<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut KriyaFarm<T0, T1, T2>, arg2: StakedPosition<T0, T1, T2>, arg3: &mut 0x2::tx_context::TxContext) : (0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::KriyaLPToken<T0, T1>, 0x2::balance::Balance<T2>) {
        harvest_rewards<T0, T1, T2>(arg1, arg0);
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let v1 = &mut arg2;
        let v2 = claim<T0, T1, T2>(arg0, arg1, v1);
        let StakedPosition {
            id           : v3,
            farm_id      : v4,
            stake_amount : v5,
            start_unit   : _,
            stake_weight : v7,
            lock_until   : v8,
        } = arg2;
        assert!(0x2::object::id<KriyaFarm<T0, T1, T2>>(arg1) == v4, 1);
        assert!(v0 >= v8, 0);
        0x2::object::delete(v3);
        arg1.total_weight = arg1.total_weight - v7;
        let v9 = UnstakeEvent<T0, T1, T2>{
            farm_id        : v4,
            unstake_amount : v5,
            unstake_weight : v7,
            end_time       : v0,
        };
        0x2::event::emit<UnstakeEvent<T0, T1, T2>>(v9);
        (0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::lp_token_split<T0, T1>(&mut arg1.staked, v5, arg3), v2)
    }

    public entry fun unstake_<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut KriyaFarm<T0, T1, T2>, arg2: StakedPosition<T0, T1, T2>, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = unstake<T0, T1, T2>(arg0, arg1, arg2, arg3);
        let v2 = v1;
        let v3 = 0x2::tx_context::sender(arg3);
        0x2::transfer::public_transfer<0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::KriyaLPToken<T0, T1>>(v0, v3);
        if (0x2::balance::value<T2>(&v2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v2, arg3), v3);
        } else {
            0x2::balance::destroy_zero<T2>(v2);
        };
    }

    public fun update_reward_rate<T0, T1, T2>(arg0: &AdminCap, arg1: &0x2::clock::Clock, arg2: &mut KriyaFarm<T0, T1, T2>, arg3: u64, arg4: u64) {
        harvest_rewards<T0, T1, T2>(arg2, arg1);
        arg2.reward_amount = arg3;
        arg2.reward_interval = arg4;
    }

    // decompiled from Move bytecode v6
}

