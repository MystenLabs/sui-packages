module 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::rewards {
    struct RewardDistributorRefreshEvent has copy, drop {
        market_id: u64,
        reward_distributor_id: 0x2::object::ID,
        last_updated: u64,
        total_xtokens: u64,
    }

    struct RewardUpdateEvent has copy, drop {
        market_id: u64,
        reward_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        distributor_id: 0x2::object::ID,
        is_auto_compounded: bool,
        auto_compound_market_id: u64,
        total_rewards: u64,
        start_time: u64,
        end_time: u64,
        distributed_rewards: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
        cummulative_rewards_per_share: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
    }

    struct UserRewardDistributorRefreshEvent has copy, drop {
        market_id: u64,
        position_id: 0x2::object::ID,
        reward_distributor_id: 0x2::object::ID,
        share: u64,
        last_updated: u64,
        is_deposit: bool,
    }

    struct UserRewardUpdateEvent has copy, drop {
        market_id: u64,
        position_id: 0x2::object::ID,
        reward_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        earned_rewards: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
        cummulative_rewards_per_share: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
        is_auto_compounded: bool,
        auto_compound_market_id: u64,
    }

    struct RewardDistributor has store, key {
        id: 0x2::object::UID,
        total_xtokens: u64,
        rewards: vector<0x1::option::Option<Reward>>,
        last_updated: u64,
        market_id: u64,
    }

    struct Reward has store, key {
        id: 0x2::object::UID,
        coin_type: 0x1::type_name::TypeName,
        distributor_id: 0x2::object::ID,
        is_auto_compounded: bool,
        auto_compound_market_id: u64,
        total_rewards: u64,
        start_time: u64,
        end_time: u64,
        distributed_rewards: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
        cummulative_rewards_per_share: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
    }

    struct UserRewardDistributor has store {
        reward_distributor_id: 0x2::object::ID,
        market_id: u64,
        share: u64,
        rewards: vector<0x1::option::Option<UserReward>>,
        last_updated: u64,
        is_deposit: bool,
    }

    struct UserReward has store {
        reward_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        earned_rewards: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
        cummulative_rewards_per_share: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
        is_auto_compounded: bool,
        auto_compound_market_id: u64,
    }

    struct ClaimableReward has copy, drop {
        market_id: u64,
        reward_type: 0x1::type_name::TypeName,
    }

    public(friend) fun add_reward<T0>(arg0: &mut RewardDistributor, arg1: 0x2::balance::Balance<T0>, arg2: 0x1::type_name::TypeName, arg3: bool, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.last_updated == 0x2::clock::timestamp_ms(arg7), 3);
        let v0 = find_reward(arg0, arg2, arg3);
        if (v0 < 0x1::vector::length<0x1::option::Option<Reward>>(&arg0.rewards)) {
            update_reward<T0>(arg0, v0, arg1, arg5, arg6, arg7);
            emit_reward_update_event(0x1::option::borrow_mut<Reward>(0x1::vector::borrow_mut<0x1::option::Option<Reward>>(&mut arg0.rewards, v0)), arg0.market_id);
        } else {
            let v1 = Reward{
                id                            : 0x2::object::new(arg8),
                coin_type                     : arg2,
                distributor_id                : 0x2::object::id<RewardDistributor>(arg0),
                is_auto_compounded            : arg3,
                auto_compound_market_id       : arg4,
                total_rewards                 : 0x2::balance::value<T0>(&arg1),
                start_time                    : arg5,
                end_time                      : arg6,
                distributed_rewards           : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0),
                cummulative_rewards_per_share : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0),
            };
            assert!(arg6 > arg5, 4);
            let v2 = 0x1::option::none<Reward>();
            0x2::dynamic_field::add<0x2::object::ID, 0x2::balance::Balance<T0>>(&mut arg0.id, 0x2::object::id<Reward>(&v1), arg1);
            emit_reward_update_event(&v1, arg0.market_id);
            0x1::option::fill<Reward>(&mut v2, v1);
            0x1::vector::push_back<0x1::option::Option<Reward>>(&mut arg0.rewards, v2);
        };
    }

    public(friend) fun borrow_mut_distributor_id(arg0: &mut RewardDistributor) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public(friend) fun borrow_reward_id(arg0: &mut RewardDistributor, arg1: u64) : 0x2::object::ID {
        0x2::object::id<Reward>(0x1::option::borrow<Reward>(0x1::vector::borrow_mut<0x1::option::Option<Reward>>(&mut arg0.rewards, arg1)))
    }

    public(friend) fun change_user_share(arg0: &mut UserRewardDistributor, arg1: &mut RewardDistributor, arg2: 0x2::object::ID, arg3: u64, arg4: &0x2::clock::Clock) {
        refresh_user_reward_distributor(arg0, arg1, false, arg2, arg4);
        arg1.total_xtokens = arg1.total_xtokens - arg0.share + arg3;
        arg0.share = arg3;
        emit_user_reward_distributor_refresh_event(arg0, arg0.market_id, arg2);
    }

    public(friend) fun claim_rewards<T0>(arg0: &mut UserRewardDistributor, arg1: &RewardDistributor, arg2: &0x2::clock::Clock) : (u64, u64, u64, u64) {
        assert!(arg0.last_updated == 0x2::clock::timestamp_ms(arg2), 2);
        let v0 = 0;
        let v1 = 0x1::type_name::get<T0>();
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        while (v0 < 0x1::vector::length<0x1::option::Option<UserReward>>(&arg0.rewards)) {
            let v6 = 0x1::vector::borrow_mut<0x1::option::Option<UserReward>>(&mut arg0.rewards, v0);
            if (0x1::option::is_some<UserReward>(v6)) {
                let v7 = 0x1::option::borrow_mut<UserReward>(v6);
                if (v7.coin_type == v1) {
                    if (v7.is_auto_compounded) {
                        v5 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(v7.earned_rewards);
                        v3 = find_reward(arg1, v1, true);
                    } else {
                        v4 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(v7.earned_rewards);
                        v2 = find_reward(arg1, v1, false);
                    };
                    v7.earned_rewards = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0);
                };
            };
            v0 = v0 + 1;
        };
        (v2, v4, v3, v5)
    }

    public(friend) fun create_reward_distributor(arg0: &mut 0x2::tx_context::TxContext, arg1: u64) : RewardDistributor {
        RewardDistributor{
            id            : 0x2::object::new(arg0),
            total_xtokens : 0,
            rewards       : 0x1::vector::empty<0x1::option::Option<Reward>>(),
            last_updated  : 0,
            market_id     : arg1,
        }
    }

    public(friend) fun create_user_reward_distributor(arg0: &RewardDistributor, arg1: bool, arg2: &0x2::clock::Clock) : UserRewardDistributor {
        UserRewardDistributor{
            reward_distributor_id : 0x2::object::id<RewardDistributor>(arg0),
            market_id             : arg0.market_id,
            share                 : 0,
            rewards               : 0x1::vector::empty<0x1::option::Option<UserReward>>(),
            last_updated          : 0,
            is_deposit            : arg1,
        }
    }

    public(friend) fun emit_reward_distributor_refresh_event(arg0: u64, arg1: &RewardDistributor) {
        let v0 = RewardDistributorRefreshEvent{
            market_id             : arg0,
            reward_distributor_id : 0x2::object::id<RewardDistributor>(arg1),
            last_updated          : arg1.last_updated,
            total_xtokens         : arg1.total_xtokens,
        };
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::events::emit_event<RewardDistributorRefreshEvent>(v0);
    }

    public(friend) fun emit_reward_update_event(arg0: &Reward, arg1: u64) {
        let v0 = RewardUpdateEvent{
            market_id                     : arg1,
            reward_id                     : 0x2::object::id<Reward>(arg0),
            coin_type                     : arg0.coin_type,
            distributor_id                : arg0.distributor_id,
            is_auto_compounded            : arg0.is_auto_compounded,
            auto_compound_market_id       : arg0.auto_compound_market_id,
            total_rewards                 : arg0.total_rewards,
            start_time                    : arg0.start_time,
            end_time                      : arg0.end_time,
            distributed_rewards           : arg0.distributed_rewards,
            cummulative_rewards_per_share : arg0.cummulative_rewards_per_share,
        };
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::events::emit_event<RewardUpdateEvent>(v0);
    }

    public(friend) fun emit_user_reward_distributor_refresh_event(arg0: &UserRewardDistributor, arg1: u64, arg2: 0x2::object::ID) {
        let v0 = UserRewardDistributorRefreshEvent{
            market_id             : arg1,
            position_id           : arg2,
            reward_distributor_id : arg0.reward_distributor_id,
            share                 : arg0.share,
            last_updated          : arg0.last_updated,
            is_deposit            : arg0.is_deposit,
        };
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::events::emit_event<UserRewardDistributorRefreshEvent>(v0);
    }

    public(friend) fun emit_user_reward_update_event(arg0: u64, arg1: 0x2::object::ID, arg2: &UserReward) {
        let v0 = UserRewardUpdateEvent{
            market_id                     : arg0,
            position_id                   : arg1,
            reward_id                     : arg2.reward_id,
            coin_type                     : arg2.coin_type,
            earned_rewards                : arg2.earned_rewards,
            cummulative_rewards_per_share : arg2.cummulative_rewards_per_share,
            is_auto_compounded            : arg2.is_auto_compounded,
            auto_compound_market_id       : arg2.auto_compound_market_id,
        };
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::events::emit_event<UserRewardUpdateEvent>(v0);
    }

    public(friend) fun find_reward(arg0: &RewardDistributor, arg1: 0x1::type_name::TypeName, arg2: bool) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::option::Option<Reward>>(&arg0.rewards)) {
            let v1 = 0x1::vector::borrow<0x1::option::Option<Reward>>(&arg0.rewards, v0);
            if (0x1::option::is_some<Reward>(v1)) {
                let v2 = 0x1::option::borrow<Reward>(v1);
                if (v2.coin_type == arg1 && v2.is_auto_compounded == arg2) {
                    break
                };
            };
            v0 = v0 + 1;
        };
        v0
    }

    public(friend) fun get_auto_compound_market_id(arg0: &RewardDistributor, arg1: u64) : u64 {
        0x1::option::borrow<Reward>(0x1::vector::borrow<0x1::option::Option<Reward>>(&arg0.rewards, arg1)).auto_compound_market_id
    }

    public(friend) fun get_claimable_rewards(arg0: &UserRewardDistributor, arg1: &RewardDistributor, arg2: &0x2::clock::Clock) : vector<ClaimableReward> {
        assert!(arg0.reward_distributor_id == 0x2::object::id<RewardDistributor>(arg1), 1);
        assert!(arg0.last_updated == 0x2::clock::timestamp_ms(arg2), 2);
        let v0 = 0x1::vector::empty<ClaimableReward>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::option::Option<UserReward>>(&arg0.rewards)) {
            let v2 = 0x1::vector::borrow<0x1::option::Option<UserReward>>(&arg0.rewards, v1);
            if (0x1::option::is_some<UserReward>(v2)) {
                let v3 = 0x1::option::borrow<UserReward>(v2);
                if (0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(v3.earned_rewards) > 0) {
                    let v4 = ClaimableReward{
                        market_id   : arg0.market_id,
                        reward_type : v3.coin_type,
                    };
                    0x1::vector::push_back<ClaimableReward>(&mut v0, v4);
                };
            };
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun get_earned_rewards(arg0: &UserReward) : u64 {
        0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(arg0.earned_rewards)
    }

    public(friend) fun get_market_id(arg0: &RewardDistributor) : u64 {
        arg0.market_id
    }

    public(friend) fun get_market_id_for_reward(arg0: &ClaimableReward) : u64 {
        arg0.market_id
    }

    public(friend) fun get_reward_distributor_id(arg0: &UserRewardDistributor) : 0x2::object::ID {
        arg0.reward_distributor_id
    }

    public(friend) fun get_reward_type_for_reward(arg0: &ClaimableReward) : 0x1::type_name::TypeName {
        arg0.reward_type
    }

    public(friend) fun get_user_distributor_market_id(arg0: &UserRewardDistributor) : u64 {
        arg0.market_id
    }

    public(friend) fun is_deposit_distributor(arg0: &UserRewardDistributor) : bool {
        arg0.is_deposit
    }

    public(friend) fun refresh(arg0: &mut RewardDistributor, arg1: &0x2::clock::Clock) {
        if (0x2::clock::timestamp_ms(arg1) == arg0.last_updated) {
            return
        };
        if (arg0.total_xtokens == 0) {
            arg0.last_updated = 0x2::clock::timestamp_ms(arg1);
            return
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::option::Option<Reward>>(&arg0.rewards)) {
            let v1 = 0x1::vector::borrow_mut<0x1::option::Option<Reward>>(&mut arg0.rewards, v0);
            if (0x1::option::is_some<Reward>(v1)) {
                let v2 = 0x1::option::borrow_mut<Reward>(v1);
                if (v2.start_time >= 0x2::clock::timestamp_ms(arg1)) {
                    /* goto 18 */
                } else if (v2.end_time < arg0.last_updated) {
                    /* goto 17 */
                } else {
                    let v3 = 0x1::u64::max(arg0.last_updated, v2.start_time);
                    let v4 = if (0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::gt(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(v2.total_rewards), v2.distributed_rewards)) {
                        0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::sub(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(v2.total_rewards), v2.distributed_rewards), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0x1::u64::min(0x2::clock::timestamp_ms(arg1), v2.end_time) - v3)), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(v2.end_time - v3))
                    } else {
                        0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0)
                    };
                    v2.distributed_rewards = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::add(v2.distributed_rewards, v4);
                    v2.cummulative_rewards_per_share = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::add(v2.cummulative_rewards_per_share, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(v4, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(arg0.total_xtokens)));
                    emit_reward_update_event(v2, arg0.market_id);
                };
            };
            v0 = v0 + 1;
            continue;
            /* label 17 */
            v0 = v0 + 1;
            continue;
            /* label 18 */
            v0 = v0 + 1;
        };
        arg0.last_updated = 0x2::clock::timestamp_ms(arg1);
        emit_reward_distributor_refresh_event(arg0.market_id, arg0);
    }

    public(friend) fun refresh_user_reward_distributor(arg0: &mut UserRewardDistributor, arg1: &mut RewardDistributor, arg2: bool, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock) {
        assert!(arg0.reward_distributor_id == 0x2::object::id<RewardDistributor>(arg1), 1);
        if (!arg2 && arg0.last_updated == 0x2::clock::timestamp_ms(arg4)) {
            return
        };
        refresh(arg1, arg4);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::option::Option<Reward>>(&arg1.rewards)) {
            let v1 = 0x1::vector::borrow_mut<0x1::option::Option<Reward>>(&mut arg1.rewards, v0);
            if (0x1::option::is_none<Reward>(v1)) {
                0x1::vector::push_back<0x1::option::Option<UserReward>>(&mut arg0.rewards, 0x1::option::none<UserReward>());
                v0 = v0 + 1;
                continue
            };
            let v2 = 0x1::option::borrow_mut<Reward>(v1);
            if (0x1::vector::length<0x1::option::Option<UserReward>>(&arg0.rewards) <= v0) {
                let v3 = 0x1::option::none<UserReward>();
                assert!(arg0.last_updated <= v2.start_time, 0);
                let v4 = if (arg0.last_updated <= v2.start_time) {
                    0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(v2.cummulative_rewards_per_share, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(arg0.share))
                } else {
                    0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0)
                };
                let v5 = UserReward{
                    reward_id                     : 0x2::object::id<Reward>(v2),
                    coin_type                     : v2.coin_type,
                    earned_rewards                : v4,
                    cummulative_rewards_per_share : v2.cummulative_rewards_per_share,
                    is_auto_compounded            : v2.is_auto_compounded,
                    auto_compound_market_id       : v2.auto_compound_market_id,
                };
                0x1::option::fill<UserReward>(&mut v3, v5);
                0x1::vector::push_back<0x1::option::Option<UserReward>>(&mut arg0.rewards, v3);
            } else {
                let v6 = 0x1::option::borrow_mut<UserReward>(0x1::vector::borrow_mut<0x1::option::Option<UserReward>>(&mut arg0.rewards, v0));
                v6.earned_rewards = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::add(v6.earned_rewards, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::sub(v2.cummulative_rewards_per_share, v6.cummulative_rewards_per_share), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(arg0.share)));
                v6.cummulative_rewards_per_share = v2.cummulative_rewards_per_share;
            };
            emit_user_reward_distributor_refresh_event(arg0, arg0.market_id, arg3);
            v0 = v0 + 1;
        };
        arg0.last_updated = 0x2::clock::timestamp_ms(arg4);
        emit_user_reward_distributor_refresh_event(arg0, arg0.market_id, arg3);
    }

    public(friend) fun remove_reward_balance<T0>(arg0: &mut RewardDistributor, arg1: u64, arg2: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<0x2::object::ID, 0x2::balance::Balance<T0>>(&mut arg0.id, 0x2::object::id<Reward>(0x1::option::borrow<Reward>(0x1::vector::borrow_mut<0x1::option::Option<Reward>>(&mut arg0.rewards, arg1)))), arg2)
    }

    public(friend) fun update_reward<T0>(arg0: &mut RewardDistributor, arg1: u64, arg2: 0x2::balance::Balance<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) {
        let v0 = 0x1::option::borrow_mut<Reward>(0x1::vector::borrow_mut<0x1::option::Option<Reward>>(&mut arg0.rewards, arg1));
        if (v0.end_time > 0x2::clock::timestamp_ms(arg5)) {
            assert!(v0.end_time == arg3, 0);
        } else {
            assert!(arg4 > arg3, 4);
            v0.start_time = arg3;
        };
        v0.end_time = arg4;
        v0.total_rewards = v0.total_rewards + 0x2::balance::value<T0>(&arg2);
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x2::object::ID, 0x2::balance::Balance<T0>>(&mut arg0.id, 0x2::object::id<Reward>(v0)), arg2);
    }

    // decompiled from Move bytecode v6
}

