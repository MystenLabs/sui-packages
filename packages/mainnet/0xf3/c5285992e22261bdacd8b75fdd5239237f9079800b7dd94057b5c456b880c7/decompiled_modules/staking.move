module 0xf3c5285992e22261bdacd8b75fdd5239237f9079800b7dd94057b5c456b880c7::staking {
    struct StakingPool has store, key {
        id: 0x2::object::UID,
        admin: address,
        token_state_id: address,
        active: bool,
        total_staked: u64,
        reward_pool: 0x2::balance::Balance<0xf3c5285992e22261bdacd8b75fdd5239237f9079800b7dd94057b5c456b880c7::limen_token::LIMEN_TOKEN>,
        last_reward_time: u64,
        current_apr: u64,
        staked_balance: 0x2::balance::Balance<0xf3c5285992e22261bdacd8b75fdd5239237f9079800b7dd94057b5c456b880c7::limen_token::LIMEN_TOKEN>,
        stakers: 0x2::table::Table<address, StakerInfo>,
    }

    struct StakerInfo has drop, store {
        staked_amount: u64,
        stake_start: u64,
        lock_end: u64,
        pending_rewards: u64,
        last_claim: u64,
        multiplier: u64,
    }

    struct StakeReceipt has store, key {
        id: 0x2::object::UID,
        owner: address,
        amount: u64,
        lock_end: u64,
        multiplier: u64,
    }

    struct Staked has copy, drop {
        user: address,
        amount: u64,
        multiplier: u64,
        lock_end: u64,
    }

    struct Unstaked has copy, drop {
        user: address,
        amount: u64,
        rewards: u64,
    }

    struct RewardsClaimed has copy, drop {
        user: address,
        amount: u64,
    }

    struct APRUpdated has copy, drop {
        old_apr: u64,
        new_apr: u64,
    }

    fun calculate_multiplier(arg0: u64) : u64 {
        if (arg0 >= 365) {
            300
        } else if (arg0 >= 180) {
            250
        } else if (arg0 >= 90) {
            200
        } else if (arg0 >= 60) {
            150
        } else {
            100
        }
    }

    public fun calculate_pending_rewards(arg0: &StakingPool, arg1: address, arg2: u64) : u64 {
        if (!0x2::table::contains<address, StakerInfo>(&arg0.stakers, arg1)) {
            return 0
        };
        calculate_pending_rewards_from_info(0x2::table::borrow<address, StakerInfo>(&arg0.stakers, arg1), arg0.current_apr, arg2)
    }

    fun calculate_pending_rewards_from_info(arg0: &StakerInfo, arg1: u64, arg2: u64) : u64 {
        let v0 = arg2 - arg0.last_claim;
        if (v0 == 0) {
            return arg0.pending_rewards
        };
        arg0.pending_rewards + (((arg0.staked_amount as u128) * (arg1 as u128) * (v0 as u128) / 3153600000) as u64) * arg0.multiplier / 100
    }

    public entry fun claim_rewards(arg0: &mut StakingPool, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        assert!(0x2::table::contains<address, StakerInfo>(&arg0.stakers, v0), 5);
        let v2 = 0x2::table::borrow_mut<address, StakerInfo>(&mut arg0.stakers, v0);
        let v3 = calculate_pending_rewards_from_info(v2, arg0.current_apr, v1);
        assert!(v3 > 0, 3);
        v2.pending_rewards = 0;
        v2.last_claim = v1;
        let v4 = RewardsClaimed{
            user   : v0,
            amount : v3,
        };
        0x2::event::emit<RewardsClaimed>(v4);
    }

    public fun current_apr(arg0: &StakingPool) : u64 {
        arg0.current_apr
    }

    public fun get_staker_info(arg0: &StakingPool, arg1: address) : (u64, u64, u64) {
        if (!0x2::table::contains<address, StakerInfo>(&arg0.stakers, arg1)) {
            return (0, 0, 0)
        };
        let v0 = 0x2::table::borrow<address, StakerInfo>(&arg0.stakers, arg1);
        (v0.staked_amount, v0.multiplier, v0.lock_end)
    }

    public entry fun init_staking(arg0: &0xf3c5285992e22261bdacd8b75fdd5239237f9079800b7dd94057b5c456b880c7::limen_token::TokenState, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = StakingPool{
            id               : 0x2::object::new(arg2),
            admin            : 0x2::tx_context::sender(arg2),
            token_state_id   : 0xf3c5285992e22261bdacd8b75fdd5239237f9079800b7dd94057b5c456b880c7::limen_token::admin(arg0),
            active           : true,
            total_staked     : 0,
            reward_pool      : 0x2::balance::zero<0xf3c5285992e22261bdacd8b75fdd5239237f9079800b7dd94057b5c456b880c7::limen_token::LIMEN_TOKEN>(),
            last_reward_time : 0x2::clock::timestamp_ms(arg1),
            current_apr      : 15,
            staked_balance   : 0x2::balance::zero<0xf3c5285992e22261bdacd8b75fdd5239237f9079800b7dd94057b5c456b880c7::limen_token::LIMEN_TOKEN>(),
            stakers          : 0x2::table::new<address, StakerInfo>(arg2),
        };
        0x2::transfer::share_object<StakingPool>(v0);
    }

    public fun is_staking_active(arg0: &StakingPool) : bool {
        arg0.active
    }

    public entry fun set_staking_active(arg0: &mut StakingPool, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 2);
        arg0.active = arg1;
    }

    public entry fun stake_tokens(arg0: &mut StakingPool, arg1: 0x2::coin::Coin<0xf3c5285992e22261bdacd8b75fdd5239237f9079800b7dd94057b5c456b880c7::limen_token::LIMEN_TOKEN>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.active, 4);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::coin::value<0xf3c5285992e22261bdacd8b75fdd5239237f9079800b7dd94057b5c456b880c7::limen_token::LIMEN_TOKEN>(&arg1);
        let v2 = 0x2::clock::timestamp_ms(arg3);
        assert!(v1 >= 1000, 3);
        assert!(arg2 >= 30, 3);
        let v3 = calculate_multiplier(arg2);
        let v4 = v2 + arg2 * 24 * 60 * 60;
        if (0x2::table::contains<address, StakerInfo>(&arg0.stakers, v0)) {
            let v5 = 0x2::table::borrow_mut<address, StakerInfo>(&mut arg0.stakers, v0);
            v5.staked_amount = v5.staked_amount + v1;
            v5.multiplier = v3;
            v5.lock_end = v4;
        } else {
            let v6 = StakerInfo{
                staked_amount   : v1,
                stake_start     : v2,
                lock_end        : v4,
                pending_rewards : 0,
                last_claim      : v2,
                multiplier      : v3,
            };
            0x2::table::add<address, StakerInfo>(&mut arg0.stakers, v0, v6);
        };
        arg0.total_staked = arg0.total_staked + v1;
        0x2::balance::join<0xf3c5285992e22261bdacd8b75fdd5239237f9079800b7dd94057b5c456b880c7::limen_token::LIMEN_TOKEN>(&mut arg0.staked_balance, 0x2::coin::into_balance<0xf3c5285992e22261bdacd8b75fdd5239237f9079800b7dd94057b5c456b880c7::limen_token::LIMEN_TOKEN>(arg1));
        let v7 = StakeReceipt{
            id         : 0x2::object::new(arg4),
            owner      : v0,
            amount     : v1,
            lock_end   : v4,
            multiplier : v3,
        };
        0x2::transfer::transfer<StakeReceipt>(v7, v0);
        let v8 = Staked{
            user       : v0,
            amount     : v1,
            multiplier : v3,
            lock_end   : v4,
        };
        0x2::event::emit<Staked>(v8);
    }

    public fun total_staked(arg0: &StakingPool) : u64 {
        arg0.total_staked
    }

    public entry fun unstake_tokens(arg0: &mut StakingPool, arg1: StakeReceipt, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        assert!(arg1.owner == v0, 2);
        assert!(v1 >= arg1.lock_end, 6);
        assert!(0x2::table::contains<address, StakerInfo>(&arg0.stakers, v0), 5);
        let v2 = calculate_pending_rewards_from_info(0x2::table::borrow<address, StakerInfo>(&arg0.stakers, v0), arg0.current_apr, v1);
        let v3 = 0x2::table::remove<address, StakerInfo>(&mut arg0.stakers, v0);
        arg0.total_staked = arg0.total_staked - v3.staked_amount;
        let v4 = 0x2::balance::split<0xf3c5285992e22261bdacd8b75fdd5239237f9079800b7dd94057b5c456b880c7::limen_token::LIMEN_TOKEN>(&mut arg0.staked_balance, arg1.amount);
        if (v2 > 0 && 0x2::balance::value<0xf3c5285992e22261bdacd8b75fdd5239237f9079800b7dd94057b5c456b880c7::limen_token::LIMEN_TOKEN>(&arg0.reward_pool) >= v2) {
            0x2::balance::join<0xf3c5285992e22261bdacd8b75fdd5239237f9079800b7dd94057b5c456b880c7::limen_token::LIMEN_TOKEN>(&mut v4, 0x2::balance::split<0xf3c5285992e22261bdacd8b75fdd5239237f9079800b7dd94057b5c456b880c7::limen_token::LIMEN_TOKEN>(&mut arg0.reward_pool, v2));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf3c5285992e22261bdacd8b75fdd5239237f9079800b7dd94057b5c456b880c7::limen_token::LIMEN_TOKEN>>(0x2::coin::from_balance<0xf3c5285992e22261bdacd8b75fdd5239237f9079800b7dd94057b5c456b880c7::limen_token::LIMEN_TOKEN>(v4, arg3), v0);
        let v5 = Unstaked{
            user    : v0,
            amount  : arg1.amount,
            rewards : v2,
        };
        0x2::event::emit<Unstaked>(v5);
        let StakeReceipt {
            id         : v6,
            owner      : _,
            amount     : _,
            lock_end   : _,
            multiplier : _,
        } = arg1;
        0x2::object::delete(v6);
    }

    public entry fun update_apr(arg0: &mut StakingPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 2);
        assert!(arg1 <= 50, 3);
        assert!(arg1 >= 5, 3);
        arg0.current_apr = arg1;
        let v0 = APRUpdated{
            old_apr : arg0.current_apr,
            new_apr : arg1,
        };
        0x2::event::emit<APRUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

