module 0x673d753d8034baaa54e4a2939b14073a16079a683a1eafeccaacd8fd1683c3d5::nft_staking {
    struct NFT_STAKING has drop {
        dummy_field: bool,
    }

    struct PoolOwnerCap has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
    }

    struct RewardToken has copy, drop, store {
        token_type: 0x1::string::String,
        daily_rate: u64,
        total_rewards: u64,
        distributed_rewards: u64,
        decimal_places: u8,
        is_base_token: bool,
    }

    struct StakingPool has store, key {
        id: 0x2::object::UID,
        owner: address,
        allowed_collections: 0x2::vec_set::VecSet<0x1::string::String>,
        reward_tokens: 0x2::vec_map::VecMap<0x1::string::String, RewardToken>,
        min_staking_period: u64,
        paused: bool,
        total_staked_nfts: u64,
        staking_started_at: u64,
        total_unique_stakers: u64,
        emergency_mode: bool,
        tvl_stats: TVLStatistics,
    }

    struct NFTStake has drop, store {
        nft_id: 0x2::object::ID,
        nft_type: 0x1::string::String,
        staked_at: u64,
        last_reward_claim: u64,
        claimed_rewards: 0x2::vec_map::VecMap<0x1::string::String, u64>,
        from_kiosk: bool,
    }

    struct UserStake has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        staker: address,
        staked_nfts: 0x2::table::Table<0x2::object::ID, NFTStake>,
        total_staked_count: u64,
        pending_rewards: 0x2::vec_map::VecMap<0x1::string::String, u64>,
        staking_since: u64,
        total_claimed: 0x2::vec_map::VecMap<0x1::string::String, u64>,
    }

    struct TVLStatistics has copy, drop, store {
        total_rewards_value: 0x2::vec_map::VecMap<0x1::string::String, u64>,
        current_rewards_value: 0x2::vec_map::VecMap<0x1::string::String, u64>,
        total_nft_value: u64,
        total_distributed: 0x2::vec_map::VecMap<0x1::string::String, u64>,
        total_pending: 0x2::vec_map::VecMap<0x1::string::String, u64>,
        last_updated: u64,
    }

    struct PoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        owner: address,
        base_reward_token: 0x1::string::String,
        min_staking_period: u64,
        allowed_collections: vector<0x1::string::String>,
    }

    struct NFTStaked has copy, drop {
        pool_id: 0x2::object::ID,
        staker: address,
        nft_id: 0x2::object::ID,
        nft_type: 0x1::string::String,
        timestamp: u64,
        from_kiosk: bool,
    }

    struct NFTUnstaked has copy, drop {
        pool_id: 0x2::object::ID,
        staker: address,
        nft_id: 0x2::object::ID,
        nft_type: 0x1::string::String,
        staked_duration: u64,
        timestamp: u64,
        to_kiosk: bool,
    }

    struct RewardsClaimed has copy, drop {
        pool_id: 0x2::object::ID,
        staker: address,
        rewards: 0x2::vec_map::VecMap<0x1::string::String, u64>,
        timestamp: u64,
    }

    struct RewardRateUpdated has copy, drop {
        pool_id: 0x2::object::ID,
        token_type: 0x1::string::String,
        new_rate: u64,
    }

    struct MinStakingPeriodUpdated has copy, drop {
        pool_id: 0x2::object::ID,
        new_period: u64,
    }

    struct PoolPaused has copy, drop {
        pool_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct PoolUnpaused has copy, drop {
        pool_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct RewardTokenAdded has copy, drop {
        pool_id: 0x2::object::ID,
        token_type: 0x1::string::String,
        daily_rate: u64,
        total_rewards: u64,
        decimal_places: u8,
    }

    struct RewardTokenRemoved has copy, drop {
        pool_id: 0x2::object::ID,
        token_type: 0x1::string::String,
    }

    struct EmergencyModeActivated has copy, drop {
        pool_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct EmergencyModeDeactivated has copy, drop {
        pool_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct ForceUnstaked has copy, drop {
        pool_id: 0x2::object::ID,
        staker: address,
        nft_id: 0x2::object::ID,
        with_rewards: bool,
        timestamp: u64,
    }

    struct TVLUpdated has copy, drop {
        pool_id: 0x2::object::ID,
        total_staked_nfts: u64,
        total_unique_stakers: u64,
        rewards_stats: 0x2::vec_map::VecMap<0x1::string::String, u64>,
        timestamp: u64,
    }

    struct StatisticsUpdated has copy, drop {
        total_staked_nfts_count: u64,
        total_unique_stakers: u64,
        total_claimed_rewards: 0x2::vec_map::VecMap<0x1::string::String, u64>,
        timestamp: u64,
    }

    public fun activate_emergency_mode(arg0: &mut StakingPool, arg1: &PoolOwnerCap, arg2: &0x2::clock::Clock) {
        assert!(0x2::object::id<StakingPool>(arg0) == arg1.pool_id, 0);
        arg0.emergency_mode = true;
        if (!arg0.paused) {
            arg0.paused = true;
            let v0 = PoolPaused{
                pool_id   : 0x2::object::id<StakingPool>(arg0),
                timestamp : 0x2::clock::timestamp_ms(arg2) / 1000,
            };
            0x2::event::emit<PoolPaused>(v0);
        };
        let v1 = EmergencyModeActivated{
            pool_id   : 0x2::object::id<StakingPool>(arg0),
            timestamp : 0x2::clock::timestamp_ms(arg2) / 1000,
        };
        0x2::event::emit<EmergencyModeActivated>(v1);
    }

    public fun add_collection(arg0: &mut StakingPool, arg1: &PoolOwnerCap, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<StakingPool>(arg0) == arg1.pool_id, 0);
        assert!(!arg0.emergency_mode, 25);
        if (!0x2::vec_set::contains<0x1::string::String>(&arg0.allowed_collections, &arg2)) {
            0x2::vec_set::insert<0x1::string::String>(&mut arg0.allowed_collections, arg2);
        };
    }

    public fun add_funds<T0>(arg0: &mut StakingPool, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 11);
        let (_, v2) = get_coin_info<T0>(arg2);
        let v3 = v2;
        assert!(0x2::vec_map::contains<0x1::string::String, RewardToken>(&arg0.reward_tokens, &v3), 20);
        if (0x2::vec_map::contains<0x1::string::String, u64>(&arg0.tvl_stats.current_rewards_value, &v3)) {
            0x2::vec_map::insert<0x1::string::String, u64>(&mut arg0.tvl_stats.current_rewards_value, v3, *0x2::vec_map::get<0x1::string::String, u64>(&arg0.tvl_stats.current_rewards_value, &v3) + v0);
        } else {
            0x2::vec_map::insert<0x1::string::String, u64>(&mut arg0.tvl_stats.current_rewards_value, v3, v0);
        };
        if (0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, v3)) {
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg0.id, v3), 0x2::coin::into_balance<T0>(arg1));
        } else {
            0x2::dynamic_field::add<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg0.id, v3, 0x2::coin::into_balance<T0>(arg1));
        };
        arg0.tvl_stats.last_updated = 0x2::tx_context::epoch(arg3);
    }

    public fun add_reward_token<T0>(arg0: &mut StakingPool, arg1: &PoolOwnerCap, arg2: u64, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<StakingPool>(arg0) == arg1.pool_id, 0);
        assert!(!arg0.emergency_mode, 25);
        assert!(arg2 > 0, 15);
        assert!(arg3 > 0, 11);
        let v0 = 0x2::coin::value<T0>(&arg4);
        assert!(v0 > 0, 11);
        let (v1, v2) = get_coin_info<T0>(arg5);
        let v3 = v2;
        let v4 = RewardToken{
            token_type          : v3,
            daily_rate          : arg2,
            total_rewards       : arg3,
            distributed_rewards : 0,
            decimal_places      : v1,
            is_base_token       : false,
        };
        if (0x2::vec_map::contains<0x1::string::String, RewardToken>(&arg0.reward_tokens, &v3)) {
            let v5 = 0x2::vec_map::get_mut<0x1::string::String, RewardToken>(&mut arg0.reward_tokens, &v3);
            v5.daily_rate = arg2;
            v5.total_rewards = v5.total_rewards + arg3;
            0x2::vec_map::insert<0x1::string::String, u64>(&mut arg0.tvl_stats.total_rewards_value, v3, *0x2::vec_map::get<0x1::string::String, u64>(&arg0.tvl_stats.total_rewards_value, &v3) + arg3);
            0x2::vec_map::insert<0x1::string::String, u64>(&mut arg0.tvl_stats.current_rewards_value, v3, *0x2::vec_map::get<0x1::string::String, u64>(&arg0.tvl_stats.current_rewards_value, &v3) + v0);
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg0.id, v3), 0x2::coin::into_balance<T0>(arg4));
        } else {
            0x2::vec_map::insert<0x1::string::String, RewardToken>(&mut arg0.reward_tokens, v3, v4);
            0x2::vec_map::insert<0x1::string::String, u64>(&mut arg0.tvl_stats.total_rewards_value, v3, arg3);
            0x2::vec_map::insert<0x1::string::String, u64>(&mut arg0.tvl_stats.current_rewards_value, v3, v0);
            0x2::vec_map::insert<0x1::string::String, u64>(&mut arg0.tvl_stats.total_distributed, v3, 0);
            0x2::vec_map::insert<0x1::string::String, u64>(&mut arg0.tvl_stats.total_pending, v3, 0);
            0x2::dynamic_field::add<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg0.id, v3, 0x2::coin::into_balance<T0>(arg4));
            let v6 = RewardTokenAdded{
                pool_id        : 0x2::object::id<StakingPool>(arg0),
                token_type     : v3,
                daily_rate     : arg2,
                total_rewards  : arg3,
                decimal_places : v1,
            };
            0x2::event::emit<RewardTokenAdded>(v6);
        };
        arg0.tvl_stats.last_updated = 0x2::tx_context::epoch(arg6);
    }

    public fun batch_stake_nft<T0: store + key>(arg0: &mut StakingPool, arg1: vector<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<T0>(&arg1)) {
            stake_nft<T0>(arg0, 0x1::vector::pop_back<T0>(&mut arg1), arg2, arg3);
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<T0>(arg1);
    }

    public fun batch_stake_nft_from_kiosk<T0: store + key>(arg0: &mut StakingPool, arg1: vector<T0>, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::owner(arg2) == 0x2::tx_context::sender(arg5), 0);
        let v0 = 0;
        while (v0 < 0x1::vector::length<T0>(&arg1)) {
            stake_nft_from_kiosk<T0>(arg0, 0x1::vector::pop_back<T0>(&mut arg1), arg2, arg3, arg4, arg5);
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<T0>(arg1);
    }

    public fun batch_unstake_nft<T0: store + key>(arg0: &mut StakingPool, arg1: &mut UserStake, arg2: vector<0x2::object::ID>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : vector<T0> {
        let v0 = 0;
        let v1 = 0x1::vector::empty<T0>();
        while (v0 < 0x1::vector::length<0x2::object::ID>(&arg2)) {
            0x1::vector::push_back<T0>(&mut v1, unstake_nft<T0>(arg0, arg1, 0x1::vector::pop_back<0x2::object::ID>(&mut arg2), arg3, arg4));
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<0x2::object::ID>(arg2);
        v1
    }

    public fun batch_unstake_nft_to_kiosk<T0: store + key>(arg0: &mut StakingPool, arg1: &mut UserStake, arg2: vector<0x2::object::ID>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::owner(arg3) == 0x2::tx_context::sender(arg6), 0);
        let v0 = batch_unstake_nft<T0>(arg0, arg1, arg2, arg5, arg6);
        let v1 = 0;
        while (v1 < 0x1::vector::length<T0>(&v0)) {
            0x2::kiosk::place<T0>(arg3, arg4, 0x1::vector::pop_back<T0>(&mut v0));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<T0>(v0);
    }

    fun borrow_mut_user_stake(arg0: &mut StakingPool, arg1: 0x2::object::ID) : &mut UserStake {
        0x2::dynamic_field::borrow_mut<0x2::object::ID, UserStake>(&mut arg0.id, arg1)
    }

    fun calculate_rewards(arg0: &StakingPool, arg1: &NFTStake, arg2: u64) : 0x2::vec_map::VecMap<0x1::string::String, u64> {
        let v0 = 0x2::vec_map::empty<0x1::string::String, u64>();
        let v1 = arg2 - arg1.last_reward_claim;
        if (v1 == 0) {
            return v0
        };
        let v2 = 0x2::vec_map::keys<0x1::string::String, RewardToken>(&arg0.reward_tokens);
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x1::string::String>(&v2)) {
            let v4 = 0x1::vector::borrow<0x1::string::String>(&v2, v3);
            let v5 = 0x2::vec_map::get<0x1::string::String, RewardToken>(&arg0.reward_tokens, v4);
            if (v5.distributed_rewards < v5.total_rewards) {
                let v6 = v5.daily_rate;
                let v7 = v1 / 86400 * v6 + v6 * v1 % 86400 / 86400;
                let v8 = v7;
                if (0x2::vec_map::contains<0x1::string::String, u64>(&arg1.claimed_rewards, v4)) {
                    let v9 = 0x2::vec_map::get<0x1::string::String, u64>(&arg1.claimed_rewards, v4);
                    if (v7 > *v9) {
                        v8 = v7 - *v9;
                    } else {
                        v8 = 0;
                    };
                };
                let v10 = v5.total_rewards - v5.distributed_rewards;
                if (v8 > v10) {
                    v8 = v10;
                };
                if (v8 > 0) {
                    0x2::vec_map::insert<0x1::string::String, u64>(&mut v0, *v4, v8);
                };
            };
            v3 = v3 + 1;
        };
        v0
    }

    fun check_create_pool_preconditions<T0>(arg0: &0x1::string::String, arg1: &0x1::string::String, arg2: &0x1::string::String, arg3: &0x1::string::String, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::coin::Coin<T0>, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 <= 365 * 86400, 22);
        assert!(arg5 > 0, 15);
        assert!(arg6 > 0, 11);
        assert!(0x2::coin::value<T0>(arg7) >= arg6, 11);
        assert!(0x1::string::length(arg0) > 0, 13);
        assert!(0x1::string::length(arg1) > 0, 13);
        assert!(0x1::string::length(arg2) > 0, 13);
        assert!(0x1::string::length(arg3) > 0, 13);
    }

    fun check_kiosk_owner(arg0: &0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: address) {
        assert!(0x2::kiosk::owner(arg0) == arg2, 24);
    }

    fun check_unstake_to_kiosk<T0>(arg0: &0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &0x2::tx_context::TxContext) {
        check_kiosk_owner(arg0, arg1, 0x2::tx_context::sender(arg2));
    }

    public fun claim_pending_rewards(arg0: &mut StakingPool, arg1: &mut UserStake, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.pool_id == 0x2::object::id<StakingPool>(arg0), 18);
        assert!(arg1.staker == 0x2::tx_context::sender(arg2), 0);
        assert!(!0x2::vec_map::is_empty<0x1::string::String, u64>(&arg1.pending_rewards), 11);
        let v0 = arg1.pending_rewards;
        arg1.pending_rewards = 0x2::vec_map::empty<0x1::string::String, u64>();
        distribute_rewards(arg0, arg1, v0, arg2);
    }

    public fun claim_rewards(arg0: &mut StakingPool, arg1: &mut UserStake, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.pool_id == 0x2::object::id<StakingPool>(arg0), 18);
        assert!(arg1.staker == 0x2::tx_context::sender(arg3), 0);
        assert!(arg1.total_staked_count > 0, 16);
        let v0 = 0x2::clock::timestamp_ms(arg2) / 1000;
        let v1 = 0x2::vec_map::empty<0x1::string::String, u64>();
        let v2 = get_stake_nft_ids(arg1);
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x2::object::ID>(&v2)) {
            let v4 = 0x2::table::borrow_mut<0x2::object::ID, NFTStake>(&mut arg1.staked_nfts, *0x1::vector::borrow<0x2::object::ID>(&v2, v3));
            let v5 = &mut v1;
            merge_rewards(v5, calculate_rewards(arg0, v4, v0));
            v4.last_reward_claim = v0;
            v3 = v3 + 1;
        };
        distribute_rewards(arg0, arg1, v1, arg3);
        update_global_stats_last_claim_time(v0, arg3);
    }

    public fun create_pool<T0>(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: u64, arg7: u64, arg8: 0x2::coin::Coin<T0>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        check_create_pool_preconditions<T0>(&arg0, &arg1, &arg2, &arg4, arg5, arg6, arg7, &arg8, arg10);
        let (v0, v1) = get_coin_info<T0>(arg9);
        let v2 = 0x2::vec_set::empty<0x1::string::String>();
        0x2::vec_set::insert<0x1::string::String>(&mut v2, arg4);
        let v3 = RewardToken{
            token_type          : v1,
            daily_rate          : arg6,
            total_rewards       : arg7,
            distributed_rewards : 0,
            decimal_places      : v0,
            is_base_token       : true,
        };
        let v4 = 0x2::vec_map::empty<0x1::string::String, RewardToken>();
        0x2::vec_map::insert<0x1::string::String, RewardToken>(&mut v4, v1, v3);
        let v5 = 0x2::vec_map::empty<0x1::string::String, u64>();
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v5, v1, arg7);
        let v6 = 0x2::vec_map::empty<0x1::string::String, u64>();
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v6, v1, arg7);
        let v7 = TVLStatistics{
            total_rewards_value   : v5,
            current_rewards_value : v6,
            total_nft_value       : 0,
            total_distributed     : 0x2::vec_map::empty<0x1::string::String, u64>(),
            total_pending         : 0x2::vec_map::empty<0x1::string::String, u64>(),
            last_updated          : 0x2::clock::timestamp_ms(arg9) / 1000,
        };
        let v8 = StakingPool{
            id                   : 0x2::object::new(arg10),
            owner                : 0x2::tx_context::sender(arg10),
            allowed_collections  : v2,
            reward_tokens        : v4,
            min_staking_period   : arg5,
            paused               : false,
            total_staked_nfts    : 0,
            staking_started_at   : 0x2::clock::timestamp_ms(arg9) / 1000,
            total_unique_stakers : 0,
            emergency_mode       : false,
            tvl_stats            : v7,
        };
        0x2::dynamic_field::add<0x1::string::String, 0x2::balance::Balance<T0>>(&mut v8.id, v1, 0x2::coin::into_balance<T0>(arg8));
        let v9 = PoolCreated{
            pool_id             : 0x2::object::id<StakingPool>(&v8),
            owner               : 0x2::tx_context::sender(arg10),
            base_reward_token   : v1,
            min_staking_period  : arg5,
            allowed_collections : 0x2::vec_set::into_keys<0x1::string::String>(v2),
        };
        0x2::event::emit<PoolCreated>(v9);
        let v10 = PoolOwnerCap{
            id      : 0x2::object::new(arg10),
            pool_id : 0x2::object::id<StakingPool>(&v8),
        };
        0x2::transfer::public_share_object<StakingPool>(v8);
        0x2::transfer::public_transfer<PoolOwnerCap>(v10, 0x2::tx_context::sender(arg10));
    }

    fun create_staking_pool_display(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"total_staked"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"unique_stakers"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"min_staking_period"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"rewards"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{owner}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{project_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{total_staked_nfts}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{total_unique_stakers}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{min_staking_period}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Multiple reward tokens available"));
        let v4 = 0x2::display::new_with_fields<StakingPool>(arg0, v0, v2, arg1);
        0x2::display::update_version<StakingPool>(&mut v4);
        0x2::transfer::public_transfer<0x2::display::Display<StakingPool>>(v4, 0x2::tx_context::sender(arg1));
    }

    fun create_user_stake_display(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"staker"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"pool_id"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"total_staked"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"staking_since"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"NFT Stake"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Staked NFTs in pool"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{staker}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{pool_id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{total_staked_count}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{staking_since}"));
        let v4 = 0x2::display::new_with_fields<UserStake>(arg0, v0, v2, arg1);
        0x2::display::update_version<UserStake>(&mut v4);
        0x2::transfer::public_transfer<0x2::display::Display<UserStake>>(v4, 0x2::tx_context::sender(arg1));
    }

    public fun deactivate_emergency_mode(arg0: &mut StakingPool, arg1: &PoolOwnerCap, arg2: &0x2::clock::Clock) {
        assert!(0x2::object::id<StakingPool>(arg0) == arg1.pool_id, 0);
        arg0.emergency_mode = false;
        let v0 = EmergencyModeDeactivated{
            pool_id   : 0x2::object::id<StakingPool>(arg0),
            timestamp : 0x2::clock::timestamp_ms(arg2) / 1000,
        };
        0x2::event::emit<EmergencyModeDeactivated>(v0);
    }

    fun distribute_reward_coin<T0>(arg0: &mut StakingPool, arg1: address, arg2: 0x1::string::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : bool {
        if (!0x2::dynamic_field::exists_with_type<0x1::string::String, 0x2::balance::Balance<T0>>(&arg0.id, arg2)) {
            return false
        };
        let v0 = 0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg0.id, arg2);
        if (0x2::balance::value<T0>(v0) < arg3) {
            return false
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v0, arg3), arg4), arg1);
        if (0x2::vec_map::contains<0x1::string::String, u64>(&arg0.tvl_stats.current_rewards_value, &arg2)) {
            let v1 = *0x2::vec_map::get<0x1::string::String, u64>(&arg0.tvl_stats.current_rewards_value, &arg2);
            if (v1 >= arg3) {
                0x2::vec_map::insert<0x1::string::String, u64>(&mut arg0.tvl_stats.current_rewards_value, arg2, v1 - arg3);
            } else {
                0x2::vec_map::insert<0x1::string::String, u64>(&mut arg0.tvl_stats.current_rewards_value, arg2, 0);
            };
        };
        true
    }

    fun distribute_rewards(arg0: &mut StakingPool, arg1: &mut UserStake, arg2: 0x2::vec_map::VecMap<0x1::string::String, u64>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::vec_map::keys<0x1::string::String, u64>(&arg2);
        let v1 = 0;
        let v2 = 0x2::tx_context::epoch(arg3);
        let v3 = 0x2::vec_map::empty<0x1::string::String, u64>();
        while (v1 < 0x1::vector::length<0x1::string::String>(&v0)) {
            let v4 = *0x1::vector::borrow<0x1::string::String>(&v0, v1);
            let v5 = *0x2::vec_map::get<0x1::string::String, u64>(&arg2, &v4);
            if (v5 > 0) {
                0x2::vec_map::insert<0x1::string::String, u64>(&mut v3, v4, v5);
                emit_rewards_distributed_event(0x2::object::id<StakingPool>(arg0), arg1.staker, v4, v5, v2);
                if (0x2::vec_map::contains<0x1::string::String, RewardToken>(&arg0.reward_tokens, &v4)) {
                    let v6 = 0x2::vec_map::get_mut<0x1::string::String, RewardToken>(&mut arg0.reward_tokens, &v4);
                    v6.distributed_rewards = v6.distributed_rewards + v5;
                    if (0x2::dynamic_field::exists_with_type<0x1::string::String, 0x2::balance::Balance<0x2::sui::SUI>>(&arg0.id, v4) && 0x2::balance::value<0x2::sui::SUI>(0x2::dynamic_field::borrow<0x1::string::String, 0x2::balance::Balance<0x2::sui::SUI>>(&arg0.id, v4)) >= v5) {
                        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.id, v4), v5), arg3), arg1.staker);
                        if (0x2::vec_map::contains<0x1::string::String, u64>(&arg1.total_claimed, &v4)) {
                            0x2::vec_map::insert<0x1::string::String, u64>(&mut arg1.total_claimed, v4, *0x2::vec_map::get<0x1::string::String, u64>(&arg1.total_claimed, &v4) + v5);
                        } else {
                            0x2::vec_map::insert<0x1::string::String, u64>(&mut arg1.total_claimed, v4, v5);
                        };
                        if (0x2::vec_map::contains<0x1::string::String, u64>(&arg0.tvl_stats.current_rewards_value, &v4)) {
                            0x2::vec_map::insert<0x1::string::String, u64>(&mut arg0.tvl_stats.current_rewards_value, v4, *0x2::vec_map::get<0x1::string::String, u64>(&arg0.tvl_stats.current_rewards_value, &v4) - v5);
                        };
                        if (0x2::vec_map::contains<0x1::string::String, u64>(&arg0.tvl_stats.total_distributed, &v4)) {
                            0x2::vec_map::insert<0x1::string::String, u64>(&mut arg0.tvl_stats.total_distributed, v4, *0x2::vec_map::get<0x1::string::String, u64>(&arg0.tvl_stats.total_distributed, &v4) + v5);
                        } else {
                            0x2::vec_map::insert<0x1::string::String, u64>(&mut arg0.tvl_stats.total_distributed, v4, v5);
                        };
                    } else {
                        if (0x2::vec_map::contains<0x1::string::String, u64>(&arg1.pending_rewards, &v4)) {
                            0x2::vec_map::insert<0x1::string::String, u64>(&mut arg1.pending_rewards, v4, *0x2::vec_map::get<0x1::string::String, u64>(&arg1.pending_rewards, &v4) + v5);
                        } else {
                            0x2::vec_map::insert<0x1::string::String, u64>(&mut arg1.pending_rewards, v4, v5);
                        };
                        if (0x2::vec_map::contains<0x1::string::String, u64>(&arg0.tvl_stats.total_pending, &v4)) {
                            0x2::vec_map::insert<0x1::string::String, u64>(&mut arg0.tvl_stats.total_pending, v4, *0x2::vec_map::get<0x1::string::String, u64>(&arg0.tvl_stats.total_pending, &v4) + v5);
                        } else {
                            0x2::vec_map::insert<0x1::string::String, u64>(&mut arg0.tvl_stats.total_pending, v4, v5);
                        };
                    };
                };
            };
            v1 = v1 + 1;
        };
        update_global_stats(arg0, v3, v2, arg3);
    }

    public fun emergency_unstake_nft<T0: store + key>(arg0: &mut StakingPool, arg1: &mut UserStake, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : T0 {
        assert!(arg1.pool_id == 0x2::object::id<StakingPool>(arg0), 18);
        assert!(arg1.staker == 0x2::tx_context::sender(arg4), 0);
        assert!(0x2::table::contains<0x2::object::ID, NFTStake>(&arg1.staked_nfts, arg2), 16);
        let v0 = 0x2::table::remove<0x2::object::ID, NFTStake>(&mut arg1.staked_nfts, arg2);
        let v1 = 0x2::clock::timestamp_ms(arg3) / 1000;
        let v2 = v1 - v0.staked_at;
        if (arg0.min_staking_period == 0 || v2 >= arg0.min_staking_period) {
            let v3 = calculate_rewards(arg0, &v0, v1);
            let v4 = &mut arg1.pending_rewards;
            merge_rewards(v4, v3);
            let v5 = 0x2::vec_map::keys<0x1::string::String, u64>(&v3);
            let v6 = 0;
            while (v6 < 0x1::vector::length<0x1::string::String>(&v5)) {
                let v7 = 0x1::vector::borrow<0x1::string::String>(&v5, v6);
                let v8 = *0x2::vec_map::get<0x1::string::String, u64>(&v3, v7);
                if (0x2::vec_map::contains<0x1::string::String, RewardToken>(&arg0.reward_tokens, v7)) {
                    let v9 = 0x2::vec_map::get_mut<0x1::string::String, RewardToken>(&mut arg0.reward_tokens, v7);
                    v9.distributed_rewards = v9.distributed_rewards + v8;
                    if (0x2::vec_map::contains<0x1::string::String, u64>(&arg0.tvl_stats.total_distributed, v7)) {
                        0x2::vec_map::insert<0x1::string::String, u64>(&mut arg0.tvl_stats.total_distributed, *v7, *0x2::vec_map::get<0x1::string::String, u64>(&arg0.tvl_stats.total_distributed, v7) + v8);
                    } else {
                        0x2::vec_map::insert<0x1::string::String, u64>(&mut arg0.tvl_stats.total_distributed, *v7, v8);
                    };
                    if (0x2::vec_map::contains<0x1::string::String, u64>(&arg0.tvl_stats.total_pending, v7)) {
                        0x2::vec_map::insert<0x1::string::String, u64>(&mut arg0.tvl_stats.total_pending, *v7, *0x2::vec_map::get<0x1::string::String, u64>(&arg0.tvl_stats.total_pending, v7) + v8);
                    } else {
                        0x2::vec_map::insert<0x1::string::String, u64>(&mut arg0.tvl_stats.total_pending, *v7, v8);
                    };
                };
                v6 = v6 + 1;
            };
        };
        arg1.total_staked_count = arg1.total_staked_count - 1;
        arg0.total_staked_nfts = arg0.total_staked_nfts - 1;
        update_global_stats_nft_unstaked(v2, false, v1, arg4);
        let v10 = NFTUnstaked{
            pool_id         : 0x2::object::id<StakingPool>(arg0),
            staker          : arg1.staker,
            nft_id          : arg2,
            nft_type        : v0.nft_type,
            staked_duration : v2,
            timestamp       : v1,
            to_kiosk        : false,
        };
        0x2::event::emit<NFTUnstaked>(v10);
        0x2::dynamic_field::remove<0x2::object::ID, T0>(&mut arg1.id, arg2)
    }

    fun emit_rewards_distributed_event(arg0: 0x2::object::ID, arg1: address, arg2: 0x1::string::String, arg3: u64, arg4: u64) {
        let v0 = 0x2::vec_map::empty<0x1::string::String, u64>();
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v0, arg2, arg3);
        let v1 = RewardsClaimed{
            pool_id   : arg0,
            staker    : arg1,
            rewards   : v0,
            timestamp : arg4,
        };
        0x2::event::emit<RewardsClaimed>(v1);
    }

    public fun force_unstake_nft<T0: store + key>(arg0: &mut StakingPool, arg1: &mut UserStake, arg2: 0x2::object::ID, arg3: bool, arg4: &PoolOwnerCap, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : T0 {
        assert!(0x2::object::id<StakingPool>(arg0) == arg4.pool_id, 0);
        assert!(arg1.pool_id == 0x2::object::id<StakingPool>(arg0), 18);
        assert!(0x2::table::contains<0x2::object::ID, NFTStake>(&arg1.staked_nfts, arg2), 16);
        let v0 = 0x2::table::remove<0x2::object::ID, NFTStake>(&mut arg1.staked_nfts, arg2);
        if (arg3) {
            let v1 = calculate_rewards(arg0, &v0, 0x2::clock::timestamp_ms(arg5) / 1000);
            distribute_rewards(arg0, arg1, v1, arg6);
        };
        arg1.total_staked_count = arg1.total_staked_count - 1;
        arg0.total_staked_nfts = arg0.total_staked_nfts - 1;
        let v2 = 0x2::clock::timestamp_ms(arg5) / 1000;
        update_global_stats_nft_unstaked(v2 - v0.staked_at, !arg3, v2, arg6);
        let v3 = ForceUnstaked{
            pool_id      : 0x2::object::id<StakingPool>(arg0),
            staker       : arg1.staker,
            nft_id       : arg2,
            with_rewards : arg3,
            timestamp    : v2,
        };
        0x2::event::emit<ForceUnstaked>(v3);
        0x2::dynamic_field::remove<0x2::object::ID, T0>(&mut arg1.id, arg2)
    }

    public fun get_allowed_collections(arg0: &StakingPool, arg1: &mut 0x2::tx_context::TxContext) : vector<0x1::string::String> {
        0x2::vec_set::into_keys<0x1::string::String>(arg0.allowed_collections)
    }

    fun get_coin_info<T0>(arg0: &0x2::clock::Clock) : (u8, 0x1::string::String) {
        (9, 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())))
    }

    public fun get_nft_stake_info(arg0: &UserStake, arg1: 0x2::object::ID) : (0x2::object::ID, 0x1::string::String, u64, u64, 0x2::vec_map::VecMap<0x1::string::String, u64>, bool) {
        assert!(0x2::table::contains<0x2::object::ID, NFTStake>(&arg0.staked_nfts, arg1), 19);
        let v0 = 0x2::table::borrow<0x2::object::ID, NFTStake>(&arg0.staked_nfts, arg1);
        (v0.nft_id, v0.nft_type, v0.staked_at, v0.last_reward_claim, v0.claimed_rewards, v0.from_kiosk)
    }

    public fun get_pool_info(arg0: &StakingPool, arg1: &0x2::tx_context::TxContext) : (address, vector<0x1::string::String>, 0x2::vec_map::VecMap<0x1::string::String, RewardToken>, u64, bool, u64, u64, u64, bool) {
        (arg0.owner, 0x2::vec_set::into_keys<0x1::string::String>(arg0.allowed_collections), arg0.reward_tokens, arg0.min_staking_period, arg0.paused, arg0.total_staked_nfts, arg0.staking_started_at, arg0.total_unique_stakers, arg0.emergency_mode)
    }

    fun get_stake_nft_ids(arg0: &UserStake) : vector<0x2::object::ID> {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"nft_id_list")) {
            v0 = *0x2::dynamic_field::borrow<vector<u8>, vector<0x2::object::ID>>(&arg0.id, b"nft_id_list");
        };
        v0
    }

    public fun get_staking_statistics(arg0: &StakingPool) : (u64, u64, 0x2::vec_map::VecMap<0x1::string::String, u64>, u64, u64) {
        let v0 = arg0.tvl_stats.total_nft_value;
        let v1 = 0x2::vec_map::keys<0x1::string::String, u64>(&arg0.tvl_stats.current_rewards_value);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::string::String>(&v1)) {
            v0 = v0 + *0x2::vec_map::get<0x1::string::String, u64>(&arg0.tvl_stats.current_rewards_value, 0x1::vector::borrow<0x1::string::String>(&v1, v2));
            v2 = v2 + 1;
        };
        (arg0.total_staked_nfts, arg0.total_unique_stakers, arg0.tvl_stats.total_distributed, v0, arg0.staking_started_at)
    }

    public fun get_tvl_stats(arg0: &StakingPool) : (0x2::vec_map::VecMap<0x1::string::String, u64>, 0x2::vec_map::VecMap<0x1::string::String, u64>, u64, 0x2::vec_map::VecMap<0x1::string::String, u64>, 0x2::vec_map::VecMap<0x1::string::String, u64>, u64) {
        (arg0.tvl_stats.total_rewards_value, arg0.tvl_stats.current_rewards_value, arg0.tvl_stats.total_nft_value, arg0.tvl_stats.total_distributed, arg0.tvl_stats.total_pending, arg0.tvl_stats.last_updated)
    }

    public fun get_user_stakes(arg0: &UserStake) : (0x2::object::ID, address, u64, vector<0x2::object::ID>, 0x2::vec_map::VecMap<0x1::string::String, u64>, u64, 0x2::vec_map::VecMap<0x1::string::String, u64>) {
        (arg0.pool_id, arg0.staker, arg0.total_staked_count, get_stake_nft_ids(arg0), arg0.pending_rewards, arg0.staking_since, arg0.total_claimed)
    }

    fun init(arg0: NFT_STAKING, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<NFT_STAKING>(arg0, arg1);
        create_staking_pool_display(&v0, arg1);
        create_user_stake_display(&v0, arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun is_nft_exists(arg0: &StakingPool, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : bool {
        0x2::dynamic_field::exists_with_type<0x2::object::ID, 0x2::object::ID>(&arg0.id, arg1)
    }

    fun merge_rewards(arg0: &mut 0x2::vec_map::VecMap<0x1::string::String, u64>, arg1: 0x2::vec_map::VecMap<0x1::string::String, u64>) {
        let v0 = 0x2::vec_map::keys<0x1::string::String, u64>(&arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&v0)) {
            let v2 = 0x1::vector::borrow<0x1::string::String>(&v0, v1);
            if (0x2::vec_map::contains<0x1::string::String, u64>(arg0, v2)) {
                let v3 = 0x2::vec_map::get_mut<0x1::string::String, u64>(arg0, v2);
                *v3 = *v3 + *0x2::vec_map::get<0x1::string::String, u64>(&arg1, v2);
            } else {
                0x2::vec_map::insert<0x1::string::String, u64>(arg0, *v2, *0x2::vec_map::get<0x1::string::String, u64>(&arg1, v2));
            };
            v1 = v1 + 1;
        };
    }

    public fun pause_pool(arg0: &mut StakingPool, arg1: &PoolOwnerCap, arg2: &0x2::clock::Clock) {
        assert!(0x2::object::id<StakingPool>(arg0) == arg1.pool_id, 0);
        assert!(!arg0.paused, 7);
        arg0.paused = true;
        let v0 = PoolPaused{
            pool_id   : 0x2::object::id<StakingPool>(arg0),
            timestamp : 0x2::clock::timestamp_ms(arg2) / 1000,
        };
        0x2::event::emit<PoolPaused>(v0);
    }

    public fun remove_reward_token<T0>(arg0: &mut StakingPool, arg1: &PoolOwnerCap, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::object::id<StakingPool>(arg0) == arg1.pool_id, 0);
        assert!(!arg0.emergency_mode, 25);
        let (_, v1) = get_coin_info<T0>(arg2);
        let v2 = v1;
        assert!(0x2::vec_map::contains<0x1::string::String, RewardToken>(&arg0.reward_tokens, &v2), 20);
        assert!(!0x2::vec_map::get<0x1::string::String, RewardToken>(&arg0.reward_tokens, &v2).is_base_token, 21);
        let (_, _) = 0x2::vec_map::remove<0x1::string::String, RewardToken>(&mut arg0.reward_tokens, &v2);
        let (_, _) = 0x2::vec_map::remove<0x1::string::String, u64>(&mut arg0.tvl_stats.total_rewards_value, &v2);
        let (_, _) = 0x2::vec_map::remove<0x1::string::String, u64>(&mut arg0.tvl_stats.current_rewards_value, &v2);
        let v9 = RewardTokenRemoved{
            pool_id    : 0x2::object::id<StakingPool>(arg0),
            token_type : v2,
        };
        0x2::event::emit<RewardTokenRemoved>(v9);
        arg0.tvl_stats.last_updated = 0x2::tx_context::epoch(arg3);
        0x2::coin::from_balance<T0>(0x2::dynamic_field::remove<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg0.id, v2), arg3)
    }

    public fun stake_nft<T0: store + key>(arg0: &mut StakingPool, arg1: T0, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 7);
        assert!(!arg0.emergency_mode, 25);
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        assert!(0x2::vec_set::contains<0x1::string::String>(&arg0.allowed_collections, &v0), 18);
        let v1 = 0x2::object::id<T0>(&arg1);
        let v2 = 0x2::clock::timestamp_ms(arg2) / 1000;
        let v3 = NFTStake{
            nft_id            : v1,
            nft_type          : v0,
            staked_at         : v2,
            last_reward_claim : v2,
            claimed_rewards   : 0x2::vec_map::empty<0x1::string::String, u64>(),
            from_kiosk        : false,
        };
        let v4 = 0x2::tx_context::sender(arg3);
        if (0x2::dynamic_field::exists_with_type<address, 0x2::object::ID>(&arg0.id, v4)) {
            let v5 = *0x2::dynamic_field::borrow<address, 0x2::object::ID>(&arg0.id, v4);
            let v6 = borrow_mut_user_stake(arg0, v5);
            assert!(!0x2::table::contains<0x2::object::ID, NFTStake>(&v6.staked_nfts, v1), 17);
            0x2::table::add<0x2::object::ID, NFTStake>(&mut v6.staked_nfts, v1, v3);
            v6.total_staked_count = v6.total_staked_count + 1;
            0x2::dynamic_field::add<0x2::object::ID, T0>(&mut v6.id, v1, arg1);
        } else {
            let v7 = UserStake{
                id                 : 0x2::object::new(arg3),
                pool_id            : 0x2::object::id<StakingPool>(arg0),
                staker             : v4,
                staked_nfts        : 0x2::table::new<0x2::object::ID, NFTStake>(arg3),
                total_staked_count : 1,
                pending_rewards    : 0x2::vec_map::empty<0x1::string::String, u64>(),
                staking_since      : v2,
                total_claimed      : 0x2::vec_map::empty<0x1::string::String, u64>(),
            };
            0x2::table::add<0x2::object::ID, NFTStake>(&mut v7.staked_nfts, v1, v3);
            0x2::dynamic_field::add<0x2::object::ID, T0>(&mut v7.id, v1, arg1);
            0x2::dynamic_field::add<address, 0x2::object::ID>(&mut arg0.id, v4, 0x2::object::id<UserStake>(&v7));
            0x2::transfer::public_share_object<UserStake>(v7);
            arg0.total_unique_stakers = arg0.total_unique_stakers + 1;
        };
        arg0.total_staked_nfts = arg0.total_staked_nfts + 1;
        update_global_stats_nft_staked(v2, arg3);
        let v8 = NFTStaked{
            pool_id    : 0x2::object::id<StakingPool>(arg0),
            staker     : v4,
            nft_id     : v1,
            nft_type   : v0,
            timestamp  : v2,
            from_kiosk : false,
        };
        0x2::event::emit<NFTStaked>(v8);
    }

    public fun stake_nft_from_kiosk<T0: store + key>(arg0: &mut StakingPool, arg1: T0, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 7);
        assert!(!arg0.emergency_mode, 25);
        assert!(0x2::kiosk::owner(arg2) == 0x2::tx_context::sender(arg5), 0);
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        assert!(0x2::vec_set::contains<0x1::string::String>(&arg0.allowed_collections, &v0), 18);
        let v1 = 0x2::object::id<T0>(&arg1);
        let v2 = 0x2::clock::timestamp_ms(arg4) / 1000;
        let v3 = NFTStake{
            nft_id            : v1,
            nft_type          : v0,
            staked_at         : v2,
            last_reward_claim : v2,
            claimed_rewards   : 0x2::vec_map::empty<0x1::string::String, u64>(),
            from_kiosk        : true,
        };
        let v4 = 0x2::tx_context::sender(arg5);
        if (0x2::dynamic_field::exists_with_type<address, 0x2::object::ID>(&arg0.id, v4)) {
            let v5 = *0x2::dynamic_field::borrow<address, 0x2::object::ID>(&arg0.id, v4);
            let v6 = borrow_mut_user_stake(arg0, v5);
            assert!(!0x2::table::contains<0x2::object::ID, NFTStake>(&v6.staked_nfts, v1), 17);
            0x2::table::add<0x2::object::ID, NFTStake>(&mut v6.staked_nfts, v1, v3);
            v6.total_staked_count = v6.total_staked_count + 1;
            0x2::dynamic_field::add<0x2::object::ID, T0>(&mut v6.id, v1, arg1);
        } else {
            let v7 = UserStake{
                id                 : 0x2::object::new(arg5),
                pool_id            : 0x2::object::id<StakingPool>(arg0),
                staker             : v4,
                staked_nfts        : 0x2::table::new<0x2::object::ID, NFTStake>(arg5),
                total_staked_count : 1,
                pending_rewards    : 0x2::vec_map::empty<0x1::string::String, u64>(),
                staking_since      : v2,
                total_claimed      : 0x2::vec_map::empty<0x1::string::String, u64>(),
            };
            0x2::table::add<0x2::object::ID, NFTStake>(&mut v7.staked_nfts, v1, v3);
            0x2::dynamic_field::add<0x2::object::ID, T0>(&mut v7.id, v1, arg1);
            0x2::dynamic_field::add<address, 0x2::object::ID>(&mut arg0.id, v4, 0x2::object::id<UserStake>(&v7));
            0x2::transfer::public_share_object<UserStake>(v7);
            arg0.total_unique_stakers = arg0.total_unique_stakers + 1;
        };
        arg0.total_staked_nfts = arg0.total_staked_nfts + 1;
        update_global_stats_last_claim_time(v2, arg5);
        let v8 = NFTStaked{
            pool_id    : 0x2::object::id<StakingPool>(arg0),
            staker     : v4,
            nft_id     : v1,
            nft_type   : v0,
            timestamp  : v2,
            from_kiosk : true,
        };
        0x2::event::emit<NFTStaked>(v8);
    }

    public fun unpause_pool(arg0: &mut StakingPool, arg1: &PoolOwnerCap, arg2: &0x2::clock::Clock) {
        assert!(0x2::object::id<StakingPool>(arg0) == arg1.pool_id, 0);
        assert!(arg0.paused, 14);
        arg0.paused = false;
        let v0 = PoolUnpaused{
            pool_id   : 0x2::object::id<StakingPool>(arg0),
            timestamp : 0x2::clock::timestamp_ms(arg2) / 1000,
        };
        0x2::event::emit<PoolUnpaused>(v0);
    }

    public fun unstake_nft<T0: store + key>(arg0: &mut StakingPool, arg1: &mut UserStake, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : T0 {
        assert!(arg1.pool_id == 0x2::object::id<StakingPool>(arg0), 18);
        assert!(arg1.staker == 0x2::tx_context::sender(arg4), 0);
        assert!(0x2::table::contains<0x2::object::ID, NFTStake>(&arg1.staked_nfts, arg2), 16);
        let v0 = 0x2::table::remove<0x2::object::ID, NFTStake>(&mut arg1.staked_nfts, arg2);
        let v1 = 0x2::clock::timestamp_ms(arg3) / 1000;
        let v2 = v1 - v0.staked_at;
        0x2::vec_map::empty<0x1::string::String, u64>();
        let v3 = false;
        if (arg0.min_staking_period > 0 && v2 < arg0.min_staking_period) {
            v3 = true;
        } else {
            let v4 = calculate_rewards(arg0, &v0, v1);
            distribute_rewards(arg0, arg1, v4, arg4);
        };
        arg1.total_staked_count = arg1.total_staked_count - 1;
        arg0.total_staked_nfts = arg0.total_staked_nfts - 1;
        update_global_stats_nft_unstaked(v2, v3, v1, arg4);
        let v5 = NFTUnstaked{
            pool_id         : 0x2::object::id<StakingPool>(arg0),
            staker          : arg1.staker,
            nft_id          : arg2,
            nft_type        : v0.nft_type,
            staked_duration : v2,
            timestamp       : v1,
            to_kiosk        : false,
        };
        0x2::event::emit<NFTUnstaked>(v5);
        0x2::dynamic_field::remove<0x2::object::ID, T0>(&mut arg1.id, arg2)
    }

    public fun unstake_nft_to_kiosk<T0: store + key>(arg0: &mut StakingPool, arg1: &mut UserStake, arg2: 0x2::object::ID, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::owner(arg3) == 0x2::tx_context::sender(arg6), 0);
        0x2::kiosk::place<T0>(arg3, arg4, unstake_nft<T0>(arg0, arg1, arg2, arg5, arg6));
    }

    fun update_global_stats(arg0: &mut StakingPool, arg1: 0x2::vec_map::VecMap<0x1::string::String, u64>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::vec_map::keys<0x1::string::String, u64>(&arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&v0)) {
            let v2 = 0x1::vector::borrow<0x1::string::String>(&v0, v1);
            if (0x2::vec_map::contains<0x1::string::String, u64>(&arg0.tvl_stats.total_distributed, v2)) {
                0x2::vec_map::insert<0x1::string::String, u64>(&mut arg0.tvl_stats.total_distributed, *v2, *0x2::vec_map::get<0x1::string::String, u64>(&arg0.tvl_stats.total_distributed, v2) + *0x2::vec_map::get<0x1::string::String, u64>(&arg1, v2));
            } else {
                0x2::vec_map::insert<0x1::string::String, u64>(&mut arg0.tvl_stats.total_distributed, *v2, *0x2::vec_map::get<0x1::string::String, u64>(&arg1, v2));
            };
            let v3 = StatisticsUpdated{
                total_staked_nfts_count : arg0.total_staked_nfts,
                total_unique_stakers    : arg0.total_unique_stakers,
                total_claimed_rewards   : arg0.tvl_stats.total_distributed,
                timestamp               : arg2,
            };
            0x2::event::emit<StatisticsUpdated>(v3);
            v1 = v1 + 1;
        };
    }

    fun update_global_stats_last_claim_time(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
    }

    fun update_global_stats_nft_staked(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
    }

    fun update_global_stats_nft_unstaked(arg0: u64, arg1: bool, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
    }

    fun update_global_stats_rewards_claimed(arg0: &0x2::vec_map::VecMap<0x1::string::String, u64>, arg1: &mut 0x2::tx_context::TxContext) {
    }

    public fun update_min_staking_period(arg0: &mut StakingPool, arg1: &PoolOwnerCap, arg2: u64) {
        assert!(0x2::object::id<StakingPool>(arg0) == arg1.pool_id, 0);
        assert!(!arg0.emergency_mode, 25);
        assert!(arg2 <= 365 * 86400, 22);
        arg0.min_staking_period = arg2;
        let v0 = MinStakingPeriodUpdated{
            pool_id    : 0x2::object::id<StakingPool>(arg0),
            new_period : arg2,
        };
        0x2::event::emit<MinStakingPeriodUpdated>(v0);
    }

    public fun update_reward_rate(arg0: &mut StakingPool, arg1: &PoolOwnerCap, arg2: 0x1::string::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<StakingPool>(arg0) == arg1.pool_id, 0);
        assert!(!arg0.emergency_mode, 25);
        assert!(arg3 > 0, 15);
        assert!(0x2::vec_map::contains<0x1::string::String, RewardToken>(&arg0.reward_tokens, &arg2), 20);
        0x2::vec_map::get_mut<0x1::string::String, RewardToken>(&mut arg0.reward_tokens, &arg2).daily_rate = arg3;
        let v0 = RewardRateUpdated{
            pool_id    : 0x2::object::id<StakingPool>(arg0),
            token_type : arg2,
            new_rate   : arg3,
        };
        0x2::event::emit<RewardRateUpdated>(v0);
        arg0.tvl_stats.last_updated = 0x2::tx_context::epoch(arg4);
    }

    public fun update_total_rewards(arg0: &mut StakingPool, arg1: &PoolOwnerCap, arg2: 0x1::string::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<StakingPool>(arg0) == arg1.pool_id, 0);
        assert!(!arg0.emergency_mode, 25);
        assert!(arg3 > 0, 11);
        assert!(0x2::vec_map::contains<0x1::string::String, RewardToken>(&arg0.reward_tokens, &arg2), 20);
        let v0 = 0x2::vec_map::get_mut<0x1::string::String, RewardToken>(&mut arg0.reward_tokens, &arg2);
        assert!(arg3 >= v0.distributed_rewards, 11);
        v0.total_rewards = arg3;
        0x2::vec_map::insert<0x1::string::String, u64>(&mut arg0.tvl_stats.total_rewards_value, arg2, arg3);
        arg0.tvl_stats.last_updated = 0x2::tx_context::epoch(arg4);
    }

    public fun update_tvl_stats(arg0: &mut StakingPool, arg1: &PoolOwnerCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<StakingPool>(arg0) == arg1.pool_id, 0);
        arg0.tvl_stats.total_nft_value = arg2;
        arg0.tvl_stats.last_updated = 0x2::tx_context::epoch(arg3);
        let v0 = TVLUpdated{
            pool_id              : 0x2::object::id<StakingPool>(arg0),
            total_staked_nfts    : arg0.total_staked_nfts,
            total_unique_stakers : arg0.total_unique_stakers,
            rewards_stats        : arg0.tvl_stats.total_rewards_value,
            timestamp            : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<TVLUpdated>(v0);
    }

    public fun withdraw_funds<T0>(arg0: &mut StakingPool, arg1: &PoolOwnerCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::object::id<StakingPool>(arg0) == arg1.pool_id, 0);
        assert!(arg2 > 0, 11);
        let (_, v1) = get_coin_info<T0>(arg3);
        let v2 = v1;
        assert!(0x2::vec_map::contains<0x1::string::String, RewardToken>(&arg0.reward_tokens, &v2), 20);
        assert!(0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, v2), 5);
        let v3 = 0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg0.id, v2);
        assert!(0x2::balance::value<T0>(v3) >= arg2, 5);
        if (0x2::vec_map::contains<0x1::string::String, u64>(&arg0.tvl_stats.current_rewards_value, &v2)) {
            let v4 = *0x2::vec_map::get<0x1::string::String, u64>(&arg0.tvl_stats.current_rewards_value, &v2);
            if (v4 >= arg2) {
                0x2::vec_map::insert<0x1::string::String, u64>(&mut arg0.tvl_stats.current_rewards_value, v2, v4 - arg2);
            } else {
                0x2::vec_map::insert<0x1::string::String, u64>(&mut arg0.tvl_stats.current_rewards_value, v2, 0);
            };
        };
        arg0.tvl_stats.last_updated = 0x2::tx_context::epoch(arg4);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v3, arg2), arg4)
    }

    // decompiled from Move bytecode v6
}

