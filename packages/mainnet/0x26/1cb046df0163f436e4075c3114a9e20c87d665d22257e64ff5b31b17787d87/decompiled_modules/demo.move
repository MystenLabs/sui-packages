module 0x261cb046df0163f436e4075c3114a9e20c87d665d22257e64ff5b31b17787d87::demo {
    struct SlotConfig has copy, drop, store {
        slot_number: u8,
        unlock_cost: u64,
        reward_multiplier: u64,
        allowed_collections: vector<0x1::string::String>,
        is_open_to_all: bool,
    }

    struct SlotData has store, key {
        id: 0x2::object::UID,
        owner: address,
        slot_number: u8,
        staked_nft: 0x1::option::Option<0x2::object::ID>,
        staked_collection: 0x1::option::Option<0x1::string::String>,
        stake_time: u64,
        last_claim_time: u64,
        pending_rewards: u64,
        total_claimed: u64,
        is_unlocked: bool,
        nft_type: 0x1::option::Option<0x1::type_name::TypeName>,
    }

    struct UserSlotAllocation has store, key {
        id: 0x2::object::UID,
        owner: address,
        max_slots_allowed: u8,
        total_slots_unlocked: u8,
        unlocked_slot_numbers: vector<u8>,
    }

    struct NftMultiplier has store, key {
        id: 0x2::object::UID,
        nft_id: 0x2::object::ID,
        collection: 0x1::string::String,
        multiplier: u64,
        rarity_tier: 0x1::string::String,
        set_by: address,
        set_time: u64,
    }

    struct CollectionMultiplier has store, key {
        id: 0x2::object::UID,
        collection: 0x1::string::String,
        default_multiplier: u64,
        set_by: address,
        set_time: u64,
    }

    struct WalletBonusMultiplier has store, key {
        id: 0x2::object::UID,
        wallet: address,
        bonus_multiplier: u64,
        set_by: address,
        set_time: u64,
        reason: 0x1::string::String,
    }

    struct PoolSlotLimits has store, key {
        id: 0x2::object::UID,
        default_max_slots_per_wallet: u8,
        absolute_max_slots: u8,
        total_users_with_custom_limits: u64,
    }

    struct SlotTokenPricing has store, key {
        id: 0x2::object::UID,
        slot_number: u8,
        token_prices: 0x2::table::Table<0x1::string::String, u64>,
    }

    struct TokenRevenue has store, key {
        id: 0x2::object::UID,
        token_type: 0x1::string::String,
        total_collected: u64,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct PaymentTokenRegistry has store, key {
        id: 0x2::object::UID,
        supported_tokens: 0x2::table::Table<0x1::string::String, bool>,
        token_list: vector<0x1::string::String>,
    }

    struct StakeInfo<phantom T0: store + key, phantom T1> has store, key {
        id: 0x2::object::UID,
        nft_id: 0x2::object::ID,
        owner: address,
        kiosk_id: 0x2::object::ID,
        collection: 0x1::string::String,
        purchase_cap: 0x2::kiosk::PurchaseCap<T0>,
        stake_time: u64,
        last_claim_time: u64,
        pending_rewards: u64,
        nft_type: 0x1::type_name::TypeName,
        total_claimed: u64,
        slot_number: u8,
    }

    struct SlotDataKey has copy, drop, store {
        owner: address,
        slot_number: u8,
    }

    struct NftMultiplierKey has copy, drop, store {
        nft_id: 0x2::object::ID,
        collection: 0x1::string::String,
    }

    struct CollectionMultiplierKey has copy, drop, store {
        collection: 0x1::string::String,
    }

    struct WalletBonusMultiplierKey has copy, drop, store {
        wallet: address,
    }

    struct UserSlotAllocationKey has copy, drop, store {
        user: address,
    }

    struct PoolSlotLimitsKey has copy, drop, store {
        dummy_field: bool,
    }

    struct SlotTokenPricingKey has copy, drop, store {
        slot_number: u8,
    }

    struct TokenRevenueKey has copy, drop, store {
        token_type: 0x1::string::String,
    }

    struct PaymentTokenRegistryKey has copy, drop, store {
        dummy_field: bool,
    }

    struct StakeKey has copy, drop, store {
        nft_id: 0x2::object::ID,
        nft_type: 0x1::type_name::TypeName,
    }

    struct UserSlotInfo has copy, drop {
        owner: address,
        max_slots_allowed: u8,
        total_slots_unlocked: u8,
        unlocked_slot_numbers: vector<u8>,
    }

    struct SlotDataInfo has copy, drop {
        owner: address,
        slot_number: u8,
        staked_nft: 0x1::option::Option<0x2::object::ID>,
        staked_collection: 0x1::option::Option<0x1::string::String>,
        stake_time: u64,
        last_claim_time: u64,
        pending_rewards: u64,
        total_claimed: u64,
        is_unlocked: bool,
    }

    struct NftMultiplierInfo has copy, drop {
        multiplier: u64,
        rarity_tier: 0x1::string::String,
        set_by: address,
        set_time: u64,
    }

    struct CollectionMultiplierInfo has copy, drop {
        default_multiplier: u64,
        set_by: address,
        set_time: u64,
    }

    struct WalletBonusMultiplierInfo has copy, drop {
        bonus_multiplier: u64,
        set_by: address,
        set_time: u64,
        reason: 0x1::string::String,
    }

    struct StakingPool<phantom T0> has key {
        id: 0x2::object::UID,
        admin: address,
        emergency_admin: address,
        total_staked: u64,
        reward_balance: 0x2::balance::Balance<T0>,
        reserved_rewards: u64,
        default_reward_rate: u64,
        start_time: u64,
        end_time: u64,
        is_locked: bool,
        is_paused: bool,
        supported_collections: vector<0x1::string::String>,
        reward_token_type: 0x1::type_name::TypeName,
        min_staking_duration: u64,
        total_rewards_distributed: u64,
        total_rewards_added: u64,
        pool_creation_time: u64,
        slot_configs: vector<SlotConfig>,
        total_users_with_slots: u64,
    }

    struct StakeReceipt<phantom T0: store + key, phantom T1> has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
        owner: address,
        stake_time: u64,
        nft_type: 0x1::type_name::TypeName,
        slot_number: u8,
    }

    struct StakingPoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        admin: address,
        emergency_admin: address,
        default_reward_rate: u64,
        start_time: u64,
        end_time: u64,
        reward_token_type: 0x1::type_name::TypeName,
        min_staking_duration: u64,
        initial_reward_amount: u64,
        slot_configs: vector<SlotConfig>,
        default_max_slots_per_wallet: u8,
    }

    struct SlotCollectionsUpdated has copy, drop {
        pool_id: 0x2::object::ID,
        slot_number: u8,
        old_collections: vector<0x1::string::String>,
        new_collections: vector<0x1::string::String>,
        is_open_to_all: bool,
        updated_by: address,
        update_time: u64,
    }

    struct SlotUnlocked has copy, drop {
        pool_id: 0x2::object::ID,
        user: address,
        slot_number: u8,
        unlock_cost: u64,
        allowed_collections: vector<0x1::string::String>,
        is_open_to_all: bool,
        unlock_time: u64,
    }

    struct SlotUnlockedWithToken has copy, drop {
        pool_id: 0x2::object::ID,
        user: address,
        slot_number: u8,
        token_type: 0x1::string::String,
        payment_amount: u64,
        unlock_time: u64,
        total_slots_unlocked: u8,
    }

    struct NftStaked has copy, drop {
        pool_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
        owner: address,
        collection: 0x1::string::String,
        stake_time: u64,
        nft_type: 0x1::type_name::TypeName,
        slot_number: u8,
        base_reward_rate: u64,
        slot_multiplier: u64,
        nft_multiplier: u64,
        wallet_bonus_multiplier: u64,
        effective_reward_rate: u64,
    }

    struct NftUnstaked has copy, drop {
        pool_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
        owner: address,
        unstake_time: u64,
        staking_duration: u64,
        nft_type: 0x1::type_name::TypeName,
        slot_number: u8,
        final_reward_claimed: u64,
    }

    struct RewardsClaimed has copy, drop {
        pool_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        owner: address,
        amount: u64,
        claim_time: u64,
        reward_token_type: 0x1::type_name::TypeName,
        is_partial_claim: bool,
        remaining_pending: u64,
        slot_number: u8,
    }

    struct NftMultiplierSet has copy, drop {
        pool_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        collection: 0x1::string::String,
        old_multiplier: u64,
        new_multiplier: u64,
        rarity_tier: 0x1::string::String,
        set_by: address,
        set_time: u64,
    }

    struct CollectionMultiplierSet has copy, drop {
        pool_id: 0x2::object::ID,
        collection: 0x1::string::String,
        old_multiplier: u64,
        new_multiplier: u64,
        set_by: address,
        set_time: u64,
    }

    struct WalletBonusMultiplierSet has copy, drop {
        pool_id: 0x2::object::ID,
        wallet: address,
        old_bonus_multiplier: u64,
        new_bonus_multiplier: u64,
        reason: 0x1::string::String,
        set_by: address,
        set_time: u64,
    }

    struct UserSlotLimitIncreased has copy, drop {
        pool_id: 0x2::object::ID,
        user: address,
        old_limit: u8,
        new_limit: u8,
        increased_by: address,
        increase_time: u64,
    }

    struct SlotPriceUpdated has copy, drop {
        pool_id: 0x2::object::ID,
        slot_number: u8,
        token_type: 0x1::string::String,
        old_price: u64,
        new_price: u64,
        updated_by: address,
        update_time: u64,
    }

    struct SlotMultiplierUpdated has copy, drop {
        pool_id: 0x2::object::ID,
        slot_number: u8,
        old_multiplier: u64,
        new_multiplier: u64,
        updated_by: address,
        update_time: u64,
    }

    struct PaymentTokenAdded has copy, drop {
        pool_id: 0x2::object::ID,
        token_type: 0x1::string::String,
        added_by: address,
        add_time: u64,
    }

    struct PaymentTokenRemoved has copy, drop {
        pool_id: 0x2::object::ID,
        token_type: 0x1::string::String,
        removed_by: address,
        remove_time: u64,
    }

    struct RewardsUpdated has copy, drop {
        pool_id: 0x2::object::ID,
        owner: address,
        slot_number: u8,
        nft_id: 0x2::object::ID,
        additional_rewards: u64,
        total_pending: u64,
        update_time: u64,
    }

    struct ActiveSlotInfo has copy, drop {
        slot_number: u8,
        pending_rewards: u64,
        effective_rate: u64,
        total_claimed: u64,
    }

    struct SlotRewardBreakdown has copy, drop {
        stored_pending: u64,
        additional_rewards: u64,
        total_pending: u64,
        effective_rate: u64,
        total_claimed: u64,
        stake_duration: u64,
    }

    struct PoolStats has copy, drop {
        total_staked: u64,
        remaining_rewards: u64,
        total_rewards_distributed: u64,
        total_rewards_added: u64,
        total_users_with_slots: u64,
    }

    struct PoolTiming has copy, drop {
        start_time: u64,
        end_time: u64,
        min_staking_duration: u64,
        pool_creation_time: u64,
    }

    struct UserSlotDetails has copy, drop {
        slot_number: u8,
        is_unlocked: bool,
        is_occupied: bool,
        staked_nft: 0x1::option::Option<0x2::object::ID>,
        staked_collection: 0x1::option::Option<0x1::string::String>,
        stake_time: u64,
        last_claim_time: u64,
        pending_rewards: u64,
        total_claimed: u64,
        effective_rate: u64,
        stake_duration: u64,
        slot_multiplier: u64,
        nft_multiplier: u64,
        allowed_collections: vector<0x1::string::String>,
        is_open_to_all: bool,
        unlock_cost: u64,
    }

    struct UserWalletDetails has copy, drop {
        owner: address,
        max_slots_allowed: u8,
        total_slots_unlocked: u8,
        unlocked_slot_numbers: vector<u8>,
        wallet_bonus_multiplier: u64,
        wallet_bonus_reason: 0x1::string::String,
        total_pending_rewards: u64,
        total_claimed_rewards: u64,
        active_stakes_count: u8,
        slot_details: vector<UserSlotDetails>,
    }

    public entry fun add_collection_to_slot<T0>(arg0: &mut StakingPool<T0>, arg1: u8, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 2);
        assert_not_paused<T0>(arg0);
        assert!(arg1 >= 1 && arg1 <= 100, 30);
        assert!(0x1::string::length(&arg2) > 0, 24);
        let v0 = 0;
        let v1 = false;
        while (v0 < 0x1::vector::length<SlotConfig>(&arg0.slot_configs)) {
            let v2 = 0x1::vector::borrow_mut<SlotConfig>(&mut arg0.slot_configs, v0);
            if (v2.slot_number == arg1) {
                if (!0x1::vector::contains<0x1::string::String>(&v2.allowed_collections, &arg2)) {
                    0x1::vector::push_back<0x1::string::String>(&mut v2.allowed_collections, arg2);
                    v2.is_open_to_all = false;
                };
                v1 = true;
                let v3 = SlotCollectionsUpdated{
                    pool_id         : 0x2::object::id<StakingPool<T0>>(arg0),
                    slot_number     : arg1,
                    old_collections : v2.allowed_collections,
                    new_collections : v2.allowed_collections,
                    is_open_to_all  : v2.is_open_to_all,
                    updated_by      : 0x2::tx_context::sender(arg4),
                    update_time     : 0x2::clock::timestamp_ms(arg3),
                };
                0x2::event::emit<SlotCollectionsUpdated>(v3);
                break
            };
            v0 = v0 + 1;
        };
        assert!(v1, 30);
    }

    public entry fun add_payment_token<T0>(arg0: &mut StakingPool<T0>, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 2);
        assert_not_paused<T0>(arg0);
        assert!(0x1::string::length(&arg1) > 0, 21);
        let v0 = PaymentTokenRegistryKey{dummy_field: false};
        let v1 = 0x2::dynamic_object_field::borrow_mut<PaymentTokenRegistryKey, PaymentTokenRegistry>(&mut arg0.id, v0);
        assert!(!0x2::table::contains<0x1::string::String, bool>(&v1.supported_tokens, arg1), 36);
        0x2::table::add<0x1::string::String, bool>(&mut v1.supported_tokens, arg1, true);
        0x1::vector::push_back<0x1::string::String>(&mut v1.token_list, arg1);
        let v2 = PaymentTokenAdded{
            pool_id    : 0x2::object::id<StakingPool<T0>>(arg0),
            token_type : arg1,
            added_by   : 0x2::tx_context::sender(arg3),
            add_time   : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<PaymentTokenAdded>(v2);
    }

    public entry fun add_rewards<T0>(arg0: &mut StakingPool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 2);
        assert_not_paused<T0>(arg0);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 21);
        0x2::balance::join<T0>(&mut arg0.reward_balance, 0x2::coin::into_balance<T0>(arg1));
        arg0.reserved_rewards = safe_add(arg0.reserved_rewards, calculate_reserve(v0));
        arg0.total_rewards_added = safe_add(arg0.total_rewards_added, v0);
    }

    public entry fun add_supported_collection<T0>(arg0: &mut StakingPool<T0>, arg1: 0x1::string::String, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 2);
        assert!(0x1::string::length(&arg1) > 0, 24);
        let (v0, _) = 0x1::vector::index_of<0x1::string::String>(&arg0.supported_collections, &arg1);
        assert!(!v0, 45);
        0x1::vector::push_back<0x1::string::String>(&mut arg0.supported_collections, arg1);
    }

    fun assert_not_paused<T0>(arg0: &StakingPool<T0>) {
        assert!(!arg0.is_paused, 20);
    }

    fun calculate_effective_reward_rate_enhanced(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        if (arg3 == 0) {
            safe_mul_div_precise(safe_mul_div_precise(arg0, arg1, 10000), arg2, 10000)
        } else {
            safe_mul_div_precise(safe_mul_div_precise(safe_mul_div_precise(arg0, arg1, 10000), arg2, 10000), safe_add(10000, arg3), 10000)
        }
    }

    fun calculate_enhanced_slot_rewards(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) : u64 {
        let v0 = if (arg7 > 0 && arg7 < arg2) {
            arg7
        } else {
            arg2
        };
        let v1 = if (arg1 > arg0) {
            arg1
        } else {
            arg0
        };
        if (v1 >= v0) {
            return 0
        };
        let v2 = (safe_sub(v0, v1) as u128) * (calculate_effective_reward_rate_enhanced(arg3, arg4, arg5, arg6) as u128) * 1000000000000 / (86400000 as u128) / 1000000000000;
        if (v2 > (18446744073709551615 as u128)) {
            18446744073709551615
        } else {
            (v2 as u64)
        }
    }

    fun calculate_reserve(arg0: u64) : u64 {
        safe_mul_div_precise(arg0, 20, 100)
    }

    fun calculate_slot_params(arg0: u8) : (u64, u64) {
        let v0 = (arg0 as u64);
        if (v0 <= 10) {
            (v0 * 10000000000, 10000 + (v0 - 1) * 2000)
        } else if (v0 <= 50) {
            (v0 * 20000000000, 30000 + (v0 - 11) * 1000)
        } else {
            (v0 * 50000000000, 70000 + (v0 - 51) * 1000)
        }
    }

    public entry fun claim_slot_rewards<T0: store + key, T1>(arg0: &mut StakingPool<T1>, arg1: &StakeReceipt<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_not_paused<T1>(arg0);
        assert!(arg1.pool_id == 0x2::object::id<StakingPool<T1>>(arg0), 10);
        assert!(arg1.owner == 0x2::tx_context::sender(arg3), 1);
        let v0 = 0x1::type_name::get<T0>();
        assert!(arg1.nft_type == v0, 10);
        let v1 = arg1.nft_id;
        let v2 = arg1.slot_number;
        let v3 = StakeKey{
            nft_id   : v1,
            nft_type : v0,
        };
        assert!(0x2::dynamic_object_field::exists_<StakeKey>(&arg0.id, v3), 3);
        let v4 = 0x2::clock::timestamp_ms(arg2);
        let v5 = 0x2::dynamic_object_field::borrow<StakeKey, StakeInfo<T0, T1>>(&arg0.id, v3);
        assert!(v5.slot_number == v2, 30);
        let v6 = v5.owner;
        let v7 = v5.collection;
        let v8 = safe_add(v5.pending_rewards, calculate_enhanced_slot_rewards(v5.stake_time, v5.last_claim_time, v4, arg0.default_reward_rate, get_slot_config(&arg0.slot_configs, v2).reward_multiplier, get_effective_nft_multiplier<T1>(arg0, v1, &v7), get_wallet_bonus_multiplier<T1>(arg0, v6), arg0.end_time));
        assert!(v8 > 0, 5);
        let v9 = if (0x2::balance::value<T1>(&arg0.reward_balance) > arg0.reserved_rewards) {
            safe_sub(0x2::balance::value<T1>(&arg0.reward_balance), arg0.reserved_rewards)
        } else {
            0
        };
        let v10 = if (v9 >= v8) {
            v8
        } else {
            v9
        };
        assert!(v10 > 0, 16);
        let v11 = 0x2::dynamic_object_field::borrow_mut<StakeKey, StakeInfo<T0, T1>>(&mut arg0.id, v3);
        v11.last_claim_time = v4;
        v11.total_claimed = safe_add(v11.total_claimed, v10);
        if (v10 < v8) {
            v11.pending_rewards = safe_sub(v8, v10);
        } else {
            v11.pending_rewards = 0;
        };
        let v12 = SlotDataKey{
            owner       : v6,
            slot_number : v2,
        };
        let v13 = 0x2::dynamic_object_field::borrow_mut<SlotDataKey, SlotData>(&mut arg0.id, v12);
        v13.last_claim_time = v4;
        v13.total_claimed = safe_add(v13.total_claimed, v10);
        if (v10 < v8) {
            v13.pending_rewards = safe_sub(v8, v10);
        } else {
            v13.pending_rewards = 0;
        };
        let v14 = &mut arg0.reserved_rewards;
        decrease_reserved_rewards(v14, v10);
        arg0.total_rewards_distributed = safe_add(arg0.total_rewards_distributed, v10);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.reward_balance, v10), arg3), v6);
        let v15 = if (v10 < v8) {
            safe_sub(v8, v10)
        } else {
            0
        };
        let v16 = RewardsClaimed{
            pool_id           : 0x2::object::id<StakingPool<T1>>(arg0),
            nft_id            : v1,
            owner             : v6,
            amount            : v10,
            claim_time        : v4,
            reward_token_type : arg0.reward_token_type,
            is_partial_claim  : v10 < v8,
            remaining_pending : v15,
            slot_number       : v2,
        };
        0x2::event::emit<RewardsClaimed>(v16);
    }

    public entry fun create_and_share_enhanced_staking_pool<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: vector<0x1::string::String>, arg6: address, arg7: u8, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<StakingPool<T0>>(create_enhanced_staking_pool<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9));
    }

    fun create_enhanced_slot_configs() : vector<SlotConfig> {
        let v0 = 0x1::vector::empty<SlotConfig>();
        let v1 = 1;
        while (v1 <= 100) {
            let (v2, v3) = calculate_slot_params(v1);
            let v4 = SlotConfig{
                slot_number         : v1,
                unlock_cost         : v2,
                reward_multiplier   : v3,
                allowed_collections : 0x1::vector::empty<0x1::string::String>(),
                is_open_to_all      : true,
            };
            0x1::vector::push_back<SlotConfig>(&mut v0, v4);
            v1 = v1 + 1;
        };
        v0
    }

    public fun create_enhanced_staking_pool<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: vector<0x1::string::String>, arg6: address, arg7: u8, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : StakingPool<T0> {
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = 0x2::object::new(arg9);
        let v2 = 0x2::coin::value<T0>(&arg0);
        let v3 = 0x1::type_name::get<T0>();
        assert!(arg7 >= 1 && arg7 <= 100, 41);
        let v4 = StakingPool<T0>{
            id                        : v1,
            admin                     : v0,
            emergency_admin           : arg6,
            total_staked              : 0,
            reward_balance            : 0x2::coin::into_balance<T0>(arg0),
            reserved_rewards          : calculate_reserve(v2),
            default_reward_rate       : arg1,
            start_time                : arg2,
            end_time                  : arg3,
            is_locked                 : false,
            is_paused                 : false,
            supported_collections     : arg5,
            reward_token_type         : v3,
            min_staking_duration      : arg4,
            total_rewards_distributed : 0,
            total_rewards_added       : v2,
            pool_creation_time        : 0x2::clock::timestamp_ms(arg8),
            slot_configs              : create_enhanced_slot_configs(),
            total_users_with_slots    : 0,
        };
        let v5 = PoolSlotLimits{
            id                             : 0x2::object::new(arg9),
            default_max_slots_per_wallet   : arg7,
            absolute_max_slots             : 100,
            total_users_with_custom_limits : 0,
        };
        let v6 = PoolSlotLimitsKey{dummy_field: false};
        0x2::dynamic_object_field::add<PoolSlotLimitsKey, PoolSlotLimits>(&mut v4.id, v6, v5);
        let v7 = PaymentTokenRegistry{
            id               : 0x2::object::new(arg9),
            supported_tokens : 0x2::table::new<0x1::string::String, bool>(arg9),
            token_list       : 0x1::vector::empty<0x1::string::String>(),
        };
        let v8 = get_token_type_string_sui<0x2::sui::SUI>();
        0x2::table::add<0x1::string::String, bool>(&mut v7.supported_tokens, v8, true);
        0x1::vector::push_back<0x1::string::String>(&mut v7.token_list, v8);
        let v9 = PaymentTokenRegistryKey{dummy_field: false};
        0x2::dynamic_object_field::add<PaymentTokenRegistryKey, PaymentTokenRegistry>(&mut v4.id, v9, v7);
        let v10 = StakingPoolCreated{
            pool_id                      : 0x2::object::uid_to_inner(&v1),
            admin                        : v0,
            emergency_admin              : arg6,
            default_reward_rate          : arg1,
            start_time                   : arg2,
            end_time                     : arg3,
            reward_token_type            : v3,
            min_staking_duration         : arg4,
            initial_reward_amount        : v2,
            slot_configs                 : v4.slot_configs,
            default_max_slots_per_wallet : arg7,
        };
        0x2::event::emit<StakingPoolCreated>(v10);
        v4
    }

    fun decrease_reserved_rewards(arg0: &mut u64, arg1: u64) {
        let v0 = calculate_reserve(arg1);
        if (*arg0 >= v0) {
            *arg0 = safe_sub(*arg0, v0);
        } else {
            *arg0 = safe_sub(*arg0, *arg0 * v0 / calculate_reserve(arg1));
        };
    }

    public fun get_admin<T0>(arg0: &StakingPool<T0>) : address {
        arg0.admin
    }

    public fun get_available_rewards<T0>(arg0: &StakingPool<T0>) : u64 {
        let v0 = 0x2::balance::value<T0>(&arg0.reward_balance);
        if (v0 <= arg0.reserved_rewards) {
            0
        } else {
            safe_sub(v0, arg0.reserved_rewards)
        }
    }

    public fun get_collection_multiplier_info<T0>(arg0: &StakingPool<T0>, arg1: 0x1::string::String) : 0x1::option::Option<CollectionMultiplierInfo> {
        let v0 = CollectionMultiplierKey{collection: arg1};
        if (0x2::dynamic_object_field::exists_<CollectionMultiplierKey>(&arg0.id, v0)) {
            let v2 = 0x2::dynamic_object_field::borrow<CollectionMultiplierKey, CollectionMultiplier>(&arg0.id, v0);
            let v3 = CollectionMultiplierInfo{
                default_multiplier : v2.default_multiplier,
                set_by             : v2.set_by,
                set_time           : v2.set_time,
            };
            0x1::option::some<CollectionMultiplierInfo>(v3)
        } else {
            0x1::option::none<CollectionMultiplierInfo>()
        }
    }

    public fun get_default_reward_rate<T0>(arg0: &StakingPool<T0>) : u64 {
        arg0.default_reward_rate
    }

    fun get_effective_nft_multiplier<T0>(arg0: &StakingPool<T0>, arg1: 0x2::object::ID, arg2: &0x1::string::String) : u64 {
        let v0 = NftMultiplierKey{
            nft_id     : arg1,
            collection : *arg2,
        };
        if (0x2::dynamic_object_field::exists_<NftMultiplierKey>(&arg0.id, v0)) {
            return 0x2::dynamic_object_field::borrow<NftMultiplierKey, NftMultiplier>(&arg0.id, v0).multiplier
        };
        let v1 = CollectionMultiplierKey{collection: *arg2};
        if (0x2::dynamic_object_field::exists_<CollectionMultiplierKey>(&arg0.id, v1)) {
            return 0x2::dynamic_object_field::borrow<CollectionMultiplierKey, CollectionMultiplier>(&arg0.id, v1).default_multiplier
        };
        10000
    }

    public fun get_effective_nft_multiplier_view<T0>(arg0: &StakingPool<T0>, arg1: 0x2::object::ID, arg2: 0x1::string::String) : u64 {
        get_effective_nft_multiplier<T0>(arg0, arg1, &arg2)
    }

    public fun get_enhanced_slot_configs<T0>(arg0: &StakingPool<T0>) : vector<SlotConfig> {
        arg0.slot_configs
    }

    public fun get_nft_multiplier_info<T0>(arg0: &StakingPool<T0>, arg1: 0x2::object::ID, arg2: 0x1::string::String) : 0x1::option::Option<NftMultiplierInfo> {
        let v0 = NftMultiplierKey{
            nft_id     : arg1,
            collection : arg2,
        };
        if (0x2::dynamic_object_field::exists_<NftMultiplierKey>(&arg0.id, v0)) {
            let v2 = 0x2::dynamic_object_field::borrow<NftMultiplierKey, NftMultiplier>(&arg0.id, v0);
            let v3 = NftMultiplierInfo{
                multiplier  : v2.multiplier,
                rarity_tier : v2.rarity_tier,
                set_by      : v2.set_by,
                set_time    : v2.set_time,
            };
            0x1::option::some<NftMultiplierInfo>(v3)
        } else {
            0x1::option::none<NftMultiplierInfo>()
        }
    }

    fun get_or_create_slot_data<T0>(arg0: &mut StakingPool<T0>, arg1: address, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) : &mut SlotData {
        let v0 = SlotDataKey{
            owner       : arg1,
            slot_number : arg2,
        };
        if (!0x2::dynamic_object_field::exists_<SlotDataKey>(&arg0.id, v0)) {
            let v1 = SlotData{
                id                : 0x2::object::new(arg3),
                owner             : arg1,
                slot_number       : arg2,
                staked_nft        : 0x1::option::none<0x2::object::ID>(),
                staked_collection : 0x1::option::none<0x1::string::String>(),
                stake_time        : 0,
                last_claim_time   : 0,
                pending_rewards   : 0,
                total_claimed     : 0,
                is_unlocked       : false,
                nft_type          : 0x1::option::none<0x1::type_name::TypeName>(),
            };
            0x2::dynamic_object_field::add<SlotDataKey, SlotData>(&mut arg0.id, v0, v1);
        };
        0x2::dynamic_object_field::borrow_mut<SlotDataKey, SlotData>(&mut arg0.id, v0)
    }

    public fun get_pool_slot_limits<T0>(arg0: &StakingPool<T0>) : (u8, u8, u64) {
        let v0 = PoolSlotLimitsKey{dummy_field: false};
        if (0x2::dynamic_object_field::exists_<PoolSlotLimitsKey>(&arg0.id, v0)) {
            let v4 = 0x2::dynamic_object_field::borrow<PoolSlotLimitsKey, PoolSlotLimits>(&arg0.id, v0);
            (v4.default_max_slots_per_wallet, v4.absolute_max_slots, v4.total_users_with_custom_limits)
        } else {
            (10, 100, 0)
        }
    }

    public fun get_remaining_rewards<T0>(arg0: &StakingPool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.reward_balance)
    }

    public fun get_slot_allowed_collections<T0>(arg0: &StakingPool<T0>, arg1: u8) : (vector<0x1::string::String>, bool) {
        let v0 = get_slot_config(&arg0.slot_configs, arg1);
        (v0.allowed_collections, v0.is_open_to_all)
    }

    fun get_slot_config(arg0: &vector<SlotConfig>, arg1: u8) : &SlotConfig {
        let v0 = 0;
        while (v0 < 0x1::vector::length<SlotConfig>(arg0)) {
            let v1 = 0x1::vector::borrow<SlotConfig>(arg0, v0);
            if (v1.slot_number == arg1) {
                return v1
            };
            v0 = v0 + 1;
        };
        abort 30
    }

    public fun get_slot_data<T0>(arg0: &StakingPool<T0>, arg1: address, arg2: u8) : 0x1::option::Option<SlotDataInfo> {
        let v0 = SlotDataKey{
            owner       : arg1,
            slot_number : arg2,
        };
        if (0x2::dynamic_object_field::exists_<SlotDataKey>(&arg0.id, v0)) {
            let v2 = 0x2::dynamic_object_field::borrow<SlotDataKey, SlotData>(&arg0.id, v0);
            let v3 = SlotDataInfo{
                owner             : v2.owner,
                slot_number       : v2.slot_number,
                staked_nft        : v2.staked_nft,
                staked_collection : v2.staked_collection,
                stake_time        : v2.stake_time,
                last_claim_time   : v2.last_claim_time,
                pending_rewards   : v2.pending_rewards,
                total_claimed     : v2.total_claimed,
                is_unlocked       : v2.is_unlocked,
            };
            0x1::option::some<SlotDataInfo>(v3)
        } else {
            0x1::option::none<SlotDataInfo>()
        }
    }

    public fun get_slot_effective_rate<T0>(arg0: &StakingPool<T0>, arg1: address, arg2: u8) : u64 {
        let v0 = SlotDataKey{
            owner       : arg1,
            slot_number : arg2,
        };
        if (!0x2::dynamic_object_field::exists_<SlotDataKey>(&arg0.id, v0)) {
            return 0
        };
        let v1 = 0x2::dynamic_object_field::borrow<SlotDataKey, SlotData>(&arg0.id, v0);
        if (0x1::option::is_none<0x2::object::ID>(&v1.staked_nft)) {
            return 0
        };
        let v2 = *0x1::option::borrow<0x1::string::String>(&v1.staked_collection);
        calculate_effective_reward_rate_enhanced(arg0.default_reward_rate, get_slot_config(&arg0.slot_configs, arg2).reward_multiplier, get_effective_nft_multiplier<T0>(arg0, *0x1::option::borrow<0x2::object::ID>(&v1.staked_nft), &v2), get_wallet_bonus_multiplier<T0>(arg0, arg1))
    }

    public fun get_slot_pending_rewards<T0>(arg0: &StakingPool<T0>, arg1: address, arg2: u8, arg3: &0x2::clock::Clock) : u64 {
        let v0 = SlotDataKey{
            owner       : arg1,
            slot_number : arg2,
        };
        if (!0x2::dynamic_object_field::exists_<SlotDataKey>(&arg0.id, v0)) {
            return 0
        };
        let v1 = 0x2::dynamic_object_field::borrow<SlotDataKey, SlotData>(&arg0.id, v0);
        if (0x1::option::is_none<0x2::object::ID>(&v1.staked_nft)) {
            return 0
        };
        let v2 = *0x1::option::borrow<0x1::string::String>(&v1.staked_collection);
        safe_add(v1.pending_rewards, calculate_enhanced_slot_rewards(v1.stake_time, v1.last_claim_time, 0x2::clock::timestamp_ms(arg3), arg0.default_reward_rate, get_slot_config(&arg0.slot_configs, arg2).reward_multiplier, get_effective_nft_multiplier<T0>(arg0, *0x1::option::borrow<0x2::object::ID>(&v1.staked_nft), &v2), get_wallet_bonus_multiplier<T0>(arg0, arg1), arg0.end_time))
    }

    public fun get_slot_pending_rewards_realtime<T0>(arg0: &StakingPool<T0>, arg1: address, arg2: u8, arg3: &0x2::clock::Clock) : u64 {
        get_slot_pending_rewards<T0>(arg0, arg1, arg2, arg3)
    }

    public fun get_slot_price<T0>(arg0: &StakingPool<T0>, arg1: u8) : u64 {
        get_slot_config(&arg0.slot_configs, arg1).unlock_cost
    }

    public fun get_slot_token_price<T0>(arg0: &StakingPool<T0>, arg1: u8, arg2: 0x1::string::String) : u64 {
        let v0 = SlotTokenPricingKey{slot_number: arg1};
        if (0x2::dynamic_object_field::exists_<SlotTokenPricingKey>(&arg0.id, v0)) {
            let v2 = 0x2::dynamic_object_field::borrow<SlotTokenPricingKey, SlotTokenPricing>(&arg0.id, v0);
            if (0x2::table::contains<0x1::string::String, u64>(&v2.token_prices, arg2)) {
                *0x2::table::borrow<0x1::string::String, u64>(&v2.token_prices, arg2)
            } else {
                0
            }
        } else if (arg2 == get_token_type_string_sui<0x2::sui::SUI>()) {
            get_slot_price<T0>(arg0, arg1)
        } else {
            0
        }
    }

    public fun get_supported_collections<T0>(arg0: &StakingPool<T0>) : vector<0x1::string::String> {
        arg0.supported_collections
    }

    public fun get_supported_payment_tokens<T0>(arg0: &StakingPool<T0>) : vector<0x1::string::String> {
        let v0 = PaymentTokenRegistryKey{dummy_field: false};
        if (0x2::dynamic_object_field::exists_<PaymentTokenRegistryKey>(&arg0.id, v0)) {
            0x2::dynamic_object_field::borrow<PaymentTokenRegistryKey, PaymentTokenRegistry>(&arg0.id, v0).token_list
        } else {
            0x1::vector::empty<0x1::string::String>()
        }
    }

    public fun get_token_revenue<T0>(arg0: &StakingPool<T0>, arg1: 0x1::string::String) : u64 {
        let v0 = TokenRevenueKey{token_type: arg1};
        if (0x2::dynamic_object_field::exists_<TokenRevenueKey>(&arg0.id, v0)) {
            0x2::dynamic_object_field::borrow<TokenRevenueKey, TokenRevenue>(&arg0.id, v0).total_collected
        } else {
            0
        }
    }

    fun get_token_type_string_any<T0>() : 0x1::string::String {
        let v0 = 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        if (0x1::vector::length<u8>(&v0) > 0 && *0x1::vector::borrow<u8>(&v0, 0) == 76) {
            *0x1::vector::borrow_mut<u8>(&mut v0, 0) = 48;
            0x1::vector::insert<u8>(&mut v0, 120, 1);
            0x1::string::utf8(v0)
        } else {
            0x1::string::utf8(v0)
        }
    }

    fun get_token_type_string_sui<T0>() : 0x1::string::String {
        0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())))
    }

    public fun get_total_staked<T0>(arg0: &StakingPool<T0>) : u64 {
        arg0.total_staked
    }

    public fun get_user_slot_allocation<T0>(arg0: &StakingPool<T0>, arg1: address) : 0x1::option::Option<UserSlotInfo> {
        let v0 = UserSlotAllocationKey{user: arg1};
        if (0x2::dynamic_object_field::exists_<UserSlotAllocationKey>(&arg0.id, v0)) {
            let v2 = 0x2::dynamic_object_field::borrow<UserSlotAllocationKey, UserSlotAllocation>(&arg0.id, v0);
            let v3 = UserSlotInfo{
                owner                 : v2.owner,
                max_slots_allowed     : v2.max_slots_allowed,
                total_slots_unlocked  : v2.total_slots_unlocked,
                unlocked_slot_numbers : v2.unlocked_slot_numbers,
            };
            0x1::option::some<UserSlotInfo>(v3)
        } else {
            0x1::option::none<UserSlotInfo>()
        }
    }

    public fun get_user_total_claimed_rewards<T0>(arg0: &StakingPool<T0>, arg1: address) : u64 {
        let v0 = UserSlotAllocationKey{user: arg1};
        if (!0x2::dynamic_object_field::exists_<UserSlotAllocationKey>(&arg0.id, v0)) {
            return 0
        };
        let v1 = 0x2::dynamic_object_field::borrow<UserSlotAllocationKey, UserSlotAllocation>(&arg0.id, v0);
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<u8>(&v1.unlocked_slot_numbers)) {
            let v4 = SlotDataKey{
                owner       : arg1,
                slot_number : *0x1::vector::borrow<u8>(&v1.unlocked_slot_numbers, v3),
            };
            if (0x2::dynamic_object_field::exists_<SlotDataKey>(&arg0.id, v4)) {
                v2 = safe_add(v2, 0x2::dynamic_object_field::borrow<SlotDataKey, SlotData>(&arg0.id, v4).total_claimed);
            };
            v3 = v3 + 1;
        };
        v2
    }

    public fun get_user_total_pending_rewards<T0>(arg0: &StakingPool<T0>, arg1: address, arg2: &0x2::clock::Clock) : u64 {
        let v0 = UserSlotAllocationKey{user: arg1};
        if (!0x2::dynamic_object_field::exists_<UserSlotAllocationKey>(&arg0.id, v0)) {
            return 0
        };
        let v1 = 0x2::dynamic_object_field::borrow<UserSlotAllocationKey, UserSlotAllocation>(&arg0.id, v0);
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<u8>(&v1.unlocked_slot_numbers)) {
            let v4 = *0x1::vector::borrow<u8>(&v1.unlocked_slot_numbers, v3);
            if (is_slot_occupied<T0>(arg0, arg1, v4)) {
                v2 = safe_add(v2, get_slot_pending_rewards<T0>(arg0, arg1, v4, arg2));
            };
            v3 = v3 + 1;
        };
        v2
    }

    public fun get_user_wallet_details<T0>(arg0: &StakingPool<T0>, arg1: address, arg2: &0x2::clock::Clock) : UserWalletDetails {
        let v0 = UserSlotAllocationKey{user: arg1};
        if (!0x2::dynamic_object_field::exists_<UserSlotAllocationKey>(&arg0.id, v0)) {
            return UserWalletDetails{
                owner                   : arg1,
                max_slots_allowed       : 0,
                total_slots_unlocked    : 0,
                unlocked_slot_numbers   : 0x1::vector::empty<u8>(),
                wallet_bonus_multiplier : 0,
                wallet_bonus_reason     : 0x1::string::utf8(b""),
                total_pending_rewards   : 0,
                total_claimed_rewards   : 0,
                active_stakes_count     : 0,
                slot_details            : 0x1::vector::empty<UserSlotDetails>(),
            }
        };
        let v1 = 0x2::dynamic_object_field::borrow<UserSlotAllocationKey, UserSlotAllocation>(&arg0.id, v0);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        let v3 = WalletBonusMultiplierKey{wallet: arg1};
        let (v4, v5) = if (0x2::dynamic_object_field::exists_<WalletBonusMultiplierKey>(&arg0.id, v3)) {
            let v6 = 0x2::dynamic_object_field::borrow<WalletBonusMultiplierKey, WalletBonusMultiplier>(&arg0.id, v3);
            (v6.bonus_multiplier, v6.reason)
        } else {
            (0, 0x1::string::utf8(b"No bonus"))
        };
        let v7 = 0x1::vector::empty<UserSlotDetails>();
        let v8 = 0;
        let v9 = 0;
        let v10 = 0;
        let v11 = 0;
        while (v11 < 0x1::vector::length<u8>(&v1.unlocked_slot_numbers)) {
            let v12 = *0x1::vector::borrow<u8>(&v1.unlocked_slot_numbers, v11);
            let v13 = SlotDataKey{
                owner       : arg1,
                slot_number : v12,
            };
            let v14 = get_slot_config(&arg0.slot_configs, v12);
            if (0x2::dynamic_object_field::exists_<SlotDataKey>(&arg0.id, v13)) {
                let v15 = 0x2::dynamic_object_field::borrow<SlotDataKey, SlotData>(&arg0.id, v13);
                let v16 = 0x1::option::is_some<0x2::object::ID>(&v15.staked_nft);
                let (v17, v18, v19, v20) = if (v16) {
                    let v21 = *0x1::option::borrow<0x2::object::ID>(&v15.staked_nft);
                    let v22 = *0x1::option::borrow<0x1::string::String>(&v15.staked_collection);
                    let v23 = arg0.default_reward_rate;
                    let v24 = v14.reward_multiplier;
                    let v25 = get_effective_nft_multiplier<T0>(arg0, v21, &v22);
                    v10 = v10 + 1;
                    (safe_add(v15.pending_rewards, calculate_enhanced_slot_rewards(v15.stake_time, v15.last_claim_time, v2, v23, v24, v25, v4, arg0.end_time)), calculate_effective_reward_rate_enhanced(v23, v24, v25, v4), safe_sub(v2, v15.stake_time), v25)
                } else {
                    (0, 0, 0, 10000)
                };
                v8 = safe_add(v8, v17);
                v9 = safe_add(v9, v15.total_claimed);
                let v26 = UserSlotDetails{
                    slot_number         : v12,
                    is_unlocked         : v15.is_unlocked,
                    is_occupied         : v16,
                    staked_nft          : v15.staked_nft,
                    staked_collection   : v15.staked_collection,
                    stake_time          : v15.stake_time,
                    last_claim_time     : v15.last_claim_time,
                    pending_rewards     : v17,
                    total_claimed       : v15.total_claimed,
                    effective_rate      : v18,
                    stake_duration      : v19,
                    slot_multiplier     : v14.reward_multiplier,
                    nft_multiplier      : v20,
                    allowed_collections : v14.allowed_collections,
                    is_open_to_all      : v14.is_open_to_all,
                    unlock_cost         : v14.unlock_cost,
                };
                0x1::vector::push_back<UserSlotDetails>(&mut v7, v26);
            } else {
                let v27 = UserSlotDetails{
                    slot_number         : v12,
                    is_unlocked         : false,
                    is_occupied         : false,
                    staked_nft          : 0x1::option::none<0x2::object::ID>(),
                    staked_collection   : 0x1::option::none<0x1::string::String>(),
                    stake_time          : 0,
                    last_claim_time     : 0,
                    pending_rewards     : 0,
                    total_claimed       : 0,
                    effective_rate      : 0,
                    stake_duration      : 0,
                    slot_multiplier     : v14.reward_multiplier,
                    nft_multiplier      : 10000,
                    allowed_collections : v14.allowed_collections,
                    is_open_to_all      : v14.is_open_to_all,
                    unlock_cost         : v14.unlock_cost,
                };
                0x1::vector::push_back<UserSlotDetails>(&mut v7, v27);
            };
            v11 = v11 + 1;
        };
        UserWalletDetails{
            owner                   : arg1,
            max_slots_allowed       : v1.max_slots_allowed,
            total_slots_unlocked    : v1.total_slots_unlocked,
            unlocked_slot_numbers   : v1.unlocked_slot_numbers,
            wallet_bonus_multiplier : v4,
            wallet_bonus_reason     : v5,
            total_pending_rewards   : v8,
            total_claimed_rewards   : v9,
            active_stakes_count     : v10,
            slot_details            : v7,
        }
    }

    fun get_wallet_bonus_multiplier<T0>(arg0: &StakingPool<T0>, arg1: address) : u64 {
        let v0 = WalletBonusMultiplierKey{wallet: arg1};
        if (0x2::dynamic_object_field::exists_<WalletBonusMultiplierKey>(&arg0.id, v0)) {
            0x2::dynamic_object_field::borrow<WalletBonusMultiplierKey, WalletBonusMultiplier>(&arg0.id, v0).bonus_multiplier
        } else {
            0
        }
    }

    public fun get_wallet_bonus_multiplier_info<T0>(arg0: &StakingPool<T0>, arg1: address) : 0x1::option::Option<WalletBonusMultiplierInfo> {
        let v0 = WalletBonusMultiplierKey{wallet: arg1};
        if (0x2::dynamic_object_field::exists_<WalletBonusMultiplierKey>(&arg0.id, v0)) {
            let v2 = 0x2::dynamic_object_field::borrow<WalletBonusMultiplierKey, WalletBonusMultiplier>(&arg0.id, v0);
            let v3 = WalletBonusMultiplierInfo{
                bonus_multiplier : v2.bonus_multiplier,
                set_by           : v2.set_by,
                set_time         : v2.set_time,
                reason           : v2.reason,
            };
            0x1::option::some<WalletBonusMultiplierInfo>(v3)
        } else {
            0x1::option::none<WalletBonusMultiplierInfo>()
        }
    }

    public fun get_wallet_bonus_multiplier_view<T0>(arg0: &StakingPool<T0>, arg1: address) : u64 {
        get_wallet_bonus_multiplier<T0>(arg0, arg1)
    }

    public fun has_wallet_bonus_multiplier<T0>(arg0: &StakingPool<T0>, arg1: address) : bool {
        let v0 = WalletBonusMultiplierKey{wallet: arg1};
        0x2::dynamic_object_field::exists_<WalletBonusMultiplierKey>(&arg0.id, v0)
    }

    public entry fun increase_user_slot_limit<T0>(arg0: &mut StakingPool<T0>, arg1: address, arg2: u8, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 2);
        assert_not_paused<T0>(arg0);
        assert!(arg2 >= 1 && arg2 <= 100, 41);
        let v0 = UserSlotAllocationKey{user: arg1};
        let v1 = PoolSlotLimitsKey{dummy_field: false};
        if (!0x2::dynamic_object_field::exists_<UserSlotAllocationKey>(&arg0.id, v0)) {
            let v2 = UserSlotAllocation{
                id                    : 0x2::object::new(arg4),
                owner                 : arg1,
                max_slots_allowed     : arg2,
                total_slots_unlocked  : 0,
                unlocked_slot_numbers : 0x1::vector::empty<u8>(),
            };
            0x2::dynamic_object_field::add<UserSlotAllocationKey, UserSlotAllocation>(&mut arg0.id, v0, v2);
            arg0.total_users_with_slots = safe_add(arg0.total_users_with_slots, 1);
            if (arg2 != 0x2::dynamic_object_field::borrow<PoolSlotLimitsKey, PoolSlotLimits>(&arg0.id, v1).default_max_slots_per_wallet) {
                let v3 = 0x2::dynamic_object_field::borrow_mut<PoolSlotLimitsKey, PoolSlotLimits>(&mut arg0.id, v1);
                v3.total_users_with_custom_limits = safe_add(v3.total_users_with_custom_limits, 1);
            };
        } else {
            let v4 = 0x2::dynamic_object_field::borrow_mut<UserSlotAllocationKey, UserSlotAllocation>(&mut arg0.id, v0);
            let v5 = v4.max_slots_allowed;
            assert!(arg2 > v5, 41);
            v4.max_slots_allowed = arg2;
            let v6 = UserSlotLimitIncreased{
                pool_id       : 0x2::object::id<StakingPool<T0>>(arg0),
                user          : arg1,
                old_limit     : v5,
                new_limit     : arg2,
                increased_by  : 0x2::tx_context::sender(arg4),
                increase_time : 0x2::clock::timestamp_ms(arg3),
            };
            0x2::event::emit<UserSlotLimitIncreased>(v6);
        };
    }

    fun is_collection_allowed_in_slot(arg0: &SlotConfig, arg1: &0x1::string::String) : bool {
        if (arg0.is_open_to_all) {
            return true
        };
        0x1::vector::contains<0x1::string::String>(&arg0.allowed_collections, arg1)
    }

    public fun is_collection_allowed_in_slot_view<T0>(arg0: &StakingPool<T0>, arg1: u8, arg2: 0x1::string::String) : bool {
        is_collection_allowed_in_slot(get_slot_config(&arg0.slot_configs, arg1), &arg2)
    }

    public fun is_paused<T0>(arg0: &StakingPool<T0>) : bool {
        arg0.is_paused
    }

    public fun is_payment_token_supported<T0>(arg0: &StakingPool<T0>, arg1: 0x1::string::String) : bool {
        let v0 = PaymentTokenRegistryKey{dummy_field: false};
        0x2::dynamic_object_field::exists_<PaymentTokenRegistryKey>(&arg0.id, v0) && 0x2::table::contains<0x1::string::String, bool>(&0x2::dynamic_object_field::borrow<PaymentTokenRegistryKey, PaymentTokenRegistry>(&arg0.id, v0).supported_tokens, arg1)
    }

    public fun is_slot_free<T0>(arg0: &StakingPool<T0>, arg1: u8) : bool {
        get_slot_price<T0>(arg0, arg1) == 0
    }

    fun is_slot_occupied<T0>(arg0: &StakingPool<T0>, arg1: address, arg2: u8) : bool {
        let v0 = SlotDataKey{
            owner       : arg1,
            slot_number : arg2,
        };
        0x2::dynamic_object_field::exists_<SlotDataKey>(&arg0.id, v0) && 0x1::option::is_some<0x2::object::ID>(&0x2::dynamic_object_field::borrow<SlotDataKey, SlotData>(&arg0.id, v0).staked_nft)
    }

    fun is_slot_unlocked<T0>(arg0: &StakingPool<T0>, arg1: address, arg2: u8) : bool {
        let v0 = SlotDataKey{
            owner       : arg1,
            slot_number : arg2,
        };
        0x2::dynamic_object_field::exists_<SlotDataKey>(&arg0.id, v0) && 0x2::dynamic_object_field::borrow<SlotDataKey, SlotData>(&arg0.id, v0).is_unlocked
    }

    fun is_sui_token<T0>() : bool {
        0x1::type_name::into_string(0x1::type_name::get<T0>()) == 0x1::ascii::string(b"0000000000000000000000000000000000000000000000000000000000000002::sui::SUI")
    }

    public entry fun remove_collection_from_slot<T0>(arg0: &mut StakingPool<T0>, arg1: u8, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 2);
        assert_not_paused<T0>(arg0);
        assert!(arg1 >= 1 && arg1 <= 100, 30);
        let v0 = 0;
        let v1 = false;
        while (v0 < 0x1::vector::length<SlotConfig>(&arg0.slot_configs)) {
            let v2 = 0x1::vector::borrow_mut<SlotConfig>(&mut arg0.slot_configs, v0);
            if (v2.slot_number == arg1) {
                let (v3, v4) = 0x1::vector::index_of<0x1::string::String>(&v2.allowed_collections, &arg2);
                if (v3) {
                    0x1::vector::remove<0x1::string::String>(&mut v2.allowed_collections, v4);
                };
                v1 = true;
                let v5 = SlotCollectionsUpdated{
                    pool_id         : 0x2::object::id<StakingPool<T0>>(arg0),
                    slot_number     : arg1,
                    old_collections : v2.allowed_collections,
                    new_collections : v2.allowed_collections,
                    is_open_to_all  : v2.is_open_to_all,
                    updated_by      : 0x2::tx_context::sender(arg4),
                    update_time     : 0x2::clock::timestamp_ms(arg3),
                };
                0x2::event::emit<SlotCollectionsUpdated>(v5);
                break
            };
            v0 = v0 + 1;
        };
        assert!(v1, 30);
    }

    public entry fun remove_payment_token<T0>(arg0: &mut StakingPool<T0>, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 2);
        assert_not_paused<T0>(arg0);
        assert!(0x1::string::length(&arg1) > 0, 21);
        let v0 = PaymentTokenRegistryKey{dummy_field: false};
        let v1 = 0x2::dynamic_object_field::borrow_mut<PaymentTokenRegistryKey, PaymentTokenRegistry>(&mut arg0.id, v0);
        assert!(0x2::table::contains<0x1::string::String, bool>(&v1.supported_tokens, arg1), 35);
        0x2::table::remove<0x1::string::String, bool>(&mut v1.supported_tokens, arg1);
        let (v2, v3) = 0x1::vector::index_of<0x1::string::String>(&v1.token_list, &arg1);
        if (v2) {
            0x1::vector::remove<0x1::string::String>(&mut v1.token_list, v3);
        };
        let v4 = PaymentTokenRemoved{
            pool_id     : 0x2::object::id<StakingPool<T0>>(arg0),
            token_type  : arg1,
            removed_by  : 0x2::tx_context::sender(arg3),
            remove_time : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<PaymentTokenRemoved>(v4);
    }

    public entry fun remove_wallet_bonus_multiplier<T0>(arg0: &mut StakingPool<T0>, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 2);
        assert_not_paused<T0>(arg0);
        let v0 = WalletBonusMultiplierKey{wallet: arg1};
        assert!(0x2::dynamic_object_field::exists_<WalletBonusMultiplierKey>(&arg0.id, v0), 42);
        let WalletBonusMultiplier {
            id               : v1,
            wallet           : _,
            bonus_multiplier : v3,
            set_by           : _,
            set_time         : _,
            reason           : _,
        } = 0x2::dynamic_object_field::remove<WalletBonusMultiplierKey, WalletBonusMultiplier>(&mut arg0.id, v0);
        0x2::object::delete(v1);
        let v7 = WalletBonusMultiplierSet{
            pool_id              : 0x2::object::id<StakingPool<T0>>(arg0),
            wallet               : arg1,
            old_bonus_multiplier : v3,
            new_bonus_multiplier : 0,
            reason               : 0x1::string::utf8(b"Removed"),
            set_by               : 0x2::tx_context::sender(arg3),
            set_time             : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<WalletBonusMultiplierSet>(v7);
    }

    fun safe_add(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u128) + (arg1 as u128);
        assert!(v0 <= (18446744073709551615 as u128), 22);
        (v0 as u64)
    }

    fun safe_mul_div_precise(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        if (arg2 == 0) {
            abort 22
        };
        let v0 = (arg0 as u128);
        let v1 = (arg1 as u128);
        assert!(v0 <= 340282366920938463463374607431768211455 / v1, 22);
        let v2 = v0 * v1 / (arg2 as u128);
        assert!(v2 <= (18446744073709551615 as u128), 22);
        (v2 as u64)
    }

    fun safe_sub(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 >= arg1, 22);
        arg0 - arg1
    }

    public entry fun set_collection_multiplier<T0>(arg0: &mut StakingPool<T0>, arg1: 0x1::string::String, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 2);
        assert_not_paused<T0>(arg0);
        assert!(arg2 >= 1000 && arg2 <= 1000000, 37);
        assert!(0x1::string::length(&arg1) > 0, 24);
        let (v0, _) = 0x1::vector::index_of<0x1::string::String>(&arg0.supported_collections, &arg1);
        assert!(v0, 9);
        let v2 = CollectionMultiplierKey{collection: arg1};
        let v3 = 0x2::clock::timestamp_ms(arg3);
        let v4 = if (0x2::dynamic_object_field::exists_<CollectionMultiplierKey>(&arg0.id, v2)) {
            0x2::dynamic_object_field::borrow<CollectionMultiplierKey, CollectionMultiplier>(&arg0.id, v2).default_multiplier
        } else {
            10000
        };
        if (0x2::dynamic_object_field::exists_<CollectionMultiplierKey>(&arg0.id, v2)) {
            let v5 = 0x2::dynamic_object_field::borrow_mut<CollectionMultiplierKey, CollectionMultiplier>(&mut arg0.id, v2);
            v5.default_multiplier = arg2;
            v5.set_by = 0x2::tx_context::sender(arg4);
            v5.set_time = v3;
        } else {
            let v6 = CollectionMultiplier{
                id                 : 0x2::object::new(arg4),
                collection         : arg1,
                default_multiplier : arg2,
                set_by             : 0x2::tx_context::sender(arg4),
                set_time           : v3,
            };
            0x2::dynamic_object_field::add<CollectionMultiplierKey, CollectionMultiplier>(&mut arg0.id, v2, v6);
        };
        let v7 = CollectionMultiplierSet{
            pool_id        : 0x2::object::id<StakingPool<T0>>(arg0),
            collection     : arg1,
            old_multiplier : v4,
            new_multiplier : arg2,
            set_by         : 0x2::tx_context::sender(arg4),
            set_time       : v3,
        };
        0x2::event::emit<CollectionMultiplierSet>(v7);
    }

    public entry fun set_nft_multiplier<T0>(arg0: &mut StakingPool<T0>, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: u64, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == arg0.admin, 2);
        assert_not_paused<T0>(arg0);
        assert!(arg3 >= 1000 && arg3 <= 1000000, 37);
        assert!(0x1::string::length(&arg2) > 0, 24);
        assert!(0x1::string::length(&arg4) > 0, 21);
        let (v0, _) = 0x1::vector::index_of<0x1::string::String>(&arg0.supported_collections, &arg2);
        assert!(v0, 9);
        let v2 = NftMultiplierKey{
            nft_id     : arg1,
            collection : arg2,
        };
        let v3 = 0x2::clock::timestamp_ms(arg5);
        let v4 = if (0x2::dynamic_object_field::exists_<NftMultiplierKey>(&arg0.id, v2)) {
            0x2::dynamic_object_field::borrow<NftMultiplierKey, NftMultiplier>(&arg0.id, v2).multiplier
        } else {
            10000
        };
        if (0x2::dynamic_object_field::exists_<NftMultiplierKey>(&arg0.id, v2)) {
            let v5 = 0x2::dynamic_object_field::borrow_mut<NftMultiplierKey, NftMultiplier>(&mut arg0.id, v2);
            v5.multiplier = arg3;
            v5.rarity_tier = arg4;
            v5.set_by = 0x2::tx_context::sender(arg6);
            v5.set_time = v3;
        } else {
            let v6 = NftMultiplier{
                id          : 0x2::object::new(arg6),
                nft_id      : arg1,
                collection  : arg2,
                multiplier  : arg3,
                rarity_tier : arg4,
                set_by      : 0x2::tx_context::sender(arg6),
                set_time    : v3,
            };
            0x2::dynamic_object_field::add<NftMultiplierKey, NftMultiplier>(&mut arg0.id, v2, v6);
        };
        let v7 = NftMultiplierSet{
            pool_id        : 0x2::object::id<StakingPool<T0>>(arg0),
            nft_id         : arg1,
            collection     : arg2,
            old_multiplier : v4,
            new_multiplier : arg3,
            rarity_tier    : arg4,
            set_by         : 0x2::tx_context::sender(arg6),
            set_time       : v3,
        };
        0x2::event::emit<NftMultiplierSet>(v7);
    }

    public entry fun set_promotional_pricing<T0>(arg0: &mut StakingPool<T0>, arg1: u8, arg2: u8, arg3: u64, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == arg0.admin, 2);
        assert_not_paused<T0>(arg0);
        assert!(arg1 >= 1 && arg2 <= 100, 30);
        assert!(arg1 <= arg2, 21);
        while (arg1 <= arg2) {
            update_slot_price<T0>(arg0, arg1, arg4, arg3, arg5, arg6);
            arg1 = arg1 + 1;
        };
    }

    public entry fun set_slot_allowed_collections<T0>(arg0: &mut StakingPool<T0>, arg1: u8, arg2: vector<0x1::string::String>, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.admin, 2);
        assert_not_paused<T0>(arg0);
        assert!(arg1 >= 1 && arg1 <= 100, 30);
        let v0 = 0;
        let v1 = false;
        while (v0 < 0x1::vector::length<SlotConfig>(&arg0.slot_configs)) {
            let v2 = 0x1::vector::borrow_mut<SlotConfig>(&mut arg0.slot_configs, v0);
            if (v2.slot_number == arg1) {
                v2.allowed_collections = arg2;
                v2.is_open_to_all = arg3;
                v1 = true;
                let v3 = SlotCollectionsUpdated{
                    pool_id         : 0x2::object::id<StakingPool<T0>>(arg0),
                    slot_number     : arg1,
                    old_collections : v2.allowed_collections,
                    new_collections : v2.allowed_collections,
                    is_open_to_all  : arg3,
                    updated_by      : 0x2::tx_context::sender(arg5),
                    update_time     : 0x2::clock::timestamp_ms(arg4),
                };
                0x2::event::emit<SlotCollectionsUpdated>(v3);
                break
            };
            v0 = v0 + 1;
        };
        assert!(v1, 30);
    }

    public entry fun set_wallet_bonus_multiplier<T0>(arg0: &mut StakingPool<T0>, arg1: address, arg2: u64, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.admin, 2);
        assert_not_paused<T0>(arg0);
        assert!(arg2 <= 1000000, 37);
        assert!(0x1::string::length(&arg3) > 0, 21);
        let v0 = WalletBonusMultiplierKey{wallet: arg1};
        let v1 = 0x2::clock::timestamp_ms(arg4);
        let v2 = if (0x2::dynamic_object_field::exists_<WalletBonusMultiplierKey>(&arg0.id, v0)) {
            0x2::dynamic_object_field::borrow<WalletBonusMultiplierKey, WalletBonusMultiplier>(&arg0.id, v0).bonus_multiplier
        } else {
            0
        };
        if (0x2::dynamic_object_field::exists_<WalletBonusMultiplierKey>(&arg0.id, v0)) {
            let v3 = 0x2::dynamic_object_field::borrow_mut<WalletBonusMultiplierKey, WalletBonusMultiplier>(&mut arg0.id, v0);
            v3.bonus_multiplier = arg2;
            v3.reason = arg3;
            v3.set_by = 0x2::tx_context::sender(arg5);
            v3.set_time = v1;
        } else {
            let v4 = WalletBonusMultiplier{
                id               : 0x2::object::new(arg5),
                wallet           : arg1,
                bonus_multiplier : arg2,
                set_by           : 0x2::tx_context::sender(arg5),
                set_time         : v1,
                reason           : arg3,
            };
            0x2::dynamic_object_field::add<WalletBonusMultiplierKey, WalletBonusMultiplier>(&mut arg0.id, v0, v4);
        };
        let v5 = WalletBonusMultiplierSet{
            pool_id              : 0x2::object::id<StakingPool<T0>>(arg0),
            wallet               : arg1,
            old_bonus_multiplier : v2,
            new_bonus_multiplier : arg2,
            reason               : arg3,
            set_by               : 0x2::tx_context::sender(arg5),
            set_time             : v1,
        };
        0x2::event::emit<WalletBonusMultiplierSet>(v5);
    }

    public entry fun stake_nft_in_slot<T0: store + key, T1>(arg0: &mut StakingPool<T1>, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: 0x1::string::String, arg5: u8, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert_not_paused<T1>(arg0);
        assert!(!arg0.is_locked, 6);
        assert!(0x1::string::length(&arg4) > 0, 24);
        assert!(arg5 >= 1 && arg5 <= 100, 30);
        let v0 = 0x2::clock::timestamp_ms(arg6);
        assert!(v0 >= arg0.start_time, 8);
        if (arg0.end_time > 0) {
            assert!(v0 < arg0.end_time, 11);
        };
        let v1 = 0x2::tx_context::sender(arg7);
        let v2 = get_slot_config(&arg0.slot_configs, arg5);
        assert!(is_collection_allowed_in_slot(v2, &arg4), 9);
        let v3 = 0x1::type_name::get<T0>();
        let v4 = StakeKey{
            nft_id   : arg3,
            nft_type : v3,
        };
        assert!(!0x2::dynamic_object_field::exists_<StakeKey>(&arg0.id, v4), 13);
        assert!(is_slot_unlocked<T1>(arg0, v1, arg5), 28);
        assert!(!is_slot_occupied<T1>(arg0, v1, arg5), 29);
        let v5 = 0x2::object::id<StakingPool<T1>>(arg0);
        let v6 = 0x2::object::id<0x2::kiosk::Kiosk>(arg1);
        let v7 = arg0.default_reward_rate;
        let v8 = v2.reward_multiplier;
        let v9 = get_effective_nft_multiplier<T1>(arg0, arg3, &arg4);
        let v10 = get_wallet_bonus_multiplier<T1>(arg0, v1);
        let v11 = get_or_create_slot_data<T1>(arg0, v1, arg5, arg7);
        v11.staked_nft = 0x1::option::some<0x2::object::ID>(arg3);
        v11.staked_collection = 0x1::option::some<0x1::string::String>(arg4);
        v11.stake_time = v0;
        v11.last_claim_time = v0;
        v11.nft_type = 0x1::option::some<0x1::type_name::TypeName>(v3);
        v11.pending_rewards = 0;
        let v12 = StakeInfo<T0, T1>{
            id              : 0x2::object::new(arg7),
            nft_id          : arg3,
            owner           : v1,
            kiosk_id        : v6,
            collection      : arg4,
            purchase_cap    : 0x2::kiosk::list_with_purchase_cap<T0>(arg1, arg2, arg3, 1000000000000, arg7),
            stake_time      : v0,
            last_claim_time : v0,
            pending_rewards : 0,
            nft_type        : v3,
            total_claimed   : 0,
            slot_number     : arg5,
        };
        0x2::dynamic_object_field::add<StakeKey, StakeInfo<T0, T1>>(&mut arg0.id, v4, v12);
        let v13 = StakeReceipt<T0, T1>{
            id          : 0x2::object::new(arg7),
            pool_id     : v5,
            nft_id      : arg3,
            kiosk_id    : v6,
            owner       : v1,
            stake_time  : v0,
            nft_type    : v3,
            slot_number : arg5,
        };
        0x2::transfer::transfer<StakeReceipt<T0, T1>>(v13, v1);
        arg0.total_staked = safe_add(arg0.total_staked, 1);
        let v14 = NftStaked{
            pool_id                 : v5,
            nft_id                  : arg3,
            kiosk_id                : v6,
            owner                   : v1,
            collection              : arg4,
            stake_time              : v0,
            nft_type                : v3,
            slot_number             : arg5,
            base_reward_rate        : v7,
            slot_multiplier         : v8,
            nft_multiplier          : v9,
            wallet_bonus_multiplier : v10,
            effective_reward_rate   : calculate_effective_reward_rate_enhanced(v7, v8, v9, v10),
        };
        0x2::event::emit<NftStaked>(v14);
    }

    public entry fun toggle_pause<T0>(arg0: &mut StakingPool<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.admin || v0 == arg0.emergency_admin, 2);
        arg0.is_paused = !arg0.is_paused;
    }

    public entry fun unlock_slot<T0>(arg0: &mut StakingPool<T0>, arg1: u8, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_not_paused<T0>(arg0);
        assert!(arg1 >= 1 && arg1 <= 100, 30);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        let v2 = get_slot_config(&arg0.slot_configs, arg1);
        let v3 = v2.unlock_cost;
        let v4 = v2.is_open_to_all;
        if (v3 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, v0);
        } else {
            assert!(v1 >= v3, 31);
            let v5 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
            if (v1 > v3) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v5, safe_sub(v1, v3)), arg4), v0);
            };
            let v6 = get_token_type_string_sui<0x2::sui::SUI>();
            let v7 = TokenRevenueKey{token_type: v6};
            if (!0x2::dynamic_object_field::exists_<TokenRevenueKey>(&arg0.id, v7)) {
                let v8 = TokenRevenue{
                    id              : 0x2::object::new(arg4),
                    token_type      : v6,
                    total_collected : 0,
                    sui_balance     : 0x2::balance::zero<0x2::sui::SUI>(),
                };
                0x2::dynamic_object_field::add<TokenRevenueKey, TokenRevenue>(&mut arg0.id, v7, v8);
            };
            let v9 = 0x2::dynamic_object_field::borrow_mut<TokenRevenueKey, TokenRevenue>(&mut arg0.id, v7);
            0x2::balance::join<0x2::sui::SUI>(&mut v9.sui_balance, v5);
            v9.total_collected = safe_add(v9.total_collected, v3);
        };
        let v10 = UserSlotAllocationKey{user: v0};
        let v11 = PoolSlotLimitsKey{dummy_field: false};
        if (!0x2::dynamic_object_field::exists_<UserSlotAllocationKey>(&arg0.id, v10)) {
            let v12 = UserSlotAllocation{
                id                    : 0x2::object::new(arg4),
                owner                 : v0,
                max_slots_allowed     : 0x2::dynamic_object_field::borrow<PoolSlotLimitsKey, PoolSlotLimits>(&arg0.id, v11).default_max_slots_per_wallet,
                total_slots_unlocked  : 0,
                unlocked_slot_numbers : 0x1::vector::empty<u8>(),
            };
            0x2::dynamic_object_field::add<UserSlotAllocationKey, UserSlotAllocation>(&mut arg0.id, v10, v12);
            arg0.total_users_with_slots = safe_add(arg0.total_users_with_slots, 1);
        };
        assert!(!is_slot_unlocked<T0>(arg0, v0, arg1), 33);
        let v13 = 0x2::dynamic_object_field::borrow_mut<UserSlotAllocationKey, UserSlotAllocation>(&mut arg0.id, v10);
        assert!(arg1 <= v13.max_slots_allowed, 40);
        assert!(v13.total_slots_unlocked < v13.max_slots_allowed, 32);
        0x1::vector::push_back<u8>(&mut v13.unlocked_slot_numbers, arg1);
        v13.total_slots_unlocked = v13.total_slots_unlocked + 1;
        let v14 = get_or_create_slot_data<T0>(arg0, v0, arg1, arg4);
        v14.is_unlocked = true;
        let v15 = SlotUnlocked{
            pool_id             : 0x2::object::id<StakingPool<T0>>(arg0),
            user                : v0,
            slot_number         : arg1,
            unlock_cost         : v3,
            allowed_collections : v2.allowed_collections,
            is_open_to_all      : v4,
            unlock_time         : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<SlotUnlocked>(v15);
    }

    public entry fun unlock_slot_with_token<T0, T1>(arg0: &mut StakingPool<T1>, arg1: u8, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_not_paused<T1>(arg0);
        assert!(arg1 >= 1 && arg1 <= 100, 30);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = get_token_type_string_any<T0>();
        let v2 = PaymentTokenRegistryKey{dummy_field: false};
        assert!(0x2::table::contains<0x1::string::String, bool>(&0x2::dynamic_object_field::borrow<PaymentTokenRegistryKey, PaymentTokenRegistry>(&arg0.id, v2).supported_tokens, v1), 35);
        let v3 = SlotTokenPricingKey{slot_number: arg1};
        let v4 = if (0x2::dynamic_object_field::exists_<SlotTokenPricingKey>(&arg0.id, v3)) {
            let v5 = 0x2::dynamic_object_field::borrow<SlotTokenPricingKey, SlotTokenPricing>(&arg0.id, v3);
            if (0x2::table::contains<0x1::string::String, u64>(&v5.token_prices, v1)) {
                *0x2::table::borrow<0x1::string::String, u64>(&v5.token_prices, v1)
            } else {
                0
            }
        } else {
            0
        };
        if (v4 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, v0);
        } else {
            assert!(0x2::coin::value<T0>(&arg2) == v4, 31);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, arg0.admin);
            let v6 = TokenRevenueKey{token_type: v1};
            if (!0x2::dynamic_object_field::exists_<TokenRevenueKey>(&arg0.id, v6)) {
                let v7 = TokenRevenue{
                    id              : 0x2::object::new(arg4),
                    token_type      : v1,
                    total_collected : 0,
                    sui_balance     : 0x2::balance::zero<0x2::sui::SUI>(),
                };
                0x2::dynamic_object_field::add<TokenRevenueKey, TokenRevenue>(&mut arg0.id, v6, v7);
            };
            let v8 = 0x2::dynamic_object_field::borrow_mut<TokenRevenueKey, TokenRevenue>(&mut arg0.id, v6);
            v8.total_collected = safe_add(v8.total_collected, v4);
        };
        let v9 = UserSlotAllocationKey{user: v0};
        let v10 = PoolSlotLimitsKey{dummy_field: false};
        if (!0x2::dynamic_object_field::exists_<UserSlotAllocationKey>(&arg0.id, v9)) {
            let v11 = UserSlotAllocation{
                id                    : 0x2::object::new(arg4),
                owner                 : v0,
                max_slots_allowed     : 0x2::dynamic_object_field::borrow<PoolSlotLimitsKey, PoolSlotLimits>(&arg0.id, v10).default_max_slots_per_wallet,
                total_slots_unlocked  : 0,
                unlocked_slot_numbers : 0x1::vector::empty<u8>(),
            };
            0x2::dynamic_object_field::add<UserSlotAllocationKey, UserSlotAllocation>(&mut arg0.id, v9, v11);
            arg0.total_users_with_slots = safe_add(arg0.total_users_with_slots, 1);
        };
        assert!(!is_slot_unlocked<T1>(arg0, v0, arg1), 33);
        let v12 = 0x2::dynamic_object_field::borrow_mut<UserSlotAllocationKey, UserSlotAllocation>(&mut arg0.id, v9);
        assert!(arg1 <= v12.max_slots_allowed, 40);
        assert!(v12.total_slots_unlocked < v12.max_slots_allowed, 32);
        0x1::vector::push_back<u8>(&mut v12.unlocked_slot_numbers, arg1);
        v12.total_slots_unlocked = v12.total_slots_unlocked + 1;
        let v13 = v12.total_slots_unlocked;
        let v14 = get_or_create_slot_data<T1>(arg0, v0, arg1, arg4);
        v14.is_unlocked = true;
        let v15 = SlotUnlockedWithToken{
            pool_id              : 0x2::object::id<StakingPool<T1>>(arg0),
            user                 : v0,
            slot_number          : arg1,
            token_type           : v1,
            payment_amount       : v4,
            unlock_time          : 0x2::clock::timestamp_ms(arg3),
            total_slots_unlocked : v13,
        };
        0x2::event::emit<SlotUnlockedWithToken>(v15);
    }

    public entry fun unstake_nft<T0: store + key, T1>(arg0: &mut StakingPool<T1>, arg1: &mut 0x2::kiosk::Kiosk, arg2: StakeReceipt<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_not_paused<T1>(arg0);
        assert!(arg2.pool_id == 0x2::object::id<StakingPool<T1>>(arg0), 10);
        assert!(arg2.owner == 0x2::tx_context::sender(arg4), 1);
        let v0 = 0x1::type_name::get<T0>();
        assert!(arg2.nft_type == v0, 10);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = arg2.nft_id;
        let v3 = arg2.slot_number;
        let v4 = StakeKey{
            nft_id   : v2,
            nft_type : v0,
        };
        assert!(0x2::dynamic_object_field::exists_<StakeKey>(&arg0.id, v4), 3);
        let StakeInfo {
            id              : v5,
            nft_id          : _,
            owner           : v7,
            kiosk_id        : v8,
            collection      : _,
            purchase_cap    : v10,
            stake_time      : v11,
            last_claim_time : _,
            pending_rewards : _,
            nft_type        : _,
            total_claimed   : v15,
            slot_number     : _,
        } = 0x2::dynamic_object_field::remove<StakeKey, StakeInfo<T0, T1>>(&mut arg0.id, v4);
        assert!(v8 == 0x2::object::id<0x2::kiosk::Kiosk>(arg1), 14);
        assert!(v1 >= safe_add(v11, arg0.min_staking_duration), 12);
        0x2::kiosk::return_purchase_cap<T0>(arg1, v10);
        let v17 = SlotDataKey{
            owner       : v7,
            slot_number : v3,
        };
        let v18 = 0x2::dynamic_object_field::borrow_mut<SlotDataKey, SlotData>(&mut arg0.id, v17);
        v18.staked_nft = 0x1::option::none<0x2::object::ID>();
        v18.staked_collection = 0x1::option::none<0x1::string::String>();
        v18.stake_time = 0;
        v18.last_claim_time = 0;
        v18.pending_rewards = 0;
        v18.nft_type = 0x1::option::none<0x1::type_name::TypeName>();
        0x2::object::delete(v5);
        let StakeReceipt {
            id          : v19,
            pool_id     : _,
            nft_id      : _,
            kiosk_id    : _,
            owner       : _,
            stake_time  : _,
            nft_type    : _,
            slot_number : _,
        } = arg2;
        0x2::object::delete(v19);
        arg0.total_staked = safe_sub(arg0.total_staked, 1);
        let v27 = NftUnstaked{
            pool_id              : 0x2::object::id<StakingPool<T1>>(arg0),
            nft_id               : v2,
            kiosk_id             : v8,
            owner                : v7,
            unstake_time         : v1,
            staking_duration     : safe_sub(v1, v11),
            nft_type             : v0,
            slot_number          : v3,
            final_reward_claimed : v15,
        };
        0x2::event::emit<NftUnstaked>(v27);
    }

    public entry fun update_multiple_slot_rewards<T0>(arg0: &mut StakingPool<T0>, arg1: vector<address>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_not_paused<T0>(arg0);
        assert!(0x1::vector::length<address>(&arg1) == 0x1::vector::length<u8>(&arg2), 21);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            update_slot_rewards<T0>(arg0, *0x1::vector::borrow<address>(&arg1, v0), *0x1::vector::borrow<u8>(&arg2, v0), arg3, arg4);
            v0 = v0 + 1;
        };
    }

    public entry fun update_slot_multiplier<T0>(arg0: &mut StakingPool<T0>, arg1: u8, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 2);
        assert_not_paused<T0>(arg0);
        assert!(arg1 >= 1 && arg1 <= 100, 30);
        assert!(arg2 >= 1000 && arg2 <= 1000000, 37);
        let v0 = 0;
        let v1 = false;
        while (v0 < 0x1::vector::length<SlotConfig>(&arg0.slot_configs)) {
            let v2 = 0x1::vector::borrow_mut<SlotConfig>(&mut arg0.slot_configs, v0);
            if (v2.slot_number == arg1) {
                v2.reward_multiplier = arg2;
                v1 = true;
                let v3 = SlotMultiplierUpdated{
                    pool_id        : 0x2::object::id<StakingPool<T0>>(arg0),
                    slot_number    : arg1,
                    old_multiplier : v2.reward_multiplier,
                    new_multiplier : arg2,
                    updated_by     : 0x2::tx_context::sender(arg4),
                    update_time    : 0x2::clock::timestamp_ms(arg3),
                };
                0x2::event::emit<SlotMultiplierUpdated>(v3);
                break
            };
            v0 = v0 + 1;
        };
        assert!(v1, 30);
    }

    public entry fun update_slot_price<T0>(arg0: &mut StakingPool<T0>, arg1: u8, arg2: 0x1::string::String, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.admin, 2);
        assert_not_paused<T0>(arg0);
        assert!(arg1 >= 1 && arg1 <= 100, 30);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        if (arg2 == get_token_type_string_sui<0x2::sui::SUI>()) {
            let v1 = 0;
            while (v1 < 0x1::vector::length<SlotConfig>(&arg0.slot_configs)) {
                let v2 = 0x1::vector::borrow_mut<SlotConfig>(&mut arg0.slot_configs, v1);
                if (v2.slot_number == arg1) {
                    v2.unlock_cost = arg3;
                    let v3 = SlotPriceUpdated{
                        pool_id     : 0x2::object::id<StakingPool<T0>>(arg0),
                        slot_number : arg1,
                        token_type  : arg2,
                        old_price   : v2.unlock_cost,
                        new_price   : arg3,
                        updated_by  : 0x2::tx_context::sender(arg5),
                        update_time : v0,
                    };
                    0x2::event::emit<SlotPriceUpdated>(v3);
                    break
                };
                v1 = v1 + 1;
            };
        };
        let v4 = SlotTokenPricingKey{slot_number: arg1};
        if (0x2::dynamic_object_field::exists_<SlotTokenPricingKey>(&arg0.id, v4)) {
            let v5 = 0x2::dynamic_object_field::borrow_mut<SlotTokenPricingKey, SlotTokenPricing>(&mut arg0.id, v4);
            let v6 = if (0x2::table::contains<0x1::string::String, u64>(&v5.token_prices, arg2)) {
                *0x2::table::borrow<0x1::string::String, u64>(&v5.token_prices, arg2)
            } else {
                0
            };
            if (0x2::table::contains<0x1::string::String, u64>(&v5.token_prices, arg2)) {
                *0x2::table::borrow_mut<0x1::string::String, u64>(&mut v5.token_prices, arg2) = arg3;
            } else {
                0x2::table::add<0x1::string::String, u64>(&mut v5.token_prices, arg2, arg3);
            };
            let v7 = SlotPriceUpdated{
                pool_id     : 0x2::object::id<StakingPool<T0>>(arg0),
                slot_number : arg1,
                token_type  : arg2,
                old_price   : v6,
                new_price   : arg3,
                updated_by  : 0x2::tx_context::sender(arg5),
                update_time : v0,
            };
            0x2::event::emit<SlotPriceUpdated>(v7);
        } else {
            let v8 = SlotTokenPricing{
                id           : 0x2::object::new(arg5),
                slot_number  : arg1,
                token_prices : 0x2::table::new<0x1::string::String, u64>(arg5),
            };
            0x2::table::add<0x1::string::String, u64>(&mut v8.token_prices, arg2, arg3);
            0x2::dynamic_object_field::add<SlotTokenPricingKey, SlotTokenPricing>(&mut arg0.id, v4, v8);
            let v9 = SlotPriceUpdated{
                pool_id     : 0x2::object::id<StakingPool<T0>>(arg0),
                slot_number : arg1,
                token_type  : arg2,
                old_price   : 0,
                new_price   : arg3,
                updated_by  : 0x2::tx_context::sender(arg5),
                update_time : v0,
            };
            0x2::event::emit<SlotPriceUpdated>(v9);
        };
    }

    public entry fun update_slot_rewards<T0>(arg0: &mut StakingPool<T0>, arg1: address, arg2: u8, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_not_paused<T0>(arg0);
        let v0 = SlotDataKey{
            owner       : arg1,
            slot_number : arg2,
        };
        if (!0x2::dynamic_object_field::exists_<SlotDataKey>(&arg0.id, v0)) {
            return
        };
        let v1 = 0x2::dynamic_object_field::borrow<SlotDataKey, SlotData>(&arg0.id, v0);
        if (0x1::option::is_none<0x2::object::ID>(&v1.staked_nft)) {
            return
        };
        let v2 = *0x1::option::borrow<0x2::object::ID>(&v1.staked_nft);
        let v3 = *0x1::option::borrow<0x1::string::String>(&v1.staked_collection);
        let v4 = 0x2::clock::timestamp_ms(arg3);
        let v5 = calculate_enhanced_slot_rewards(v1.stake_time, v1.last_claim_time, v4, arg0.default_reward_rate, get_slot_config(&arg0.slot_configs, arg2).reward_multiplier, get_effective_nft_multiplier<T0>(arg0, v2, &v3), get_wallet_bonus_multiplier<T0>(arg0, arg1), arg0.end_time);
        let v6 = 0x2::dynamic_object_field::borrow_mut<SlotDataKey, SlotData>(&mut arg0.id, v0);
        v6.pending_rewards = safe_add(v6.pending_rewards, v5);
        v6.last_claim_time = v4;
        let v7 = RewardsUpdated{
            pool_id            : 0x2::object::id<StakingPool<T0>>(arg0),
            owner              : arg1,
            slot_number        : arg2,
            nft_id             : v2,
            additional_rewards : v5,
            total_pending      : v6.pending_rewards,
            update_time        : v4,
        };
        0x2::event::emit<RewardsUpdated>(v7);
    }

    public fun user_has_staked_nfts<T0>(arg0: &StakingPool<T0>, arg1: address) : bool {
        let v0 = UserSlotAllocationKey{user: arg1};
        if (!0x2::dynamic_object_field::exists_<UserSlotAllocationKey>(&arg0.id, v0)) {
            return false
        };
        let v1 = 0x2::dynamic_object_field::borrow<UserSlotAllocationKey, UserSlotAllocation>(&arg0.id, v0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(&v1.unlocked_slot_numbers)) {
            if (is_slot_occupied<T0>(arg0, arg1, *0x1::vector::borrow<u8>(&v1.unlocked_slot_numbers, v2))) {
                return true
            };
            v2 = v2 + 1;
        };
        false
    }

    fun verify_nft_ownership<T0: store + key>(arg0: &0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: address) {
        assert!(0x2::kiosk::owner(arg0) == arg3, 17);
        assert!(0x2::kiosk::has_item(arg0, arg2), 10);
        assert!(0x2::kiosk::has_item_with_type<T0>(arg0, arg2), 25);
    }

    public entry fun withdraw_sui_revenue<T0>(arg0: &mut StakingPool<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 2);
        assert_not_paused<T0>(arg0);
        let v0 = TokenRevenueKey{token_type: get_token_type_string_sui<0x2::sui::SUI>()};
        assert!(0x2::dynamic_object_field::exists_<TokenRevenueKey>(&arg0.id, v0), 35);
        let v1 = 0x2::dynamic_object_field::borrow_mut<TokenRevenueKey, TokenRevenue>(&mut arg0.id, v0);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v1.sui_balance) >= arg1, 16);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v1.sui_balance, arg1), arg2), arg0.admin);
    }

    // decompiled from Move bytecode v6
}

