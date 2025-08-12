module 0x1f246b075220ec5f49435224ca862fa60c254b9c544c8961764b1bfe77bf8728::pool_rewards {
    struct PoolAdminCap has key {
        id: 0x2::object::UID,
    }

    struct PoolSystem has key {
        id: 0x2::object::UID,
        pools: 0x2::object_table::ObjectTable<0x2::object::ID, Pool>,
        pool_counter: u64,
        global_config: GlobalConfig,
    }

    struct GlobalConfig has store {
        reward_update_interval: u64,
    }

    struct Pool has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        creator: address,
        image_url: 0x1::string::String,
        required_elements: vector<u64>,
        start_time: u64,
        end_time: u64,
        is_active: bool,
        sui_reward_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        last_reward_update: u64,
        staked_nfts: 0x2::object_table::ObjectTable<0x2::object::ID, StakedNFT>,
        user_stakes: 0x2::table::Table<address, UserStakeInfo>,
        total_staked_count: u64,
        total_weight: u64,
        staked_nft_ids: vector<0x2::object::ID>,
        unique_participants: 0x2::table::Table<address, bool>,
        participant_count: u64,
    }

    struct UserStakeInfo has store {
        nft_count: u64,
        total_weight: u64,
        stake_start_time: u64,
        pending_sui_rewards: u64,
        last_reward_claim: u64,
    }

    struct StakedNFT has store, key {
        id: 0x2::object::UID,
        nft: 0x1f246b075220ec5f49435224ca862fa60c254b9c544c8961764b1bfe77bf8728::creature_nft::CreatureNFT,
        owner: address,
        pool_id: 0x2::object::ID,
        stake_time: u64,
        weight: u64,
    }

    struct PoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        name: 0x1::string::String,
        creator: address,
        start_time: u64,
        end_time: u64,
        required_elements: vector<u64>,
    }

    struct PoolStarted has copy, drop {
        pool_id: 0x2::object::ID,
        start_time: u64,
    }

    struct PoolEnded has copy, drop {
        pool_id: 0x2::object::ID,
        end_time: u64,
        total_participants: u64,
        total_nfts: u64,
    }

    struct NFTStaked has copy, drop {
        pool_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        owner: address,
        stake_time: u64,
    }

    struct NFTUnstaked has copy, drop {
        pool_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        owner: address,
        stake_duration: u64,
        rewards_forfeited: bool,
    }

    struct RewardsUpdated has copy, drop {
        pool_id: 0x2::object::ID,
        update_time: u64,
        total_participants: u64,
        total_weight: u64,
    }

    struct RewardsClaimed has copy, drop {
        pool_id: 0x2::object::ID,
        user: address,
        sui_amount: u64,
    }

    struct SuiRewardsAdded has copy, drop {
        pool_id: 0x2::object::ID,
        sui_amount: u64,
    }

    struct PoolImageUpdated has copy, drop {
        pool_id: 0x2::object::ID,
        old_image_url: 0x1::string::String,
        new_image_url: 0x1::string::String,
        updated_by: address,
    }

    struct PoolTimeExtended has copy, drop {
        pool_id: 0x2::object::ID,
        new_end_time: u64,
    }

    struct POOL_REWARDS has drop {
        dummy_field: bool,
    }

    public entry fun add_sui_rewards(arg0: &PoolAdminCap, arg1: &mut PoolSystem, arg2: 0x2::object::ID, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, Pool>(&mut arg1.pools, arg2);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg3) >= arg4, 5);
        0x2::balance::join<0x2::sui::SUI>(&mut v0.sui_reward_pool, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg3, arg4, arg5)));
        let v1 = SuiRewardsAdded{
            pool_id    : arg2,
            sui_amount : arg4,
        };
        0x2::event::emit<SuiRewardsAdded>(v1);
    }

    public entry fun add_sui_rewards_from_balance(arg0: &PoolAdminCap, arg1: &mut PoolSystem, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut 0x2::object_table::borrow_mut<0x2::object::ID, Pool>(&mut arg1.pools, arg2).sui_reward_pool, 0x2::coin::into_balance<0x2::sui::SUI>(arg3));
        let v0 = SuiRewardsAdded{
            pool_id    : arg2,
            sui_amount : 0x2::coin::value<0x2::sui::SUI>(&arg3),
        };
        0x2::event::emit<SuiRewardsAdded>(v0);
    }

    fun calculate_total_current_weight(arg0: &Pool, arg1: u64) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(&arg0.staked_nft_ids)) {
            let v2 = *0x1::vector::borrow<0x2::object::ID>(&arg0.staked_nft_ids, v1);
            if (0x2::object_table::contains<0x2::object::ID, StakedNFT>(&arg0.staked_nfts, v2)) {
                let v3 = (arg1 - 0x2::object_table::borrow<0x2::object::ID, StakedNFT>(&arg0.staked_nfts, v2).stake_time) / 3600000;
                let v4 = if (v3 == 0) {
                    1
                } else {
                    v3
                };
                v0 = v0 + v4;
            };
            v1 = v1 + 1;
        };
        v0
    }

    fun calculate_user_current_weight(arg0: &Pool, arg1: address, arg2: u64) : u64 {
        if (!0x2::table::contains<address, UserStakeInfo>(&arg0.user_stakes, arg1)) {
            return 0
        };
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(&arg0.staked_nft_ids)) {
            let v2 = *0x1::vector::borrow<0x2::object::ID>(&arg0.staked_nft_ids, v1);
            if (0x2::object_table::contains<0x2::object::ID, StakedNFT>(&arg0.staked_nfts, v2)) {
                let v3 = 0x2::object_table::borrow<0x2::object::ID, StakedNFT>(&arg0.staked_nfts, v2);
                if (v3.owner == arg1) {
                    let v4 = (arg2 - v3.stake_time) / 3600000;
                    let v5 = if (v4 == 0) {
                        1
                    } else {
                        v4
                    };
                    v0 = v0 + v5;
                };
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun calculate_user_sui_rewards(arg0: &Pool, arg1: u64) : u64 {
        if (arg0.total_weight == 0 || arg1 == 0) {
            return 0
        };
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reward_pool) * arg1 / arg0.total_weight
    }

    public fun can_claim_rewards(arg0: &PoolSystem, arg1: 0x2::object::ID, arg2: address, arg3: &0x2::clock::Clock) : bool {
        let v0 = 0x2::object_table::borrow<0x2::object::ID, Pool>(&arg0.pools, arg1);
        if (!0x2::table::contains<address, UserStakeInfo>(&v0.user_stakes, arg2)) {
            return false
        };
        0x2::clock::timestamp_ms(arg3) - 0x2::table::borrow<address, UserStakeInfo>(&v0.user_stakes, arg2).last_reward_claim >= 21600000
    }

    fun check_nft_has_required_elements(arg0: &0x1f246b075220ec5f49435224ca862fa60c254b9c544c8961764b1bfe77bf8728::creature_nft::CreatureNFT, arg1: &vector<u64>) : bool {
        let v0 = extract_nft_element_ids(arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(arg1)) {
            let v2 = *0x1::vector::borrow<u64>(arg1, v1);
            if (0x1::vector::contains<u64>(&v0, &v2)) {
                return true
            };
            v1 = v1 + 1;
        };
        false
    }

    public entry fun claim_rewards(arg0: &mut PoolSystem, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun claim_rewards_dynamic(arg0: &mut PoolSystem, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, Pool>(&mut arg0.pools, arg1);
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<address, UserStakeInfo>(&v0.user_stakes, v1), 8);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        let v3 = 0x2::table::borrow<address, UserStakeInfo>(&v0.user_stakes, v1);
        assert!(v2 - v3.last_reward_claim >= 1 * 86400000 || v3.last_reward_claim == 0, 12);
        let v4 = calculate_user_current_weight(v0, v1, v2);
        let v5 = calculate_total_current_weight(v0, v2);
        let v6 = if (v5 == 0 || v4 == 0) {
            0
        } else {
            0x2::balance::value<0x2::sui::SUI>(&v0.sui_reward_pool) * v4 / v5
        };
        if (v6 > 0 && 0x2::balance::value<0x2::sui::SUI>(&v0.sui_reward_pool) >= v6) {
            0x2::table::borrow_mut<address, UserStakeInfo>(&mut v0.user_stakes, v1).last_reward_claim = v2;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v0.sui_reward_pool, v6), arg3), v1);
            let v7 = RewardsClaimed{
                pool_id    : arg1,
                user       : v1,
                sui_amount : v6,
            };
            0x2::event::emit<RewardsClaimed>(v7);
        };
    }

    public entry fun create_pool(arg0: &PoolAdminCap, arg1: &mut PoolSystem, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<u64>, arg5: u64, arg6: 0x1::string::String, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg7 > arg5, 7);
        arg1.pool_counter = arg1.pool_counter + 1;
        let v0 = 0x2::object::new(arg9);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = Pool{
            id                  : v0,
            pool_id             : v1,
            name                : arg2,
            description         : arg3,
            creator             : 0x2::tx_context::sender(arg9),
            image_url           : arg6,
            required_elements   : arg4,
            start_time          : arg5,
            end_time            : arg7,
            is_active           : false,
            sui_reward_pool     : 0x2::balance::zero<0x2::sui::SUI>(),
            last_reward_update  : 0x2::clock::timestamp_ms(arg8),
            staked_nfts         : 0x2::object_table::new<0x2::object::ID, StakedNFT>(arg9),
            user_stakes         : 0x2::table::new<address, UserStakeInfo>(arg9),
            total_staked_count  : 0,
            total_weight        : 0,
            staked_nft_ids      : 0x1::vector::empty<0x2::object::ID>(),
            unique_participants : 0x2::table::new<address, bool>(arg9),
            participant_count   : 0,
        };
        let v3 = PoolCreated{
            pool_id           : v1,
            name              : v2.name,
            creator           : v2.creator,
            start_time        : arg5,
            end_time          : arg7,
            required_elements : arg4,
        };
        0x2::event::emit<PoolCreated>(v3);
        0x2::object_table::add<0x2::object::ID, Pool>(&mut arg1.pools, v1, v2);
    }

    public entry fun emergency_withdraw_all(arg0: &PoolAdminCap, arg1: &mut PoolSystem, arg2: 0x2::object::ID, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object_table::contains<0x2::object::ID, Pool>(&arg1.pools, arg2), 1);
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, Pool>(&mut arg1.pools, arg2);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v0.sui_reward_pool) > 0, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut v0.sui_reward_pool), arg4), arg3);
    }

    public entry fun end_pool(arg0: &PoolAdminCap, arg1: &mut PoolSystem, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, Pool>(&mut arg1.pools, arg2);
        assert!(v0.is_active, 2);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        v0.is_active = false;
        v0.end_time = v1;
        let v2 = PoolEnded{
            pool_id            : arg2,
            end_time           : v1,
            total_participants : v0.participant_count,
            total_nfts         : v0.total_staked_count,
        };
        0x2::event::emit<PoolEnded>(v2);
    }

    public entry fun extend_pool_time(arg0: &PoolAdminCap, arg1: &mut PoolSystem, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, Pool>(&mut arg1.pools, arg2);
        assert!(v0.is_active, 2);
        v0.end_time = arg3;
        let v1 = PoolTimeExtended{
            pool_id      : arg2,
            new_end_time : arg3,
        };
        0x2::event::emit<PoolTimeExtended>(v1);
    }

    fun extract_nft_element_ids(arg0: &0x1f246b075220ec5f49435224ca862fa60c254b9c544c8961764b1bfe77bf8728::creature_nft::CreatureNFT) : vector<u64> {
        0x1f246b075220ec5f49435224ca862fa60c254b9c544c8961764b1bfe77bf8728::creature_nft::get_all_item_ids(arg0)
    }

    public fun get_pool_info(arg0: &PoolSystem, arg1: 0x2::object::ID) : (0x1::string::String, 0x1::string::String, bool, u64, u64, u64, u64, vector<u64>) {
        let v0 = 0x2::object_table::borrow<0x2::object::ID, Pool>(&arg0.pools, arg1);
        (v0.name, v0.description, v0.is_active, v0.start_time, v0.end_time, v0.participant_count, v0.total_staked_count, v0.required_elements)
    }

    public fun get_pool_overview(arg0: &PoolSystem, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : (u64, u64, u64, u64, u64, bool) {
        assert!(0x2::object_table::contains<0x2::object::ID, Pool>(&arg0.pools, arg1), 1);
        let v0 = 0x2::object_table::borrow<0x2::object::ID, Pool>(&arg0.pools, arg1);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = if (v1 < v0.end_time) {
            v0.end_time - v1
        } else {
            0
        };
        (0x2::balance::value<0x2::sui::SUI>(&v0.sui_reward_pool), v2 / 3600000 * 24, v2 % 3600000 * 24 / 3600000, v0.participant_count, v0.total_staked_count, v0.is_active)
    }

    public fun get_pool_rewards_info(arg0: &PoolSystem, arg1: 0x2::object::ID) : (u64, u64) {
        let v0 = 0x2::object_table::borrow<0x2::object::ID, Pool>(&arg0.pools, arg1);
        (0x2::balance::value<0x2::sui::SUI>(&v0.sui_reward_pool), v0.last_reward_update)
    }

    public fun get_user_nft_weights(arg0: &PoolSystem, arg1: 0x2::object::ID, arg2: address, arg3: &0x2::clock::Clock) : vector<u64> {
        let v0 = 0x2::object_table::borrow<0x2::object::ID, Pool>(&arg0.pools, arg1);
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(&v0.staked_nft_ids)) {
            let v3 = *0x1::vector::borrow<0x2::object::ID>(&v0.staked_nft_ids, v2);
            if (0x2::object_table::contains<0x2::object::ID, StakedNFT>(&v0.staked_nfts, v3)) {
                let v4 = 0x2::object_table::borrow<0x2::object::ID, StakedNFT>(&v0.staked_nfts, v3);
                if (v4.owner == arg2) {
                    let v5 = (0x2::clock::timestamp_ms(arg3) - v4.stake_time) / 3600000;
                    let v6 = if (v5 == 0) {
                        1
                    } else {
                        v5
                    };
                    0x1::vector::push_back<u64>(&mut v1, v6);
                };
            };
            v2 = v2 + 1;
        };
        v1
    }

    public fun get_user_reward_details(arg0: &PoolSystem, arg1: 0x2::object::ID, arg2: address, arg3: &0x2::clock::Clock) : (u64, u64, u64, u64, bool, u64, u64) {
        assert!(0x2::object_table::contains<0x2::object::ID, Pool>(&arg0.pools, arg1), 1);
        let v0 = 0x2::object_table::borrow<0x2::object::ID, Pool>(&arg0.pools, arg1);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        if (!0x2::table::contains<address, UserStakeInfo>(&v0.user_stakes, arg2)) {
            return (0, 0, 0, 0, false, 0, 0)
        };
        let v2 = 0x2::table::borrow<address, UserStakeInfo>(&v0.user_stakes, arg2);
        let v3 = v1 - v2.stake_start_time;
        let v4 = v3 / 3600000;
        let v5 = if (v4 == 0) {
            v2.nft_count
        } else {
            v2.nft_count * v4
        };
        let v6 = if (v0.total_weight > 0) {
            0x2::balance::value<0x2::sui::SUI>(&v0.sui_reward_pool) * v5 / v0.total_weight
        } else {
            0
        };
        let v7 = v1 - v2.last_reward_claim;
        (v2.nft_count, v5, v2.pending_sui_rewards, v6, v7 >= 21600000, v3, v7)
    }

    public fun get_user_reward_details_dynamic(arg0: &PoolSystem, arg1: 0x2::object::ID, arg2: address, arg3: &0x2::clock::Clock) : (u64, u64, u64, u64, u64, u64) {
        assert!(0x2::object_table::contains<0x2::object::ID, Pool>(&arg0.pools, arg1), 1);
        let v0 = 0x2::object_table::borrow<0x2::object::ID, Pool>(&arg0.pools, arg1);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        if (!0x2::table::contains<address, UserStakeInfo>(&v0.user_stakes, arg2)) {
            return (0, 0, 0, 0, 0, 0)
        };
        let v2 = 0x2::table::borrow<address, UserStakeInfo>(&v0.user_stakes, arg2);
        let v3 = calculate_user_current_weight(v0, arg2, v1);
        let v4 = calculate_total_current_weight(v0, v1);
        let v5 = if (v4 > 0 && v3 > 0) {
            0x2::balance::value<0x2::sui::SUI>(&v0.sui_reward_pool) * v3 / v4
        } else {
            0
        };
        (v2.nft_count, v3, v4, v5, v1 - v2.stake_start_time, v1)
    }

    public fun get_user_stake_info(arg0: &PoolSystem, arg1: 0x2::object::ID, arg2: address) : (u64, u64, u64, u64) {
        let v0 = 0x2::object_table::borrow<0x2::object::ID, Pool>(&arg0.pools, arg1);
        if (!0x2::table::contains<address, UserStakeInfo>(&v0.user_stakes, arg2)) {
            return (0, 0, 0, 0)
        };
        let v1 = 0x2::table::borrow<address, UserStakeInfo>(&v0.user_stakes, arg2);
        (v1.nft_count, v1.total_weight, v1.pending_sui_rewards, v1.last_reward_claim)
    }

    public fun get_user_staked_nft_ids(arg0: &PoolSystem, arg1: 0x2::object::ID, arg2: address) : vector<0x2::object::ID> {
        assert!(0x2::object_table::contains<0x2::object::ID, Pool>(&arg0.pools, arg1), 1);
        let v0 = 0x2::object_table::borrow<0x2::object::ID, Pool>(&arg0.pools, arg1);
        let v1 = 0x1::vector::empty<0x2::object::ID>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(&v0.staked_nft_ids)) {
            let v3 = *0x1::vector::borrow<0x2::object::ID>(&v0.staked_nft_ids, v2);
            if (0x2::object_table::contains<0x2::object::ID, StakedNFT>(&v0.staked_nfts, v3)) {
                if (0x2::object_table::borrow<0x2::object::ID, StakedNFT>(&v0.staked_nfts, v3).owner == arg2) {
                    0x1::vector::push_back<0x2::object::ID>(&mut v1, v3);
                };
            };
            v2 = v2 + 1;
        };
        v1
    }

    fun init(arg0: POOL_REWARDS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = PoolAdminCap{id: 0x2::object::new(arg1)};
        let v1 = GlobalConfig{reward_update_interval: 21600000};
        let v2 = PoolSystem{
            id            : 0x2::object::new(arg1),
            pools         : 0x2::object_table::new<0x2::object::ID, Pool>(arg1),
            pool_counter  : 0,
            global_config : v1,
        };
        0x2::transfer::transfer<PoolAdminCap>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<PoolSystem>(v2);
    }

    public entry fun stake_nft(arg0: &mut PoolSystem, arg1: 0x2::object::ID, arg2: 0x1f246b075220ec5f49435224ca862fa60c254b9c544c8961764b1bfe77bf8728::creature_nft::CreatureNFT, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, Pool>(&mut arg0.pools, arg1);
        assert!(v0.is_active, 2);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(v1 < v0.end_time, 6);
        validate_nft_requirements(v0, &arg2);
        let v2 = 0x2::tx_context::sender(arg4);
        let v3 = 0x2::object::id<0x1f246b075220ec5f49435224ca862fa60c254b9c544c8961764b1bfe77bf8728::creature_nft::CreatureNFT>(&arg2);
        let v4 = 1;
        let v5 = StakedNFT{
            id         : 0x2::object::new(arg4),
            nft        : arg2,
            owner      : v2,
            pool_id    : arg1,
            stake_time : v1,
            weight     : v4,
        };
        v0.total_staked_count = v0.total_staked_count + 1;
        v0.total_weight = v0.total_weight + v4;
        if (!0x2::table::contains<address, UserStakeInfo>(&v0.user_stakes, v2)) {
            0x2::table::add<address, bool>(&mut v0.unique_participants, v2, true);
            v0.participant_count = v0.participant_count + 1;
            let v6 = UserStakeInfo{
                nft_count           : 1,
                total_weight        : v4,
                stake_start_time    : v1,
                pending_sui_rewards : 0,
                last_reward_claim   : v1,
            };
            0x2::table::add<address, UserStakeInfo>(&mut v0.user_stakes, v2, v6);
        } else {
            let v7 = 0x2::table::borrow_mut<address, UserStakeInfo>(&mut v0.user_stakes, v2);
            v7.nft_count = v7.nft_count + 1;
            v7.total_weight = v7.total_weight + v4;
        };
        0x2::object_table::add<0x2::object::ID, StakedNFT>(&mut v0.staked_nfts, v3, v5);
        0x1::vector::push_back<0x2::object::ID>(&mut v0.staked_nft_ids, v3);
        let v8 = NFTStaked{
            pool_id    : arg1,
            nft_id     : v3,
            owner      : v2,
            stake_time : v1,
        };
        0x2::event::emit<NFTStaked>(v8);
    }

    public entry fun start_pool(arg0: &PoolAdminCap, arg1: &mut PoolSystem, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, Pool>(&mut arg1.pools, arg2);
        assert!(!v0.is_active, 3);
        v0.is_active = true;
        let v1 = PoolStarted{
            pool_id    : arg2,
            start_time : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<PoolStarted>(v1);
    }

    public fun time_until_next_reward_update(arg0: &PoolSystem, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg2) - 0x2::object_table::borrow<0x2::object::ID, Pool>(&arg0.pools, arg1).last_reward_update;
        if (v0 >= 21600000) {
            0
        } else {
            21600000 - v0
        }
    }

    public entry fun unstake_nft(arg0: &mut PoolSystem, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, Pool>(&mut arg0.pools, arg1);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(0x2::object_table::contains<0x2::object::ID, StakedNFT>(&v0.staked_nfts, arg2), 8);
        let v2 = 0x2::object_table::remove<0x2::object::ID, StakedNFT>(&mut v0.staked_nfts, arg2);
        assert!(v2.owner == v1, 4);
        let v3 = 0x2::clock::timestamp_ms(arg3);
        let v4 = v3 - v0.last_reward_update < 21600000;
        v0.total_staked_count = v0.total_staked_count - 1;
        v0.total_weight = v0.total_weight - v2.weight;
        let v5 = 0x2::table::borrow_mut<address, UserStakeInfo>(&mut v0.user_stakes, v1);
        v5.nft_count = v5.nft_count - 1;
        v5.total_weight = v5.total_weight - v2.weight;
        if (v4) {
            v5.pending_sui_rewards = 0;
        };
        let StakedNFT {
            id         : v6,
            nft        : v7,
            owner      : _,
            pool_id    : _,
            stake_time : _,
            weight     : _,
        } = v2;
        0x2::object::delete(v6);
        let (v12, v13) = 0x1::vector::index_of<0x2::object::ID>(&v0.staked_nft_ids, &arg2);
        if (v12) {
            0x1::vector::remove<0x2::object::ID>(&mut v0.staked_nft_ids, v13);
        };
        0x2::transfer::public_transfer<0x1f246b075220ec5f49435224ca862fa60c254b9c544c8961764b1bfe77bf8728::creature_nft::CreatureNFT>(v7, v1);
        let v14 = NFTUnstaked{
            pool_id           : arg1,
            nft_id            : arg2,
            owner             : v1,
            stake_duration    : v3 - v2.stake_time,
            rewards_forfeited : v4,
        };
        0x2::event::emit<NFTUnstaked>(v14);
    }

    fun update_all_nft_weights(arg0: &mut Pool, arg1: u64) {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(&arg0.staked_nft_ids)) {
            let v2 = *0x1::vector::borrow<0x2::object::ID>(&arg0.staked_nft_ids, v1);
            if (0x2::object_table::contains<0x2::object::ID, StakedNFT>(&arg0.staked_nfts, v2)) {
                let v3 = 0x2::object_table::borrow_mut<0x2::object::ID, StakedNFT>(&mut arg0.staked_nfts, v2);
                let v4 = (arg1 - v3.stake_time) / 3600000;
                let v5 = if (v4 == 0) {
                    1
                } else {
                    v4
                };
                v3.weight = v5;
                v0 = v0 + v5;
            };
            v1 = v1 + 1;
        };
        arg0.total_weight = v0;
    }

    public entry fun update_pool_image_url(arg0: &PoolAdminCap, arg1: &mut PoolSystem, arg2: 0x2::object::ID, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object_table::contains<0x2::object::ID, Pool>(&arg1.pools, arg2), 1);
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, Pool>(&mut arg1.pools, arg2);
        v0.image_url = arg3;
        let v1 = PoolImageUpdated{
            pool_id       : arg2,
            old_image_url : v0.image_url,
            new_image_url : v0.image_url,
            updated_by    : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<PoolImageUpdated>(v1);
    }

    public entry fun update_pool_rewards(arg0: &mut PoolSystem, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, Pool>(&mut arg0.pools, arg1);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        assert!(v1 - v0.last_reward_update >= 21600000, 9);
        update_all_nft_weights(v0, v1);
        v0.last_reward_update = v1;
        let v2 = RewardsUpdated{
            pool_id            : arg1,
            update_time        : v1,
            total_participants : v0.participant_count,
            total_weight       : v0.total_weight,
        };
        0x2::event::emit<RewardsUpdated>(v2);
    }

    fun validate_nft_requirements(arg0: &Pool, arg1: &0x1f246b075220ec5f49435224ca862fa60c254b9c544c8961764b1bfe77bf8728::creature_nft::CreatureNFT) {
        if (0x1::vector::length<u64>(&arg0.required_elements) > 0) {
            assert!(check_nft_has_required_elements(arg1, &arg0.required_elements), 11);
        };
    }

    public entry fun withdraw_pool_funds(arg0: &PoolAdminCap, arg1: &mut PoolSystem, arg2: 0x2::object::ID, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object_table::contains<0x2::object::ID, Pool>(&arg1.pools, arg2), 1);
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, Pool>(&mut arg1.pools, arg2);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v0.sui_reward_pool) >= arg3, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v0.sui_reward_pool, arg3), arg5), arg4);
    }

    // decompiled from Move bytecode v6
}

