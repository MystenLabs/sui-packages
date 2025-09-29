module 0x54f67a03aff5e987ba320f440d8683a993c6470fb1ecbb1188644b86aba8b240::custom_token_pool {
    struct CustomTokenPoolAdminCap has key {
        id: 0x2::object::UID,
    }

    struct CustomTokenPoolSystem has key {
        id: 0x2::object::UID,
        pools: 0x2::object_table::ObjectTable<0x2::object::ID, CustomTokenPool>,
        pool_counter: u64,
        global_config: GlobalConfig,
    }

    struct GlobalConfig has store {
        claim_time_interval: u64,
    }

    struct CustomTokenPool has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        creator: address,
        image_url: 0x1::string::String,
        token_type: 0x1::string::String,
        required_elements: vector<u64>,
        start_time: u64,
        end_time: u64,
        is_active: bool,
        last_reward_update: u64,
        total_rewards: u64,
        staked_nfts: 0x2::object_table::ObjectTable<0x2::object::ID, StakedNFT>,
        user_stakes: 0x2::table::Table<address, UserStakeInfo>,
        total_staked_count: u64,
        total_weight: u64,
        staked_nft_ids: vector<0x2::object::ID>,
        unique_participants: 0x2::table::Table<address, bool>,
        participant_count: u64,
    }

    struct TokenRewardBalance<phantom T0> has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        balance: 0x2::balance::Balance<T0>,
    }

    struct UserStakeInfo has drop, store {
        nft_count: u64,
        total_weight: u64,
        stake_start_time: u64,
        last_reward_claim: u64,
    }

    struct StakedNFT has store, key {
        id: 0x2::object::UID,
        nft: 0x54f67a03aff5e987ba320f440d8683a993c6470fb1ecbb1188644b86aba8b240::creature_nft::CreatureNFT,
        owner: address,
        pool_id: 0x2::object::ID,
        stake_time: u64,
        weight: u64,
    }

    struct CustomTokenPoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        name: 0x1::string::String,
        creator: address,
        token_type: 0x1::string::String,
        start_time: u64,
        end_time: u64,
        required_elements: vector<u64>,
    }

    struct CustomTokenPoolStarted has copy, drop {
        pool_id: 0x2::object::ID,
        start_time: u64,
    }

    struct CustomTokenPoolEnded has copy, drop {
        pool_id: 0x2::object::ID,
        end_time: u64,
        total_participants: u64,
        total_nfts: u64,
    }

    struct NFTStakedInCustomPool has copy, drop {
        pool_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        owner: address,
        stake_time: u64,
    }

    struct NFTUnstakedFromCustomPool has copy, drop {
        pool_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        owner: address,
        stake_duration: u64,
    }

    struct CustomTokenRewardsUpdated has copy, drop {
        pool_id: 0x2::object::ID,
        update_time: u64,
        total_participants: u64,
        total_weight: u64,
    }

    struct CustomTokenRewardsClaimed has copy, drop {
        pool_id: 0x2::object::ID,
        user: address,
        token_type: 0x1::string::String,
        amount: u64,
    }

    struct CustomTokenRewardsAdded has copy, drop {
        pool_id: 0x2::object::ID,
        token_type: 0x1::string::String,
        amount: u64,
    }

    struct CustomPoolImageUpdated has copy, drop {
        pool_id: 0x2::object::ID,
        old_image_url: 0x1::string::String,
        new_image_url: 0x1::string::String,
        updated_by: address,
    }

    struct CustomPoolTimeExtended has copy, drop {
        pool_id: 0x2::object::ID,
        new_end_time: u64,
    }

    struct CustomPoolDeleted has copy, drop {
        pool_id: 0x2::object::ID,
        deleted_by: address,
        funds_withdrawn: u64,
    }

    struct CUSTOM_TOKEN_POOL has drop {
        dummy_field: bool,
    }

    public fun add_custom_token_rewards<T0>(arg0: &CustomTokenPoolAdminCap, arg1: &mut CustomTokenPoolSystem, arg2: &mut TokenRewardBalance<T0>, arg3: 0x2::object::ID, arg4: &mut 0x2::coin::Coin<T0>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, CustomTokenPool>(&mut arg1.pools, arg3);
        assert!(0x2::coin::value<T0>(arg4) >= arg5, 5);
        assert!(arg2.pool_id == arg3, 13);
        0x2::balance::join<T0>(&mut arg2.balance, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg4, arg5, arg6)));
        v0.total_rewards = v0.total_rewards + arg5;
        let v1 = CustomTokenRewardsAdded{
            pool_id    : arg3,
            token_type : 0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()))),
            amount     : arg5,
        };
        0x2::event::emit<CustomTokenRewardsAdded>(v1);
    }

    public fun add_custom_token_rewards_from_balance<T0>(arg0: &CustomTokenPoolAdminCap, arg1: &mut CustomTokenPoolSystem, arg2: &mut TokenRewardBalance<T0>, arg3: 0x2::object::ID, arg4: 0x2::coin::Coin<T0>) {
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, CustomTokenPool>(&mut arg1.pools, arg3);
        assert!(arg2.pool_id == arg3, 13);
        let v1 = 0x2::coin::value<T0>(&arg4);
        0x2::balance::join<T0>(&mut arg2.balance, 0x2::coin::into_balance<T0>(arg4));
        v0.total_rewards = v0.total_rewards + v1;
        let v2 = CustomTokenRewardsAdded{
            pool_id    : arg3,
            token_type : 0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()))),
            amount     : v1,
        };
        0x2::event::emit<CustomTokenRewardsAdded>(v2);
    }

    fun calculate_total_current_weight(arg0: &CustomTokenPool, arg1: u64) : u64 {
        let v0 = if (arg1 > arg0.end_time) {
            arg0.end_time
        } else {
            arg1
        };
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(&arg0.staked_nft_ids)) {
            let v3 = *0x1::vector::borrow<0x2::object::ID>(&arg0.staked_nft_ids, v2);
            if (0x2::object_table::contains<0x2::object::ID, StakedNFT>(&arg0.staked_nfts, v3)) {
                let v4 = 0x2::object_table::borrow<0x2::object::ID, StakedNFT>(&arg0.staked_nfts, v3);
                let v5 = v4.owner;
                if (0x2::table::contains<address, UserStakeInfo>(&arg0.user_stakes, v5)) {
                    let v6 = 0x2::table::borrow<address, UserStakeInfo>(&arg0.user_stakes, v5);
                    let v7 = if (v6.last_reward_claim > v4.stake_time) {
                        v6.last_reward_claim
                    } else {
                        v4.stake_time
                    };
                    let v8 = if (v0 > v7) {
                        v0 - v7
                    } else {
                        0
                    };
                    v1 = v1 + v8;
                };
            };
            v2 = v2 + 1;
        };
        if (v1 == 0) {
            1
        } else {
            v1
        }
    }

    fun calculate_user_current_weight(arg0: &CustomTokenPool, arg1: address, arg2: u64) : u64 {
        if (!0x2::table::contains<address, UserStakeInfo>(&arg0.user_stakes, arg1)) {
            return 0
        };
        let v0 = if (arg2 > arg0.end_time) {
            arg0.end_time
        } else {
            arg2
        };
        let v1 = 0x2::table::borrow<address, UserStakeInfo>(&arg0.user_stakes, arg1);
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x2::object::ID>(&arg0.staked_nft_ids)) {
            let v4 = *0x1::vector::borrow<0x2::object::ID>(&arg0.staked_nft_ids, v3);
            if (0x2::object_table::contains<0x2::object::ID, StakedNFT>(&arg0.staked_nfts, v4)) {
                let v5 = 0x2::object_table::borrow<0x2::object::ID, StakedNFT>(&arg0.staked_nfts, v4);
                if (v5.owner == arg1) {
                    let v6 = if (v1.last_reward_claim > v5.stake_time) {
                        v1.last_reward_claim
                    } else {
                        v5.stake_time
                    };
                    let v7 = if (v0 > v6) {
                        v0 - v6
                    } else {
                        0
                    };
                    v2 = v2 + v7;
                };
            };
            v3 = v3 + 1;
        };
        v2
    }

    public fun can_claim_rewards(arg0: &CustomTokenPoolSystem, arg1: 0x2::object::ID, arg2: address, arg3: &0x2::clock::Clock) : bool {
        let v0 = 0x2::object_table::borrow<0x2::object::ID, CustomTokenPool>(&arg0.pools, arg1);
        if (!0x2::table::contains<address, UserStakeInfo>(&v0.user_stakes, arg2)) {
            return false
        };
        0x2::clock::timestamp_ms(arg3) - 0x2::table::borrow<address, UserStakeInfo>(&v0.user_stakes, arg2).last_reward_claim >= arg0.global_config.claim_time_interval
    }

    fun check_nft_has_all_required_elements(arg0: &0x54f67a03aff5e987ba320f440d8683a993c6470fb1ecbb1188644b86aba8b240::creature_nft::CreatureNFT, arg1: &vector<u64>) : bool {
        let v0 = extract_nft_element_ids(arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(arg1)) {
            let v2 = *0x1::vector::borrow<u64>(arg1, v1);
            if (!0x1::vector::contains<u64>(&v0, &v2)) {
                return false
            };
            v1 = v1 + 1;
        };
        true
    }

    public fun claim_custom_token_rewards<T0>(arg0: &mut CustomTokenPoolSystem, arg1: &mut TokenRewardBalance<T0>, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, CustomTokenPool>(&mut arg0.pools, arg2);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(0x2::table::contains<address, UserStakeInfo>(&v0.user_stakes, v1), 8);
        assert!(arg1.pool_id == arg2, 13);
        let v2 = 0x2::clock::timestamp_ms(arg3);
        let v3 = 0x2::table::borrow<address, UserStakeInfo>(&v0.user_stakes, v1);
        if (v3.nft_count == 0) {
            return
        };
        assert!(v2 - v3.last_reward_claim >= arg0.global_config.claim_time_interval || v3.last_reward_claim == 0, 12);
        let v4 = calculate_user_current_weight(v0, v1, v2);
        let v5 = calculate_total_current_weight(v0, v2);
        let v6 = if (v5 == 0 || v4 == 0) {
            0
        } else {
            0x2::balance::value<T0>(&arg1.balance) * v4 / v5
        };
        if (v6 > 0 && 0x2::balance::value<T0>(&arg1.balance) >= v6) {
            0x2::table::borrow_mut<address, UserStakeInfo>(&mut v0.user_stakes, v1).last_reward_claim = v2;
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, v6), arg4), v1);
            let v7 = CustomTokenRewardsClaimed{
                pool_id    : arg2,
                user       : v1,
                token_type : 0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()))),
                amount     : v6,
            };
            0x2::event::emit<CustomTokenRewardsClaimed>(v7);
        };
    }

    public fun create_custom_token_pool<T0>(arg0: &CustomTokenPoolAdminCap, arg1: &mut CustomTokenPoolSystem, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<u64>, arg5: u64, arg6: 0x1::string::String, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg7 > arg5, 7);
        arg1.pool_counter = arg1.pool_counter + 1;
        let v0 = 0x2::object::new(arg9);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = CustomTokenPool{
            id                  : v0,
            pool_id             : v1,
            name                : arg2,
            description         : arg3,
            creator             : 0x2::tx_context::sender(arg9),
            image_url           : arg6,
            token_type          : 0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()))),
            required_elements   : arg4,
            start_time          : arg5,
            end_time            : arg7,
            is_active           : false,
            last_reward_update  : 0x2::clock::timestamp_ms(arg8),
            total_rewards       : 0,
            staked_nfts         : 0x2::object_table::new<0x2::object::ID, StakedNFT>(arg9),
            user_stakes         : 0x2::table::new<address, UserStakeInfo>(arg9),
            total_staked_count  : 0,
            total_weight        : 0,
            staked_nft_ids      : 0x1::vector::empty<0x2::object::ID>(),
            unique_participants : 0x2::table::new<address, bool>(arg9),
            participant_count   : 0,
        };
        let v3 = CustomTokenPoolCreated{
            pool_id           : v1,
            name              : v2.name,
            creator           : v2.creator,
            token_type        : v2.token_type,
            start_time        : arg5,
            end_time          : arg7,
            required_elements : arg4,
        };
        0x2::event::emit<CustomTokenPoolCreated>(v3);
        0x2::object_table::add<0x2::object::ID, CustomTokenPool>(&mut arg1.pools, v1, v2);
    }

    public fun create_token_reward_balance<T0>(arg0: &CustomTokenPoolAdminCap, arg1: &CustomTokenPoolSystem, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : TokenRewardBalance<T0> {
        assert!(0x2::object_table::contains<0x2::object::ID, CustomTokenPool>(&arg1.pools, arg2), 1);
        TokenRewardBalance<T0>{
            id      : 0x2::object::new(arg3),
            pool_id : arg2,
            balance : 0x2::balance::zero<T0>(),
        }
    }

    public fun delete_custom_pool<T0>(arg0: &CustomTokenPoolAdminCap, arg1: &mut CustomTokenPoolSystem, arg2: &mut TokenRewardBalance<T0>, arg3: 0x2::object::ID, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object_table::contains<0x2::object::ID, CustomTokenPool>(&arg1.pools, arg3), 1);
        assert!(arg2.pool_id == arg3, 13);
        let v0 = 0x2::object_table::remove<0x2::object::ID, CustomTokenPool>(&mut arg1.pools, arg3);
        v0.is_active = false;
        let v1 = 0x2::balance::value<T0>(&arg2.balance);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg2.balance), arg5), arg4);
        };
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(&v0.staked_nft_ids)) {
            let v3 = *0x1::vector::borrow<0x2::object::ID>(&v0.staked_nft_ids, v2);
            if (0x2::object_table::contains<0x2::object::ID, StakedNFT>(&v0.staked_nfts, v3)) {
                let v4 = 0x2::object_table::remove<0x2::object::ID, StakedNFT>(&mut v0.staked_nfts, v3);
                let StakedNFT {
                    id         : v5,
                    nft        : v6,
                    owner      : _,
                    pool_id    : _,
                    stake_time : _,
                    weight     : _,
                } = v4;
                0x2::object::delete(v5);
                0x2::transfer::public_transfer<0x54f67a03aff5e987ba320f440d8683a993c6470fb1ecbb1188644b86aba8b240::creature_nft::CreatureNFT>(v6, v4.owner);
            };
            v2 = v2 + 1;
        };
        let CustomTokenPool {
            id                  : v11,
            pool_id             : _,
            name                : _,
            description         : _,
            creator             : _,
            image_url           : _,
            token_type          : _,
            required_elements   : _,
            start_time          : _,
            end_time            : _,
            is_active           : _,
            last_reward_update  : _,
            total_rewards       : _,
            staked_nfts         : v24,
            user_stakes         : v25,
            total_staked_count  : _,
            total_weight        : _,
            staked_nft_ids      : _,
            unique_participants : v29,
            participant_count   : _,
        } = v0;
        0x2::object_table::destroy_empty<0x2::object::ID, StakedNFT>(v24);
        0x2::table::drop<address, UserStakeInfo>(v25);
        0x2::table::drop<address, bool>(v29);
        0x2::object::delete(v11);
        let v31 = CustomPoolDeleted{
            pool_id         : arg3,
            deleted_by      : 0x2::tx_context::sender(arg5),
            funds_withdrawn : v1,
        };
        0x2::event::emit<CustomPoolDeleted>(v31);
    }

    public fun emergency_withdraw_all_custom<T0>(arg0: &CustomTokenPoolAdminCap, arg1: &mut CustomTokenPoolSystem, arg2: &mut TokenRewardBalance<T0>, arg3: 0x2::object::ID, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object_table::contains<0x2::object::ID, CustomTokenPool>(&arg1.pools, arg3), 1);
        assert!(arg2.pool_id == arg3, 13);
        assert!(0x2::balance::value<T0>(&arg2.balance) > 0, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg2.balance), arg5), arg4);
    }

    public fun end_custom_pool(arg0: &CustomTokenPoolAdminCap, arg1: &mut CustomTokenPoolSystem, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, CustomTokenPool>(&mut arg1.pools, arg2);
        assert!(v0.is_active, 2);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        v0.is_active = false;
        v0.end_time = v1;
        let v2 = CustomTokenPoolEnded{
            pool_id            : arg2,
            end_time           : v1,
            total_participants : v0.participant_count,
            total_nfts         : v0.total_staked_count,
        };
        0x2::event::emit<CustomTokenPoolEnded>(v2);
    }

    public fun extend_custom_pool_time(arg0: &CustomTokenPoolAdminCap, arg1: &mut CustomTokenPoolSystem, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, CustomTokenPool>(&mut arg1.pools, arg2);
        assert!(v0.is_active, 2);
        v0.end_time = arg3;
        let v1 = CustomPoolTimeExtended{
            pool_id      : arg2,
            new_end_time : arg3,
        };
        0x2::event::emit<CustomPoolTimeExtended>(v1);
    }

    fun extract_nft_element_ids(arg0: &0x54f67a03aff5e987ba320f440d8683a993c6470fb1ecbb1188644b86aba8b240::creature_nft::CreatureNFT) : vector<u64> {
        0x54f67a03aff5e987ba320f440d8683a993c6470fb1ecbb1188644b86aba8b240::creature_nft::get_all_item_ids(arg0)
    }

    public fun get_claim_time_interval(arg0: &CustomTokenPoolSystem) : u64 {
        arg0.global_config.claim_time_interval
    }

    public fun get_custom_pool_info(arg0: &CustomTokenPoolSystem, arg1: 0x2::object::ID) : (0x1::string::String, 0x1::string::String, 0x1::string::String, bool, u64, u64, u64, u64, vector<u64>) {
        let v0 = 0x2::object_table::borrow<0x2::object::ID, CustomTokenPool>(&arg0.pools, arg1);
        (v0.name, v0.description, v0.token_type, v0.is_active, v0.start_time, v0.end_time, v0.participant_count, v0.total_staked_count, v0.required_elements)
    }

    public fun get_custom_pool_rewards_info<T0>(arg0: &CustomTokenPoolSystem, arg1: &TokenRewardBalance<T0>, arg2: 0x2::object::ID) : (u64, u64, u64) {
        let v0 = 0x2::object_table::borrow<0x2::object::ID, CustomTokenPool>(&arg0.pools, arg2);
        assert!(arg1.pool_id == arg2, 13);
        (0x2::balance::value<T0>(&arg1.balance), v0.total_rewards, v0.last_reward_update)
    }

    public fun get_pool_overview(arg0: &CustomTokenPoolSystem, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : (u64, u64, u64, bool) {
        assert!(0x2::object_table::contains<0x2::object::ID, CustomTokenPool>(&arg0.pools, arg1), 1);
        let v0 = 0x2::object_table::borrow<0x2::object::ID, CustomTokenPool>(&arg0.pools, arg1);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = if (v1 < v0.end_time) {
            v0.end_time - v1
        } else {
            0
        };
        (v2 / 3600000 * 24, v2 % 3600000 * 24 / 3600000, v0.participant_count, v0.is_active)
    }

    public fun get_user_reward_details_custom<T0>(arg0: &CustomTokenPoolSystem, arg1: &TokenRewardBalance<T0>, arg2: 0x2::object::ID, arg3: address, arg4: &0x2::clock::Clock) : (u64, u64, u64, u64, u64, u64) {
        assert!(0x2::object_table::contains<0x2::object::ID, CustomTokenPool>(&arg0.pools, arg2), 1);
        assert!(arg1.pool_id == arg2, 13);
        let v0 = 0x2::object_table::borrow<0x2::object::ID, CustomTokenPool>(&arg0.pools, arg2);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        if (!0x2::table::contains<address, UserStakeInfo>(&v0.user_stakes, arg3)) {
            return (0, 0, 0, 0, 0, 0)
        };
        let v2 = 0x2::table::borrow<address, UserStakeInfo>(&v0.user_stakes, arg3);
        let v3 = calculate_user_current_weight(v0, arg3, v1);
        let v4 = calculate_total_current_weight(v0, v1);
        let v5 = if (v4 > 0 && v3 > 0) {
            0x2::balance::value<T0>(&arg1.balance) * v3 / v4
        } else {
            0
        };
        (v2.nft_count, v3, v4, v5, v1 - v2.stake_start_time, v1)
    }

    public fun get_user_stake_info_custom(arg0: &CustomTokenPoolSystem, arg1: 0x2::object::ID, arg2: address) : (u64, u64, u64, u64) {
        let v0 = 0x2::object_table::borrow<0x2::object::ID, CustomTokenPool>(&arg0.pools, arg1);
        if (!0x2::table::contains<address, UserStakeInfo>(&v0.user_stakes, arg2)) {
            return (0, 0, 0, 0)
        };
        let v1 = 0x2::table::borrow<address, UserStakeInfo>(&v0.user_stakes, arg2);
        (v1.nft_count, v1.total_weight, v1.stake_start_time, v1.last_reward_claim)
    }

    public fun get_user_staked_nft_ids(arg0: &CustomTokenPoolSystem, arg1: 0x2::object::ID, arg2: address) : vector<0x2::object::ID> {
        assert!(0x2::object_table::contains<0x2::object::ID, CustomTokenPool>(&arg0.pools, arg1), 1);
        let v0 = 0x2::object_table::borrow<0x2::object::ID, CustomTokenPool>(&arg0.pools, arg1);
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

    fun init(arg0: CUSTOM_TOKEN_POOL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = CustomTokenPoolAdminCap{id: 0x2::object::new(arg1)};
        let v1 = GlobalConfig{claim_time_interval: 500000};
        let v2 = CustomTokenPoolSystem{
            id            : 0x2::object::new(arg1),
            pools         : 0x2::object_table::new<0x2::object::ID, CustomTokenPool>(arg1),
            pool_counter  : 0,
            global_config : v1,
        };
        0x2::transfer::transfer<CustomTokenPoolAdminCap>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<CustomTokenPoolSystem>(v2);
    }

    public fun stake_nft_in_custom_pool(arg0: &mut CustomTokenPoolSystem, arg1: 0x2::object::ID, arg2: 0x54f67a03aff5e987ba320f440d8683a993c6470fb1ecbb1188644b86aba8b240::creature_nft::CreatureNFT, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, CustomTokenPool>(&mut arg0.pools, arg1);
        assert!(v0.is_active, 2);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(v1 < v0.end_time, 6);
        validate_nft_requirements(v0, &arg2);
        let v2 = 0x2::tx_context::sender(arg4);
        let v3 = 0x2::object::id<0x54f67a03aff5e987ba320f440d8683a993c6470fb1ecbb1188644b86aba8b240::creature_nft::CreatureNFT>(&arg2);
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
                nft_count         : 1,
                total_weight      : v4,
                stake_start_time  : v1,
                last_reward_claim : v1,
            };
            0x2::table::add<address, UserStakeInfo>(&mut v0.user_stakes, v2, v6);
        } else {
            let v7 = 0x2::table::borrow_mut<address, UserStakeInfo>(&mut v0.user_stakes, v2);
            v7.nft_count = v7.nft_count + 1;
            v7.total_weight = v7.total_weight + v4;
        };
        0x2::object_table::add<0x2::object::ID, StakedNFT>(&mut v0.staked_nfts, v3, v5);
        0x1::vector::push_back<0x2::object::ID>(&mut v0.staked_nft_ids, v3);
        let v8 = NFTStakedInCustomPool{
            pool_id    : arg1,
            nft_id     : v3,
            owner      : v2,
            stake_time : v1,
        };
        0x2::event::emit<NFTStakedInCustomPool>(v8);
    }

    public fun start_custom_pool(arg0: &CustomTokenPoolAdminCap, arg1: &mut CustomTokenPoolSystem, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, CustomTokenPool>(&mut arg1.pools, arg2);
        assert!(!v0.is_active, 3);
        v0.is_active = true;
        let v1 = CustomTokenPoolStarted{
            pool_id    : arg2,
            start_time : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<CustomTokenPoolStarted>(v1);
    }

    public fun transfer_custom_pool_admin_cap(arg0: CustomTokenPoolAdminCap, arg1: address) {
        0x2::transfer::transfer<CustomTokenPoolAdminCap>(arg0, arg1);
    }

    public fun unstake_nft_from_custom_pool(arg0: &mut CustomTokenPoolSystem, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, CustomTokenPool>(&mut arg0.pools, arg1);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(0x2::object_table::contains<0x2::object::ID, StakedNFT>(&v0.staked_nfts, arg2), 8);
        let v2 = 0x2::object_table::remove<0x2::object::ID, StakedNFT>(&mut v0.staked_nfts, arg2);
        assert!(v2.owner == v1, 4);
        v0.total_staked_count = v0.total_staked_count - 1;
        v0.total_weight = v0.total_weight - v2.weight;
        let v3 = 0x2::table::borrow_mut<address, UserStakeInfo>(&mut v0.user_stakes, v1);
        v3.nft_count = v3.nft_count - 1;
        v3.total_weight = v3.total_weight - v2.weight;
        let StakedNFT {
            id         : v4,
            nft        : v5,
            owner      : _,
            pool_id    : _,
            stake_time : _,
            weight     : _,
        } = v2;
        0x2::object::delete(v4);
        let (v10, v11) = 0x1::vector::index_of<0x2::object::ID>(&v0.staked_nft_ids, &arg2);
        if (v10) {
            0x1::vector::remove<0x2::object::ID>(&mut v0.staked_nft_ids, v11);
        };
        0x2::transfer::public_transfer<0x54f67a03aff5e987ba320f440d8683a993c6470fb1ecbb1188644b86aba8b240::creature_nft::CreatureNFT>(v5, v1);
        let v12 = NFTUnstakedFromCustomPool{
            pool_id        : arg1,
            nft_id         : arg2,
            owner          : v1,
            stake_duration : 0x2::clock::timestamp_ms(arg3) - v2.stake_time,
        };
        0x2::event::emit<NFTUnstakedFromCustomPool>(v12);
    }

    fun update_all_nft_weights(arg0: &mut CustomTokenPool, arg1: u64) {
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

    public fun update_claim_time_interval(arg0: &CustomTokenPoolAdminCap, arg1: &mut CustomTokenPoolSystem, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.global_config.claim_time_interval = arg2;
    }

    public fun update_custom_pool_image_url(arg0: &CustomTokenPoolAdminCap, arg1: &mut CustomTokenPoolSystem, arg2: 0x2::object::ID, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object_table::contains<0x2::object::ID, CustomTokenPool>(&arg1.pools, arg2), 1);
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, CustomTokenPool>(&mut arg1.pools, arg2);
        v0.image_url = arg3;
        let v1 = CustomPoolImageUpdated{
            pool_id       : arg2,
            old_image_url : v0.image_url,
            new_image_url : v0.image_url,
            updated_by    : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<CustomPoolImageUpdated>(v1);
    }

    public fun update_custom_pool_required_elements(arg0: &CustomTokenPoolAdminCap, arg1: &mut CustomTokenPoolSystem, arg2: 0x2::object::ID, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object_table::contains<0x2::object::ID, CustomTokenPool>(&arg1.pools, arg2), 1);
        0x2::object_table::borrow_mut<0x2::object::ID, CustomTokenPool>(&mut arg1.pools, arg2).required_elements = arg3;
    }

    fun validate_nft_requirements(arg0: &CustomTokenPool, arg1: &0x54f67a03aff5e987ba320f440d8683a993c6470fb1ecbb1188644b86aba8b240::creature_nft::CreatureNFT) {
        if (0x1::vector::length<u64>(&arg0.required_elements) > 0) {
            assert!(check_nft_has_all_required_elements(arg1, &arg0.required_elements), 11);
        };
    }

    public fun withdraw_custom_pool_funds<T0>(arg0: &CustomTokenPoolAdminCap, arg1: &mut CustomTokenPoolSystem, arg2: &mut TokenRewardBalance<T0>, arg3: 0x2::object::ID, arg4: u64, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object_table::contains<0x2::object::ID, CustomTokenPool>(&arg1.pools, arg3), 1);
        assert!(arg2.pool_id == arg3, 13);
        assert!(0x2::balance::value<T0>(&arg2.balance) >= arg4, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg2.balance, arg4), arg6), arg5);
    }

    // decompiled from Move bytecode v6
}

