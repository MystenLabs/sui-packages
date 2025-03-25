module 0x60f111ab7008221887988ef62602ee180ff61fddefa200fba926631269199890::nft_staking {
    struct LockInfo has copy, drop, store {
        lock_type: u8,
        lock_end_time: u64,
        reward_multiplier: u64,
        early_withdrawal_fee: u64,
    }

    struct StakeInfo has copy, drop, store {
        owner: address,
        stake_time: u64,
        last_claim_times: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        nft_id: 0x2::object::ID,
        nft_type: 0x1::type_name::TypeName,
        lock_info: LockInfo,
    }

    struct ReferralInfo has copy, drop, store {
        referral_percentage: u64,
        total_referral_rewards: u64,
        total_referrals: u64,
    }

    struct UserStakingStats has copy, drop, store {
        total_staked_nfts: u64,
        total_rewards_earned: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        total_staking_time_ms: u64,
        total_referrals: u64,
        total_referral_rewards: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        first_stake_time: u64,
        last_stake_time: u64,
        pending_referral_rewards: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
    }

    struct RewardConfig has copy, drop, store {
        reward_type: u64,
        tokens_per_day_per_nft: u64,
        total_reward_pool: u64,
        distributed_rewards: u64,
    }

    struct RewardPoolInfo has copy, drop, store {
        pool_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        reward_config: RewardConfig,
        is_primary: bool,
        auto_mint: bool,
    }

    struct NFT_STAKING has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct StakingConfig has store, key {
        id: 0x2::object::UID,
        reward_pools: 0x2::vec_map::VecMap<0x1::type_name::TypeName, RewardPoolInfo>,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        eligible_nft_types: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        is_active: bool,
        min_stake_period_days: u64,
        lock_enabled: bool,
        max_lock_period_months: u64,
        early_withdrawal_fee: u64,
        paused: bool,
        referral_info: ReferralInfo,
        total_unique_stakers: u64,
        total_rewards_distributed: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        avg_stake_time_ms: u64,
        total_early_unstakes: u64,
    }

    struct RewardPool<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    struct StakingStats has store, key {
        id: 0x2::object::UID,
        total_staked_nfts: u64,
        stake_info: 0x2::table::Table<0x2::object::ID, StakeInfo>,
        total_reward_multiplier: u64,
        user_stats: 0x2::table::Table<address, UserStakingStats>,
    }

    struct NFTStaked has copy, drop {
        nft_id: 0x2::object::ID,
        staker: address,
        stake_time: u64,
        lock_period_months: u64,
        lock_end_time: u64,
        reward_multiplier: u64,
        lock_type: u8,
    }

    struct NFTUnstaked has copy, drop {
        nft_id: 0x2::object::ID,
        staker: address,
        unstake_time: u64,
        total_time_staked_ms: u64,
        early_withdrawal: bool,
        early_withdrawal_fee_amount: u64,
    }

    struct NFTUnstakedAdmin has copy, drop {
        nft_id: 0x2::object::ID,
        staker: address,
        unstake_time: u64,
        admin: address,
    }

    struct RewardClaimed has copy, drop {
        nft_id: 0x2::object::ID,
        staker: address,
        claim_time: u64,
        reward_amount: u64,
        reward_type: 0x1::type_name::TypeName,
    }

    struct PoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        name: 0x1::string::String,
        reward_coin_type: 0x1::type_name::TypeName,
        reward_type: u64,
    }

    struct NFTTypeRegistered has copy, drop {
        nft_type: 0x1::type_name::TypeName,
        pool_id: 0x2::object::ID,
    }

    struct NFTTypeUnregistered has copy, drop {
        nft_type: 0x1::type_name::TypeName,
        pool_id: 0x2::object::ID,
    }

    struct NFTEarlyUnstaked has copy, drop {
        nft_id: 0x2::object::ID,
        staker: address,
        unstake_time: u64,
        total_time_staked_ms: u64,
        min_stake_period_days: u64,
    }

    struct EmergencyPauseChanged has copy, drop {
        pool_id: 0x2::object::ID,
        paused: bool,
        admin: address,
    }

    struct RewardPoolAdded<phantom T0> has copy, drop {
        pool_id: address,
        reward_type: u64,
        tokens_per_day_per_nft: u64,
        total_reward_pool: u64,
    }

    struct RewardPoolRemoved has copy, drop {
        pool_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        admin: address,
    }

    struct ReferralPercentageUpdated has copy, drop {
        pool_id: 0x2::object::ID,
        old_percentage: u64,
        new_percentage: u64,
        admin: address,
    }

    struct StakingStatsUpdated has copy, drop {
        pool_id: 0x2::object::ID,
        total_staked_nfts: u64,
        total_unique_stakers: u64,
        total_rewards_distributed: vector<u64>,
        avg_stake_time_ms: u64,
        update_time: u64,
    }

    struct ContractPaused has copy, drop {
        pool_id: 0x2::object::ID,
        admin: address,
        pause_time: u64,
    }

    struct ContractUnpaused has copy, drop {
        pool_id: 0x2::object::ID,
        admin: address,
        unpause_time: u64,
    }

    struct EmergencyUnstake has copy, drop {
        nft_id: 0x2::object::ID,
        staker: address,
        unstake_time: u64,
        total_time_staked_ms: u64,
    }

    struct ForceUnstakeWithDeferredRewards has copy, drop {
        nft_id: 0x2::object::ID,
        staker: address,
        unstake_time: u64,
        deferred_rewards: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        total_time_staked_ms: u64,
    }

    struct DeferredRewardsClaimed has copy, drop {
        claimer: address,
        reward_amount: u64,
        reward_type: 0x1::type_name::TypeName,
        claim_time: u64,
    }

    struct FundsAdded has copy, drop {
        pool_id: 0x2::object::ID,
        amount: u64,
        sender: address,
        coin_type: 0x1::type_name::TypeName,
    }

    struct FundsWithdrawn has copy, drop {
        pool_id: 0x2::object::ID,
        amount: u64,
        recipient: address,
        admin: address,
        coin_type: 0x1::type_name::TypeName,
    }

    struct StakingPoolCreated has copy, drop {
        pool_id: address,
        name: 0x1::string::String,
        reward_coin_type: 0x1::type_name::TypeName,
        reward_type: u64,
    }

    struct RewardPoolFunded<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        amount: u64,
        funder: address,
    }

    struct RewardTypeUpdated has copy, drop {
        pool_id: address,
        reward_type: u8,
    }

    struct TokensPerDayUpdated has copy, drop {
        pool_id: address,
        tokens_per_day_per_nft: u64,
    }

    struct TotalRewardPoolUpdated has copy, drop {
        pool_id: address,
        total_reward_pool: u64,
    }

    struct FundsAddedToRewardPool<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        amount: u64,
        sender: address,
    }

    struct FundsWithdrawnFromRewardPool<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        amount: u64,
        recipient: address,
    }

    struct DeferredRewardAdded<phantom T0> has copy, drop {
        staker: address,
        nft_id: 0x2::object::ID,
        amount: u64,
        deferred_time: u64,
    }

    struct ReferralRewardClaimed has copy, drop {
        referrer: address,
        reward_amount: u64,
        reward_type: 0x1::type_name::TypeName,
        claim_time: u64,
    }

    struct DeferredRewardsAdded has copy, drop {
        nft_id: 0x2::object::ID,
        staker: address,
        unstake_time: u64,
        min_stake_period_days: u64,
    }

    struct NFTForceUnstaked has copy, drop {
        nft_id: 0x2::object::ID,
        staker: address,
        unstake_time: u64,
        total_time_staked_ms: u64,
        deferred_rewards: bool,
    }

    struct NFTEmergencyUnstaked has copy, drop {
        nft_id: 0x2::object::ID,
        owner: address,
        unstake_time: u64,
        by_admin: bool,
    }

    public entry fun add_funds_to_reward_pool<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut RewardPool<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(arg0));
        let v0 = FundsAddedToRewardPool<T0>{
            pool_id : 0x2::object::id<RewardPool<T0>>(arg1),
            amount  : 0x2::coin::value<T0>(&arg0),
            sender  : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<FundsAddedToRewardPool<T0>>(v0);
    }

    public entry fun add_funds_to_reward_pool_from_admin<T0>(arg0: &AdminCap, arg1: &mut RewardPool<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(arg2));
        let v0 = FundsAddedToRewardPool<T0>{
            pool_id : 0x2::object::id<RewardPool<T0>>(arg1),
            amount  : 0x2::coin::value<T0>(&arg2),
            sender  : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<FundsAddedToRewardPool<T0>>(v0);
    }

    public entry fun add_reward_type<T0>(arg0: &AdminCap, arg1: &mut StakingConfig, arg2: u64, arg3: u64, arg4: u64, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 == 0 || arg2 == 1, 10);
        let v0 = 0x1::type_name::get<T0>();
        assert!(!0x2::vec_map::contains<0x1::type_name::TypeName, RewardPoolInfo>(&arg1.reward_pools, &v0), 4);
        let v1 = 0x2::object::new(arg6);
        let v2 = RewardConfig{
            reward_type            : arg2,
            tokens_per_day_per_nft : arg3,
            total_reward_pool      : arg4,
            distributed_rewards    : 0,
        };
        let v3 = RewardPoolInfo{
            pool_id       : 0x2::object::uid_to_inner(&v1),
            coin_type     : v0,
            reward_config : v2,
            is_primary    : false,
            auto_mint     : arg5,
        };
        0x2::vec_map::insert<0x1::type_name::TypeName, RewardPoolInfo>(&mut arg1.reward_pools, v0, v3);
        let v4 = RewardPool<T0>{
            id      : v1,
            balance : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<RewardPool<T0>>(v4);
        let v5 = RewardPoolAdded<T0>{
            pool_id                : 0x2::object::id_address<RewardPool<T0>>(&v4),
            reward_type            : arg2,
            tokens_per_day_per_nft : arg3,
            total_reward_pool      : arg4,
        };
        0x2::event::emit<RewardPoolAdded<T0>>(v5);
    }

    public entry fun admin_force_unstake_nft<T0: store + key, T1>(arg0: &AdminCap, arg1: &mut StakingConfig, arg2: &mut RewardPool<T1>, arg3: 0x2::object::ID, arg4: bool, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(is_nft_type_eligible<T0>(arg1), 29);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = 0x2::dynamic_field::borrow_mut<vector<u8>, StakingStats>(&mut arg1.id, b"stats");
        assert!(0x2::table::contains<0x2::object::ID, StakeInfo>(&v1.stake_info, arg3), 5);
        let v2 = 0x2::table::borrow<0x2::object::ID, StakeInfo>(&v1.stake_info, arg3);
        let v3 = v2.owner;
        let v4 = if (v2.lock_info.lock_type == 1) {
            if (v0 < v2.lock_info.lock_end_time) {
                arg1.lock_enabled
            } else {
                false
            }
        } else {
            false
        };
        let v5 = *v2;
        v1.total_staked_nfts = v1.total_staked_nfts - 1;
        v1.total_reward_multiplier = v1.total_reward_multiplier - v5.lock_info.reward_multiplier;
        0x2::table::remove<0x2::object::ID, StakeInfo>(&mut v1.stake_info, arg3);
        let v6 = arg4 && v0 >= v2.stake_time + arg1.min_stake_period_days * 86400000;
        let v7 = 0;
        if (v6) {
            let v8 = calculate_reward<T1>(arg1, arg2, v5, arg5);
            let v9 = v8;
            if (v4) {
                let v10 = v8 * arg1.early_withdrawal_fee / 10000;
                v7 = v10;
                v9 = v8 - v10;
            };
            if (v9 > 0) {
                transfer_reward<T1>(arg2, v9, v3, arg6);
            };
        };
        0x2::transfer::public_transfer<T0>(0x2::dynamic_field::remove<0x2::object::ID, T0>(&mut arg1.id, arg3), v3);
        let v11 = NFTUnstaked{
            nft_id                      : arg3,
            staker                      : v3,
            unstake_time                : v0,
            total_time_staked_ms        : v0 - v5.stake_time,
            early_withdrawal            : v4,
            early_withdrawal_fee_amount : v7,
        };
        0x2::event::emit<NFTUnstaked>(v11);
    }

    public entry fun batch_admin_force_unstake_nfts<T0: store + key, T1>(arg0: &AdminCap, arg1: &mut StakingConfig, arg2: &mut RewardPool<T1>, arg3: vector<0x2::object::ID>, arg4: bool, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(&arg3)) {
            let v2 = *0x1::vector::borrow<0x2::object::ID>(&arg3, v1);
            let v3 = 0x2::dynamic_field::borrow_mut<vector<u8>, StakingStats>(&mut arg1.id, b"stats");
            assert!(0x2::table::contains<0x2::object::ID, StakeInfo>(&v3.stake_info, v2), 5);
            let v4 = 0x2::table::borrow<0x2::object::ID, StakeInfo>(&v3.stake_info, v2);
            let v5 = v4.owner;
            let v6 = arg4 && v0 >= v4.stake_time + arg1.min_stake_period_days * 86400000;
            let v7 = if (v4.lock_info.lock_type == 1) {
                if (v0 < v4.lock_info.lock_end_time) {
                    arg1.lock_enabled
                } else {
                    false
                }
            } else {
                false
            };
            let v8 = *v4;
            v3.total_staked_nfts = v3.total_staked_nfts - 1;
            v3.total_reward_multiplier = v3.total_reward_multiplier - v4.lock_info.reward_multiplier;
            0x2::table::remove<0x2::object::ID, StakeInfo>(&mut v3.stake_info, v2);
            let v9 = 0;
            if (v6) {
                let v10 = calculate_reward<T1>(arg1, arg2, v8, arg5);
                let v11 = v10;
                if (v7) {
                    let v12 = v10 * v8.lock_info.early_withdrawal_fee / 10000;
                    v9 = v12;
                    v11 = v10 - v12;
                };
                if (v11 > 0) {
                    transfer_reward<T1>(arg2, v11, v5, arg6);
                };
                let v13 = NFTUnstaked{
                    nft_id                      : v2,
                    staker                      : v5,
                    unstake_time                : v0,
                    total_time_staked_ms        : v0 - v8.stake_time,
                    early_withdrawal            : v7,
                    early_withdrawal_fee_amount : v9,
                };
                0x2::event::emit<NFTUnstaked>(v13);
            } else {
                let v14 = NFTUnstaked{
                    nft_id                      : v2,
                    staker                      : v5,
                    unstake_time                : v0,
                    total_time_staked_ms        : v0 - v8.stake_time,
                    early_withdrawal            : v7,
                    early_withdrawal_fee_amount : 0,
                };
                0x2::event::emit<NFTUnstaked>(v14);
            };
            0x2::transfer::public_transfer<T0>(0x2::dynamic_field::remove<0x2::object::ID, T0>(&mut arg1.id, v2), v5);
            v1 = v1 + 1;
        };
    }

    public entry fun batch_claim_rewards<T0>(arg0: &mut StakingConfig, arg1: &mut RewardPool<T0>, arg2: vector<0x2::object::ID>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(&arg2)) {
            let v3 = *0x1::vector::borrow<0x2::object::ID>(&arg2, v2);
            let v4 = 0x2::dynamic_field::borrow_mut<vector<u8>, StakingStats>(&mut arg0.id, b"stats");
            assert!(0x2::table::contains<0x2::object::ID, StakeInfo>(&v4.stake_info, v3), 5);
            let v5 = 0x2::table::borrow_mut<0x2::object::ID, StakeInfo>(&mut v4.stake_info, v3);
            assert!(v5.owner == 0x2::tx_context::sender(arg4), 1);
            if (arg0.min_stake_period_days > 0) {
                assert!(v0 >= v5.stake_time + arg0.min_stake_period_days * 86400000, 15);
            };
            let v6 = *v5;
            let v7 = 0x1::type_name::get<T0>();
            if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&v5.last_claim_times, &v7)) {
                *0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut v5.last_claim_times, &v7) = v0;
            } else {
                0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v5.last_claim_times, v7, v0);
            };
            let v8 = calculate_reward<T0>(arg0, arg1, v6, arg3);
            if (v8 > 0) {
                v1 = v1 + v8;
                let v9 = RewardClaimed{
                    nft_id        : v3,
                    staker        : v6.owner,
                    claim_time    : v0,
                    reward_amount : v8,
                    reward_type   : 0x1::type_name::get<T0>(),
                };
                0x2::event::emit<RewardClaimed>(v9);
            };
            v2 = v2 + 1;
        };
        assert!(v1 > 0, 11);
        let v10 = 0x2::tx_context::sender(arg4);
        transfer_reward<T0>(arg1, v1, v10, arg4);
    }

    public entry fun batch_early_unstake_nfts<T0: store + key>(arg0: &mut StakingConfig, arg1: vector<0x2::object::ID>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(&arg1)) {
            let v2 = *0x1::vector::borrow<0x2::object::ID>(&arg1, v1);
            let v3 = 0x2::dynamic_field::borrow_mut<vector<u8>, StakingStats>(&mut arg0.id, b"stats");
            assert!(0x2::table::contains<0x2::object::ID, StakeInfo>(&v3.stake_info, v2), 5);
            let v4 = 0x2::table::borrow<0x2::object::ID, StakeInfo>(&v3.stake_info, v2);
            assert!(v4.owner == 0x2::tx_context::sender(arg3), 1);
            let v5 = v4.owner;
            v3.total_staked_nfts = v3.total_staked_nfts - 1;
            v3.total_reward_multiplier = v3.total_reward_multiplier - v4.lock_info.reward_multiplier;
            0x2::table::remove<0x2::object::ID, StakeInfo>(&mut v3.stake_info, v2);
            0x2::transfer::public_transfer<T0>(0x2::dynamic_field::remove<0x2::object::ID, T0>(&mut arg0.id, v2), v5);
            let v6 = NFTEarlyUnstaked{
                nft_id                : v2,
                staker                : v5,
                unstake_time          : v0,
                total_time_staked_ms  : v0 - v4.stake_time,
                min_stake_period_days : arg0.min_stake_period_days,
            };
            0x2::event::emit<NFTEarlyUnstaked>(v6);
            v1 = v1 + 1;
        };
    }

    public entry fun batch_stake_nfts<T0: store + key>(arg0: vector<T0>, arg1: &mut StakingConfig, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.paused, 16);
        assert!(arg1.is_active, 2);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg1.eligible_nft_types, &v0), 3);
        if (!arg1.lock_enabled) {
            assert!(arg2 == 0, 7);
        } else {
            assert!((arg2 as u64) == 0 || arg2 >= 1 && arg2 <= arg1.max_lock_period_months, 7);
        };
        0x2::dynamic_field::borrow_mut<vector<u8>, StakingStats>(&mut arg1.id, b"stats");
        let v1 = calculate_reward_multiplier(arg2);
        let v2 = 0x2::clock::timestamp_ms(arg3);
        let v3 = 0;
        while (v3 < 0x1::vector::length<T0>(&arg0)) {
            let v4 = 0x1::vector::swap_remove<T0>(&mut arg0, 0);
            let v5 = 0x2::object::id<T0>(&v4);
            let v6 = if ((arg2 as u64) > 0) {
                1
            } else {
                0
            };
            let v7 = if ((arg2 as u64) > 0) {
                v2 + arg1.min_stake_period_days * 86400000 + (arg2 as u64) * 2592000000
            } else {
                0
            };
            let v8 = LockInfo{
                lock_type            : v6,
                lock_end_time        : v7,
                reward_multiplier    : v1,
                early_withdrawal_fee : arg1.early_withdrawal_fee,
            };
            let v9 = StakeInfo{
                owner            : 0x2::tx_context::sender(arg4),
                stake_time       : v2,
                last_claim_times : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
                nft_id           : v5,
                nft_type         : v0,
                lock_info        : v8,
            };
            let v10 = 0x2::dynamic_field::borrow_mut<vector<u8>, StakingStats>(&mut arg1.id, b"stats");
            assert!(!0x2::table::contains<0x2::object::ID, StakeInfo>(&v10.stake_info, v5), 4);
            0x2::table::add<0x2::object::ID, StakeInfo>(&mut v10.stake_info, v5, v9);
            v10.total_staked_nfts = v10.total_staked_nfts + 1;
            v10.total_reward_multiplier = v10.total_reward_multiplier + v1;
            0x2::dynamic_field::add<0x2::object::ID, T0>(&mut arg1.id, v5, v4);
            let v11 = NFTStaked{
                nft_id             : v5,
                staker             : 0x2::tx_context::sender(arg4),
                stake_time         : v9.stake_time,
                lock_period_months : (arg2 as u64),
                lock_end_time      : v8.lock_end_time,
                reward_multiplier  : v8.reward_multiplier,
                lock_type          : v8.lock_type,
            };
            0x2::event::emit<NFTStaked>(v11);
            v3 = v3 + 1;
        };
        assert!(0x1::vector::is_empty<T0>(&arg0), 30);
        0x1::vector::destroy_empty<T0>(arg0);
    }

    public entry fun batch_stake_nfts_from_kiosk<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: vector<0x2::object::ID>, arg3: &mut StakingConfig, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg3.paused, 16);
        assert!(arg3.is_active, 2);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg3.eligible_nft_types, &v0), 3);
        if (!arg3.lock_enabled) {
            assert!(arg4 == 0, 7);
        } else {
            assert!((arg4 as u64) == 0 || arg4 >= 1 && arg4 <= arg3.max_lock_period_months, 7);
        };
        let v1 = calculate_reward_multiplier(arg4);
        let v2 = 0x2::clock::timestamp_ms(arg5);
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x2::object::ID>(&arg2)) {
            let v4 = *0x1::vector::borrow<0x2::object::ID>(&arg2, v3);
            let v5 = if ((arg4 as u64) > 0) {
                1
            } else {
                0
            };
            let v6 = if ((arg4 as u64) > 0) {
                v2 + arg3.min_stake_period_days * 86400000 + (arg4 as u64) * 2592000000
            } else {
                0
            };
            let v7 = LockInfo{
                lock_type            : v5,
                lock_end_time        : v6,
                reward_multiplier    : v1,
                early_withdrawal_fee : arg3.early_withdrawal_fee,
            };
            let v8 = StakeInfo{
                owner            : 0x2::tx_context::sender(arg6),
                stake_time       : v2,
                last_claim_times : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
                nft_id           : v4,
                nft_type         : v0,
                lock_info        : v7,
            };
            let v9 = 0x2::dynamic_field::borrow_mut<vector<u8>, StakingStats>(&mut arg3.id, b"stats");
            assert!(!0x2::table::contains<0x2::object::ID, StakeInfo>(&v9.stake_info, v4), 4);
            0x2::table::add<0x2::object::ID, StakeInfo>(&mut v9.stake_info, v4, v8);
            v9.total_staked_nfts = v9.total_staked_nfts + 1;
            v9.total_reward_multiplier = v9.total_reward_multiplier + v1;
            0x2::dynamic_field::add<0x2::object::ID, T0>(&mut arg3.id, v4, 0x2::kiosk::take<T0>(arg0, arg1, v4));
            let v10 = NFTStaked{
                nft_id             : v4,
                staker             : 0x2::tx_context::sender(arg6),
                stake_time         : v8.stake_time,
                lock_period_months : (arg4 as u64),
                lock_end_time      : v7.lock_end_time,
                reward_multiplier  : v7.reward_multiplier,
                lock_type          : v7.lock_type,
            };
            0x2::event::emit<NFTStaked>(v10);
            v3 = v3 + 1;
        };
    }

    public entry fun batch_stake_nfts_with_referral<T0: store + key>(arg0: vector<T0>, arg1: &mut StakingConfig, arg2: u64, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.paused, 16);
        assert!(arg1.is_active, 2);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg1.eligible_nft_types, &v0), 29);
        assert!((arg2 as u64) == 0 || arg2 >= 1 && arg2 <= arg1.max_lock_period_months, 7);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        let v2 = if ((arg2 as u64) > 0) {
            1
        } else {
            0
        };
        let v3 = if ((arg2 as u64) > 0) {
            v1 + arg1.min_stake_period_days * 86400000 + (arg2 as u64) * 2592000000
        } else {
            0
        };
        let v4 = LockInfo{
            lock_type            : v2,
            lock_end_time        : v3,
            reward_multiplier    : calculate_reward_multiplier(arg2),
            early_withdrawal_fee : arg1.early_withdrawal_fee,
        };
        let v5 = 0;
        let v6 = 0x1::vector::length<T0>(&arg0);
        while (v5 < v6) {
            let v7 = 0x1::vector::swap_remove<T0>(&mut arg0, 0);
            let v8 = 0x2::object::id<T0>(&v7);
            let v9 = create_stake_info(v8, 0x2::tx_context::sender(arg5), v1, arg1.min_stake_period_days, v4);
            let v10 = 0x2::dynamic_field::borrow_mut<vector<u8>, StakingStats>(&mut arg1.id, b"stats");
            0x2::table::add<0x2::object::ID, StakeInfo>(&mut v10.stake_info, v8, v9);
            v10.total_staked_nfts = v10.total_staked_nfts + 1;
            v10.total_reward_multiplier = v10.total_reward_multiplier + v4.reward_multiplier;
            0x2::dynamic_field::add<0x2::object::ID, T0>(&mut arg1.id, v8, v7);
            let v11 = NFTStaked{
                nft_id             : v8,
                staker             : 0x2::tx_context::sender(arg5),
                stake_time         : v9.stake_time,
                lock_period_months : (arg2 as u64),
                lock_end_time      : v4.lock_end_time,
                reward_multiplier  : v4.reward_multiplier,
                lock_type          : v4.lock_type,
            };
            0x2::event::emit<NFTStaked>(v11);
            v5 = v5 + 1;
        };
        let v12 = if (arg3 != @0x0) {
            if (arg3 != 0x2::tx_context::sender(arg5)) {
                v6 > 0
            } else {
                false
            }
        } else {
            false
        };
        if (v12) {
            let v13 = 0x2::dynamic_field::borrow_mut<vector<u8>, StakingStats>(&mut arg1.id, b"stats");
            update_referral_stats(v13, arg3, 0x2::tx_context::sender(arg5), arg1.referral_info.referral_percentage, arg4);
            update_user_stake_stats(v13, 0x2::tx_context::sender(arg5), v4.reward_multiplier * (v6 as u64), 0x2::object::id_from_address(@0x0), arg4);
        };
        assert!(0x1::vector::is_empty<T0>(&arg0), 30);
        0x1::vector::destroy_empty<T0>(arg0);
    }

    fun batch_unstake_helper<T0: store + key, T1>(arg0: &mut StakingConfig, arg1: &mut RewardPool<T1>, arg2: vector<0x2::object::ID>, arg3: address, arg4: bool, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(&arg2)) {
            let v1 = *0x1::vector::borrow<0x2::object::ID>(&arg2, v0);
            let v2 = 0x2::clock::timestamp_ms(arg5);
            let v3 = 0x2::dynamic_field::borrow_mut<vector<u8>, StakingStats>(&mut arg0.id, b"stats");
            assert!(0x2::table::contains<0x2::object::ID, StakeInfo>(&v3.stake_info, v1), 5);
            let v4 = 0x2::table::borrow<0x2::object::ID, StakeInfo>(&v3.stake_info, v1);
            assert!(v4.owner == arg3, 1);
            if (arg0.min_stake_period_days > 0) {
                assert!(v2 >= v4.stake_time + arg0.min_stake_period_days * 86400000, 15);
            };
            let v5 = *v4;
            v3.total_staked_nfts = v3.total_staked_nfts - 1;
            v3.total_reward_multiplier = v3.total_reward_multiplier - v4.lock_info.reward_multiplier;
            0x2::table::remove<0x2::object::ID, StakeInfo>(&mut v3.stake_info, v1);
            if (arg4) {
                let v6 = calculate_reward<T1>(arg0, arg1, v5, arg5);
                let v7 = v6;
                let v8 = if (v5.lock_info.lock_type == 1) {
                    if (v2 < v5.lock_info.lock_end_time) {
                        arg0.lock_enabled
                    } else {
                        false
                    }
                } else {
                    false
                };
                let v9 = 0;
                if (v8) {
                    let v10 = v6 * arg0.early_withdrawal_fee / 10000;
                    v9 = v10;
                    v7 = v6 - v10;
                };
                if (v7 > 0) {
                    transfer_reward<T1>(arg1, v7, arg3, arg6);
                };
                let v11 = NFTUnstaked{
                    nft_id                      : v1,
                    staker                      : arg3,
                    unstake_time                : v2,
                    total_time_staked_ms        : v2 - v5.stake_time,
                    early_withdrawal            : v8,
                    early_withdrawal_fee_amount : v9,
                };
                0x2::event::emit<NFTUnstaked>(v11);
            } else {
                let v12 = NFTEarlyUnstaked{
                    nft_id                : v1,
                    staker                : arg3,
                    unstake_time          : v2,
                    total_time_staked_ms  : v2 - v5.stake_time,
                    min_stake_period_days : arg0.min_stake_period_days,
                };
                0x2::event::emit<NFTEarlyUnstaked>(v12);
            };
            0x2::transfer::public_transfer<T0>(0x2::dynamic_field::remove<0x2::object::ID, T0>(&mut arg0.id, v1), arg3);
            v0 = v0 + 1;
        };
    }

    public entry fun batch_unstake_nfts<T0: store + key, T1>(arg0: &mut StakingConfig, arg1: &mut RewardPool<T1>, arg2: vector<0x2::object::ID>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        batch_unstake_helper<T0, T1>(arg0, arg1, arg2, v0, true, arg3, arg4);
    }

    fun calculate_base_staking_reward(arg0: u64, arg1: u64) : u64 {
        arg0 * arg1
    }

    fun calculate_dynamic_reward(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &RewardConfig) : u128 {
        if (arg4 == 0) {
            return 0
        };
        let v0 = if (arg1 > arg0) {
            arg2 - arg1
        } else {
            arg2 - arg0
        };
        if (v0 == 0) {
            return 0
        };
        ((arg5.total_reward_pool as u128) - (arg5.distributed_rewards as u128)) * (arg3 as u128) * 1000000 / (arg4 as u128) * (v0 as u128) * 1000000 / (31536000000 as u128) / 1000000000000
    }

    fun calculate_reward<T0>(arg0: &StakingConfig, arg1: &RewardPool<T0>, arg2: StakeInfo, arg3: &0x2::clock::Clock) : u64 {
        calculate_reward_for_token_type<T0>(arg0, arg1, arg2, 0x1::type_name::get<T0>(), arg3)
    }

    fun calculate_reward_for_token_type<T0>(arg0: &StakingConfig, arg1: &RewardPool<T0>, arg2: StakeInfo, arg3: 0x1::type_name::TypeName, arg4: &0x2::clock::Clock) : u64 {
        if (arg0.paused) {
            return 0
        };
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, RewardPoolInfo>(&arg0.reward_pools, &arg3), 27);
        let (v0, v1, v2, v3, _, _) = get_reward_pool_info(arg0, arg3);
        if (v1 == 0 || v2 > 0 && v3 >= v2) {
            return 0
        };
        let v6 = 0x2::clock::timestamp_ms(arg4) - arg2.stake_time;
        if (arg0.min_stake_period_days > 0 && v6 < arg0.min_stake_period_days * 86400000) {
            return 0
        };
        if (v0 == 1) {
            let v8 = v6 / 86400000 * v1 * arg2.lock_info.reward_multiplier / 100;
            let v9 = v8;
            if (v2 > 0 && v3 + v8 > v2) {
                v9 = v2 - v3;
            };
            let v10 = 0x2::balance::value<T0>(&arg1.balance);
            if (v9 > v10) {
                v9 = v10;
            };
            v9
        } else {
            let v11 = 0x2::dynamic_field::borrow<vector<u8>, StakingStats>(&arg0.id, b"stats");
            if (v11.total_staked_nfts == 0 || v11.total_reward_multiplier == 0) {
                return 0
            };
            let v12 = v6 / 86400000 * v1 * arg2.lock_info.reward_multiplier * 10000 / v11.total_reward_multiplier / 10000;
            let v13 = v12;
            if (v2 > 0 && v3 + v12 > v2) {
                v13 = v2 - v3;
            };
            let v14 = 0x2::balance::value<T0>(&arg1.balance);
            if (v13 > v14) {
                v13 = v14;
            };
            v13
        }
    }

    fun calculate_reward_multiplier(arg0: u64) : u64 {
        if ((arg0 as u64) == 0) {
            return 100
        };
        if (arg0 == 12) {
            return 1300
        };
        let v0 = 100 + arg0 * 100;
        let v1 = v0;
        if (v0 > 1200) {
            v1 = 1200;
        };
        v1
    }

    public entry fun claim_deferred_rewards<T0>(arg0: &mut StakingConfig, arg1: &mut RewardPool<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, RewardPoolInfo>(&arg0.reward_pools, &v0), 2);
        let v1 = 0x2::dynamic_field::borrow_mut<vector<u8>, StakingStats>(&mut arg0.id, b"stats");
        assert!(0x2::table::contains<address, UserStakingStats>(&v1.user_stats, 0x2::tx_context::sender(arg3)), 1);
        let v2 = 0x2::table::borrow_mut<address, UserStakingStats>(&mut v1.user_stats, 0x2::tx_context::sender(arg3));
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&v2.pending_referral_rewards, &v0), 18);
        let v3 = *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&v2.pending_referral_rewards, &v0);
        assert!(v3 > 0, 18);
        assert!(0x2::balance::value<T0>(&arg1.balance) >= v3, 19);
        *0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut v2.pending_referral_rewards, &v0) = 0;
        let v4 = 0x2::tx_context::sender(arg3);
        transfer_reward<T0>(arg1, v3, v4, arg3);
        let v5 = DeferredRewardsClaimed{
            claimer       : 0x2::tx_context::sender(arg3),
            reward_amount : v3,
            reward_type   : v0,
            claim_time    : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<DeferredRewardsClaimed>(v5);
    }

    public entry fun claim_referral_rewards<T0>(arg0: &mut StakingConfig, arg1: &mut RewardPool<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, RewardPoolInfo>(&arg0.reward_pools, &v0), 2);
        let v1 = 0x2::dynamic_field::borrow_mut<vector<u8>, StakingStats>(&mut arg0.id, b"stats");
        assert!(0x2::table::contains<address, UserStakingStats>(&v1.user_stats, 0x2::tx_context::sender(arg3)), 1);
        let v2 = 0x2::table::borrow_mut<address, UserStakingStats>(&mut v1.user_stats, 0x2::tx_context::sender(arg3));
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&v2.pending_referral_rewards, &v0), 18);
        let v3 = *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&v2.pending_referral_rewards, &v0);
        assert!(v3 > 0, 18);
        *0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut v2.pending_referral_rewards, &v0) = 0;
        let v4 = 0x2::tx_context::sender(arg3);
        transfer_reward<T0>(arg1, v3, v4, arg3);
        let v5 = ReferralRewardClaimed{
            referrer      : 0x2::tx_context::sender(arg3),
            reward_amount : v3,
            reward_type   : v0,
            claim_time    : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<ReferralRewardClaimed>(v5);
    }

    public entry fun claim_rewards<T0>(arg0: &mut StakingConfig, arg1: &mut RewardPool<T0>, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 16);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = 0x1::type_name::get<T0>();
        let v3 = 0x2::dynamic_field::borrow_mut<vector<u8>, StakingStats>(&mut arg0.id, b"stats");
        assert!(0x2::table::contains<0x2::object::ID, StakeInfo>(&v3.stake_info, arg2), 5);
        let v4 = *0x2::table::borrow<0x2::object::ID, StakeInfo>(&v3.stake_info, arg2);
        assert!(v4.owner == v1, 1);
        let v5 = 0x2::table::borrow_mut<0x2::object::ID, StakeInfo>(&mut v3.stake_info, arg2);
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&v5.last_claim_times, &v2)) {
            *0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut v5.last_claim_times, &v2) = v0;
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v5.last_claim_times, v2, v0);
        };
        let v6 = calculate_reward<T0>(arg0, arg1, v4, arg3);
        assert!(v6 > 0, 28);
        transfer_reward<T0>(arg1, v6, v1, arg4);
        let v7 = 0x2::dynamic_field::borrow_mut<vector<u8>, StakingStats>(&mut arg0.id, b"stats");
        if (0x2::table::contains<address, UserStakingStats>(&v7.user_stats, v1)) {
            let v8 = 0x2::table::borrow_mut<address, UserStakingStats>(&mut v7.user_stats, v1);
            if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&v8.total_rewards_earned, &v2)) {
                *0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut v8.total_rewards_earned, &v2) = *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&v8.total_rewards_earned, &v2) + v6;
            } else {
                0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v8.total_rewards_earned, v2, v6);
            };
        };
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.total_rewards_distributed, &v2)) {
            *0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg0.total_rewards_distributed, &v2) = *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&arg0.total_rewards_distributed, &v2) + v6;
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg0.total_rewards_distributed, v2, v6);
        };
        let v9 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, RewardPoolInfo>(&mut arg0.reward_pools, &v2);
        v9.reward_config.distributed_rewards = v9.reward_config.distributed_rewards + v6;
        let v10 = RewardClaimed{
            nft_id        : arg2,
            staker        : v1,
            claim_time    : v0,
            reward_amount : v6,
            reward_type   : v2,
        };
        0x2::event::emit<RewardClaimed>(v10);
    }

    fun create_lock_info(arg0: u8, arg1: &StakingConfig, arg2: &0x2::clock::Clock) : LockInfo {
        if (!arg1.lock_enabled) {
            assert!(arg0 == 0, 7);
        };
        let v0 = if ((arg0 as u64) > 0) {
            1
        } else {
            0
        };
        let v1 = if (v0 == 1) {
            0x2::clock::timestamp_ms(arg2) + (arg0 as u64) * 2592000000
        } else {
            0
        };
        LockInfo{
            lock_type            : v0,
            lock_end_time        : v1,
            reward_multiplier    : 100 + (arg0 as u64) * 10,
            early_withdrawal_fee : arg1.early_withdrawal_fee,
        }
    }

    fun create_stake_info(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: LockInfo) : StakeInfo {
        StakeInfo{
            owner            : arg1,
            stake_time       : arg2,
            last_claim_times : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            nft_id           : arg0,
            nft_type         : 0x1::type_name::get<0x2::object::ID>(),
            lock_info        : arg4,
        }
    }

    public entry fun create_staking_pool<T0>(arg0: &AdminCap, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: bool, arg9: u64, arg10: u64, arg11: bool, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 == 0 || arg4 == 1, 10);
        assert!(arg5 > 0, 11);
        assert!(arg6 > 0, 11);
        assert!(arg7 <= 60, 14);
        assert!(arg10 <= 5000, 11);
        let v0 = RewardConfig{
            reward_type            : arg4,
            tokens_per_day_per_nft : arg5,
            total_reward_pool      : arg6,
            distributed_rewards    : 0,
        };
        let v1 = 0x2::object::new(arg12);
        let v2 = RewardPoolInfo{
            pool_id       : 0x2::object::uid_to_inner(&v1),
            coin_type     : 0x1::type_name::get<T0>(),
            reward_config : v0,
            is_primary    : true,
            auto_mint     : arg11,
        };
        let v3 = 0x2::vec_map::empty<0x1::type_name::TypeName, RewardPoolInfo>();
        0x2::vec_map::insert<0x1::type_name::TypeName, RewardPoolInfo>(&mut v3, 0x1::type_name::get<T0>(), v2);
        let v4 = ReferralInfo{
            referral_percentage    : 500,
            total_referral_rewards : 0,
            total_referrals        : 0,
        };
        let v5 = StakingConfig{
            id                        : 0x2::object::new(arg12),
            reward_pools              : v3,
            name                      : 0x1::string::utf8(arg1),
            description               : 0x1::string::utf8(arg2),
            image_url                 : 0x2::url::new_unsafe_from_bytes(arg3),
            eligible_nft_types        : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            is_active                 : true,
            min_stake_period_days     : arg7,
            lock_enabled              : arg8,
            max_lock_period_months    : arg9,
            early_withdrawal_fee      : arg10,
            paused                    : false,
            referral_info             : v4,
            total_unique_stakers      : 0,
            total_rewards_distributed : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            avg_stake_time_ms         : 0,
            total_early_unstakes      : 0,
        };
        let v6 = StakingStats{
            id                      : 0x2::object::new(arg12),
            total_staked_nfts       : 0,
            stake_info              : 0x2::table::new<0x2::object::ID, StakeInfo>(arg12),
            total_reward_multiplier : 0,
            user_stats              : 0x2::table::new<address, UserStakingStats>(arg12),
        };
        0x2::dynamic_field::add<vector<u8>, StakingStats>(&mut v5.id, b"stats", v6);
        let v7 = RewardPool<T0>{
            id      : v1,
            balance : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<StakingConfig>(v5);
        0x2::transfer::share_object<RewardPool<T0>>(v7);
        let v8 = StakingPoolCreated{
            pool_id          : 0x2::object::id_address<StakingConfig>(&v5),
            name             : 0x1::string::utf8(arg1),
            reward_coin_type : 0x1::type_name::get<T0>(),
            reward_type      : arg4,
        };
        0x2::event::emit<StakingPoolCreated>(v8);
    }

    fun defer_rewards<T0>(arg0: &mut StakingConfig, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x2::dynamic_field::borrow_mut<vector<u8>, StakingStats>(&mut arg0.id, b"stats");
        let v2 = if (0x2::table::contains<address, UserStakingStats>(&v1.user_stats, arg2)) {
            0x2::table::borrow_mut<address, UserStakingStats>(&mut v1.user_stats, arg2)
        } else {
            let v3 = UserStakingStats{
                total_staked_nfts        : 0,
                total_rewards_earned     : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
                total_staking_time_ms    : 0,
                total_referrals          : 0,
                total_referral_rewards   : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
                first_stake_time         : arg3,
                last_stake_time          : arg3,
                pending_referral_rewards : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            };
            0x2::table::add<address, UserStakingStats>(&mut v1.user_stats, arg2, v3);
            0x2::table::borrow_mut<address, UserStakingStats>(&mut v1.user_stats, arg2)
        };
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&v2.pending_referral_rewards, &v0)) {
            let v4 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut v2.pending_referral_rewards, &v0);
            *v4 = *v4 + arg4;
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v2.pending_referral_rewards, v0, arg4);
        };
        let v5 = DeferredRewardAdded<T0>{
            staker        : arg2,
            nft_id        : arg1,
            amount        : arg4,
            deferred_time : arg3,
        };
        0x2::event::emit<DeferredRewardAdded<T0>>(v5);
    }

    public entry fun early_unstake_nft<T0: store + key>(arg0: &mut StakingConfig, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, StakingStats>(&mut arg0.id, b"stats");
        assert!(0x2::table::contains<0x2::object::ID, StakeInfo>(&v0.stake_info, arg1), 5);
        let v1 = 0x2::table::borrow<0x2::object::ID, StakeInfo>(&v0.stake_info, arg1);
        assert!(v1.owner == 0x2::tx_context::sender(arg3), 1);
        let v2 = v1.owner;
        v0.total_staked_nfts = v0.total_staked_nfts - 1;
        v0.total_reward_multiplier = v0.total_reward_multiplier - v1.lock_info.reward_multiplier;
        0x2::table::remove<0x2::object::ID, StakeInfo>(&mut v0.stake_info, arg1);
        0x2::transfer::public_transfer<T0>(0x2::dynamic_field::remove<0x2::object::ID, T0>(&mut arg0.id, arg1), v2);
        let v3 = 0x2::clock::timestamp_ms(arg2);
        let v4 = NFTEarlyUnstaked{
            nft_id                : arg1,
            staker                : v2,
            unstake_time          : v3,
            total_time_staked_ms  : v3 - v1.stake_time,
            min_stake_period_days : arg0.min_stake_period_days,
        };
        0x2::event::emit<NFTEarlyUnstaked>(v4);
    }

    public entry fun emergency_batch_unstake_nfts<T0: store + key>(arg0: &mut StakingConfig, arg1: vector<0x2::object::ID>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(&arg1)) {
            let v2 = *0x1::vector::borrow<0x2::object::ID>(&arg1, v1);
            let v3 = 0x2::tx_context::sender(arg3);
            let v4 = 0;
            let v5 = false;
            let v6 = 0x2::dynamic_field::borrow_mut<vector<u8>, StakingStats>(&mut arg0.id, b"stats");
            if (0x2::table::contains<0x2::object::ID, StakeInfo>(&v6.stake_info, v2)) {
                let v7 = 0x2::table::borrow<0x2::object::ID, StakeInfo>(&v6.stake_info, v2);
                if (v7.owner == 0x2::tx_context::sender(arg3)) {
                    v3 = v7.owner;
                    let v8 = v7.stake_time;
                    v4 = v8;
                    v5 = true;
                    let v9 = 0x2::table::remove<0x2::object::ID, StakeInfo>(&mut v6.stake_info, v2);
                    v6.total_staked_nfts = v6.total_staked_nfts - 1;
                    v6.total_reward_multiplier = v6.total_reward_multiplier - v9.lock_info.reward_multiplier;
                    if (0x2::table::contains<address, UserStakingStats>(&v6.user_stats, 0x2::tx_context::sender(arg3))) {
                        let v10 = 0x2::table::borrow_mut<address, UserStakingStats>(&mut v6.user_stats, 0x2::tx_context::sender(arg3));
                        if (v10.total_staked_nfts > 0) {
                            v10.total_staked_nfts = v10.total_staked_nfts - 1;
                        };
                        v10.total_staking_time_ms = v10.total_staking_time_ms + v0 - v8;
                    };
                    arg0.total_early_unstakes = arg0.total_early_unstakes + 1;
                };
            };
            if (v5) {
                0x2::transfer::public_transfer<T0>(0x2::dynamic_field::remove<0x2::object::ID, T0>(&mut arg0.id, v2), v3);
                let v11 = NFTUnstaked{
                    nft_id                      : v2,
                    staker                      : v3,
                    unstake_time                : v0,
                    total_time_staked_ms        : v0 - v4,
                    early_withdrawal            : true,
                    early_withdrawal_fee_amount : 0,
                };
                0x2::event::emit<NFTUnstaked>(v11);
                let v12 = EmergencyUnstake{
                    nft_id               : v2,
                    staker               : v3,
                    unstake_time         : v0,
                    total_time_staked_ms : v0 - v4,
                };
                0x2::event::emit<EmergencyUnstake>(v12);
            };
            v1 = v1 + 1;
        };
    }

    public entry fun emergency_pause(arg0: &AdminCap, arg1: &mut StakingConfig, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.paused = arg2;
        let v0 = EmergencyPauseChanged{
            pool_id : 0x2::object::id<StakingConfig>(arg1),
            paused  : arg2,
            admin   : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<EmergencyPauseChanged>(v0);
    }

    public entry fun emergency_unstake_nft<T0: store + key>(arg0: &AdminCap, arg1: &mut StakingConfig, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, StakingStats>(&mut arg1.id, b"stats");
        assert!(0x2::table::contains<0x2::object::ID, StakeInfo>(&v0.stake_info, arg2), 5);
        let v1 = 0x2::table::borrow<0x2::object::ID, StakeInfo>(&v0.stake_info, arg2);
        let v2 = v1.owner;
        v0.total_staked_nfts = v0.total_staked_nfts - 1;
        v0.total_reward_multiplier = v0.total_reward_multiplier - v1.lock_info.reward_multiplier;
        0x2::table::remove<0x2::object::ID, StakeInfo>(&mut v0.stake_info, arg2);
        if (0x2::table::contains<address, UserStakingStats>(&v0.user_stats, v2)) {
            let v3 = 0x2::table::borrow_mut<address, UserStakingStats>(&mut v0.user_stats, v2);
            v3.total_staked_nfts = v3.total_staked_nfts - 1;
            if (v3.total_staked_nfts == 0) {
                v3.last_stake_time = 0x2::tx_context::epoch_timestamp_ms(arg3);
            };
        };
        0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<0x2::object::ID, T0>(&mut arg1.id, arg2), v2);
        let v4 = NFTEmergencyUnstaked{
            nft_id       : arg2,
            owner        : v2,
            unstake_time : 0x2::tx_context::epoch_timestamp_ms(arg3),
            by_admin     : true,
        };
        0x2::event::emit<NFTEmergencyUnstaked>(v4);
    }

    public entry fun force_unstake_nft<T0: store + key, T1>(arg0: &mut StakingConfig, arg1: &mut RewardPool<T1>, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 16);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = 0x1::type_name::get<T1>();
        let v3 = 0x2::dynamic_field::borrow_mut<vector<u8>, StakingStats>(&mut arg0.id, b"stats");
        assert!(0x2::table::contains<0x2::object::ID, StakeInfo>(&v3.stake_info, arg2), 5);
        let v4 = 0x2::table::borrow<0x2::object::ID, StakeInfo>(&v3.stake_info, arg2);
        assert!(v4.owner == v1, 1);
        if (v4.lock_info.lock_type == 1 && arg0.lock_enabled) {
            assert!(v0 >= v4.lock_info.lock_end_time, 6);
        };
        let v5 = *0x2::vec_map::get<0x1::type_name::TypeName, RewardPoolInfo>(&arg0.reward_pools, &v2);
        let v6 = v4.stake_time;
        let v7 = v4.lock_info.reward_multiplier;
        let v8 = if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&v4.last_claim_times, &v2)) {
            *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&v4.last_claim_times, &v2)
        } else {
            v6
        };
        v3.total_staked_nfts = v3.total_staked_nfts - 1;
        v3.total_reward_multiplier = v3.total_reward_multiplier - v7;
        0x2::table::remove<0x2::object::ID, StakeInfo>(&mut v3.stake_info, arg2);
        let v9 = if (v5.reward_config.reward_type == 0) {
            ((v5.reward_config.tokens_per_day_per_nft * v7 / 100) as u128) * ((v0 - v8) as u128) / (86400000 as u128)
        } else {
            calculate_dynamic_reward(v6, v8, v0, v7, v3.total_reward_multiplier, &v5.reward_config)
        };
        let v10 = if (v9 > 18446744073709551615) {
            18446744073709551615
        } else {
            (v9 as u64)
        };
        let v11 = 0x2::balance::value<T1>(&arg1.balance);
        0x2::transfer::public_transfer<T0>(0x2::dynamic_field::remove<0x2::object::ID, T0>(&mut arg0.id, arg2), v1);
        if (v10 > 0) {
            if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.total_rewards_distributed, &v2)) {
                let v12 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg0.total_rewards_distributed, &v2);
                *v12 = *v12 + v10;
            } else {
                0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg0.total_rewards_distributed, v2, v10);
            };
            let v13 = NFTForceUnstaked{
                nft_id               : arg2,
                staker               : v1,
                unstake_time         : v0,
                total_time_staked_ms : v0 - v6,
                deferred_rewards     : v11 < v10,
            };
            0x2::event::emit<NFTForceUnstaked>(v13);
            if (v11 >= v10) {
                transfer_reward<T1>(arg1, v10, v1, arg4);
            } else {
                defer_rewards<T1>(arg0, arg2, v1, v0, v10, arg4);
            };
        } else {
            let v14 = NFTForceUnstaked{
                nft_id               : arg2,
                staker               : v1,
                unstake_time         : v0,
                total_time_staked_ms : v0 - v6,
                deferred_rewards     : false,
            };
            0x2::event::emit<NFTForceUnstaked>(v14);
        };
    }

    public entry fun fund_reward_pool<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut RewardPool<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(arg0));
        let v0 = FundsAddedToRewardPool<T0>{
            pool_id : 0x2::object::id<RewardPool<T0>>(arg1),
            amount  : 0x2::coin::value<T0>(&arg0),
            sender  : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<FundsAddedToRewardPool<T0>>(v0);
    }

    public fun get_eligible_nft_types(arg0: &StakingConfig) : vector<0x1::type_name::TypeName> {
        0x2::vec_set::into_keys<0x1::type_name::TypeName>(arg0.eligible_nft_types)
    }

    public fun get_lock_settings(arg0: &StakingConfig) : (u64, u64, u64) {
        (arg0.min_stake_period_days, arg0.max_lock_period_months, arg0.early_withdrawal_fee)
    }

    public fun get_pending_referral_rewards(arg0: &StakingConfig, arg1: address) : 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64> {
        let v0 = 0x2::dynamic_field::borrow<vector<u8>, StakingStats>(&arg0.id, b"stats");
        if (0x2::table::contains<address, UserStakingStats>(&v0.user_stats, arg1)) {
            0x2::table::borrow<address, UserStakingStats>(&v0.user_stats, arg1).pending_referral_rewards
        } else {
            0x2::vec_map::empty<0x1::type_name::TypeName, u64>()
        }
    }

    public fun get_pool_info(arg0: &StakingConfig) : (0x1::string::String, 0x1::string::String, 0x2::url::Url, bool, u8, u64, u64) {
        (arg0.name, arg0.description, arg0.image_url, arg0.is_active, 0, 10000000, 1000000000)
    }

    public fun get_pool_stats(arg0: &StakingConfig) : (u64, u64, 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>, u64, u64) {
        (arg0.total_unique_stakers, 0x2::dynamic_field::borrow<vector<u8>, StakingStats>(&arg0.id, b"stats").total_staked_nfts, arg0.total_rewards_distributed, arg0.avg_stake_time_ms, arg0.total_early_unstakes)
    }

    public fun get_referral_info(arg0: &StakingConfig) : (u64, u64, u64) {
        (arg0.referral_info.referral_percentage, arg0.referral_info.total_referral_rewards, arg0.referral_info.total_referrals)
    }

    public fun get_reward_config(arg0: &StakingConfig, arg1: 0x1::type_name::TypeName) : (u64, u64, u64, u64, bool, bool) {
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, RewardPoolInfo>(&arg0.reward_pools, &arg1), 2);
        let v0 = 0x2::vec_map::get<0x1::type_name::TypeName, RewardPoolInfo>(&arg0.reward_pools, &arg1);
        (v0.reward_config.reward_type, v0.reward_config.tokens_per_day_per_nft, v0.reward_config.total_reward_pool, v0.reward_config.distributed_rewards, v0.is_primary, v0.auto_mint)
    }

    public fun get_reward_pool_info(arg0: &StakingConfig, arg1: 0x1::type_name::TypeName) : (u64, u64, u64, u64, bool, bool) {
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, RewardPoolInfo>(&arg0.reward_pools, &arg1), 2);
        let v0 = 0x2::vec_map::get<0x1::type_name::TypeName, RewardPoolInfo>(&arg0.reward_pools, &arg1);
        (v0.reward_config.reward_type, v0.reward_config.tokens_per_day_per_nft, v0.reward_config.total_reward_pool, v0.reward_config.distributed_rewards, v0.is_primary, v0.auto_mint)
    }

    public fun get_reward_types(arg0: &StakingConfig) : vector<0x1::type_name::TypeName> {
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = 0;
        while (v1 < 0x2::vec_map::size<0x1::type_name::TypeName, RewardPoolInfo>(&arg0.reward_pools)) {
            let (v2, _) = 0x2::vec_map::get_entry_by_idx<0x1::type_name::TypeName, RewardPoolInfo>(&arg0.reward_pools, v1);
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut v0, *v2);
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_stake_info(arg0: &StakingConfig, arg1: 0x2::object::ID) : 0x1::option::Option<StakeInfo> {
        let v0 = 0x2::dynamic_field::borrow<vector<u8>, StakingStats>(&arg0.id, b"stats");
        if (0x2::table::contains<0x2::object::ID, StakeInfo>(&v0.stake_info, arg1)) {
            0x1::option::some<StakeInfo>(*0x2::table::borrow<0x2::object::ID, StakeInfo>(&v0.stake_info, arg1))
        } else {
            0x1::option::none<StakeInfo>()
        }
    }

    public fun get_total_staked_nfts(arg0: &StakingConfig) : u64 {
        0x2::dynamic_field::borrow<vector<u8>, StakingStats>(&arg0.id, b"stats").total_staked_nfts
    }

    public fun get_user_stats(arg0: &StakingConfig, arg1: address) : (u64, 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>, u64, u64, 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>, u64, u64, 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>) {
        let v0 = 0x2::dynamic_field::borrow<vector<u8>, StakingStats>(&arg0.id, b"stats");
        if (0x2::table::contains<address, UserStakingStats>(&v0.user_stats, arg1)) {
            let v9 = 0x2::table::borrow<address, UserStakingStats>(&v0.user_stats, arg1);
            (v9.total_staked_nfts, v9.total_rewards_earned, v9.total_staking_time_ms, v9.total_referrals, v9.total_referral_rewards, v9.first_stake_time, v9.last_stake_time, v9.pending_referral_rewards)
        } else {
            (0, 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(), 0, 0, 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(), 0, 0, 0x2::vec_map::empty<0x1::type_name::TypeName, u64>())
        }
    }

    public fun has_reward_type(arg0: &StakingConfig, arg1: 0x1::type_name::TypeName) : bool {
        0x2::vec_map::contains<0x1::type_name::TypeName, RewardPoolInfo>(&arg0.reward_pools, &arg1)
    }

    fun init(arg0: NFT_STAKING, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<NFT_STAKING>(arg0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun is_nft_staked(arg0: &StakingConfig, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, StakeInfo>(&0x2::dynamic_field::borrow<vector<u8>, StakingStats>(&arg0.id, b"stats").stake_info, arg1)
    }

    public fun is_nft_type_eligible<T0: store + key>(arg0: &StakingConfig) : bool {
        let v0 = 0x1::type_name::get<T0>();
        0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.eligible_nft_types, &v0)
    }

    public fun is_paused(arg0: &StakingConfig) : bool {
        arg0.paused
    }

    public entry fun pause_contract(arg0: &AdminCap, arg1: &mut StakingConfig, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.paused = true;
        let v0 = ContractPaused{
            pool_id    : 0x2::object::id<StakingConfig>(arg1),
            admin      : 0x2::tx_context::sender(arg3),
            pause_time : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<ContractPaused>(v0);
    }

    public entry fun register_nft_type<T0: store + key>(arg0: &AdminCap, arg1: &mut StakingConfig, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg1.eligible_nft_types, &v0), 12);
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg1.eligible_nft_types, v0);
        let v1 = NFTTypeRegistered{
            nft_type : v0,
            pool_id  : 0x2::object::id<StakingConfig>(arg1),
        };
        0x2::event::emit<NFTTypeRegistered>(v1);
    }

    public entry fun remove_reward_type<T0>(arg0: &AdminCap, arg1: &mut StakingConfig, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, RewardPoolInfo>(&arg1.reward_pools, &v0), 2);
        let v1 = 0x2::vec_map::get<0x1::type_name::TypeName, RewardPoolInfo>(&arg1.reward_pools, &v0);
        let v2 = v1.pool_id;
        assert!(!v1.is_primary, 1);
        let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, RewardPoolInfo>(&mut arg1.reward_pools, &v0);
        let v5 = RewardPoolRemoved{
            pool_id   : v2,
            coin_type : v0,
            admin     : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<RewardPoolRemoved>(v5);
    }

    public entry fun set_pool_active(arg0: &AdminCap, arg1: &mut StakingConfig, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.is_active = arg2;
    }

    public entry fun stake_nft<T0: store + key>(arg0: T0, arg1: &mut StakingConfig, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.paused, 16);
        assert!(arg1.is_active, 2);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg1.eligible_nft_types, &v0), 3);
        if (!arg1.lock_enabled) {
            assert!(arg2 == 0, 7);
        } else {
            assert!((arg2 as u64) == 0 || arg2 >= 1 && arg2 <= arg1.max_lock_period_months, 7);
        };
        let v1 = 0x2::dynamic_field::borrow_mut<vector<u8>, StakingStats>(&mut arg1.id, b"stats");
        let v2 = 0x2::object::id<T0>(&arg0);
        assert!(!0x2::table::contains<0x2::object::ID, StakeInfo>(&v1.stake_info, v2), 4);
        let v3 = calculate_reward_multiplier(arg2);
        let v4 = 0x2::clock::timestamp_ms(arg3);
        let v5 = if ((arg2 as u64) > 0) {
            1
        } else {
            0
        };
        let v6 = if ((arg2 as u64) > 0) {
            v4 + arg1.min_stake_period_days * 86400000 + (arg2 as u64) * 2592000000
        } else {
            0
        };
        let v7 = LockInfo{
            lock_type            : v5,
            lock_end_time        : v6,
            reward_multiplier    : v3,
            early_withdrawal_fee : arg1.early_withdrawal_fee,
        };
        let v8 = StakeInfo{
            owner            : 0x2::tx_context::sender(arg4),
            stake_time       : v4,
            last_claim_times : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            nft_id           : v2,
            nft_type         : v0,
            lock_info        : v7,
        };
        0x2::table::add<0x2::object::ID, StakeInfo>(&mut v1.stake_info, v2, v8);
        v1.total_staked_nfts = v1.total_staked_nfts + 1;
        v1.total_reward_multiplier = v1.total_reward_multiplier + v3;
        0x2::dynamic_field::add<0x2::object::ID, T0>(&mut arg1.id, v2, arg0);
        let v9 = NFTStaked{
            nft_id             : v2,
            staker             : 0x2::tx_context::sender(arg4),
            stake_time         : v8.stake_time,
            lock_period_months : (arg2 as u64),
            lock_end_time      : v7.lock_end_time,
            reward_multiplier  : v7.reward_multiplier,
            lock_type          : v7.lock_type,
        };
        0x2::event::emit<NFTStaked>(v9);
    }

    public entry fun stake_nft_from_kiosk<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: &mut StakingConfig, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg3.paused, 16);
        assert!(arg3.is_active, 2);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg3.eligible_nft_types, &v0), 3);
        if (!arg3.lock_enabled) {
            assert!(arg4 == 0, 7);
        } else {
            assert!((arg4 as u64) == 0 || arg4 >= 1 && arg4 <= arg3.max_lock_period_months, 7);
        };
        let v1 = calculate_reward_multiplier(arg4);
        let v2 = 0x2::clock::timestamp_ms(arg5);
        let v3 = if ((arg4 as u64) > 0) {
            1
        } else {
            0
        };
        let v4 = if ((arg4 as u64) > 0) {
            v2 + arg3.min_stake_period_days * 86400000 + (arg4 as u64) * 2592000000
        } else {
            0
        };
        let v5 = LockInfo{
            lock_type            : v3,
            lock_end_time        : v4,
            reward_multiplier    : v1,
            early_withdrawal_fee : arg3.early_withdrawal_fee,
        };
        let v6 = StakeInfo{
            owner            : 0x2::tx_context::sender(arg6),
            stake_time       : v2,
            last_claim_times : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            nft_id           : arg2,
            nft_type         : v0,
            lock_info        : v5,
        };
        let v7 = 0x2::dynamic_field::borrow_mut<vector<u8>, StakingStats>(&mut arg3.id, b"stats");
        assert!(!0x2::table::contains<0x2::object::ID, StakeInfo>(&v7.stake_info, arg2), 4);
        0x2::table::add<0x2::object::ID, StakeInfo>(&mut v7.stake_info, arg2, v6);
        v7.total_staked_nfts = v7.total_staked_nfts + 1;
        v7.total_reward_multiplier = v7.total_reward_multiplier + v1;
        0x2::dynamic_field::add<0x2::object::ID, T0>(&mut arg3.id, arg2, 0x2::kiosk::take<T0>(arg0, arg1, arg2));
        let v8 = NFTStaked{
            nft_id             : arg2,
            staker             : 0x2::tx_context::sender(arg6),
            stake_time         : v6.stake_time,
            lock_period_months : (arg4 as u64),
            lock_end_time      : v5.lock_end_time,
            reward_multiplier  : v5.reward_multiplier,
            lock_type          : v5.lock_type,
        };
        0x2::event::emit<NFTStaked>(v8);
    }

    public entry fun stake_nft_from_kiosk_with_referral<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: &mut StakingConfig, arg4: u8, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!arg3.paused, 16);
        assert!(is_nft_type_eligible<T0>(arg3), 20);
        assert!(0x2::kiosk::owner(arg0) == 0x2::tx_context::sender(arg7), 1);
        assert!(0x2::kiosk::has_access(arg0, arg1), 1);
        assert!(0x2::kiosk::has_item(arg0, arg2), 1);
        if (!arg3.lock_enabled) {
            assert!(arg4 == 0, 7);
        } else {
            assert!(arg4 <= (arg3.max_lock_period_months as u8), 7);
        };
        assert!(arg5 != 0x2::tx_context::sender(arg7) && arg5 != @0x0, 22);
        let v0 = create_lock_info(arg4, arg3, arg6);
        let v1 = 0x2::dynamic_field::borrow_mut<vector<u8>, StakingStats>(&mut arg3.id, b"stats");
        let v2 = StakeInfo{
            owner            : 0x2::tx_context::sender(arg7),
            stake_time       : 0x2::clock::timestamp_ms(arg6),
            last_claim_times : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            nft_id           : arg2,
            nft_type         : 0x1::type_name::get<T0>(),
            lock_info        : v0,
        };
        0x2::table::add<0x2::object::ID, StakeInfo>(&mut v1.stake_info, arg2, v2);
        v1.total_staked_nfts = v1.total_staked_nfts + 1;
        v1.total_reward_multiplier = v1.total_reward_multiplier + v0.reward_multiplier;
        update_referral_stats(v1, arg5, 0x2::tx_context::sender(arg7), arg3.referral_info.referral_percentage, arg6);
        update_user_stake_stats(v1, 0x2::tx_context::sender(arg7), v0.reward_multiplier, arg2, arg6);
        0x2::dynamic_field::add<0x2::object::ID, T0>(&mut arg3.id, arg2, 0x2::kiosk::take<T0>(arg0, arg1, arg2));
        let v3 = NFTStaked{
            nft_id             : arg2,
            staker             : 0x2::tx_context::sender(arg7),
            stake_time         : v2.stake_time,
            lock_period_months : (arg4 as u64),
            lock_end_time      : v0.lock_end_time,
            reward_multiplier  : v0.reward_multiplier,
            lock_type          : v0.lock_type,
        };
        0x2::event::emit<NFTStaked>(v3);
    }

    public entry fun stake_nft_with_referral<T0: store + key>(arg0: T0, arg1: &mut StakingConfig, arg2: u8, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.paused, 16);
        assert!(is_nft_type_eligible<T0>(arg1), 20);
        if (!arg1.lock_enabled) {
            assert!(arg2 == 0, 7);
        } else {
            assert!(arg2 <= (arg1.max_lock_period_months as u8), 7);
        };
        let v0 = create_lock_info(arg2, arg1, arg4);
        let v1 = 0x2::object::id<T0>(&arg0);
        let v2 = create_stake_info(v1, 0x2::tx_context::sender(arg5), 0x2::clock::timestamp_ms(arg4), arg1.min_stake_period_days, v0);
        let v3 = 0x2::dynamic_field::borrow_mut<vector<u8>, StakingStats>(&mut arg1.id, b"stats");
        0x2::table::add<0x2::object::ID, StakeInfo>(&mut v3.stake_info, v1, v2);
        v3.total_staked_nfts = v3.total_staked_nfts + 1;
        v3.total_reward_multiplier = v3.total_reward_multiplier + v0.reward_multiplier;
        if (arg3 != @0x0 && arg3 != 0x2::tx_context::sender(arg5)) {
            update_referral_stats(v3, arg3, 0x2::tx_context::sender(arg5), arg1.referral_info.referral_percentage, arg4);
        };
        update_user_stake_stats(v3, 0x2::tx_context::sender(arg5), v0.reward_multiplier, v1, arg4);
        0x2::dynamic_field::add<0x2::object::ID, T0>(&mut arg1.id, v1, arg0);
        let v4 = NFTStaked{
            nft_id             : v1,
            staker             : 0x2::tx_context::sender(arg5),
            stake_time         : v2.stake_time,
            lock_period_months : (arg2 as u64),
            lock_end_time      : v0.lock_end_time,
            reward_multiplier  : v0.reward_multiplier,
            lock_type          : v0.lock_type,
        };
        0x2::event::emit<NFTStaked>(v4);
    }

    fun transfer_reward<T0>(arg0: &mut RewardPool<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg1 == 0) {
            return
        };
        assert!(arg1 <= 0x2::balance::value<T0>(&arg0.balance), 9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.balance, arg1, arg3), arg2);
    }

    public entry fun unpause_contract(arg0: &AdminCap, arg1: &mut StakingConfig, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.paused = false;
        let v0 = ContractUnpaused{
            pool_id      : 0x2::object::id<StakingConfig>(arg1),
            admin        : 0x2::tx_context::sender(arg3),
            unpause_time : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<ContractUnpaused>(v0);
    }

    public entry fun unregister_nft_type<T0: store + key>(arg0: &AdminCap, arg1: &mut StakingConfig, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg1.eligible_nft_types, &v0), 13);
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg1.eligible_nft_types, &v0);
        let v1 = NFTTypeUnregistered{
            nft_type : v0,
            pool_id  : 0x2::object::id<StakingConfig>(arg1),
        };
        0x2::event::emit<NFTTypeUnregistered>(v1);
    }

    public entry fun unstake_nft<T0: store + key, T1>(arg0: &mut StakingConfig, arg1: &mut RewardPool<T1>, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = arg0.min_stake_period_days;
        let v2 = 0x1::type_name::get<T1>();
        let v3 = 0x2::dynamic_field::borrow_mut<vector<u8>, StakingStats>(&mut arg0.id, b"stats");
        assert!(0x2::table::contains<0x2::object::ID, StakeInfo>(&v3.stake_info, arg2), 5);
        let v4 = 0x2::table::borrow<0x2::object::ID, StakeInfo>(&v3.stake_info, arg2);
        assert!(v4.owner == 0x2::tx_context::sender(arg4), 1);
        if (v1 > 0) {
            assert!(v0 >= v4.stake_time + v1 * 86400000, 31);
        };
        let v5 = v4.owner;
        v3.total_staked_nfts = v3.total_staked_nfts - 1;
        v3.total_reward_multiplier = v3.total_reward_multiplier - v4.lock_info.reward_multiplier;
        0x2::table::remove<0x2::object::ID, StakeInfo>(&mut v3.stake_info, arg2);
        0x2::transfer::public_transfer<T0>(0x2::dynamic_field::remove<0x2::object::ID, T0>(&mut arg0.id, arg2), v5);
        let v6 = calculate_reward<T1>(arg0, arg1, *v4, arg3);
        assert!(v6 > 0, 28);
        transfer_reward<T1>(arg1, v6, v5, arg4);
        let v7 = 0x2::dynamic_field::borrow_mut<vector<u8>, StakingStats>(&mut arg0.id, b"stats");
        if (0x2::table::contains<address, UserStakingStats>(&v7.user_stats, v5)) {
            let v8 = 0x2::table::borrow_mut<address, UserStakingStats>(&mut v7.user_stats, v5);
            if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&v8.total_rewards_earned, &v2)) {
                *0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut v8.total_rewards_earned, &v2) = *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&v8.total_rewards_earned, &v2) + v6;
            } else {
                0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v8.total_rewards_earned, v2, v6);
            };
        };
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.total_rewards_distributed, &v2)) {
            *0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg0.total_rewards_distributed, &v2) = *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&arg0.total_rewards_distributed, &v2) + v6;
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg0.total_rewards_distributed, v2, v6);
        };
        let v9 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, RewardPoolInfo>(&mut arg0.reward_pools, &v2);
        v9.reward_config.distributed_rewards = v9.reward_config.distributed_rewards + v6;
        let v10 = NFTUnstaked{
            nft_id                      : arg2,
            staker                      : v5,
            unstake_time                : v0,
            total_time_staked_ms        : v0 - v4.stake_time,
            early_withdrawal            : false,
            early_withdrawal_fee_amount : 0,
        };
        0x2::event::emit<NFTUnstaked>(v10);
    }

    fun unstake_single_nft<T0: store + key, T1>(arg0: &mut StakingConfig, arg1: &mut RewardPool<T1>, arg2: 0x2::object::ID, arg3: address, arg4: bool, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = 0x2::dynamic_field::borrow_mut<vector<u8>, StakingStats>(&mut arg0.id, b"stats");
        assert!(0x2::table::contains<0x2::object::ID, StakeInfo>(&v1.stake_info, arg2), 5);
        let v2 = 0x2::table::borrow<0x2::object::ID, StakeInfo>(&v1.stake_info, arg2);
        assert!(v2.owner == arg3, 1);
        if (arg0.min_stake_period_days > 0) {
            assert!(v0 >= v2.stake_time + arg0.min_stake_period_days * 86400000, 15);
        };
        let v3 = *v2;
        v1.total_staked_nfts = v1.total_staked_nfts - 1;
        v1.total_reward_multiplier = v1.total_reward_multiplier - v2.lock_info.reward_multiplier;
        0x2::table::remove<0x2::object::ID, StakeInfo>(&mut v1.stake_info, arg2);
        let v4 = 0;
        let v5 = if (v3.lock_info.lock_type == 1) {
            if (v0 < v3.lock_info.lock_end_time) {
                arg0.lock_enabled
            } else {
                false
            }
        } else {
            false
        };
        if (arg4) {
            let v6 = calculate_reward<T1>(arg0, arg1, v3, arg5);
            let v7 = v6;
            if (v5) {
                let v8 = v6 * arg0.early_withdrawal_fee / 10000;
                v4 = v8;
                v7 = v6 - v8;
            };
            if (v7 > 0) {
                transfer_reward<T1>(arg1, v7, arg3, arg6);
            };
            let v9 = NFTUnstaked{
                nft_id                      : arg2,
                staker                      : arg3,
                unstake_time                : v0,
                total_time_staked_ms        : v0 - v3.stake_time,
                early_withdrawal            : v5,
                early_withdrawal_fee_amount : v4,
            };
            0x2::event::emit<NFTUnstaked>(v9);
        } else {
            let v10 = NFTEarlyUnstaked{
                nft_id                : arg2,
                staker                : arg3,
                unstake_time          : v0,
                total_time_staked_ms  : v0 - v3.stake_time,
                min_stake_period_days : arg0.min_stake_period_days,
            };
            0x2::event::emit<NFTEarlyUnstaked>(v10);
        };
        0x2::transfer::public_transfer<T0>(0x2::dynamic_field::remove<0x2::object::ID, T0>(&mut arg0.id, arg2), arg3);
    }

    public entry fun update_contract_statistics(arg0: &AdminCap, arg1: &mut StakingConfig, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = StakingStatsUpdated{
            pool_id                   : 0x2::object::id<StakingConfig>(arg1),
            total_staked_nfts         : 0x2::dynamic_field::borrow<vector<u8>, StakingStats>(&arg1.id, b"stats").total_staked_nfts,
            total_unique_stakers      : arg1.total_unique_stakers,
            total_rewards_distributed : 0x2::vec_set::into_keys<u64>(0x2::vec_set::empty<u64>()),
            avg_stake_time_ms         : arg1.avg_stake_time_ms,
            update_time               : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<StakingStatsUpdated>(v0);
    }

    public entry fun update_lock_settings(arg0: &AdminCap, arg1: &mut StakingConfig, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        arg1.max_lock_period_months = arg3;
        arg1.early_withdrawal_fee = arg4;
    }

    public entry fun update_min_stake_period(arg0: &AdminCap, arg1: &mut StakingConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 60, 14);
        arg1.min_stake_period_days = arg2;
    }

    public entry fun update_referral_percentage(arg0: &AdminCap, arg1: &mut StakingConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 >= 100 && arg2 <= 2000, 17);
        arg1.referral_info.referral_percentage = arg2;
        let v0 = ReferralPercentageUpdated{
            pool_id        : 0x2::object::id<StakingConfig>(arg1),
            old_percentage : arg1.referral_info.referral_percentage,
            new_percentage : arg2,
            admin          : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<ReferralPercentageUpdated>(v0);
    }

    fun update_referral_stats(arg0: &mut StakingStats, arg1: address, arg2: address, arg3: u64, arg4: &0x2::clock::Clock) {
        assert!(arg1 != arg2 && arg1 != @0x0, 22);
        if (0x2::table::contains<address, UserStakingStats>(&arg0.user_stats, arg1)) {
            let v0 = 0x2::table::borrow_mut<address, UserStakingStats>(&mut arg0.user_stats, arg1);
            let v1 = 0x1::type_name::get<0x2::sui::SUI>();
            if (!0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&v0.total_referral_rewards, &v1)) {
                0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v0.total_referral_rewards, 0x1::type_name::get<0x2::sui::SUI>(), 0);
            };
            v0.total_referrals = v0.total_referrals + 1;
        } else {
            let v2 = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v2, 0x1::type_name::get<0x2::sui::SUI>(), 0);
            let v3 = UserStakingStats{
                total_staked_nfts        : 0,
                total_rewards_earned     : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
                total_staking_time_ms    : 0,
                total_referrals          : 1,
                total_referral_rewards   : v2,
                first_stake_time         : 0x2::clock::timestamp_ms(arg4),
                last_stake_time          : 0,
                pending_referral_rewards : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            };
            0x2::table::add<address, UserStakingStats>(&mut arg0.user_stats, arg1, v3);
        };
    }

    public entry fun update_reward_config<T0>(arg0: &AdminCap, arg1: &mut StakingConfig, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, RewardPoolInfo>(&arg1.reward_pools, &v0)) {
            let v1 = &mut 0x2::vec_map::get_mut<0x1::type_name::TypeName, RewardPoolInfo>(&mut arg1.reward_pools, &v0).reward_config;
            v1.reward_type = arg2;
            v1.tokens_per_day_per_nft = arg3;
            v1.total_reward_pool = arg4;
        } else {
            let v2 = RewardConfig{
                reward_type            : arg2,
                tokens_per_day_per_nft : arg3,
                total_reward_pool      : arg4,
                distributed_rewards    : 0,
            };
            let v3 = RewardPoolInfo{
                pool_id       : 0x2::object::id_from_address(@0x0),
                coin_type     : v0,
                reward_config : v2,
                is_primary    : false,
                auto_mint     : false,
            };
            0x2::vec_map::insert<0x1::type_name::TypeName, RewardPoolInfo>(&mut arg1.reward_pools, v0, v3);
        };
    }

    fun update_user_referral_rewards_stats(arg0: &mut StakingStats, arg1: address, arg2: 0x1::type_name::TypeName, arg3: u64) {
        if (0x2::table::contains<address, UserStakingStats>(&arg0.user_stats, arg1)) {
            let v0 = 0x2::table::borrow_mut<address, UserStakingStats>(&mut arg0.user_stats, arg1);
            if (!0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&v0.total_referral_rewards, &arg2)) {
                0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v0.total_referral_rewards, arg2, arg3);
            } else {
                let v1 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut v0.total_referral_rewards, &arg2);
                *v1 = *v1 + arg3;
            };
            if (!0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&v0.pending_referral_rewards, &arg2)) {
                0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v0.pending_referral_rewards, arg2, arg3);
            } else {
                let v2 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut v0.pending_referral_rewards, &arg2);
                *v2 = *v2 + arg3;
            };
        };
    }

    fun update_user_referral_stats(arg0: &mut StakingStats, arg1: address, arg2: address, arg3: u64) {
        if (!0x2::table::contains<address, UserStakingStats>(&arg0.user_stats, arg1)) {
            let v0 = UserStakingStats{
                total_staked_nfts        : 0,
                total_rewards_earned     : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
                total_staking_time_ms    : 0,
                total_referrals          : 1,
                total_referral_rewards   : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
                first_stake_time         : 0,
                last_stake_time          : 0,
                pending_referral_rewards : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            };
            0x2::table::add<address, UserStakingStats>(&mut arg0.user_stats, arg1, v0);
        } else {
            let v1 = 0x2::table::borrow_mut<address, UserStakingStats>(&mut arg0.user_stats, arg1);
            v1.total_referrals = v1.total_referrals + 1;
        };
    }

    fun update_user_rewards_stats(arg0: &mut StakingStats, arg1: address, arg2: 0x1::type_name::TypeName, arg3: u64) {
        if (0x2::table::contains<address, UserStakingStats>(&arg0.user_stats, arg1)) {
            let v0 = 0x2::table::borrow_mut<address, UserStakingStats>(&mut arg0.user_stats, arg1);
            if (!0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&v0.total_rewards_earned, &arg2)) {
                0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v0.total_rewards_earned, arg2, arg3);
            } else {
                let v1 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut v0.total_rewards_earned, &arg2);
                *v1 = *v1 + arg3;
            };
        };
    }

    fun update_user_stake_stats(arg0: &mut StakingStats, arg1: address, arg2: u64, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        if (0x2::table::contains<address, UserStakingStats>(&arg0.user_stats, arg1)) {
            let v1 = 0x2::table::borrow_mut<address, UserStakingStats>(&mut arg0.user_stats, arg1);
            v1.total_staked_nfts = v1.total_staked_nfts + 1;
            if (v1.first_stake_time == 0) {
                v1.first_stake_time = v0;
            };
            v1.last_stake_time = v0;
        } else {
            let v2 = UserStakingStats{
                total_staked_nfts        : 1,
                total_rewards_earned     : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
                total_staking_time_ms    : 0,
                total_referrals          : 0,
                total_referral_rewards   : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
                first_stake_time         : v0,
                last_stake_time          : v0,
                pending_referral_rewards : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            };
            0x2::table::add<address, UserStakingStats>(&mut arg0.user_stats, arg1, v2);
        };
    }

    public entry fun withdraw_funds_from_reward_pool<T0>(arg0: &AdminCap, arg1: &mut RewardPool<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<T0>(&arg1.balance) >= arg2, 9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, arg2), arg4), arg3);
        let v0 = FundsWithdrawnFromRewardPool<T0>{
            pool_id   : 0x2::object::id<RewardPool<T0>>(arg1),
            amount    : arg2,
            recipient : arg3,
        };
        0x2::event::emit<FundsWithdrawnFromRewardPool<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

