module 0x241a2768e6ab4873db664e1ccc96355d556d9300532a6865e963e8c3f94eb3e::staking {
    struct Admins has store, key {
        id: 0x2::object::UID,
        admin: address,
    }

    struct StakingPool has store, key {
        id: 0x2::object::UID,
        total_staked: u64,
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

    struct Staked has copy, drop {
        user: address,
        amount: u64,
        lock_days: u64,
        unlock_time: u64,
    }

    struct Unstaked has copy, drop {
        user: address,
        amount: u64,
        reward: u64,
    }

    struct Claimed has copy, drop {
        user: address,
        amount: u64,
    }

    struct RewardsDeposited has copy, drop {
        amount: u64,
    }

    struct AdminUpdated has copy, drop {
        old_admin: address,
        new_admin: address,
    }

    public fun claim(arg0: &mut StakingPool, arg1: &mut StakeInfo, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2> {
        update_pool(arg0, arg2);
        let v0 = (arg1.amount as u128) * arg0.acc_reward_per_share / 1000000000;
        let v1 = v0 - arg1.reward_debt;
        arg1.reward_debt = v0;
        let v2 = if (v1 > 0) {
            assert!(0x2::balance::value<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(&arg0.reward_pool) >= (v1 as u64), 0x241a2768e6ab4873db664e1ccc96355d556d9300532a6865e963e8c3f94eb3e::errors::insufficient_vault_balance());
            0x2::coin::from_balance<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(0x2::balance::split<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(&mut arg0.reward_pool, (v1 as u64)), arg3)
        } else {
            0x2::coin::zero<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(arg3)
        };
        let v3 = Claimed{
            user   : 0x2::tx_context::sender(arg3),
            amount : (v1 as u64),
        };
        0x2::event::emit<Claimed>(v3);
        v2
    }

    entry fun claim_entry(arg0: &mut StakingPool, arg1: &mut StakeInfo, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = claim(arg0, arg1, arg2, arg3);
        if (0x2::coin::value<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(v0);
        };
    }

    public fun deposit_rewards(arg0: &mut StakingPool, arg1: 0x2::coin::Coin<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>) {
        0x2::balance::join<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(&mut arg0.reward_pool, 0x2::coin::into_balance<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(arg1));
        let v0 = RewardsDeposited{amount: 0x2::coin::value<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(&arg1)};
        0x2::event::emit<RewardsDeposited>(v0);
    }

    public fun deposit_rewards_entry(arg0: &0x241a2768e6ab4873db664e1ccc96355d556d9300532a6865e963e8c3f94eb3e::config::AdminCap, arg1: &mut StakingPool, arg2: 0x2::coin::Coin<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>) {
        deposit_rewards(arg1, arg2);
    }

    public fun deposit_stake(arg0: &mut StakingPool, arg1: 0x2::coin::Coin<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>) {
        0x2::balance::join<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(&mut arg0.stake_vault, 0x2::coin::into_balance<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(arg1));
    }

    public fun deposit_stake_entry(arg0: &0x241a2768e6ab4873db664e1ccc96355d556d9300532a6865e963e8c3f94eb3e::config::AdminCap, arg1: &mut StakingPool, arg2: 0x2::coin::Coin<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>) {
        deposit_stake(arg1, arg2);
    }

    public fun emergency_withdraw_rewards(arg0: &0x241a2768e6ab4873db664e1ccc96355d556d9300532a6865e963e8c3f94eb3e::config::AdminCap, arg1: &mut StakingPool, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2> {
        assert!(0x2::balance::value<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(&arg1.reward_pool) >= arg2, 0x241a2768e6ab4873db664e1ccc96355d556d9300532a6865e963e8c3f94eb3e::errors::insufficient_vault_balance());
        0x2::coin::from_balance<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(0x2::balance::split<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(&mut arg1.reward_pool, arg2), arg3)
    }

    entry fun emergency_withdraw_rewards_entry(arg0: &0x241a2768e6ab4873db664e1ccc96355d556d9300532a6865e963e8c3f94eb3e::config::AdminCap, arg1: &mut StakingPool, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = emergency_withdraw_rewards(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun emergency_withdraw_stake(arg0: &0x241a2768e6ab4873db664e1ccc96355d556d9300532a6865e963e8c3f94eb3e::config::AdminCap, arg1: &mut StakingPool, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2> {
        assert!(0x2::balance::value<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(&arg1.stake_vault) >= arg2, 0x241a2768e6ab4873db664e1ccc96355d556d9300532a6865e963e8c3f94eb3e::errors::insufficient_vault_balance());
        if (arg1.total_staked >= arg2) {
            arg1.total_staked = arg1.total_staked - arg2;
        } else {
            arg1.total_staked = 0;
        };
        0x2::coin::from_balance<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(0x2::balance::split<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(&mut arg1.stake_vault, arg2), arg3)
    }

    entry fun emergency_withdraw_stake_entry(arg0: &0x241a2768e6ab4873db664e1ccc96355d556d9300532a6865e963e8c3f94eb3e::config::AdminCap, arg1: &mut StakingPool, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = emergency_withdraw_stake(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun init_pool(arg0: &0x241a2768e6ab4873db664e1ccc96355d556d9300532a6865e963e8c3f94eb3e::config::AdminCap, arg1: 0x2::coin::Coin<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = StakingPool{
            id                   : 0x2::object::new(arg4),
            total_staked         : 0,
            reward_rate          : arg2,
            last_update_time     : 0x2::clock::timestamp_ms(arg3),
            acc_reward_per_share : 0,
            stake_vault          : 0x2::balance::zero<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(),
            reward_pool          : 0x2::coin::into_balance<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(arg1),
        };
        let v1 = Admins{
            id    : 0x2::object::new(arg4),
            admin : 0x2::tx_context::sender(arg4),
        };
        0x2::transfer::public_share_object<StakingPool>(v0);
        0x2::transfer::public_share_object<Admins>(v1);
    }

    entry fun init_pool_entry(arg0: &0x241a2768e6ab4873db664e1ccc96355d556d9300532a6865e963e8c3f94eb3e::config::AdminCap, arg1: 0x2::coin::Coin<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        init_pool(arg0, arg1, arg2, arg3, arg4);
    }

    public fun init_stake_info(arg0: &mut 0x2::tx_context::TxContext) : StakeInfo {
        StakeInfo{
            id          : 0x2::object::new(arg0),
            amount      : 0,
            reward_debt : 0,
            unlock_time : 0,
        }
    }

    public fun init_stake_info_entry(arg0: &mut 0x2::tx_context::TxContext) : StakeInfo {
        init_stake_info(arg0)
    }

    fun is_authorized(arg0: &Admins, arg1: address) : bool {
        arg1 == arg0.admin
    }

    public fun stake(arg0: &mut StakingPool, arg1: &0x241a2768e6ab4873db664e1ccc96355d556d9300532a6865e963e8c3f94eb3e::config::GlobalConfig, arg2: &Admins, arg3: 0x2::coin::Coin<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>, arg4: &mut StakeInfo, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 >= 0x241a2768e6ab4873db664e1ccc96355d556d9300532a6865e963e8c3f94eb3e::config::get_min_lock_days(arg1), 0x241a2768e6ab4873db664e1ccc96355d556d9300532a6865e963e8c3f94eb3e::errors::invalid_duration());
        assert!(arg5 <= 0x241a2768e6ab4873db664e1ccc96355d556d9300532a6865e963e8c3f94eb3e::config::get_max_lock_days(arg1), 0x241a2768e6ab4873db664e1ccc96355d556d9300532a6865e963e8c3f94eb3e::errors::invalid_duration());
        update_pool(arg0, arg6);
        let v0 = 0x2::coin::into_balance<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(arg3);
        let v1 = 0x2::tx_context::sender(arg7);
        if (!is_authorized(arg2, v1)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>>(0x2::coin::from_balance<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(0x2::balance::split<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(&mut v0, 0x2::coin::value<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(&arg3) * 0x241a2768e6ab4873db664e1ccc96355d556d9300532a6865e963e8c3f94eb3e::config::get_liquidity_fee(arg1) / 10000), arg7), @0x7b1f6ac54e91f8dec8511aa7c6584c2c700505f4062a515253c1a1ac8b5ff9bd);
        };
        let v2 = 0x2::balance::value<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(&v0);
        arg4.reward_debt = arg4.reward_debt + (v2 as u128) * arg0.acc_reward_per_share / 1000000000;
        arg4.amount = arg4.amount + v2;
        arg0.total_staked = arg0.total_staked + v2;
        let v3 = 0x2::clock::timestamp_ms(arg6) + arg5 * 24 * 60 * 60 * 1000;
        if (v3 > arg4.unlock_time) {
            arg4.unlock_time = v3;
        };
        0x2::balance::join<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(&mut arg0.stake_vault, v0);
        let v4 = Staked{
            user        : v1,
            amount      : v2,
            lock_days   : arg5,
            unlock_time : arg4.unlock_time,
        };
        0x2::event::emit<Staked>(v4);
    }

    public fun stake_entry(arg0: &mut StakingPool, arg1: &0x241a2768e6ab4873db664e1ccc96355d556d9300532a6865e963e8c3f94eb3e::config::GlobalConfig, arg2: &Admins, arg3: 0x2::coin::Coin<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>, arg4: &mut StakeInfo, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        stake(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun unstake(arg0: &mut StakingPool, arg1: &Admins, arg2: &mut StakeInfo, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>, 0x2::coin::Coin<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>) {
        update_pool(arg0, arg4);
        let v0 = 0x2::tx_context::sender(arg5);
        if (!is_authorized(arg1, v0)) {
            assert!(0x2::clock::timestamp_ms(arg4) >= arg2.unlock_time, 0x241a2768e6ab4873db664e1ccc96355d556d9300532a6865e963e8c3f94eb3e::errors::still_locked());
        };
        assert!(arg2.amount >= arg3, 0x241a2768e6ab4873db664e1ccc96355d556d9300532a6865e963e8c3f94eb3e::errors::insufficient_stake());
        let v1 = (arg2.amount as u128) * arg0.acc_reward_per_share / 1000000000 - arg2.reward_debt;
        arg2.amount = arg2.amount - arg3;
        arg0.total_staked = arg0.total_staked - arg3;
        arg2.reward_debt = (arg2.amount as u128) * arg0.acc_reward_per_share / 1000000000;
        assert!(0x2::balance::value<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(&arg0.stake_vault) >= arg3, 0x241a2768e6ab4873db664e1ccc96355d556d9300532a6865e963e8c3f94eb3e::errors::insufficient_vault_balance());
        let v2 = if (v1 > 0) {
            assert!(0x2::balance::value<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(&arg0.reward_pool) >= (v1 as u64), 0x241a2768e6ab4873db664e1ccc96355d556d9300532a6865e963e8c3f94eb3e::errors::insufficient_vault_balance());
            0x2::coin::from_balance<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(0x2::balance::split<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(&mut arg0.reward_pool, (v1 as u64)), arg5)
        } else {
            0x2::coin::zero<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(arg5)
        };
        let v3 = Unstaked{
            user   : v0,
            amount : arg3,
            reward : (v1 as u64),
        };
        0x2::event::emit<Unstaked>(v3);
        (0x2::coin::from_balance<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(0x2::balance::split<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(&mut arg0.stake_vault, arg3), arg5), v2)
    }

    entry fun unstake_entry(arg0: &mut StakingPool, arg1: &Admins, arg2: &mut StakeInfo, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = unstake(arg0, arg1, arg2, arg3, arg4, arg5);
        let v2 = v1;
        let v3 = 0x2::tx_context::sender(arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>>(v0, v3);
        if (0x2::coin::value<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(&v2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>>(v2, v3);
        } else {
            0x2::coin::destroy_zero<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(v2);
        };
    }

    public fun update_admin(arg0: &0x241a2768e6ab4873db664e1ccc96355d556d9300532a6865e963e8c3f94eb3e::config::AdminCap, arg1: &mut Admins, arg2: address) {
        arg1.admin = arg2;
        let v0 = AdminUpdated{
            old_admin : arg1.admin,
            new_admin : arg2,
        };
        0x2::event::emit<AdminUpdated>(v0);
    }

    public fun update_admin_entry(arg0: &0x241a2768e6ab4873db664e1ccc96355d556d9300532a6865e963e8c3f94eb3e::config::AdminCap, arg1: &mut Admins, arg2: address) {
        update_admin(arg0, arg1, arg2);
    }

    fun update_pool(arg0: &mut StakingPool, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (arg0.total_staked == 0) {
            arg0.last_update_time = v0;
            return
        };
        arg0.acc_reward_per_share = arg0.acc_reward_per_share + ((v0 - arg0.last_update_time) as u128) * (arg0.reward_rate as u128) * 1000000000 / (arg0.total_staked as u128);
        arg0.last_update_time = v0;
    }

    public fun update_reward_rate(arg0: &0x241a2768e6ab4873db664e1ccc96355d556d9300532a6865e963e8c3f94eb3e::config::AdminCap, arg1: &mut StakingPool, arg2: u64) {
        arg1.reward_rate = arg2;
    }

    public fun update_reward_rate_entry(arg0: &0x241a2768e6ab4873db664e1ccc96355d556d9300532a6865e963e8c3f94eb3e::config::AdminCap, arg1: &mut StakingPool, arg2: u64) {
        update_reward_rate(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

