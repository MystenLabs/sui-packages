module 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::well {
    struct Well<phantom T0> has store, key {
        id: 0x2::object::UID,
        shared_pool: 0x2::balance::Balance<T0>,
        reserve: 0x2::balance::Balance<T0>,
        staked: 0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>,
        total_weight: u64,
        current_s: u128,
    }

    struct StakedBKT<phantom T0> has store, key {
        id: 0x2::object::UID,
        stake_amount: u64,
        start_s: u128,
        stake_weight: u64,
        lock_until: u64,
    }

    struct WELL has drop {
        dummy_field: bool,
    }

    public(friend) fun new<T0>(arg0: &mut 0x2::tx_context::TxContext) : Well<T0> {
        Well<T0>{
            id           : 0x2::object::new(arg0),
            shared_pool  : 0x2::balance::zero<T0>(),
            reserve      : 0x2::balance::zero<T0>(),
            staked       : 0x2::balance::zero<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>(),
            total_weight : 0,
            current_s    : 0,
        }
    }

    public fun claim<T0>(arg0: &mut Well<T0>, arg1: &mut StakedBKT<T0>) : 0x2::balance::Balance<T0> {
        let v0 = (0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::math::mul_factor_u128((arg1.stake_weight as u128), arg0.current_s - arg1.start_s, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::constants::distribution_precision()) as u64);
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::well_events::emit_claim<T0>(v0);
        arg1.start_s = arg0.current_s;
        0x2::balance::split<T0>(&mut arg0.shared_pool, v0)
    }

    public fun airdrop<T0>(arg0: &mut Well<T0>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.shared_pool, arg1);
    }

    public fun collect_fee<T0>(arg0: &mut Well<T0>, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x2::balance::value<T0>(&arg1);
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::well_events::emit_collect_fee<T0>(v0);
        if (arg0.total_weight > 0 && v0 >= 100) {
            0x2::balance::join<T0>(&mut arg0.reserve, 0x2::balance::split<T0>(&mut arg1, v0 / 100));
            0x2::balance::join<T0>(&mut arg0.shared_pool, arg1);
            arg0.current_s = arg0.current_s + 0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::math::mul_factor_u128((0x2::balance::value<T0>(&arg1) as u128), 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::constants::distribution_precision(), (arg0.total_weight as u128));
        } else {
            0x2::balance::join<T0>(&mut arg0.reserve, arg1);
        };
    }

    public fun collect_fee_from<T0>(arg0: &mut Well<T0>, arg1: 0x2::balance::Balance<T0>, arg2: 0x1::ascii::String) {
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::well_events::emit_collect_fee_from<T0>(&arg1, 0x1::ascii::into_bytes(arg2));
        collect_fee<T0>(arg0, arg1);
    }

    fun compute_weight(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 >= 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::constants::min_lock_time() && arg1 <= 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::constants::max_lock_time(), 2);
        let v0 = 0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::math::mul_factor(arg0, arg1, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::constants::max_lock_time());
        assert!(v0 > 0, 3);
        v0
    }

    public fun force_unstake<T0>(arg0: &0x2::clock::Clock, arg1: &mut Well<T0>, arg2: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BktTreasury, arg3: StakedBKT<T0>) : (0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>, 0x2::balance::Balance<T0>) {
        let v0 = get_reward_amount<T0>(arg1, &arg3);
        let v1 = 0x2::clock::timestamp_ms(arg0);
        let v2 = get_token_penalty_amount<T0>(&arg3, v1);
        let StakedBKT {
            id           : v3,
            stake_amount : v4,
            start_s      : _,
            stake_weight : v6,
            lock_until   : v7,
        } = arg3;
        assert!(v1 < v7, 1);
        0x2::object::delete(v3);
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::well_events::emit_penalty<T0>(v2);
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::collect_bkt(arg2, 0x2::balance::split<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>(&mut arg1.staked, v2));
        arg1.total_weight = arg1.total_weight - v6;
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::well_events::emit_unstake<T0>(v4, v6, v0);
        (0x2::balance::split<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>(&mut arg1.staked, v4 - v2), 0x2::balance::split<T0>(&mut arg1.shared_pool, v0))
    }

    public fun get_reward_amount<T0>(arg0: &Well<T0>, arg1: &StakedBKT<T0>) : u64 {
        (0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::math::mul_factor_u128((arg1.stake_weight as u128), arg0.current_s - arg1.start_s, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::constants::distribution_precision()) as u64)
    }

    public fun get_token_lock_until<T0>(arg0: &StakedBKT<T0>) : u64 {
        arg0.lock_until
    }

    public fun get_token_penalty_amount<T0>(arg0: &StakedBKT<T0>, arg1: u64) : u64 {
        if (arg1 >= arg0.lock_until) {
            0
        } else {
            0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::math::mul_factor(arg0.stake_amount, 0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::math::mul_factor(arg0.stake_amount, arg0.lock_until - arg1, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::constants::max_lock_time()), arg0.stake_weight)
        }
    }

    public fun get_token_stake_amount<T0>(arg0: &StakedBKT<T0>) : u64 {
        arg0.stake_amount
    }

    public fun get_token_stake_weight<T0>(arg0: &StakedBKT<T0>) : u64 {
        arg0.stake_weight
    }

    public fun get_well_pool_balance<T0>(arg0: &Well<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.shared_pool)
    }

    public fun get_well_reserve_balance<T0>(arg0: &Well<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.reserve)
    }

    public fun get_well_staked_balance<T0>(arg0: &Well<T0>) : u64 {
        0x2::balance::value<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>(&arg0.staked)
    }

    public fun get_well_total_weight<T0>(arg0: &Well<T0>) : u64 {
        arg0.total_weight
    }

    fun init(arg0: WELL, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<WELL>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun stake<T0>(arg0: &0x2::clock::Clock, arg1: &mut Well<T0>, arg2: 0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : StakedBKT<T0> {
        let v0 = 0x2::balance::value<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>(&arg2);
        0x2::balance::join<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>(&mut arg1.staked, arg2);
        let v1 = compute_weight(v0, arg3);
        arg1.total_weight = arg1.total_weight + v1;
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::well_events::emit_stake<T0>(v0, v1, arg3);
        StakedBKT<T0>{
            id           : 0x2::object::new(arg4),
            stake_amount : v0,
            start_s      : arg1.current_s,
            stake_weight : v1,
            lock_until   : 0x2::clock::timestamp_ms(arg0) + arg3,
        }
    }

    public fun unstake<T0>(arg0: &0x2::clock::Clock, arg1: &mut Well<T0>, arg2: StakedBKT<T0>) : (0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>, 0x2::balance::Balance<T0>) {
        let v0 = get_reward_amount<T0>(arg1, &arg2);
        let StakedBKT {
            id           : v1,
            stake_amount : v2,
            start_s      : _,
            stake_weight : v4,
            lock_until   : v5,
        } = arg2;
        assert!(0x2::clock::timestamp_ms(arg0) >= v5, 0);
        0x2::object::delete(v1);
        arg1.total_weight = arg1.total_weight - v4;
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::well_events::emit_unstake<T0>(v2, v4, v0);
        (0x2::balance::split<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>(&mut arg1.staked, v2), 0x2::balance::split<T0>(&mut arg1.shared_pool, v0))
    }

    public fun withdraw_reserve<T0>(arg0: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BktAdminCap, arg1: &mut Well<T0>) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(&mut arg1.reserve, 0x2::balance::value<T0>(&arg1.reserve))
    }

    // decompiled from Move bytecode v6
}

