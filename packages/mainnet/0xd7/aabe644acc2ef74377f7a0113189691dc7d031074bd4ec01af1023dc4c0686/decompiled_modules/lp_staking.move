module 0xd7aabe644acc2ef74377f7a0113189691dc7d031074bd4ec01af1023dc4c0686::lp_staking {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct StakingPool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        total_staked: 0x2::balance::Balance<0xd7aabe644acc2ef74377f7a0113189691dc7d031074bd4ec01af1023dc4c0686::lp_coin::LP<T0, T1>>,
        reward_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        acc_reward_per_share: u128,
        total_rewards_distributed: u64,
        reward_per_second: u64,
        last_reward_time: u64,
        start_time: u64,
        end_time: u64,
        is_paused: bool,
    }

    struct StakePosition<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        owner: address,
        amount: u64,
        reward_debt: u128,
        staked_at: u64,
    }

    struct StakingRegistry has key {
        id: 0x2::object::UID,
        pools: 0x2::table::Table<address, bool>,
        total_pools: u64,
    }

    struct StakingPoolCreated has copy, drop {
        pool_id: address,
        reward_per_second: u64,
    }

    struct Staked has copy, drop {
        pool_id: address,
        user: address,
        amount: u64,
        total_staked: u64,
    }

    struct Unstaked has copy, drop {
        pool_id: address,
        user: address,
        amount: u64,
        rewards_claimed: u64,
    }

    struct RewardsClaimed has copy, drop {
        pool_id: address,
        user: address,
        amount: u64,
    }

    struct RewardsAdded has copy, drop {
        pool_id: address,
        amount: u64,
        new_total: u64,
    }

    public fun add_rewards<T0, T1>(arg0: &mut StakingPool<T0, T1>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock) {
        update_pool<T0, T1>(arg0, arg2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.reward_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v0 = RewardsAdded{
            pool_id   : 0x2::object::id_address<StakingPool<T0, T1>>(arg0),
            amount    : 0x2::coin::value<0x2::sui::SUI>(&arg1),
            new_total : 0x2::balance::value<0x2::sui::SUI>(&arg0.reward_balance),
        };
        0x2::event::emit<RewardsAdded>(v0);
    }

    fun calculate_pending<T0, T1>(arg0: &StakingPool<T0, T1>, arg1: u64, arg2: u128) : u64 {
        calculate_pending_with_acc(arg1, arg2, arg0.acc_reward_per_share)
    }

    fun calculate_pending_with_acc(arg0: u64, arg1: u128, arg2: u128) : u64 {
        let v0 = (arg0 as u128) * arg2 / 1000000000000;
        if (v0 > arg1) {
            ((v0 - arg1) as u64)
        } else {
            0
        }
    }

    public fun claim_rewards<T0, T1>(arg0: &mut StakingPool<T0, T1>, arg1: &mut StakePosition<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg1.owner == 0x2::tx_context::sender(arg3), 0);
        update_pool<T0, T1>(arg0, arg2);
        let v0 = calculate_pending<T0, T1>(arg0, arg1.amount, arg1.reward_debt);
        arg1.reward_debt = (arg1.amount as u128) * arg0.acc_reward_per_share / 1000000000000;
        let v1 = if (v0 > 0 && 0x2::balance::value<0x2::sui::SUI>(&arg0.reward_balance) >= v0) {
            v0
        } else {
            0
        };
        assert!(v1 > 0, 3);
        arg0.total_rewards_distributed = arg0.total_rewards_distributed + v1;
        let v2 = RewardsClaimed{
            pool_id : 0x2::object::id_address<StakingPool<T0, T1>>(arg0),
            user    : 0x2::tx_context::sender(arg3),
            amount  : v1,
        };
        0x2::event::emit<RewardsClaimed>(v2);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.reward_balance, v1), arg3)
    }

    public fun create_staking_pool<T0, T1>(arg0: &AdminCap, arg1: &mut StakingRegistry, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : StakingPool<T0, T1> {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = StakingPool<T0, T1>{
            id                        : 0x2::object::new(arg4),
            total_staked              : 0x2::balance::zero<0xd7aabe644acc2ef74377f7a0113189691dc7d031074bd4ec01af1023dc4c0686::lp_coin::LP<T0, T1>>(),
            reward_balance            : 0x2::balance::zero<0x2::sui::SUI>(),
            acc_reward_per_share      : 0,
            total_rewards_distributed : 0,
            reward_per_second         : arg2,
            last_reward_time          : v0,
            start_time                : v0,
            end_time                  : 0,
            is_paused                 : false,
        };
        let v2 = 0x2::object::id_address<StakingPool<T0, T1>>(&v1);
        0x2::table::add<address, bool>(&mut arg1.pools, v2, true);
        arg1.total_pools = arg1.total_pools + 1;
        let v3 = StakingPoolCreated{
            pool_id           : v2,
            reward_per_second : arg2,
        };
        0x2::event::emit<StakingPoolCreated>(v3);
        v1
    }

    public fun estimate_apr<T0, T1>(arg0: &StakingPool<T0, T1>) : u64 {
        let v0 = 0x2::balance::value<0xd7aabe644acc2ef74377f7a0113189691dc7d031074bd4ec01af1023dc4c0686::lp_coin::LP<T0, T1>>(&arg0.total_staked);
        if (v0 == 0) {
            return 0
        };
        (((arg0.reward_per_second as u128) * 31536000 * 10000 / (v0 as u128)) as u64)
    }

    public fun get_reward_balance<T0, T1>(arg0: &StakingPool<T0, T1>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.reward_balance)
    }

    public fun get_reward_rate<T0, T1>(arg0: &StakingPool<T0, T1>) : u64 {
        arg0.reward_per_second
    }

    public fun get_stake_amount<T0, T1>(arg0: &StakePosition<T0, T1>) : u64 {
        arg0.amount
    }

    public fun get_stake_owner<T0, T1>(arg0: &StakePosition<T0, T1>) : address {
        arg0.owner
    }

    public fun get_total_staked<T0, T1>(arg0: &StakingPool<T0, T1>) : u64 {
        0x2::balance::value<0xd7aabe644acc2ef74377f7a0113189691dc7d031074bd4ec01af1023dc4c0686::lp_coin::LP<T0, T1>>(&arg0.total_staked)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = StakingRegistry{
            id          : 0x2::object::new(arg0),
            pools       : 0x2::table::new<address, bool>(arg0),
            total_pools : 0,
        };
        0x2::transfer::share_object<StakingRegistry>(v1);
    }

    public fun is_paused<T0, T1>(arg0: &StakingPool<T0, T1>) : bool {
        arg0.is_paused
    }

    public fun pending_rewards<T0, T1>(arg0: &StakingPool<T0, T1>, arg1: &StakePosition<T0, T1>, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::balance::value<0xd7aabe644acc2ef74377f7a0113189691dc7d031074bd4ec01af1023dc4c0686::lp_coin::LP<T0, T1>>(&arg0.total_staked);
        if (v0 == 0) {
            return 0
        };
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = if (v1 > arg0.last_reward_time) {
            (v1 - arg0.last_reward_time) / 1000
        } else {
            0
        };
        calculate_pending_with_acc(arg1.amount, arg1.reward_debt, arg0.acc_reward_per_share + ((v2 * arg0.reward_per_second) as u128) * 1000000000000 / (v0 as u128))
    }

    public fun share_staking_pool<T0, T1>(arg0: StakingPool<T0, T1>) {
        0x2::transfer::share_object<StakingPool<T0, T1>>(arg0);
    }

    public fun stake<T0, T1>(arg0: &mut StakingPool<T0, T1>, arg1: 0x2::coin::Coin<0xd7aabe644acc2ef74377f7a0113189691dc7d031074bd4ec01af1023dc4c0686::lp_coin::LP<T0, T1>>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : StakePosition<T0, T1> {
        assert!(!arg0.is_paused, 4);
        update_pool<T0, T1>(arg0, arg2);
        let v0 = 0x2::coin::value<0xd7aabe644acc2ef74377f7a0113189691dc7d031074bd4ec01af1023dc4c0686::lp_coin::LP<T0, T1>>(&arg1);
        assert!(v0 > 0, 1);
        0x2::balance::join<0xd7aabe644acc2ef74377f7a0113189691dc7d031074bd4ec01af1023dc4c0686::lp_coin::LP<T0, T1>>(&mut arg0.total_staked, 0x2::coin::into_balance<0xd7aabe644acc2ef74377f7a0113189691dc7d031074bd4ec01af1023dc4c0686::lp_coin::LP<T0, T1>>(arg1));
        let v1 = StakePosition<T0, T1>{
            id          : 0x2::object::new(arg3),
            owner       : 0x2::tx_context::sender(arg3),
            amount      : v0,
            reward_debt : (v0 as u128) * arg0.acc_reward_per_share / 1000000000000,
            staked_at   : 0x2::clock::timestamp_ms(arg2),
        };
        let v2 = Staked{
            pool_id      : 0x2::object::id_address<StakingPool<T0, T1>>(arg0),
            user         : 0x2::tx_context::sender(arg3),
            amount       : v0,
            total_staked : 0x2::balance::value<0xd7aabe644acc2ef74377f7a0113189691dc7d031074bd4ec01af1023dc4c0686::lp_coin::LP<T0, T1>>(&arg0.total_staked),
        };
        0x2::event::emit<Staked>(v2);
        v1
    }

    public entry fun toggle_pause<T0, T1>(arg0: &AdminCap, arg1: &mut StakingPool<T0, T1>) {
        arg1.is_paused = !arg1.is_paused;
    }

    public fun unstake<T0, T1>(arg0: &mut StakingPool<T0, T1>, arg1: StakePosition<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xd7aabe644acc2ef74377f7a0113189691dc7d031074bd4ec01af1023dc4c0686::lp_coin::LP<T0, T1>>, 0x2::coin::Coin<0x2::sui::SUI>) {
        let StakePosition {
            id          : v0,
            owner       : v1,
            amount      : v2,
            reward_debt : v3,
            staked_at   : _,
        } = arg1;
        assert!(v1 == 0x2::tx_context::sender(arg3), 0);
        update_pool<T0, T1>(arg0, arg2);
        let v5 = calculate_pending<T0, T1>(arg0, v2, v3);
        let v6 = if (v5 > 0 && 0x2::balance::value<0x2::sui::SUI>(&arg0.reward_balance) >= v5) {
            v5
        } else {
            0
        };
        let v7 = if (v6 > 0) {
            arg0.total_rewards_distributed = arg0.total_rewards_distributed + v6;
            0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.reward_balance, v6), arg3)
        } else {
            0x2::coin::zero<0x2::sui::SUI>(arg3)
        };
        let v8 = Unstaked{
            pool_id         : 0x2::object::id_address<StakingPool<T0, T1>>(arg0),
            user            : 0x2::tx_context::sender(arg3),
            amount          : v2,
            rewards_claimed : v6,
        };
        0x2::event::emit<Unstaked>(v8);
        0x2::object::delete(v0);
        (0x2::coin::from_balance<0xd7aabe644acc2ef74377f7a0113189691dc7d031074bd4ec01af1023dc4c0686::lp_coin::LP<T0, T1>>(0x2::balance::split<0xd7aabe644acc2ef74377f7a0113189691dc7d031074bd4ec01af1023dc4c0686::lp_coin::LP<T0, T1>>(&mut arg0.total_staked, v2), arg3), v7)
    }

    fun update_pool<T0, T1>(arg0: &mut StakingPool<T0, T1>, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 <= arg0.last_reward_time) {
            return
        };
        let v1 = 0x2::balance::value<0xd7aabe644acc2ef74377f7a0113189691dc7d031074bd4ec01af1023dc4c0686::lp_coin::LP<T0, T1>>(&arg0.total_staked);
        if (v1 == 0) {
            arg0.last_reward_time = v0;
            return
        };
        let v2 = (v0 - arg0.last_reward_time) / 1000 * arg0.reward_per_second;
        if (v2 > 0) {
            arg0.acc_reward_per_share = arg0.acc_reward_per_share + (v2 as u128) * 1000000000000 / (v1 as u128);
        };
        arg0.last_reward_time = v0;
    }

    public entry fun update_reward_rate<T0, T1>(arg0: &AdminCap, arg1: &mut StakingPool<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock) {
        update_pool<T0, T1>(arg1, arg3);
        arg1.reward_per_second = arg2;
    }

    // decompiled from Move bytecode v6
}

