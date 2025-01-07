module 0xfb85d5e15c854d310e42d57fcc5269108c55c73797e2e2658fdb973756f791b5::pool {
    struct Pool has store, key {
        id: 0x2::object::UID,
        ended_at_sec: u64,
        alloc_point: u64,
        total_token_staked: u64,
        acc_reward_per_share: u256,
        last_reward_at_sec: u64,
        is_emergency: bool,
    }

    fun new(arg0: &mut 0x2::tx_context::TxContext) : Pool {
        Pool{
            id                   : 0x2::object::new(arg0),
            ended_at_sec         : 0,
            alloc_point          : 0,
            total_token_staked   : 0,
            acc_reward_per_share : 0,
            last_reward_at_sec   : 0,
            is_emergency         : false,
        }
    }

    public fun acc_reward_per_share(arg0: &Pool) : u256 {
        arg0.acc_reward_per_share
    }

    public fun alloc_point(arg0: &Pool) : u64 {
        arg0.alloc_point
    }

    public fun calc_pending_rewards(arg0: &Pool, arg1: &0xfb85d5e15c854d310e42d57fcc5269108c55c73797e2e2658fdb973756f791b5::position::Position) : u64 {
        ((calc_rewards_for(arg0, arg1) - 0xfb85d5e15c854d310e42d57fcc5269108c55c73797e2e2658fdb973756f791b5::position::reward_debt(arg1)) as u64)
    }

    public fun calc_rewards_for(arg0: &Pool, arg1: &0xfb85d5e15c854d310e42d57fcc5269108c55c73797e2e2658fdb973756f791b5::position::Position) : u256 {
        (0xfb85d5e15c854d310e42d57fcc5269108c55c73797e2e2658fdb973756f791b5::position::value(arg1) as u256) * arg0.acc_reward_per_share / 1000000000000
    }

    public(friend) fun create_pool(arg0: u64, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : Pool {
        let v0 = 0xfb85d5e15c854d310e42d57fcc5269108c55c73797e2e2658fdb973756f791b5::utils::to_seconds(0x2::clock::timestamp_ms(arg3));
        let v1 = new(arg4);
        v1.ended_at_sec = arg1;
        v1.alloc_point = arg2;
        let v2 = if (v0 > arg0) {
            v0
        } else {
            arg0
        };
        v1.last_reward_at_sec = v2;
        v1
    }

    public(friend) fun decrease_staked_amount(arg0: &mut Pool, arg1: u64) {
        assert!(arg0.total_token_staked >= arg1, 0);
        arg0.total_token_staked = arg0.total_token_staked - arg1;
    }

    public fun get_multiplier(arg0: &Pool, arg1: u64) : u64 {
        let v0 = arg0.last_reward_at_sec;
        if (v0 >= arg0.ended_at_sec) {
            return 0
        };
        if (arg1 > arg0.ended_at_sec) {
            arg1 = arg0.ended_at_sec;
        };
        arg1 - v0
    }

    public(friend) fun increase_staked_amount(arg0: &mut Pool, arg1: u64) {
        arg0.total_token_staked = arg0.total_token_staked + arg1;
    }

    public fun is_emergency(arg0: &Pool) : bool {
        arg0.is_emergency
    }

    public fun last_reward_at(arg0: &Pool) : u64 {
        arg0.last_reward_at_sec
    }

    public fun pending_reward(arg0: &Pool, arg1: &0xfb85d5e15c854d310e42d57fcc5269108c55c73797e2e2658fdb973756f791b5::position::Position, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) : u64 {
        let v0 = 0xfb85d5e15c854d310e42d57fcc5269108c55c73797e2e2658fdb973756f791b5::utils::to_seconds(0x2::clock::timestamp_ms(arg4));
        let v1 = arg0.acc_reward_per_share;
        let v2 = v1;
        if (v0 > arg0.last_reward_at_sec && arg0.total_token_staked != 0) {
            v2 = v1 + ((get_multiplier(arg0, v0) * arg3 * arg0.alloc_point / arg2) as u256) * 1000000000000 / (arg0.total_token_staked as u256);
        };
        (((0xfb85d5e15c854d310e42d57fcc5269108c55c73797e2e2658fdb973756f791b5::position::value(arg1) as u256) * v2 / 1000000000000 - 0xfb85d5e15c854d310e42d57fcc5269108c55c73797e2e2658fdb973756f791b5::position::reward_debt(arg1)) as u64)
    }

    public(friend) fun set_alloc_point(arg0: &mut Pool, arg1: u64) {
        arg0.alloc_point = arg1;
    }

    public(friend) fun set_emergency(arg0: &mut Pool) {
        arg0.is_emergency = true;
    }

    public fun total_token_staked(arg0: &Pool) : u64 {
        arg0.total_token_staked
    }

    public fun uid(arg0: &Pool) : &0x2::object::UID {
        &arg0.id
    }

    public fun uid_mut(arg0: &mut Pool) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public(friend) fun update_pool(arg0: &mut Pool, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) {
        let v0 = 0xfb85d5e15c854d310e42d57fcc5269108c55c73797e2e2658fdb973756f791b5::utils::to_seconds(0x2::clock::timestamp_ms(arg3));
        if (v0 <= arg0.last_reward_at_sec) {
            return
        };
        if (arg0.total_token_staked == 0) {
            arg0.last_reward_at_sec = v0;
            return
        };
        arg0.acc_reward_per_share = arg0.acc_reward_per_share + ((get_multiplier(arg0, v0) * arg2 * arg0.alloc_point / arg1) as u256) * 1000000000000 / (arg0.total_token_staked as u256);
        arg0.last_reward_at_sec = v0;
    }

    // decompiled from Move bytecode v6
}

