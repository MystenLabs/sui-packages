module 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::rewards {
    struct RewardState has copy, drop, store {
        emission_per_sec: u64,
        last_update_ts: u64,
        reward_per_lp: u128,
        start_ts: u64,
        end_ts: u64,
        total_emitted: u128,
        total_claimed: u128,
        reserved: u128,
    }

    struct UserReward has copy, drop, store {
        rewards: u64,
        reward_per_lp_paid: u128,
    }

    struct PoolRewards has store {
        total_staked: u64,
        lp_vault: 0x2::bag::Bag,
        reward_vault: 0x2::bag::Bag,
        reward_states: 0x2::vec_map::VecMap<0x1::type_name::TypeName, RewardState>,
        reward_types: vector<0x1::type_name::TypeName>,
        stakers: 0x2::linked_table::LinkedTable<address, Staker>,
    }

    struct Staker has store {
        amount: u64,
        rewards: 0x2::linked_table::LinkedTable<0x1::type_name::TypeName, UserReward>,
    }

    struct RewardsManager has store, key {
        id: 0x2::object::UID,
        pools: 0x2::linked_table::LinkedTable<0x2::object::ID, PoolRewards>,
    }

    struct InitRewardsManagerEvent has copy, drop {
        id: 0x2::object::ID,
    }

    struct RegisterPoolEvent has copy, drop {
        pool_id: 0x2::object::ID,
    }

    struct AddRewardTokenEvent has copy, drop {
        pool_id: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
        emission_per_sec: u64,
    }

    struct ScheduleRewardEvent has copy, drop {
        pool_id: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
        start_ts: u64,
        end_ts: u64,
        emission_per_sec: u64,
        reserved: u128,
    }

    struct FundEvent has copy, drop {
        reward_type: 0x1::type_name::TypeName,
        amount: u64,
        vault_balance: u64,
    }

    struct WithdrawEvent has copy, drop {
        pool_id: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct StakeEvent has copy, drop {
        pool_id: 0x2::object::ID,
        user: address,
        amount: u64,
        total_staked: u64,
    }

    struct UnstakeEvent has copy, drop {
        pool_id: 0x2::object::ID,
        user: address,
        amount: u64,
        total_staked: u64,
    }

    struct ClaimEvent has copy, drop {
        pool_id: 0x2::object::ID,
        user: address,
        reward_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct UserStakeEvent has copy, drop {
        pool_id: 0x2::object::ID,
        user: address,
        staked_amount: u64,
    }

    struct UserStakeAllEvent has copy, drop {
        infos: vector<UserStakeEvent>,
    }

    struct UserRewardInfoEvent has copy, drop {
        infos: vector<UserReward>,
    }

    public fun add_reward_token<T0, T1, T2: store, T3: drop, T4>(arg0: &mut RewardsManager, arg1: &0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::global_config::GlobalConfig, arg2: &0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::pool::Pool<T0, T1, T2, T3>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::global_config::check_package_version(arg1);
        0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::global_config::check_reward_manager_role(arg1, 0x2::tx_context::sender(arg4));
        let v0 = 0x2::object::id<0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::pool::Pool<T0, T1, T2, T3>>(arg2);
        assert!(0x2::linked_table::contains<0x2::object::ID, PoolRewards>(&arg0.pools, v0), 0);
        let v1 = 0x2::linked_table::borrow_mut<0x2::object::ID, PoolRewards>(&mut arg0.pools, v0);
        let v2 = 0x1::type_name::with_defining_ids<T4>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&v1.reward_vault, v2)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T4>>(&mut v1.reward_vault, v2, 0x2::balance::zero<T4>());
        };
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, RewardState>(&v1.reward_states, &v2)) {
            let v3 = 0x2::clock::timestamp_ms(arg3) / 1000;
            let v4 = RewardState{
                emission_per_sec : 0,
                last_update_ts   : v3,
                reward_per_lp    : 0,
                start_ts         : v3,
                end_ts           : v3,
                total_emitted    : 0,
                total_claimed    : 0,
                reserved         : 0,
            };
            0x2::vec_map::insert<0x1::type_name::TypeName, RewardState>(&mut v1.reward_states, v2, v4);
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut v1.reward_types, v2);
        };
        let v5 = AddRewardTokenEvent{
            pool_id          : v0,
            reward_type      : v2,
            emission_per_sec : 0,
        };
        0x2::event::emit<AddRewardTokenEvent>(v5);
    }

    public fun claim<T0, T1, T2: store, T3: drop, T4>(arg0: &mut RewardsManager, arg1: &0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::global_config::GlobalConfig, arg2: &0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::pool::Pool<T0, T1, T2, T3>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T4> {
        0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::global_config::check_package_version(arg1);
        let v0 = 0x2::object::id<0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::pool::Pool<T0, T1, T2, T3>>(arg2);
        assert!(0x2::linked_table::contains<0x2::object::ID, PoolRewards>(&arg0.pools, v0), 0);
        let v1 = 0x2::linked_table::borrow_mut<0x2::object::ID, PoolRewards>(&mut arg0.pools, v0);
        update_all_rewards(v1, arg3);
        settle_user_one<T4>(v1, 0x2::tx_context::sender(arg4));
        let v2 = 0x1::type_name::with_defining_ids<T4>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&v1.reward_vault, v2), 4);
        let v3 = 0x2::linked_table::borrow_mut<address, Staker>(&mut v1.stakers, 0x2::tx_context::sender(arg4));
        assert!(0x2::linked_table::contains<0x1::type_name::TypeName, UserReward>(&v3.rewards, v2), 3);
        let v4 = 0x2::linked_table::borrow_mut<0x1::type_name::TypeName, UserReward>(&mut v3.rewards, v2);
        let v5 = v4.rewards;
        if (v5 == 0) {
            return 0x2::coin::zero<T4>(arg4)
        };
        let v6 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T4>>(&mut v1.reward_vault, v2);
        let v7 = 0x2::balance::value<T4>(v6);
        let v8 = if (v7 >= v5) {
            v5
        } else {
            v7
        };
        assert!(v8 > 0, 4);
        v4.rewards = v4.rewards - v8;
        let v9 = 0x2::coin::from_balance<T4>(0x2::balance::split<T4>(v6, v8), arg4);
        let v10 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, RewardState>(&mut v1.reward_states, &v2);
        v10.total_claimed = v10.total_claimed + (v8 as u128);
        update_reserved(v10, arg3);
        let v11 = ClaimEvent{
            pool_id     : v0,
            user        : 0x2::tx_context::sender(arg4),
            reward_type : v2,
            amount      : v8,
        };
        0x2::event::emit<ClaimEvent>(v11);
        v9
    }

    fun ensure_lp_vault_and_join<T0>(arg0: &mut 0x2::bag::Bag, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(arg0, v0)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(arg0, v0, 0x2::balance::zero<T0>());
        };
        0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(arg0, v0), arg1);
    }

    fun ensure_staker(arg0: &mut PoolRewards, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (!0x2::linked_table::contains<address, Staker>(&arg0.stakers, arg1)) {
            let v0 = Staker{
                amount  : 0,
                rewards : 0x2::linked_table::new<0x1::type_name::TypeName, UserReward>(arg2),
            };
            0x2::linked_table::push_back<address, Staker>(&mut arg0.stakers, arg1, v0);
        };
    }

    fun ensure_staker_mut(arg0: &mut PoolRewards, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : &mut Staker {
        ensure_staker(arg0, arg1, arg2);
        0x2::linked_table::borrow_mut<address, Staker>(&mut arg0.stakers, arg1)
    }

    public fun fund<T0, T1, T2: store, T3: drop, T4>(arg0: &mut RewardsManager, arg1: &0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::global_config::GlobalConfig, arg2: &0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::pool::Pool<T0, T1, T2, T3>, arg3: 0x2::coin::Coin<T4>, arg4: &mut 0x2::tx_context::TxContext) {
        0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::global_config::check_package_version(arg1);
        assert!(0x2::coin::value<T4>(&arg3) > 0, 2);
        let v0 = 0x2::object::id<0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::pool::Pool<T0, T1, T2, T3>>(arg2);
        assert!(0x2::linked_table::contains<0x2::object::ID, PoolRewards>(&arg0.pools, v0), 0);
        let v1 = 0x2::linked_table::borrow_mut<0x2::object::ID, PoolRewards>(&mut arg0.pools, v0);
        let v2 = 0x1::type_name::with_defining_ids<T4>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&v1.reward_vault, v2)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T4>>(&mut v1.reward_vault, v2, 0x2::balance::zero<T4>());
        };
        let v3 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T4>>(&mut v1.reward_vault, v2);
        0x2::balance::join<T4>(v3, 0x2::coin::into_balance<T4>(arg3));
        let v4 = FundEvent{
            reward_type   : v2,
            amount        : 0x2::coin::value<T4>(&arg3),
            vault_balance : 0x2::balance::value<T4>(v3),
        };
        0x2::event::emit<FundEvent>(v4);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RewardsManager{
            id    : 0x2::object::new(arg0),
            pools : 0x2::linked_table::new<0x2::object::ID, PoolRewards>(arg0),
        };
        0x2::transfer::share_object<RewardsManager>(v0);
        let v1 = InitRewardsManagerEvent{id: 0x2::object::id<RewardsManager>(&v0)};
        0x2::event::emit<InitRewardsManagerEvent>(v1);
    }

    public fun is_pool_registered<T0, T1, T2: store, T3: drop>(arg0: &RewardsManager, arg1: &0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::pool::Pool<T0, T1, T2, T3>) : bool {
        0x2::linked_table::contains<0x2::object::ID, PoolRewards>(&arg0.pools, 0x2::object::id<0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::pool::Pool<T0, T1, T2, T3>>(arg1))
    }

    public fun register_pool<T0, T1, T2: store, T3: drop>(arg0: &mut RewardsManager, arg1: &0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::global_config::GlobalConfig, arg2: &0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::pool::Pool<T0, T1, T2, T3>, arg3: &mut 0x2::tx_context::TxContext) {
        0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::global_config::check_package_version(arg1);
        0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::global_config::check_reward_manager_role(arg1, 0x2::tx_context::sender(arg3));
        let v0 = 0x2::object::id<0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::pool::Pool<T0, T1, T2, T3>>(arg2);
        assert!(!0x2::linked_table::contains<0x2::object::ID, PoolRewards>(&arg0.pools, v0), 1);
        let v1 = PoolRewards{
            total_staked  : 0,
            lp_vault      : 0x2::bag::new(arg3),
            reward_vault  : 0x2::bag::new(arg3),
            reward_states : 0x2::vec_map::empty<0x1::type_name::TypeName, RewardState>(),
            reward_types  : 0x1::vector::empty<0x1::type_name::TypeName>(),
            stakers       : 0x2::linked_table::new<address, Staker>(arg3),
        };
        0x2::linked_table::push_back<0x2::object::ID, PoolRewards>(&mut arg0.pools, v0, v1);
        let v2 = RegisterPoolEvent{pool_id: v0};
        0x2::event::emit<RegisterPoolEvent>(v2);
    }

    public fun schedule_reward<T0, T1, T2: store, T3: drop, T4>(arg0: &mut RewardsManager, arg1: &0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::global_config::GlobalConfig, arg2: &0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::pool::Pool<T0, T1, T2, T3>, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::global_config::check_package_version(arg1);
        0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::global_config::check_reward_manager_role(arg1, 0x2::tx_context::sender(arg7));
        assert!(arg3 >= 0x2::clock::timestamp_ms(arg6) / 1000, 5);
        assert!(arg4 >= arg3, 2);
        let v0 = 0x2::object::id<0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::pool::Pool<T0, T1, T2, T3>>(arg2);
        assert!(0x2::linked_table::contains<0x2::object::ID, PoolRewards>(&arg0.pools, v0), 0);
        let v1 = 0x2::linked_table::borrow_mut<0x2::object::ID, PoolRewards>(&mut arg0.pools, v0);
        let v2 = 0x1::type_name::with_defining_ids<T4>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&v1.reward_vault, v2), 3);
        let v3 = (0x2::balance::value<T4>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T4>>(&mut v1.reward_vault, v2)) as u128);
        update_all_rewards(v1, arg6);
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, RewardState>(&v1.reward_states, &v2)) {
            let v4 = 0x2::clock::timestamp_ms(arg6) / 1000;
            let v5 = RewardState{
                emission_per_sec : 0,
                last_update_ts   : v4,
                reward_per_lp    : 0,
                start_ts         : v4,
                end_ts           : v4,
                total_emitted    : 0,
                total_claimed    : 0,
                reserved         : 0,
            };
            0x2::vec_map::insert<0x1::type_name::TypeName, RewardState>(&mut v1.reward_states, v2, v5);
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut v1.reward_types, v2);
        };
        let v6 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, RewardState>(&mut v1.reward_states, &v2);
        v6.last_update_ts = 0x2::clock::timestamp_ms(arg6) / 1000;
        v6.start_ts = arg3;
        v6.end_ts = arg4;
        v6.emission_per_sec = arg5;
        update_reserved(v6, arg6);
        assert!(v6.reserved <= v3, 4);
        let v7 = ScheduleRewardEvent{
            pool_id          : v0,
            reward_type      : v2,
            start_ts         : arg3,
            end_ts           : arg4,
            emission_per_sec : arg5,
            reserved         : v6.reserved,
        };
        0x2::event::emit<ScheduleRewardEvent>(v7);
    }

    fun settle_user_all(arg0: &mut PoolRewards, arg1: address) {
        if (!0x2::linked_table::contains<address, Staker>(&arg0.stakers, arg1)) {
            return
        };
        let v0 = 0x2::linked_table::borrow_mut<address, Staker>(&mut arg0.stakers, arg1);
        let v1 = v0.amount;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&arg0.reward_types)) {
            settle_user_one_impl(&arg0.reward_states, v0, v1, *0x1::vector::borrow<0x1::type_name::TypeName>(&arg0.reward_types, v2));
            v2 = v2 + 1;
        };
    }

    fun settle_user_one<T0>(arg0: &mut PoolRewards, arg1: address) {
        if (!0x2::linked_table::contains<address, Staker>(&arg0.stakers, arg1)) {
            return
        };
        let v0 = 0x2::linked_table::borrow_mut<address, Staker>(&mut arg0.stakers, arg1);
        let v1 = v0.amount;
        settle_user_one_impl(&arg0.reward_states, v0, v1, 0x1::type_name::with_defining_ids<T0>());
    }

    fun settle_user_one_impl(arg0: &0x2::vec_map::VecMap<0x1::type_name::TypeName, RewardState>, arg1: &mut Staker, arg2: u64, arg3: 0x1::type_name::TypeName) {
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, RewardState>(arg0, &arg3)) {
            return
        };
        let v0 = 0x2::vec_map::get<0x1::type_name::TypeName, RewardState>(arg0, &arg3).reward_per_lp;
        if (!0x2::linked_table::contains<0x1::type_name::TypeName, UserReward>(&arg1.rewards, arg3)) {
            let v1 = UserReward{
                rewards            : 0,
                reward_per_lp_paid : v0,
            };
            0x2::linked_table::push_back<0x1::type_name::TypeName, UserReward>(&mut arg1.rewards, arg3, v1);
            return
        };
        let v2 = 0x2::linked_table::borrow_mut<0x1::type_name::TypeName, UserReward>(&mut arg1.rewards, arg3);
        let v3 = v2.reward_per_lp_paid;
        if (v0 > v3 && arg2 > 0) {
            v2.rewards = v2.rewards + (0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::math128::mul_div_down((arg2 as u128), v0 - v3, 1000000) as u64);
        };
        v2.reward_per_lp_paid = v0;
    }

    public fun stake<T0, T1, T2: store, T3: drop>(arg0: &mut RewardsManager, arg1: &0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::global_config::GlobalConfig, arg2: &0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::pool::Pool<T0, T1, T2, T3>, arg3: &mut 0x2::coin::Coin<T3>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::global_config::check_package_version(arg1);
        assert!(arg4 > 0 && 0x2::coin::value<T3>(arg3) >= arg4, 2);
        let v0 = 0x2::object::id<0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::pool::Pool<T0, T1, T2, T3>>(arg2);
        assert!(0x2::linked_table::contains<0x2::object::ID, PoolRewards>(&arg0.pools, v0), 0);
        let v1 = 0x2::linked_table::borrow_mut<0x2::object::ID, PoolRewards>(&mut arg0.pools, v0);
        update_all_rewards(v1, arg5);
        let v2 = 0x2::tx_context::sender(arg6);
        ensure_staker(v1, v2, arg6);
        settle_user_all(v1, 0x2::tx_context::sender(arg6));
        let v3 = &mut v1.lp_vault;
        ensure_lp_vault_and_join<T3>(v3, 0x2::coin::into_balance<T3>(0x2::coin::split<T3>(arg3, arg4, arg6)));
        let v4 = 0x2::tx_context::sender(arg6);
        let v5 = ensure_staker_mut(v1, v4, arg6);
        v5.amount = v5.amount + arg4;
        v1.total_staked = v1.total_staked + arg4;
        let v6 = StakeEvent{
            pool_id      : v0,
            user         : 0x2::tx_context::sender(arg6),
            amount       : arg4,
            total_staked : v1.total_staked,
        };
        0x2::event::emit<StakeEvent>(v6);
    }

    public fun unstake<T0, T1, T2: store, T3: drop>(arg0: &mut RewardsManager, arg1: &0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::global_config::GlobalConfig, arg2: &0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::pool::Pool<T0, T1, T2, T3>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T3> {
        0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::global_config::check_package_version(arg1);
        assert!(arg3 > 0, 2);
        let v0 = 0x2::object::id<0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::pool::Pool<T0, T1, T2, T3>>(arg2);
        assert!(0x2::linked_table::contains<0x2::object::ID, PoolRewards>(&arg0.pools, v0), 0);
        let v1 = 0x2::linked_table::borrow_mut<0x2::object::ID, PoolRewards>(&mut arg0.pools, v0);
        update_all_rewards(v1, arg4);
        settle_user_all(v1, 0x2::tx_context::sender(arg5));
        let v2 = 0x2::tx_context::sender(arg5);
        let v3 = ensure_staker_mut(v1, v2, arg5);
        assert!(v3.amount >= arg3, 2);
        v3.amount = v3.amount - arg3;
        v1.total_staked = v1.total_staked - arg3;
        let v4 = UnstakeEvent{
            pool_id      : v0,
            user         : 0x2::tx_context::sender(arg5),
            amount       : arg3,
            total_staked : v1.total_staked,
        };
        0x2::event::emit<UnstakeEvent>(v4);
        0x2::coin::from_balance<T3>(0x2::balance::split<T3>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T3>>(&mut v1.lp_vault, 0x1::type_name::with_defining_ids<T3>()), arg3), arg5)
    }

    fun update_all_rewards(arg0: &mut PoolRewards, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000;
        let v1 = arg0.total_staked;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&arg0.reward_types)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&arg0.reward_types, v2);
            let v4 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, RewardState>(&mut arg0.reward_states, &v3);
            let v5 = if (v4.last_update_ts > v4.start_ts) {
                v4.last_update_ts
            } else {
                v4.start_ts
            };
            let v6 = if (v0 < v4.end_ts) {
                v0
            } else {
                v4.end_ts
            };
            if (v6 > v5 && v4.emission_per_sec > 0) {
                let v7 = ((v6 - v5) as u128) * (v4.emission_per_sec as u128);
                v4.total_emitted = v4.total_emitted + v7;
                if (v1 > 0) {
                    v4.reward_per_lp = v4.reward_per_lp + 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::math128::mul_div_down(v7, 1000000, (v1 as u128));
                };
            };
            if (v0 > v4.last_update_ts) {
                v4.last_update_ts = v0;
            };
            update_reserved(v4, arg1);
            v2 = v2 + 1;
        };
    }

    fun update_reserved(arg0: &mut RewardState, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000;
        let v1 = if (arg0.total_emitted >= arg0.total_claimed) {
            arg0.total_emitted - arg0.total_claimed
        } else {
            0
        };
        let v2 = if (arg0.start_ts > v0) {
            arg0.start_ts
        } else {
            v0
        };
        let v3 = if (arg0.end_ts > v2) {
            arg0.end_ts - v2
        } else {
            0
        };
        arg0.reserved = v1 + (v3 as u128) * (arg0.emission_per_sec as u128);
    }

    public fun user_rewards(arg0: &mut RewardsManager, arg1: 0x2::object::ID, arg2: address, arg3: &0x2::clock::Clock) {
        if (!0x2::linked_table::contains<0x2::object::ID, PoolRewards>(&arg0.pools, arg1)) {
            return
        };
        let v0 = 0x2::linked_table::borrow_mut<0x2::object::ID, PoolRewards>(&mut arg0.pools, arg1);
        update_all_rewards(v0, arg3);
        settle_user_all(v0, arg2);
        let v1 = if (0x2::linked_table::contains<address, Staker>(&v0.stakers, arg2)) {
            0x2::linked_table::borrow<address, Staker>(&v0.stakers, arg2).amount
        } else {
            0
        };
        let v2 = UserStakeEvent{
            pool_id       : arg1,
            user          : arg2,
            staked_amount : v1,
        };
        0x2::event::emit<UserStakeEvent>(v2);
        let v3 = 0;
        let v4 = 0x1::vector::empty<UserReward>();
        while (v3 < 0x1::vector::length<0x1::type_name::TypeName>(&v0.reward_types)) {
            let v5 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0.reward_types, v3);
            if (0x2::linked_table::contains<address, Staker>(&v0.stakers, arg2) && 0x2::linked_table::contains<0x1::type_name::TypeName, UserReward>(&0x2::linked_table::borrow<address, Staker>(&v0.stakers, arg2).rewards, v5)) {
                0x1::vector::push_back<UserReward>(&mut v4, *0x2::linked_table::borrow<0x1::type_name::TypeName, UserReward>(&0x2::linked_table::borrow<address, Staker>(&v0.stakers, arg2).rewards, v5));
            };
            v3 = v3 + 1;
        };
        let v6 = UserRewardInfoEvent{infos: v4};
        0x2::event::emit<UserRewardInfoEvent>(v6);
    }

    public fun user_staked_amount(arg0: &RewardsManager, arg1: 0x2::object::ID, arg2: address) {
        let v0 = 0;
        if (0x2::linked_table::contains<0x2::object::ID, PoolRewards>(&arg0.pools, arg1)) {
            let v1 = 0x2::linked_table::borrow<0x2::object::ID, PoolRewards>(&arg0.pools, arg1);
            if (0x2::linked_table::contains<address, Staker>(&v1.stakers, arg2)) {
                v0 = 0x2::linked_table::borrow<address, Staker>(&v1.stakers, arg2).amount;
            };
        };
        let v2 = UserStakeEvent{
            pool_id       : arg1,
            user          : arg2,
            staked_amount : v0,
        };
        0x2::event::emit<UserStakeEvent>(v2);
    }

    public fun user_staked_amount_all(arg0: &RewardsManager, arg1: address) {
        let v0 = 0x2::linked_table::front<0x2::object::ID, PoolRewards>(&arg0.pools);
        let v1 = 0x1::vector::empty<UserStakeEvent>();
        while (0x1::option::is_some<0x2::object::ID>(v0)) {
            let v2 = 0;
            let v3 = *0x1::option::borrow<0x2::object::ID>(v0);
            let v4 = 0x2::linked_table::borrow<0x2::object::ID, PoolRewards>(&arg0.pools, v3);
            if (0x2::linked_table::contains<address, Staker>(&v4.stakers, arg1)) {
                v2 = 0x2::linked_table::borrow<address, Staker>(&v4.stakers, arg1).amount;
            };
            let v5 = UserStakeEvent{
                pool_id       : v3,
                user          : arg1,
                staked_amount : v2,
            };
            0x1::vector::push_back<UserStakeEvent>(&mut v1, v5);
            v0 = 0x2::linked_table::next<0x2::object::ID, PoolRewards>(&arg0.pools, v3);
        };
        let v6 = UserStakeAllEvent{infos: v1};
        0x2::event::emit<UserStakeAllEvent>(v6);
    }

    public fun withdraw<T0, T1, T2: store, T3: drop, T4>(arg0: &mut RewardsManager, arg1: &0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::global_config::GlobalConfig, arg2: &0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::pool::Pool<T0, T1, T2, T3>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T4> {
        0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::global_config::check_package_version(arg1);
        0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::global_config::check_reward_manager_role(arg1, 0x2::tx_context::sender(arg5));
        let v0 = 0x2::object::id<0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::pool::Pool<T0, T1, T2, T3>>(arg2);
        assert!(0x2::linked_table::contains<0x2::object::ID, PoolRewards>(&arg0.pools, v0), 0);
        let v1 = 0x2::linked_table::borrow_mut<0x2::object::ID, PoolRewards>(&mut arg0.pools, v0);
        let v2 = 0x1::type_name::with_defining_ids<T4>();
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, RewardState>(&v1.reward_states, &v2), 3);
        update_all_rewards(v1, arg4);
        let v3 = 0x2::vec_map::get<0x1::type_name::TypeName, RewardState>(&v1.reward_states, &v2).reserved;
        let v4 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T4>>(&mut v1.reward_vault, v2);
        let v5 = (0x2::balance::value<T4>(v4) as u128);
        let v6 = if (v5 > v3) {
            v5 - v3
        } else {
            0
        };
        if (v6 < (arg3 as u128)) {
            arg3 = (v6 as u64);
        };
        let v7 = WithdrawEvent{
            pool_id     : v0,
            reward_type : v2,
            amount      : arg3,
        };
        0x2::event::emit<WithdrawEvent>(v7);
        0x2::coin::from_balance<T4>(0x2::balance::split<T4>(v4, arg3), arg5)
    }

    // decompiled from Move bytecode v6
}

