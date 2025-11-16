module 0x1063b19905b541b7b365690ab6c8ac0277a066046bf8f069aeb2cfc93a64965c::staking_pool {
    struct StakingPool has key {
        id: 0x2::object::UID,
        total_staked: 0x2::balance::Balance<0xdb343621b92be1a6ae51d60c5aaa9dc9ab56f3618f2fe1524688f3bbe834aa31::nest::NEST>,
        reward_pool: 0x2::balance::Balance<0xdb343621b92be1a6ae51d60c5aaa9dc9ab56f3618f2fe1524688f3bbe834aa31::nest::NEST>,
        stakers: 0x2::table::Table<address, StakerInfo>,
        total_stakers: u64,
        total_rewards_distributed: u64,
    }

    struct StakerInfo has drop, store {
        amount_staked: u64,
        stake_timestamp: u64,
        pending_rewards: u64,
        last_reward_update: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun claim_rewards(arg0: &mut StakingPool, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        assert!(0x2::table::contains<address, StakerInfo>(&arg0.stakers, v0), 1);
        update_pending_rewards(arg0, v0, v1);
        let v2 = 0x2::table::borrow_mut<address, StakerInfo>(&mut arg0.stakers, v0);
        let v3 = v2.pending_rewards;
        assert!(v3 > 0, 4);
        v2.pending_rewards = 0;
        v2.last_reward_update = v1;
        arg0.total_rewards_distributed = arg0.total_rewards_distributed + v3;
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdb343621b92be1a6ae51d60c5aaa9dc9ab56f3618f2fe1524688f3bbe834aa31::nest::NEST>>(0x2::coin::from_balance<0xdb343621b92be1a6ae51d60c5aaa9dc9ab56f3618f2fe1524688f3bbe834aa31::nest::NEST>(0x2::balance::split<0xdb343621b92be1a6ae51d60c5aaa9dc9ab56f3618f2fe1524688f3bbe834aa31::nest::NEST>(&mut arg0.reward_pool, v3), arg2), v0);
    }

    public fun deposit_rewards(arg0: &mut StakingPool, arg1: 0x2::coin::Coin<0xdb343621b92be1a6ae51d60c5aaa9dc9ab56f3618f2fe1524688f3bbe834aa31::nest::NEST>) {
        0x2::balance::join<0xdb343621b92be1a6ae51d60c5aaa9dc9ab56f3618f2fe1524688f3bbe834aa31::nest::NEST>(&mut arg0.reward_pool, 0x2::coin::into_balance<0xdb343621b92be1a6ae51d60c5aaa9dc9ab56f3618f2fe1524688f3bbe834aa31::nest::NEST>(arg1));
    }

    public fun fund_rewards(arg0: &mut StakingPool, arg1: 0x2::coin::Coin<0xdb343621b92be1a6ae51d60c5aaa9dc9ab56f3618f2fe1524688f3bbe834aa31::nest::NEST>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xdb343621b92be1a6ae51d60c5aaa9dc9ab56f3618f2fe1524688f3bbe834aa31::nest::NEST>(&mut arg0.reward_pool, 0x2::coin::into_balance<0xdb343621b92be1a6ae51d60c5aaa9dc9ab56f3618f2fe1524688f3bbe834aa31::nest::NEST>(arg1));
    }

    public fun get_pending_rewards(arg0: &StakingPool, arg1: address) : u64 {
        if (!0x2::table::contains<address, StakerInfo>(&arg0.stakers, arg1)) {
            return 0
        };
        0x2::table::borrow<address, StakerInfo>(&arg0.stakers, arg1).pending_rewards
    }

    public fun get_reward_pool_balance(arg0: &StakingPool) : u64 {
        0x2::balance::value<0xdb343621b92be1a6ae51d60c5aaa9dc9ab56f3618f2fe1524688f3bbe834aa31::nest::NEST>(&arg0.reward_pool)
    }

    public fun get_staked_amount(arg0: &StakingPool, arg1: address) : u64 {
        if (!0x2::table::contains<address, StakerInfo>(&arg0.stakers, arg1)) {
            return 0
        };
        0x2::table::borrow<address, StakerInfo>(&arg0.stakers, arg1).amount_staked
    }

    public fun get_total_staked(arg0: &StakingPool) : u64 {
        0x2::balance::value<0xdb343621b92be1a6ae51d60c5aaa9dc9ab56f3618f2fe1524688f3bbe834aa31::nest::NEST>(&arg0.total_staked)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = StakingPool{
            id                        : 0x2::object::new(arg0),
            total_staked              : 0x2::balance::zero<0xdb343621b92be1a6ae51d60c5aaa9dc9ab56f3618f2fe1524688f3bbe834aa31::nest::NEST>(),
            reward_pool               : 0x2::balance::zero<0xdb343621b92be1a6ae51d60c5aaa9dc9ab56f3618f2fe1524688f3bbe834aa31::nest::NEST>(),
            stakers                   : 0x2::table::new<address, StakerInfo>(arg0),
            total_stakers             : 0,
            total_rewards_distributed : 0,
        };
        0x2::transfer::share_object<StakingPool>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun stake(arg0: &mut StakingPool, arg1: 0x2::coin::Coin<0xdb343621b92be1a6ae51d60c5aaa9dc9ab56f3618f2fe1524688f3bbe834aa31::nest::NEST>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        if (0x2::table::contains<address, StakerInfo>(&arg0.stakers, v0)) {
            update_pending_rewards(arg0, v0, v1);
            let v2 = 0x2::table::borrow_mut<address, StakerInfo>(&mut arg0.stakers, v0);
            v2.amount_staked = v2.amount_staked + 0x2::coin::value<0xdb343621b92be1a6ae51d60c5aaa9dc9ab56f3618f2fe1524688f3bbe834aa31::nest::NEST>(&arg1);
            v2.last_reward_update = v1;
        } else {
            let v3 = StakerInfo{
                amount_staked      : 0x2::coin::value<0xdb343621b92be1a6ae51d60c5aaa9dc9ab56f3618f2fe1524688f3bbe834aa31::nest::NEST>(&arg1),
                stake_timestamp    : v1,
                pending_rewards    : 0,
                last_reward_update : v1,
            };
            0x2::table::add<address, StakerInfo>(&mut arg0.stakers, v0, v3);
            arg0.total_stakers = arg0.total_stakers + 1;
        };
        0x2::balance::join<0xdb343621b92be1a6ae51d60c5aaa9dc9ab56f3618f2fe1524688f3bbe834aa31::nest::NEST>(&mut arg0.total_staked, 0x2::coin::into_balance<0xdb343621b92be1a6ae51d60c5aaa9dc9ab56f3618f2fe1524688f3bbe834aa31::nest::NEST>(arg1));
    }

    public fun unstake(arg0: &mut StakingPool, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        assert!(0x2::table::contains<address, StakerInfo>(&arg0.stakers, v0), 1);
        let v2 = 0x2::table::borrow<address, StakerInfo>(&arg0.stakers, v0);
        assert!(v1 >= v2.stake_timestamp + 259200000, 3);
        assert!(v2.amount_staked >= arg1, 2);
        update_pending_rewards(arg0, v0, v1);
        let v3 = 0x2::table::borrow_mut<address, StakerInfo>(&mut arg0.stakers, v0);
        let v4 = v3.pending_rewards;
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdb343621b92be1a6ae51d60c5aaa9dc9ab56f3618f2fe1524688f3bbe834aa31::nest::NEST>>(0x2::coin::from_balance<0xdb343621b92be1a6ae51d60c5aaa9dc9ab56f3618f2fe1524688f3bbe834aa31::nest::NEST>(0x2::balance::split<0xdb343621b92be1a6ae51d60c5aaa9dc9ab56f3618f2fe1524688f3bbe834aa31::nest::NEST>(&mut arg0.reward_pool, v4), arg3), v0);
            arg0.total_rewards_distributed = arg0.total_rewards_distributed + v4;
            v3.pending_rewards = 0;
        };
        v3.amount_staked = v3.amount_staked - arg1;
        if (v3.amount_staked == 0) {
            0x2::table::remove<address, StakerInfo>(&mut arg0.stakers, v0);
            arg0.total_stakers = arg0.total_stakers - 1;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdb343621b92be1a6ae51d60c5aaa9dc9ab56f3618f2fe1524688f3bbe834aa31::nest::NEST>>(0x2::coin::from_balance<0xdb343621b92be1a6ae51d60c5aaa9dc9ab56f3618f2fe1524688f3bbe834aa31::nest::NEST>(0x2::balance::split<0xdb343621b92be1a6ae51d60c5aaa9dc9ab56f3618f2fe1524688f3bbe834aa31::nest::NEST>(&mut arg0.total_staked, arg1), arg3), v0);
    }

    fun update_pending_rewards(arg0: &mut StakingPool, arg1: address, arg2: u64) {
        let v0 = 0x2::table::borrow_mut<address, StakerInfo>(&mut arg0.stakers, arg1);
        let v1 = 0x2::balance::value<0xdb343621b92be1a6ae51d60c5aaa9dc9ab56f3618f2fe1524688f3bbe834aa31::nest::NEST>(&arg0.total_staked);
        if (v1 == 0) {
            return
        };
        let v2 = 0x2::balance::value<0xdb343621b92be1a6ae51d60c5aaa9dc9ab56f3618f2fe1524688f3bbe834aa31::nest::NEST>(&arg0.reward_pool);
        if (v2 > 0 && v0.amount_staked > 0) {
            let v3 = (((v0.amount_staked as u128) * (v2 as u128) / (v1 as u128)) as u64);
            if (v3 > 0) {
                v0.pending_rewards = v0.pending_rewards + v3;
            };
        };
        v0.last_reward_update = arg2;
    }

    // decompiled from Move bytecode v6
}

