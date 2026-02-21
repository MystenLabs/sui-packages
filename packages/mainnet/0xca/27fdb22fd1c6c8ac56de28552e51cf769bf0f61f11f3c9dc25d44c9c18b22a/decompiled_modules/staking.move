module 0xca27fdb22fd1c6c8ac56de28552e51cf769bf0f61f11f3c9dc25d44c9c18b22a::staking {
    struct StakingPool has key {
        id: 0x2::object::UID,
        reward_balance: 0x2::balance::Balance<0xca27fdb22fd1c6c8ac56de28552e51cf769bf0f61f11f3c9dc25d44c9c18b22a::agu_token::AGU_TOKEN>,
        total_staked: u64,
        total_rewards_paid: u64,
        total_stakers: u64,
        pool_start_ms: u64,
    }

    struct StakePosition has store, key {
        id: 0x2::object::UID,
        owner: address,
        staked: 0x2::balance::Balance<0xca27fdb22fd1c6c8ac56de28552e51cf769bf0f61f11f3c9dc25d44c9c18b22a::agu_token::AGU_TOKEN>,
        amount: u64,
        stake_start_ms: u64,
        unlock_ms: u64,
        last_claim_ms: u64,
        total_claimed: u64,
    }

    struct Staked has copy, drop {
        staker: address,
        amount: u64,
        unlock_ms: u64,
    }

    struct Unstaked has copy, drop {
        staker: address,
        amount: u64,
    }

    struct RewardClaimed has copy, drop {
        staker: address,
        reward: u64,
    }

    struct RewardPoolFunded has copy, drop {
        amount: u64,
        new_pool_balance: u64,
    }

    fun calculate_reward(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : u64 {
        let v0 = if (arg1 == 0) {
            true
        } else if (arg2 == 0) {
            true
        } else {
            arg0 == 0
        };
        if (v0) {
            return 0
        };
        let v1 = 31536000000;
        let v2 = (arg5 - arg4) / v1;
        let v3 = if (v2 == 0) {
            800
        } else if (v2 == 1) {
            600
        } else if (v2 == 2) {
            400
        } else {
            200
        };
        (((arg2 as u128) * (v3 as u128) / (10000 as u128) * (arg0 as u128) * (10000 as u128) / (arg1 as u128) * (arg3 as u128) * (10000 as u128) / (v1 as u128) / (10000 as u128) * (10000 as u128)) as u64)
    }

    entry fun claim_reward(arg0: &mut StakingPool, arg1: &mut StakePosition, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.owner, 800);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = v0 - arg1.last_claim_ms;
        assert!(v1 > 0, 804);
        let v2 = calculate_reward(arg1.amount, arg0.total_staked, 0x2::balance::value<0xca27fdb22fd1c6c8ac56de28552e51cf769bf0f61f11f3c9dc25d44c9c18b22a::agu_token::AGU_TOKEN>(&arg0.reward_balance), v1, arg0.pool_start_ms, v0);
        if (v2 > 0 && v2 <= 0x2::balance::value<0xca27fdb22fd1c6c8ac56de28552e51cf769bf0f61f11f3c9dc25d44c9c18b22a::agu_token::AGU_TOKEN>(&arg0.reward_balance)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xca27fdb22fd1c6c8ac56de28552e51cf769bf0f61f11f3c9dc25d44c9c18b22a::agu_token::AGU_TOKEN>>(0x2::coin::from_balance<0xca27fdb22fd1c6c8ac56de28552e51cf769bf0f61f11f3c9dc25d44c9c18b22a::agu_token::AGU_TOKEN>(0x2::balance::split<0xca27fdb22fd1c6c8ac56de28552e51cf769bf0f61f11f3c9dc25d44c9c18b22a::agu_token::AGU_TOKEN>(&mut arg0.reward_balance, v2), arg3), arg1.owner);
            arg1.last_claim_ms = v0;
            arg1.total_claimed = arg1.total_claimed + v2;
            arg0.total_rewards_paid = arg0.total_rewards_paid + v2;
            let v3 = RewardClaimed{
                staker : arg1.owner,
                reward : v2,
            };
            0x2::event::emit<RewardClaimed>(v3);
        };
    }

    entry fun fund_reward_pool(arg0: &0xca27fdb22fd1c6c8ac56de28552e51cf769bf0f61f11f3c9dc25d44c9c18b22a::access_control::StakingManagerCap, arg1: &mut StakingPool, arg2: 0x2::coin::Coin<0xca27fdb22fd1c6c8ac56de28552e51cf769bf0f61f11f3c9dc25d44c9c18b22a::agu_token::AGU_TOKEN>) {
        let v0 = 0x2::coin::value<0xca27fdb22fd1c6c8ac56de28552e51cf769bf0f61f11f3c9dc25d44c9c18b22a::agu_token::AGU_TOKEN>(&arg2);
        assert!(v0 > 0, 802);
        0x2::balance::join<0xca27fdb22fd1c6c8ac56de28552e51cf769bf0f61f11f3c9dc25d44c9c18b22a::agu_token::AGU_TOKEN>(&mut arg1.reward_balance, 0x2::coin::into_balance<0xca27fdb22fd1c6c8ac56de28552e51cf769bf0f61f11f3c9dc25d44c9c18b22a::agu_token::AGU_TOKEN>(arg2));
        let v1 = RewardPoolFunded{
            amount           : v0,
            new_pool_balance : 0x2::balance::value<0xca27fdb22fd1c6c8ac56de28552e51cf769bf0f61f11f3c9dc25d44c9c18b22a::agu_token::AGU_TOKEN>(&arg1.reward_balance),
        };
        0x2::event::emit<RewardPoolFunded>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = StakingPool{
            id                 : 0x2::object::new(arg0),
            reward_balance     : 0x2::balance::zero<0xca27fdb22fd1c6c8ac56de28552e51cf769bf0f61f11f3c9dc25d44c9c18b22a::agu_token::AGU_TOKEN>(),
            total_staked       : 0,
            total_rewards_paid : 0,
            total_stakers      : 0,
            pool_start_ms      : 0,
        };
        0x2::transfer::share_object<StakingPool>(v0);
    }

    public fun reward_pool_balance(arg0: &StakingPool) : u64 {
        0x2::balance::value<0xca27fdb22fd1c6c8ac56de28552e51cf769bf0f61f11f3c9dc25d44c9c18b22a::agu_token::AGU_TOKEN>(&arg0.reward_balance)
    }

    entry fun stake(arg0: &mut StakingPool, arg1: 0x2::coin::Coin<0xca27fdb22fd1c6c8ac56de28552e51cf769bf0f61f11f3c9dc25d44c9c18b22a::agu_token::AGU_TOKEN>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xca27fdb22fd1c6c8ac56de28552e51cf769bf0f61f11f3c9dc25d44c9c18b22a::agu_token::AGU_TOKEN>(&arg1);
        assert!(v0 >= 100000000000, 805);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = v1 + 2592000000;
        let v3 = 0x2::tx_context::sender(arg3);
        if (arg0.pool_start_ms == 0) {
            arg0.pool_start_ms = v1;
        };
        arg0.total_staked = arg0.total_staked + v0;
        arg0.total_stakers = arg0.total_stakers + 1;
        let v4 = StakePosition{
            id             : 0x2::object::new(arg3),
            owner          : v3,
            staked         : 0x2::coin::into_balance<0xca27fdb22fd1c6c8ac56de28552e51cf769bf0f61f11f3c9dc25d44c9c18b22a::agu_token::AGU_TOKEN>(arg1),
            amount         : v0,
            stake_start_ms : v1,
            unlock_ms      : v2,
            last_claim_ms  : v1,
            total_claimed  : 0,
        };
        let v5 = Staked{
            staker    : v3,
            amount    : v0,
            unlock_ms : v2,
        };
        0x2::event::emit<Staked>(v5);
        0x2::transfer::transfer<StakePosition>(v4, v3);
    }

    public fun stake_amount(arg0: &StakePosition) : u64 {
        arg0.amount
    }

    public fun stake_total_claimed(arg0: &StakePosition) : u64 {
        arg0.total_claimed
    }

    public fun stake_unlock_ms(arg0: &StakePosition) : u64 {
        arg0.unlock_ms
    }

    public fun total_rewards_paid(arg0: &StakingPool) : u64 {
        arg0.total_rewards_paid
    }

    public fun total_staked(arg0: &StakingPool) : u64 {
        arg0.total_staked
    }

    public fun total_stakers(arg0: &StakingPool) : u64 {
        arg0.total_stakers
    }

    entry fun unstake(arg0: &mut StakingPool, arg1: StakePosition, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let StakePosition {
            id             : v0,
            owner          : v1,
            staked         : v2,
            amount         : v3,
            stake_start_ms : _,
            unlock_ms      : v5,
            last_claim_ms  : _,
            total_claimed  : _,
        } = arg1;
        assert!(0x2::tx_context::sender(arg3) == v1, 800);
        assert!(0x2::clock::timestamp_ms(arg2) >= v5, 801);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xca27fdb22fd1c6c8ac56de28552e51cf769bf0f61f11f3c9dc25d44c9c18b22a::agu_token::AGU_TOKEN>>(0x2::coin::from_balance<0xca27fdb22fd1c6c8ac56de28552e51cf769bf0f61f11f3c9dc25d44c9c18b22a::agu_token::AGU_TOKEN>(v2, arg3), v1);
        arg0.total_staked = arg0.total_staked - v3;
        arg0.total_stakers = arg0.total_stakers - 1;
        let v8 = Unstaked{
            staker : v1,
            amount : v3,
        };
        0x2::event::emit<Unstaked>(v8);
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v6
}

