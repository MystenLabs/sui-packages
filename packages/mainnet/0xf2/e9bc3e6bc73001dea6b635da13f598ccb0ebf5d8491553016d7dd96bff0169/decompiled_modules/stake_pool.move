module 0xf2e9bc3e6bc73001dea6b635da13f598ccb0ebf5d8491553016d7dd96bff0169::stake_pool {
    struct STAKE_POOL has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ManagerCap has store, key {
        id: 0x2::object::UID,
    }

    struct TreasureCap has store, key {
        id: 0x2::object::UID,
    }

    struct StakeItem has copy, drop, store {
        pool: address,
        stake: u128,
        withdraw_stake: u128,
        reward: u128,
        reward_remaining: u128,
        reward_claimed: u128,
        stake_time: u64,
        unlock_time: u64,
        unstaked: bool,
        last_updated_time: u64,
    }

    struct StakePool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        apy: u128,
        paused: bool,
        unlock_times: u64,
        stake_coins: 0x2::balance::Balance<T0>,
        reward_coins: 0x2::balance::Balance<T1>,
        stakes: 0x2::table::Table<address, vector<StakeItem>>,
    }

    struct Config has store, key {
        id: 0x2::object::UID,
        version: u64,
        pools: vector<address>,
        user_pools: 0x2::table::Table<address, vector<address>>,
    }

    struct StakeEvent has copy, drop, store {
        pool: address,
        user_address: address,
        amount: u128,
        apy: u128,
        unlock_time: u64,
        pool_total_stake: u128,
        user_total_staked: u128,
        user_total_withdraw: u128,
        user_total_reward_remain: u128,
    }

    struct UnStakeEvent has copy, drop, store {
        pool: address,
        user_address: address,
        unstake_amount: u128,
        reward_amount: u128,
        user_total_stake: u128,
        user_total_withdraw_stake: u128,
        user_total_reward_remaining: u128,
        user_total_reward_claimed: u128,
    }

    struct StakeRewardsEvent has copy, drop, store {
        pool: address,
        user_address: address,
        amount: u128,
        pool_total_stake: u128,
        user_total_stake: u128,
        user_total_withdraw_stake: u128,
        user_total_reward_remaining: u128,
        user_total_reward_claimed: u128,
    }

    struct ClaimRewardsEvent has copy, drop, store {
        pool: address,
        user_address: address,
        amount: u128,
        user_total_stake: u128,
        user_total_withdraw_stake: u128,
        user_total_reward_remaining: u128,
        user_total_reward_claimed: u128,
    }

    struct CreatePoolEvent has copy, drop {
        pool: address,
        unlock_times: u64,
        apy: u128,
    }

    struct PausePoolEvent has copy, drop, store {
        pool: address,
        paused: bool,
    }

    struct UpdateUnlockTimeEvent has copy, drop, store {
        pool: address,
        old_unlock_time: u64,
        new_unclock_time: u64,
    }

    struct UpdateUserUnlockTimeEvent has copy, drop, store {
        pool: address,
        user_address: address,
        amount: u128,
        stake_time: u64,
        old_unlock_time: u64,
        new_unlock_time: u64,
    }

    struct UpdateApyEvent has copy, drop, store {
        pool: address,
        user_address: address,
        old_apy: u128,
        new_apy: u128,
        user_total_stake: u128,
        user_total_withdraw_stake: u128,
        user_total_reward: u128,
        user_total_reward_remaining: u128,
        user_last_updated_time: u64,
    }

    struct WithdarawStakeEvent has copy, drop, store {
        pool: address,
        amount: u128,
        pool_total_stake: u128,
    }

    struct DepositRewardEvent has copy, drop, store {
        pool: address,
        amount: u128,
        pool_total_reward: u128,
    }

    struct WithdarawRewardEvent has copy, drop, store {
        pool: address,
        amount: u128,
        pool_total_reward: u128,
    }

    struct StopEmergencyEvent has copy, drop, store {
        pool: address,
        pool_total_stake: u128,
        paused: bool,
    }

    fun add_pool_to_registry(arg0: &mut Config, arg1: address, arg2: address) {
        if (0x2::table::contains<address, vector<address>>(&arg0.user_pools, arg1)) {
            let v0 = 0x2::table::borrow_mut<address, vector<address>>(&mut arg0.user_pools, arg1);
            let (v1, _) = 0x1::vector::index_of<address>(v0, &arg2);
            if (!v1) {
                0x1::vector::push_back<address>(v0, arg2);
            };
        } else {
            let v3 = 0x1::vector::empty<address>();
            0x1::vector::push_back<address>(&mut v3, arg2);
            0x2::table::add<address, vector<address>>(&mut arg0.user_pools, arg1, v3);
        };
    }

    fun add_stake_item_to_pool<T0, T1>(arg0: &mut StakePool<T0, T1>, arg1: address, arg2: StakeItem) {
        if (0x2::table::contains<address, vector<StakeItem>>(&arg0.stakes, arg1)) {
            0x1::vector::push_back<StakeItem>(0x2::table::borrow_mut<address, vector<StakeItem>>(&mut arg0.stakes, arg1), arg2);
        } else {
            let v0 = 0x1::vector::empty<StakeItem>();
            0x1::vector::push_back<StakeItem>(&mut v0, arg2);
            0x2::table::add<address, vector<StakeItem>>(&mut arg0.stakes, arg1, v0);
        };
    }

    public fun change_admin(arg0: AdminCap, arg1: &Config, arg2: address) {
        assert!(arg1.version == 1, 8001);
        0x2::transfer::public_transfer<AdminCap>(arg0, arg2);
    }

    public fun change_manager(arg0: ManagerCap, arg1: &Config, arg2: address) {
        assert!(arg1.version == 1, 8001);
        0x2::transfer::public_transfer<ManagerCap>(arg0, arg2);
    }

    public fun change_treasure(arg0: TreasureCap, arg1: &Config, arg2: address) {
        assert!(arg1.version == 1, 8001);
        0x2::transfer::public_transfer<TreasureCap>(arg0, arg2);
    }

    public fun claim_reward<T0, T1>(arg0: &mut StakePool<T0, T1>, arg1: &Config, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 8001);
        assert!(!arg0.paused, 8006);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<address, vector<StakeItem>>(&arg0.stakes, v1), 8004);
        let v2 = 0x2::table::borrow_mut<address, vector<StakeItem>>(&mut arg0.stakes, v1);
        let v3 = 0;
        let v4 = 0;
        while (v3 < 0x1::vector::length<StakeItem>(v2)) {
            let v5 = 0x1::vector::borrow_mut<StakeItem>(v2, v3);
            if (!v5.unstaked) {
                update_reward_remaining(arg0.apy, v0, v5);
                v4 = v4 + v5.reward;
                v5.reward_claimed = v5.reward_claimed + v5.reward;
                v5.reward = 0;
            };
            v3 = v3 + 1;
        };
        assert!(v4 > 0 && (0x2::balance::value<T1>(&arg0.reward_coins) as u128) >= v4, 8005);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.reward_coins, (v4 as u64)), arg3), v1);
        let (v6, v7, _, v9, v10) = get_user_stake_info_in_a_pool<T0, T1>(arg0, v1, v0);
        let v11 = ClaimRewardsEvent{
            pool                        : 0x2::object::id_address<StakePool<T0, T1>>(arg0),
            user_address                : v1,
            amount                      : v4,
            user_total_stake            : v6,
            user_total_withdraw_stake   : v7,
            user_total_reward_remaining : v10,
            user_total_reward_claimed   : v9,
        };
        0x2::event::emit<ClaimRewardsEvent>(v11);
    }

    public fun create_pool<T0, T1>(arg0: &ManagerCap, arg1: &mut Config, arg2: u64, arg3: u128, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 8001);
        assert!(arg3 > 0, 8001);
        let v0 = StakePool<T0, T1>{
            id           : 0x2::object::new(arg4),
            apy          : arg3,
            paused       : false,
            unlock_times : arg2,
            stake_coins  : 0x2::balance::zero<T0>(),
            reward_coins : 0x2::balance::zero<T1>(),
            stakes       : 0x2::table::new<address, vector<StakeItem>>(arg4),
        };
        0x1::vector::push_back<address>(&mut arg1.pools, 0x2::object::id_address<StakePool<T0, T1>>(&v0));
        let v1 = CreatePoolEvent{
            pool         : 0x2::object::id_address<StakePool<T0, T1>>(&v0),
            unlock_times : arg2,
            apy          : arg3,
        };
        0x2::event::emit<CreatePoolEvent>(v1);
        0x2::transfer::share_object<StakePool<T0, T1>>(v0);
    }

    public fun deposit_reward_coins<T0, T1>(arg0: &TreasureCap, arg1: &mut StakePool<T0, T1>, arg2: &Config, arg3: 0x2::coin::Coin<T1>) {
        assert!(arg2.version == 1, 8001);
        let v0 = (0x2::coin::value<T1>(&arg3) as u128);
        assert!(v0 > 0, 8002);
        0x2::balance::join<T1>(&mut arg1.reward_coins, 0x2::coin::into_balance<T1>(arg3));
        let v1 = DepositRewardEvent{
            pool              : 0x2::object::id_address<StakePool<T0, T1>>(arg1),
            amount            : v0,
            pool_total_reward : (0x2::balance::value<T1>(&arg1.reward_coins) as u128),
        };
        0x2::event::emit<DepositRewardEvent>(v1);
    }

    public fun get_user_claimable_tokens<T0, T1>(arg0: &mut StakePool<T0, T1>, arg1: address, arg2: u64) : (u128, u128) {
        let v0 = 0x2::table::borrow_mut<address, vector<StakeItem>>(&mut arg0.stakes, arg1);
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        while (v1 < 0x1::vector::length<StakeItem>(v0)) {
            let v4 = 0x1::vector::borrow_mut<StakeItem>(v0, v1);
            if (!v4.unstaked) {
                update_reward_remaining(arg0.apy, arg2, v4);
            };
            if (arg2 >= v4.unlock_time) {
                v3 = v3 + v4.stake;
            };
            v2 = v2 + v4.reward;
        };
        (v2, v3)
    }

    public fun get_user_stake_info_in_a_pool<T0, T1>(arg0: &mut StakePool<T0, T1>, arg1: address, arg2: u64) : (u128, u128, u128, u128, u128) {
        let v0 = 0x2::table::borrow_mut<address, vector<StakeItem>>(&mut arg0.stakes, arg1);
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        while (v6 < 0x1::vector::length<StakeItem>(v0)) {
            let v7 = 0x1::vector::borrow_mut<StakeItem>(v0, v6);
            v5 = v5 + v7.stake;
            v4 = v4 + v7.withdraw_stake;
            if (!v7.unstaked) {
                update_reward_remaining(arg0.apy, arg2, v7);
            };
            v3 = v3 + v7.reward;
            v2 = v2 + v7.reward_claimed;
            v1 = v1 + v7.reward_remaining;
            v6 = v6 + 1;
        };
        (v5, v4, v3, v2, v1)
    }

    fun init(arg0: STAKE_POOL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        let v1 = ManagerCap{id: 0x2::object::new(arg1)};
        let v2 = TreasureCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<ManagerCap>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<TreasureCap>(v2, 0x2::tx_context::sender(arg1));
        let v3 = Config{
            id         : 0x2::object::new(arg1),
            version    : 1,
            pools      : 0x1::vector::empty<address>(),
            user_pools : 0x2::table::new<address, vector<address>>(arg1),
        };
        0x2::transfer::share_object<Config>(v3);
    }

    public fun migrate(arg0: &AdminCap, arg1: &mut Config) {
        assert!(arg1.version < 1, 8007);
        arg1.version = 1;
    }

    public fun pause<T0, T1>(arg0: &ManagerCap, arg1: &mut StakePool<T0, T1>, arg2: bool, arg3: &Config) {
        assert!(arg3.version == 1, 8001);
        arg1.paused = arg2;
        let v0 = PausePoolEvent{
            pool   : 0x2::object::id_address<StakePool<T0, T1>>(arg1),
            paused : arg2,
        };
        0x2::event::emit<PausePoolEvent>(v0);
    }

    public fun restake<T0, T1>(arg0: &mut StakePool<T0, T1>, arg1: &Config, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 8001);
        assert!(!arg0.paused, 8006);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<address, vector<StakeItem>>(&arg0.stakes, v1), 8003);
        let v2 = 0x2::table::borrow_mut<address, vector<StakeItem>>(&mut arg0.stakes, v1);
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        while (v3 < 0x1::vector::length<StakeItem>(v2)) {
            let v6 = 0x1::vector::borrow_mut<StakeItem>(v2, v3);
            if (!v6.unstaked) {
                update_reward_remaining(arg0.apy, v0, v6);
                v5 = v5 + v6.stake;
                v4 = v4 + v6.reward;
                v6.reward_claimed = v6.reward_claimed + v6.reward;
                v6.reward = 0;
                v6.withdraw_stake = v6.stake;
                v6.reward_remaining = 0;
                v6.unstaked = true;
            };
            v3 = v3 + 1;
        };
        if (v4 > 0) {
            assert!((0x2::balance::value<T1>(&arg0.reward_coins) as u128) >= v4, 8005);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.reward_coins, (v4 as u64)), arg3), v1);
        };
        let v7 = StakeItem{
            pool              : 0x2::object::id_address<StakePool<T0, T1>>(arg0),
            stake             : v5,
            withdraw_stake    : 0,
            reward            : 0,
            reward_remaining  : (arg0.unlock_times as u128) * v5 * arg0.apy / 31536000000 * 10000,
            reward_claimed    : 0,
            stake_time        : v0,
            unlock_time       : v0 + arg0.unlock_times,
            unstaked          : false,
            last_updated_time : v0,
        };
        add_stake_item_to_pool<T0, T1>(arg0, v1, v7);
        let (v8, v9, _, _, v12) = get_user_stake_info_in_a_pool<T0, T1>(arg0, v1, v0);
        let v13 = StakeEvent{
            pool                     : 0x2::object::id_address<StakePool<T0, T1>>(arg0),
            user_address             : v1,
            amount                   : v5,
            apy                      : arg0.apy,
            unlock_time              : v7.unlock_time,
            pool_total_stake         : (0x2::balance::value<T0>(&arg0.stake_coins) as u128),
            user_total_staked        : v8,
            user_total_withdraw      : v9,
            user_total_reward_remain : v12,
        };
        0x2::event::emit<StakeEvent>(v13);
    }

    public fun stake<T0, T1>(arg0: &mut StakePool<T0, T1>, arg1: &mut Config, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 8001);
        assert!(!arg0.paused, 8006);
        let v0 = (0x2::coin::value<T0>(&arg2) as u128);
        assert!(v0 > 0, 8002);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = arg0.apy;
        let v3 = 0x2::clock::timestamp_ms(arg3);
        let v4 = StakeItem{
            pool              : 0x2::object::id_address<StakePool<T0, T1>>(arg0),
            stake             : v0,
            withdraw_stake    : 0,
            reward            : 0,
            reward_remaining  : (arg0.unlock_times as u128) * v0 * v2 / 31536000000 * 10000,
            reward_claimed    : 0,
            stake_time        : v3,
            unlock_time       : v3 + arg0.unlock_times,
            unstaked          : false,
            last_updated_time : v3,
        };
        add_stake_item_to_pool<T0, T1>(arg0, v1, v4);
        add_pool_to_registry(arg1, v1, 0x2::object::id_address<StakePool<T0, T1>>(arg0));
        let (v5, v6, _, _, v9) = get_user_stake_info_in_a_pool<T0, T1>(arg0, v1, v3);
        0x2::balance::join<T0>(&mut arg0.stake_coins, 0x2::coin::into_balance<T0>(arg2));
        let v10 = StakeEvent{
            pool                     : 0x2::object::id_address<StakePool<T0, T1>>(arg0),
            user_address             : v1,
            amount                   : v0,
            apy                      : v2,
            unlock_time              : v4.unlock_time,
            pool_total_stake         : (0x2::balance::value<T0>(&arg0.stake_coins) as u128),
            user_total_staked        : v5,
            user_total_withdraw      : v6,
            user_total_reward_remain : v9,
        };
        0x2::event::emit<StakeEvent>(v10);
    }

    public fun stake_reward<T0, T1>(arg0: &mut StakePool<T0, T1>, arg1: &Config, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 8001);
        assert!(!arg0.paused, 8006);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<address, vector<StakeItem>>(&arg0.stakes, v1), 8003);
        let v2 = 0x2::table::borrow_mut<address, vector<StakeItem>>(&mut arg0.stakes, v1);
        let v3 = 0;
        let v4 = 0;
        while (v3 < 0x1::vector::length<StakeItem>(v2)) {
            let v5 = 0x1::vector::borrow_mut<StakeItem>(v2, v3);
            if (!v5.unstaked) {
                update_reward_remaining(arg0.apy, v0, v5);
                v5.stake = v5.stake + v5.reward;
                v4 = v4 + v5.reward;
                v5.reward_claimed = v5.reward_claimed + v5.reward;
                v5.reward = 0;
            };
            v3 = v3 + 1;
        };
        assert!(v4 > 0, 8003);
        let (v6, v7, _, v9, v10) = get_user_stake_info_in_a_pool<T0, T1>(arg0, v1, v0);
        let v11 = StakeRewardsEvent{
            pool                        : 0x2::object::id_address<StakePool<T0, T1>>(arg0),
            user_address                : v1,
            amount                      : v4,
            pool_total_stake            : (0x2::balance::value<T0>(&arg0.stake_coins) as u128) + v4,
            user_total_stake            : v6,
            user_total_withdraw_stake   : v7,
            user_total_reward_remaining : v10,
            user_total_reward_claimed   : v9,
        };
        0x2::event::emit<StakeRewardsEvent>(v11);
    }

    public fun stop_emergency<T0, T1>(arg0: &ManagerCap, arg1: &mut StakePool<T0, T1>, arg2: &Config, arg3: vector<address>, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.version == 1, 8001);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg3)) {
            let v1 = *0x1::vector::borrow<address>(&arg3, v0);
            if (0x2::table::contains<address, vector<StakeItem>>(&arg1.stakes, v1)) {
                let v2 = 0x2::table::borrow_mut<address, vector<StakeItem>>(&mut arg1.stakes, v1);
                let v3 = 0;
                let v4 = 0;
                while (v3 < 0x1::vector::length<StakeItem>(v2)) {
                    let v5 = 0x1::vector::borrow_mut<StakeItem>(v2, v3);
                    if (!v5.unstaked) {
                        v4 = v4 + v5.stake;
                        v5.withdraw_stake = v5.stake;
                        v5.unstaked = true;
                    };
                    v3 = v3 + 1;
                };
                assert!(v4 > 0 && (0x2::balance::value<T0>(&arg1.stake_coins) as u128) >= v4, 8003);
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.stake_coins, (v4 as u64)), arg5), v1);
            };
            v0 = v0 + 1;
        };
        arg1.paused = arg4;
        let v6 = StopEmergencyEvent{
            pool             : 0x2::object::id_address<StakePool<T0, T1>>(arg1),
            pool_total_stake : (0x2::balance::value<T0>(&arg1.stake_coins) as u128),
            paused           : arg4,
        };
        0x2::event::emit<StopEmergencyEvent>(v6);
    }

    public fun unstake<T0, T1>(arg0: &mut StakePool<T0, T1>, arg1: &Config, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 8001);
        assert!(!arg0.paused, 8006);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<address, vector<StakeItem>>(&arg0.stakes, v1), 8004);
        let v2 = 0x2::table::borrow_mut<address, vector<StakeItem>>(&mut arg0.stakes, v1);
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        while (v3 < 0x1::vector::length<StakeItem>(v2)) {
            let v6 = 0x1::vector::borrow_mut<StakeItem>(v2, v3);
            if (!v6.unstaked && v0 >= v6.unlock_time) {
                update_reward_remaining(arg0.apy, v0, v6);
                v4 = v4 + v6.reward;
                v5 = v5 + v6.stake;
                v6.reward_claimed = v6.reward_claimed + v6.reward;
                v6.reward = 0;
                v6.withdraw_stake = v6.stake;
                v6.unstaked = true;
            };
            v3 = v3 + 1;
        };
        if (v4 > 0) {
            assert!((0x2::balance::value<T1>(&arg0.reward_coins) as u128) >= v4, 8005);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.reward_coins, (v4 as u64)), arg3), v1);
        };
        assert!(v5 > 0 && (0x2::balance::value<T0>(&arg0.stake_coins) as u128) >= v5, 8003);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.stake_coins, (v5 as u64)), arg3), v1);
        let (v7, v8, _, v10, v11) = get_user_stake_info_in_a_pool<T0, T1>(arg0, v1, v0);
        let v12 = UnStakeEvent{
            pool                        : 0x2::object::id_address<StakePool<T0, T1>>(arg0),
            user_address                : v1,
            unstake_amount              : v5,
            reward_amount               : v4,
            user_total_stake            : v7,
            user_total_withdraw_stake   : v8,
            user_total_reward_remaining : v11,
            user_total_reward_claimed   : v10,
        };
        0x2::event::emit<UnStakeEvent>(v12);
    }

    public fun update_apy<T0, T1>(arg0: &ManagerCap, arg1: &mut StakePool<T0, T1>, arg2: &Config, arg3: vector<address>, arg4: u128, arg5: &0x2::clock::Clock) {
        assert!(arg2.version == 1, 8001);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = arg1.apy;
        arg1.apy = arg4;
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&arg3)) {
            let v3 = *0x1::vector::borrow<address>(&arg3, v2);
            if (0x2::table::contains<address, vector<StakeItem>>(&arg1.stakes, v3)) {
                let v4 = 0x2::table::borrow_mut<address, vector<StakeItem>>(&mut arg1.stakes, v3);
                let v5 = 0;
                while (v5 < 0x1::vector::length<StakeItem>(v4)) {
                    let v6 = 0x1::vector::borrow_mut<StakeItem>(v4, v5);
                    if (!v6.unstaked) {
                        update_reward_remaining(v1, v0, v6);
                    };
                    v5 = v5 + 1;
                };
                let (v7, v8, v9, _, v11) = get_user_stake_info_in_a_pool<T0, T1>(arg1, v3, v0);
                let v12 = UpdateApyEvent{
                    pool                        : 0x2::object::id_address<StakePool<T0, T1>>(arg1),
                    user_address                : v3,
                    old_apy                     : v1,
                    new_apy                     : arg4,
                    user_total_stake            : v7,
                    user_total_withdraw_stake   : v8,
                    user_total_reward           : v9,
                    user_total_reward_remaining : v11,
                    user_last_updated_time      : v0,
                };
                0x2::event::emit<UpdateApyEvent>(v12);
            };
            v2 = v2 + 1;
        };
    }

    fun update_reward_remaining(arg0: u128, arg1: u64, arg2: &mut StakeItem) {
        assert!(arg0 > 0, 8001);
        if (arg2.reward_remaining > 0) {
            let v0 = ((arg1 - arg2.last_updated_time) as u128) * arg2.stake * arg0 / 31536000000 * 10000;
            if (arg2.reward_remaining >= v0) {
                arg2.reward = arg2.reward + v0;
                arg2.reward_remaining = arg2.reward_remaining - v0;
            } else {
                arg2.reward = arg2.reward + arg2.reward_remaining;
                arg2.reward_remaining = 0;
            };
            arg2.last_updated_time = arg1;
        };
    }

    public fun update_unlock_time<T0, T1>(arg0: &ManagerCap, arg1: &mut StakePool<T0, T1>, arg2: &0x1::option::Option<vector<address>>, arg3: &Config, arg4: u64) {
        assert!(arg3.version == 1, 8001);
        assert!(!arg1.paused, 8006);
        assert!(arg4 > 0 && arg4 != arg1.unlock_times, 8001);
        let v0 = arg1.unlock_times;
        arg1.unlock_times = arg4;
        if (0x1::option::is_some<vector<address>>(arg2)) {
            let v1 = 0x1::option::borrow<vector<address>>(arg2);
            let v2 = 0;
            while (v2 < 0x1::vector::length<address>(v1)) {
                let v3 = *0x1::vector::borrow<address>(v1, v2);
                let v4 = 0x2::table::borrow_mut<address, vector<StakeItem>>(&mut arg1.stakes, v3);
                let v5 = 0;
                while (v5 < 0x1::vector::length<StakeItem>(v4)) {
                    let v6 = 0x1::vector::borrow_mut<StakeItem>(v4, v5);
                    v6.unlock_time = v6.stake_time + arg1.unlock_times;
                    let v7 = UpdateUserUnlockTimeEvent{
                        pool            : v6.pool,
                        user_address    : v3,
                        amount          : v6.stake,
                        stake_time      : v6.stake_time,
                        old_unlock_time : v0,
                        new_unlock_time : v6.unlock_time,
                    };
                    0x2::event::emit<UpdateUserUnlockTimeEvent>(v7);
                    v5 = v5 + 1;
                };
                v2 = v2 + 1;
            };
        };
        let v8 = UpdateUnlockTimeEvent{
            pool             : 0x2::object::id_address<StakePool<T0, T1>>(arg1),
            old_unlock_time  : v0,
            new_unclock_time : arg4,
        };
        0x2::event::emit<UpdateUnlockTimeEvent>(v8);
    }

    public fun withdraw_reward_coins<T0, T1>(arg0: &TreasureCap, arg1: &mut StakePool<T0, T1>, arg2: &Config, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.version == 1, 8001);
        let v0 = (0x2::balance::value<T1>(&arg1.reward_coins) as u128);
        assert!(v0 > 0, 8003);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.reward_coins, (v0 as u64)), arg3), 0x2::tx_context::sender(arg3));
        let v1 = WithdarawRewardEvent{
            pool              : 0x2::object::id_address<StakePool<T0, T1>>(arg1),
            amount            : v0,
            pool_total_reward : (0x2::balance::value<T1>(&arg1.reward_coins) as u128),
        };
        0x2::event::emit<WithdarawRewardEvent>(v1);
    }

    public fun withdraw_stake_coins<T0, T1>(arg0: &TreasureCap, arg1: &mut StakePool<T0, T1>, arg2: &Config, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.version == 1, 8001);
        let v0 = (0x2::balance::value<T0>(&arg1.stake_coins) as u128);
        assert!(v0 > 0, 8003);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.stake_coins, (v0 as u64)), arg3), 0x2::tx_context::sender(arg3));
        let v1 = WithdarawStakeEvent{
            pool             : 0x2::object::id_address<StakePool<T0, T1>>(arg1),
            amount           : v0,
            pool_total_stake : (0x2::balance::value<T0>(&arg1.stake_coins) as u128),
        };
        0x2::event::emit<WithdarawStakeEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

