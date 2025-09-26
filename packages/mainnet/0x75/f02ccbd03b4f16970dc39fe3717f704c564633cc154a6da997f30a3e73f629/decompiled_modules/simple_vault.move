module 0x75f02ccbd03b4f16970dc39fe3717f704c564633cc154a6da997f30a3e73f629::simple_vault {
    struct VaultAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct SimpleUSDTVault has key {
        id: 0x2::object::UID,
        total_staked: 0x2::balance::Balance<0x75f02ccbd03b4f16970dc39fe3717f704c564633cc154a6da997f30a3e73f629::tether_usdt_sui::TETHER_USDT_SUI>,
        total_rewards: u64,
        paused: bool,
        pools: 0x2::table::Table<u64, FarmingPool>,
        next_pool_id: u64,
        user_stakes: 0x2::table::Table<address, UserStake>,
    }

    struct FarmingPool has store {
        id: u64,
        name: vector<u8>,
        apy: u64,
        min_staking_period: u64,
        max_capacity: u64,
        current_staked: u64,
        active: bool,
        early_penalty: u64,
    }

    struct UserStake has store {
        amount: u64,
        pool_id: u64,
        start_time: u64,
        last_reward_time: u64,
        pending_rewards: u64,
    }

    struct VaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        creator: address,
    }

    struct PoolCreated has copy, drop {
        pool_id: u64,
        name: vector<u8>,
        apy: u64,
        max_capacity: u64,
    }

    struct Staked has copy, drop {
        user: address,
        amount: u64,
        pool_id: u64,
        timestamp: u64,
    }

    struct Unstaked has copy, drop {
        user: address,
        amount: u64,
        pool_id: u64,
        rewards: u64,
        penalty: u64,
        timestamp: u64,
    }

    struct RewardsClaimed has copy, drop {
        user: address,
        amount: u64,
        pool_id: u64,
        timestamp: u64,
    }

    public entry fun add_vault_rewards(arg0: &VaultAdminCap, arg1: &mut SimpleUSDTVault, arg2: 0x2::coin::Coin<0x75f02ccbd03b4f16970dc39fe3717f704c564633cc154a6da997f30a3e73f629::tether_usdt_sui::TETHER_USDT_SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x75f02ccbd03b4f16970dc39fe3717f704c564633cc154a6da997f30a3e73f629::tether_usdt_sui::TETHER_USDT_SUI>(&mut arg1.total_staked, 0x2::coin::into_balance<0x75f02ccbd03b4f16970dc39fe3717f704c564633cc154a6da997f30a3e73f629::tether_usdt_sui::TETHER_USDT_SUI>(arg2));
    }

    public fun calculate_pending_rewards(arg0: &SimpleUSDTVault, arg1: address, arg2: u64) : u64 {
        if (!0x2::table::contains<address, UserStake>(&arg0.user_stakes, arg1)) {
            return 0
        };
        let v0 = 0x2::table::borrow<address, UserStake>(&arg0.user_stakes, arg1);
        v0.pending_rewards + calculate_rewards(v0.amount, 0x2::table::borrow<u64, FarmingPool>(&arg0.pools, v0.pool_id).apy, arg2 - v0.last_reward_time)
    }

    fun calculate_rewards(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg1 == 0) {
            true
        } else {
            arg2 == 0
        };
        if (v0) {
            return 0
        };
        arg0 * arg1 * arg2 / 10000 * 31536000
    }

    public entry fun claim_rewards(arg0: &mut SimpleUSDTVault, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 4);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, UserStake>(&arg0.user_stakes, v0), 6);
        let v1 = 0x2::clock::timestamp_ms(arg1) / 1000;
        let v2 = 0x2::table::borrow_mut<address, UserStake>(&mut arg0.user_stakes, v0);
        let v3 = v2.pending_rewards + calculate_rewards(v2.amount, 0x2::table::borrow<u64, FarmingPool>(&arg0.pools, v2.pool_id).apy, v1 - v2.last_reward_time);
        assert!(v3 > 0, 3);
        v2.pending_rewards = 0;
        v2.last_reward_time = v1;
        arg0.total_rewards = arg0.total_rewards + v3;
        let v4 = RewardsClaimed{
            user      : v0,
            amount    : v3,
            pool_id   : v2.pool_id,
            timestamp : v1,
        };
        0x2::event::emit<RewardsClaimed>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x75f02ccbd03b4f16970dc39fe3717f704c564633cc154a6da997f30a3e73f629::tether_usdt_sui::TETHER_USDT_SUI>>(0x2::coin::from_balance<0x75f02ccbd03b4f16970dc39fe3717f704c564633cc154a6da997f30a3e73f629::tether_usdt_sui::TETHER_USDT_SUI>(0x2::balance::split<0x75f02ccbd03b4f16970dc39fe3717f704c564633cc154a6da997f30a3e73f629::tether_usdt_sui::TETHER_USDT_SUI>(&mut arg0.total_staked, v3), arg2), v0);
    }

    public entry fun create_pool(arg0: &VaultAdminCap, arg1: &mut SimpleUSDTVault, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.paused, 4);
        assert!(arg3 <= 10000, 3);
        assert!(arg6 <= 2000, 3);
        let v0 = arg1.next_pool_id;
        let v1 = FarmingPool{
            id                 : v0,
            name               : arg2,
            apy                : arg3,
            min_staking_period : arg4,
            max_capacity       : arg5,
            current_staked     : 0,
            active             : true,
            early_penalty      : arg6,
        };
        0x2::table::add<u64, FarmingPool>(&mut arg1.pools, v0, v1);
        arg1.next_pool_id = v0 + 1;
        let v2 = PoolCreated{
            pool_id      : v0,
            name         : arg2,
            apy          : arg3,
            max_capacity : arg5,
        };
        0x2::event::emit<PoolCreated>(v2);
    }

    public entry fun create_vault(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = VaultAdminCap{id: 0x2::object::new(arg0)};
        let v1 = SimpleUSDTVault{
            id            : 0x2::object::new(arg0),
            total_staked  : 0x2::balance::zero<0x75f02ccbd03b4f16970dc39fe3717f704c564633cc154a6da997f30a3e73f629::tether_usdt_sui::TETHER_USDT_SUI>(),
            total_rewards : 0,
            paused        : false,
            pools         : 0x2::table::new<u64, FarmingPool>(arg0),
            next_pool_id  : 0,
            user_stakes   : 0x2::table::new<address, UserStake>(arg0),
        };
        let v2 = VaultCreated{
            vault_id : 0x2::object::id<SimpleUSDTVault>(&v1),
            creator  : 0x2::tx_context::sender(arg0),
        };
        0x2::event::emit<VaultCreated>(v2);
        0x2::transfer::transfer<VaultAdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<SimpleUSDTVault>(v1);
    }

    public fun get_pool_info(arg0: &SimpleUSDTVault, arg1: u64) : (vector<u8>, u64, u64, u64, u64, bool) {
        let v0 = 0x2::table::borrow<u64, FarmingPool>(&arg0.pools, arg1);
        (v0.name, v0.apy, v0.min_staking_period, v0.max_capacity, v0.current_staked, v0.active)
    }

    public fun get_user_stake(arg0: &SimpleUSDTVault, arg1: address) : (u64, u64, u64, u64, u64) {
        if (!0x2::table::contains<address, UserStake>(&arg0.user_stakes, arg1)) {
            return (0, 0, 0, 0, 0)
        };
        let v0 = 0x2::table::borrow<address, UserStake>(&arg0.user_stakes, arg1);
        (v0.amount, v0.pool_id, v0.start_time, v0.last_reward_time, v0.pending_rewards)
    }

    public fun get_vault_stats(arg0: &SimpleUSDTVault) : (u64, u64, bool, u64) {
        (0x2::balance::value<0x75f02ccbd03b4f16970dc39fe3717f704c564633cc154a6da997f30a3e73f629::tether_usdt_sui::TETHER_USDT_SUI>(&arg0.total_staked), arg0.total_rewards, arg0.paused, arg0.next_pool_id)
    }

    public entry fun set_vault_paused(arg0: &VaultAdminCap, arg1: &mut SimpleUSDTVault, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.paused = arg2;
    }

    public entry fun stake(arg0: &mut SimpleUSDTVault, arg1: u64, arg2: 0x2::coin::Coin<0x75f02ccbd03b4f16970dc39fe3717f704c564633cc154a6da997f30a3e73f629::tether_usdt_sui::TETHER_USDT_SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 4);
        assert!(0x2::table::contains<u64, FarmingPool>(&arg0.pools, arg1), 5);
        let v0 = 0x2::coin::value<0x75f02ccbd03b4f16970dc39fe3717f704c564633cc154a6da997f30a3e73f629::tether_usdt_sui::TETHER_USDT_SUI>(&arg2);
        assert!(v0 >= 1000000, 3);
        let v1 = 0x2::table::borrow_mut<u64, FarmingPool>(&mut arg0.pools, arg1);
        assert!(v1.active, 5);
        assert!(v1.current_staked + v0 <= v1.max_capacity, 8);
        let v2 = 0x2::tx_context::sender(arg4);
        let v3 = 0x2::clock::timestamp_ms(arg3) / 1000;
        v1.current_staked = v1.current_staked + v0;
        0x2::balance::join<0x75f02ccbd03b4f16970dc39fe3717f704c564633cc154a6da997f30a3e73f629::tether_usdt_sui::TETHER_USDT_SUI>(&mut arg0.total_staked, 0x2::coin::into_balance<0x75f02ccbd03b4f16970dc39fe3717f704c564633cc154a6da997f30a3e73f629::tether_usdt_sui::TETHER_USDT_SUI>(arg2));
        if (0x2::table::contains<address, UserStake>(&arg0.user_stakes, v2)) {
            let v4 = 0x2::table::borrow_mut<address, UserStake>(&mut arg0.user_stakes, v2);
            v4.pending_rewards = v4.pending_rewards + calculate_rewards(v4.amount, v1.apy, v3 - v4.last_reward_time);
            v4.amount = v4.amount + v0;
            v4.last_reward_time = v3;
        } else {
            let v5 = UserStake{
                amount           : v0,
                pool_id          : arg1,
                start_time       : v3,
                last_reward_time : v3,
                pending_rewards  : 0,
            };
            0x2::table::add<address, UserStake>(&mut arg0.user_stakes, v2, v5);
        };
        let v6 = Staked{
            user      : v2,
            amount    : v0,
            pool_id   : arg1,
            timestamp : v3,
        };
        0x2::event::emit<Staked>(v6);
    }

    public entry fun unstake(arg0: &mut SimpleUSDTVault, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 4);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<address, UserStake>(&arg0.user_stakes, v0), 6);
        let v1 = 0x2::clock::timestamp_ms(arg2) / 1000;
        let v2 = 0x2::table::borrow_mut<address, UserStake>(&mut arg0.user_stakes, v0);
        let v3 = 0x2::table::borrow_mut<u64, FarmingPool>(&mut arg0.pools, v2.pool_id);
        assert!(v2.amount >= arg1, 2);
        let v4 = v2.pending_rewards + calculate_rewards(arg1, v3.apy, v1 - v2.last_reward_time);
        let v5 = if (v1 - v2.start_time < v3.min_staking_period) {
            arg1 * v3.early_penalty / 10000
        } else {
            0
        };
        let v6 = if (v5 > 0) {
            arg1 - v5
        } else {
            arg1
        };
        v2.amount = v2.amount - arg1;
        v2.pending_rewards = 0;
        v2.last_reward_time = v1;
        v3.current_staked = v3.current_staked - arg1;
        arg0.total_rewards = arg0.total_rewards + v4;
        let v7 = Unstaked{
            user      : v0,
            amount    : v6,
            pool_id   : v2.pool_id,
            rewards   : v4,
            penalty   : v5,
            timestamp : v1,
        };
        0x2::event::emit<Unstaked>(v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x75f02ccbd03b4f16970dc39fe3717f704c564633cc154a6da997f30a3e73f629::tether_usdt_sui::TETHER_USDT_SUI>>(0x2::coin::from_balance<0x75f02ccbd03b4f16970dc39fe3717f704c564633cc154a6da997f30a3e73f629::tether_usdt_sui::TETHER_USDT_SUI>(0x2::balance::split<0x75f02ccbd03b4f16970dc39fe3717f704c564633cc154a6da997f30a3e73f629::tether_usdt_sui::TETHER_USDT_SUI>(&mut arg0.total_staked, v6 + v4), arg3), v0);
    }

    // decompiled from Move bytecode v6
}

