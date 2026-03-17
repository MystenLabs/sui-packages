module 0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::staking {
    struct Admins has store, key {
        id: 0x2::object::UID,
        wallet1: address,
        wallet2: address,
        wallet4: address,
        wallet5: address,
    }

    struct StakingPool has store, key {
        id: 0x2::object::UID,
        total_staked: u64,
        num_stakers: u64,
        reward_rate: u64,
        last_update_time: u64,
        acc_reward_per_share: u128,
        stake_vault: 0x2::balance::Balance<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>,
        reward_pool: 0x2::balance::Balance<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>,
    }

    struct StakeInfo has store, key {
        id: 0x2::object::UID,
        amount: u64,
        reward_debt: u128,
        unlock_time: u64,
    }

    public fun claim(arg0: &mut StakingPool, arg1: &0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::config::GlobalConfig, arg2: &mut StakeInfo, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        update_pool(arg0, arg1, arg3);
        let v0 = (arg2.amount as u128) * arg0.acc_reward_per_share / 1000000000;
        let v1 = v0 - arg2.reward_debt;
        arg2.reward_debt = v0;
        if (v1 > 0) {
            assert!(0x2::balance::value<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(&arg0.reward_pool) >= (v1 as u64), 0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::errors::insufficient_vault_balance());
            0x2::transfer::public_transfer<0x2::coin::Coin<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>>(0x2::coin::from_balance<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(0x2::balance::split<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(&mut arg0.reward_pool, (v1 as u64)), arg4), 0x2::tx_context::sender(arg4));
        };
    }

    public entry fun claim_entry(arg0: &mut StakingPool, arg1: &0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::config::GlobalConfig, arg2: &mut StakeInfo, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        claim(arg0, arg1, arg2, arg3, arg4);
    }

    public fun deposit_rewards(arg0: &mut StakingPool, arg1: 0x2::coin::Coin<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>) {
        0x2::balance::join<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(&mut arg0.reward_pool, 0x2::coin::into_balance<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(arg1));
    }

    public fun deposit_stake(arg0: &mut StakingPool, arg1: 0x2::coin::Coin<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>) {
        0x2::balance::join<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(&mut arg0.stake_vault, 0x2::coin::into_balance<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(arg1));
    }

    public fun init_pool(arg0: &0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::config::AdminCap, arg1: 0x2::coin::Coin<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext, arg5: address, arg6: address, arg7: address, arg8: address) : (StakingPool, Admins) {
        let v0 = StakingPool{
            id                   : 0x2::object::new(arg4),
            total_staked         : 0,
            num_stakers          : 0,
            reward_rate          : arg2,
            last_update_time     : 0x2::clock::timestamp_ms(arg3),
            acc_reward_per_share : 0,
            stake_vault          : 0x2::balance::zero<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(),
            reward_pool          : 0x2::coin::into_balance<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(arg1),
        };
        let v1 = Admins{
            id      : 0x2::object::new(arg4),
            wallet1 : arg5,
            wallet2 : arg6,
            wallet4 : arg7,
            wallet5 : arg8,
        };
        (v0, v1)
    }

    public entry fun init_pool_entry(arg0: &0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::config::AdminCap, arg1: 0x2::coin::Coin<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>, arg2: u64, arg3: &0x2::clock::Clock, arg4: address, arg5: address, arg6: address, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = init_pool(arg0, arg1, arg2, arg3, arg8, arg4, arg5, arg6, arg7);
        0x2::transfer::public_share_object<StakingPool>(v0);
        0x2::transfer::public_share_object<Admins>(v1);
    }

    public fun init_stake_info(arg0: &mut 0x2::tx_context::TxContext) : StakeInfo {
        StakeInfo{
            id          : 0x2::object::new(arg0),
            amount      : 0,
            reward_debt : 0,
            unlock_time : 0,
        }
    }

    public entry fun init_stake_info_entry(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = init_stake_info(arg0);
        0x2::transfer::transfer<StakeInfo>(v0, 0x2::tx_context::sender(arg0));
    }

    fun is_authorized(arg0: &Admins, arg1: address) : bool {
        if (arg1 == arg0.wallet1) {
            true
        } else if (arg1 == arg0.wallet2) {
            true
        } else if (arg1 == @0x7b1f6ac54e91f8dec8511aa7c6584c2c700505f4062a515253c1a1ac8b5ff9bd) {
            true
        } else if (arg1 == arg0.wallet4) {
            true
        } else {
            arg1 == arg0.wallet5
        }
    }

    public fun stake(arg0: &mut StakingPool, arg1: &0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::config::GlobalConfig, arg2: &Admins, arg3: 0x2::coin::Coin<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>, arg4: &mut StakeInfo, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 >= 0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::config::get_min_lock_days(arg1), 0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::errors::invalid_duration());
        assert!(arg5 <= 0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::config::get_max_lock_days(arg1), 0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::errors::invalid_duration());
        update_pool(arg0, arg1, arg6);
        if (arg4.amount == 0) {
            arg0.num_stakers = arg0.num_stakers + 1;
        };
        let v0 = 0x2::coin::value<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(&arg3);
        let v1 = 0x2::coin::into_balance<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(arg3);
        if (!is_authorized(arg2, 0x2::tx_context::sender(arg7))) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>>(0x2::coin::from_balance<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(0x2::balance::split<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(&mut v1, v0 * 0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::config::get_liquidity_fee(arg1) / 10000), arg7), @0x7b1f6ac54e91f8dec8511aa7c6584c2c700505f4062a515253c1a1ac8b5ff9bd);
        };
        arg4.amount = arg4.amount + v0;
        arg0.total_staked = arg0.total_staked + v0;
        arg4.reward_debt = (arg4.amount as u128) * arg0.acc_reward_per_share / 1000000000;
        let v2 = 0x2::clock::timestamp_ms(arg6) + arg5 * 24 * 60 * 60 * 1000;
        if (v2 > arg4.unlock_time) {
            arg4.unlock_time = v2;
        };
        0x2::balance::join<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(&mut arg0.stake_vault, v1);
    }

    public entry fun stake_entry(arg0: &mut StakingPool, arg1: &0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::config::GlobalConfig, arg2: &Admins, arg3: 0x2::coin::Coin<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>, arg4: &mut StakeInfo, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        stake(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun unstake(arg0: &mut StakingPool, arg1: &0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::config::GlobalConfig, arg2: &Admins, arg3: &mut StakeInfo, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        update_pool(arg0, arg1, arg5);
        let v0 = 0x2::tx_context::sender(arg6);
        if (!is_authorized(arg2, v0)) {
            assert!(0x2::clock::timestamp_ms(arg5) >= arg3.unlock_time, 0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::errors::still_locked());
        };
        assert!(arg3.amount >= arg4, 0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::errors::insufficient_stake());
        let v1 = (arg3.amount as u128) * arg0.acc_reward_per_share / 1000000000 - arg3.reward_debt;
        arg3.amount = arg3.amount - arg4;
        arg0.total_staked = arg0.total_staked - arg4;
        if (arg3.amount == 0) {
            arg0.num_stakers = arg0.num_stakers - 1;
        };
        arg3.reward_debt = (arg3.amount as u128) * arg0.acc_reward_per_share / 1000000000;
        assert!(0x2::balance::value<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(&arg0.stake_vault) >= arg4, 0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::errors::insufficient_vault_balance());
        0x2::transfer::public_transfer<0x2::coin::Coin<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>>(0x2::coin::from_balance<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(0x2::balance::split<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(&mut arg0.stake_vault, arg4), arg6), v0);
        if (v1 > 0) {
            assert!(0x2::balance::value<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(&arg0.reward_pool) >= (v1 as u64), 0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::errors::insufficient_vault_balance());
            0x2::transfer::public_transfer<0x2::coin::Coin<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>>(0x2::coin::from_balance<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(0x2::balance::split<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(&mut arg0.reward_pool, (v1 as u64)), arg6), v0);
        };
    }

    public entry fun unstake_entry(arg0: &mut StakingPool, arg1: &0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::config::GlobalConfig, arg2: &Admins, arg3: &mut StakeInfo, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        unstake(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    fun update_pool(arg0: &mut StakingPool, arg1: &0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::config::GlobalConfig, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        if (arg0.total_staked == 0) {
            arg0.last_update_time = v0;
            return
        };
        arg0.acc_reward_per_share = arg0.acc_reward_per_share + (arg0.total_staked as u128) * (0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::config::get_apy(arg1) as u128) * ((v0 - arg0.last_update_time) as u128) / 10000 * 31536000000 * 1000000000 / (arg0.total_staked as u128);
        arg0.last_update_time = v0;
    }

    public fun update_reward_rate(arg0: &0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::config::AdminCap, arg1: &mut StakingPool, arg2: u64) {
        arg1.reward_rate = arg2;
    }

    public fun update_wallet1(arg0: &0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::config::AdminCap, arg1: &mut Admins, arg2: address) {
        arg1.wallet1 = arg2;
    }

    public fun update_wallet2(arg0: &0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::config::AdminCap, arg1: &mut Admins, arg2: address) {
        arg1.wallet2 = arg2;
    }

    public fun update_wallet4(arg0: &0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::config::AdminCap, arg1: &mut Admins, arg2: address) {
        arg1.wallet4 = arg2;
    }

    public fun update_wallet5(arg0: &0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::config::AdminCap, arg1: &mut Admins, arg2: address) {
        arg1.wallet5 = arg2;
    }

    public fun update_whitelist(arg0: &0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::config::AdminCap, arg1: &mut Admins, arg2: address, arg3: address, arg4: address, arg5: address) {
        arg1.wallet1 = arg2;
        arg1.wallet2 = arg3;
        arg1.wallet4 = arg4;
        arg1.wallet5 = arg5;
    }

    public entry fun update_whitelist_entry(arg0: &0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::config::AdminCap, arg1: &mut Admins, arg2: address, arg3: address, arg4: address, arg5: address) {
        update_whitelist(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

