module 0x30e8d064f3a69887766cc3af527264aa671f83d8f27f7571f9c1b0e51d668544::farm {
    struct Farm<phantom T0> has store, key {
        id: 0x2::object::UID,
        name: 0x1::type_name::TypeName,
        description: 0x1::type_name::TypeName,
        image_url: 0x1::type_name::TypeName,
        owner: address,
        reward_coin_balance: 0x2::balance::Balance<T0>,
        initial_balance: u64,
        enabled: bool,
        bank_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        farmers: vector<address>,
        whitelisted_collections: 0x2::table::Table<0x1::type_name::TypeName, u64>,
        min_staking_period_days: u64,
        forfeited_rewards: 0x2::table::Table<address, u64>,
    }

    struct FarmerKey has copy, drop, store {
        farmer_address: address,
    }

    struct FarmListKey has copy, drop, store {
        owner: address,
    }

    struct FarmList has drop, store {
        farm_ids: vector<0x2::object::ID>,
    }

    struct FarmCreated has copy, drop {
        farm_id: 0x2::object::ID,
        owner: address,
        bank_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
    }

    struct FarmerRegistered has copy, drop {
        farm_id: 0x2::object::ID,
        farmer: address,
    }

    struct FarmerUnregistered has copy, drop {
        farm_id: 0x2::object::ID,
        farmer: address,
    }

    struct CollectionWhitelisted has copy, drop {
        farm_id: 0x2::object::ID,
        collection_name: 0x1::type_name::TypeName,
        bonus: u64,
    }

    struct NFTStaked has copy, drop {
        farm_id: 0x2::object::ID,
        farmer_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct NFTUnstaked has copy, drop {
        farm_id: 0x2::object::ID,
        farmer_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct RewardsClaimed has copy, drop {
        farm_id: 0x2::object::ID,
        farmer: address,
        amount: u64,
        timestamp: u64,
    }

    struct RewardsFunded has copy, drop {
        farm_id: 0x2::object::ID,
        amount: u64,
    }

    struct CollectionRemoved has copy, drop {
        farm_id: 0x2::object::ID,
        collection_name: 0x1::type_name::TypeName,
    }

    struct StakingBonusChanged has copy, drop {
        farm_id: 0x2::object::ID,
        new_bonus: u64,
    }

    struct CollectionBonusApplied has copy, drop {
        farm_id: 0x2::object::ID,
        farmer: address,
        collection_name: 0x1::type_name::TypeName,
        bonus: u64,
    }

    struct NFTStakeInfoKey has copy, drop, store {
        nft_id: 0x2::object::ID,
    }

    struct NFTStakeInfo has copy, drop, store {
        farmer: address,
        stake_time: u64,
        collection_name: 0x1::type_name::TypeName,
    }

    struct MinStakingPeriodUpdated has copy, drop {
        farm_id: 0x2::object::ID,
        owner: address,
        min_staking_period_days: u64,
        timestamp: u64,
    }

    struct EarlyUnstakeWithPenalty has copy, drop {
        farm_id: 0x2::object::ID,
        farmer: address,
        nft_id: 0x2::object::ID,
        forfeited_rewards: u64,
        time_staked: u64,
        min_required_time: u64,
        timestamp: u64,
    }

    struct ForfeitedRewardsClaimed has copy, drop {
        farm_id: 0x2::object::ID,
        owner: address,
        user_address: address,
        amount: u64,
        timestamp: u64,
    }

    struct AdditionalSettings has copy, drop, store {
        reserved_value: u64,
        reserved_type: 0x1::type_name::TypeName,
    }

    struct AdditionalSettingsKey has copy, drop, store {
        dummy_field: bool,
    }

    struct CollectionWhitelistKey has copy, drop, store {
        dummy_field: bool,
    }

    public fun add_collection_to_whitelist<T0: store + key, T1: store + key>(arg0: &mut Farm<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 2);
        let v0 = 0x1::type_name::get<T1>();
        0x2::table::add<0x1::type_name::TypeName, u64>(&mut arg0.whitelisted_collections, v0, arg1);
        let v1 = CollectionWhitelistKey{dummy_field: false};
        let v2 = if (0x2::dynamic_field::exists_with_type<CollectionWhitelistKey, vector<0x1::type_name::TypeName>>(&arg0.id, v1)) {
            *0x2::dynamic_field::borrow<CollectionWhitelistKey, vector<0x1::type_name::TypeName>>(&arg0.id, v1)
        } else {
            0x1::vector::empty<0x1::type_name::TypeName>()
        };
        let v3 = v2;
        if (!0x1::vector::contains<0x1::type_name::TypeName>(&v3, &v0)) {
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut v3, v0);
            if (0x2::dynamic_field::exists_with_type<CollectionWhitelistKey, vector<0x1::type_name::TypeName>>(&arg0.id, v1)) {
                0x2::dynamic_field::remove<CollectionWhitelistKey, vector<0x1::type_name::TypeName>>(&mut arg0.id, v1);
            };
            0x2::dynamic_field::add<CollectionWhitelistKey, vector<0x1::type_name::TypeName>>(&mut arg0.id, v1, v3);
        };
        let v4 = CollectionWhitelisted{
            farm_id         : 0x2::object::id<Farm<T0>>(arg0),
            collection_name : v0,
            bonus           : arg1,
        };
        0x2::event::emit<CollectionWhitelisted>(v4);
    }

    public entry fun claim_forfeited_rewards<T0: store + key>(arg0: &mut Farm<T0>, arg1: &mut 0x30e8d064f3a69887766cc3af527264aa671f83d8f27f7571f9c1b0e51d668544::reward_vault::RewardVault<T0>, arg2: &mut 0x30e8d064f3a69887766cc3af527264aa671f83d8f27f7571f9c1b0e51d668544::reward_vault::RewardTransmitter<T0>, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(v0 == arg0.owner, 7);
        assert!(0x2::table::contains<address, u64>(&arg0.forfeited_rewards, arg3), 20);
        0x2::table::remove<address, u64>(&mut arg0.forfeited_rewards, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x30e8d064f3a69887766cc3af527264aa671f83d8f27f7571f9c1b0e51d668544::reward_vault::claim_rewards<T0>(arg1, arg2, v0, arg4, arg5), v0);
        let v1 = ForfeitedRewardsClaimed{
            farm_id      : 0x2::object::id<Farm<T0>>(arg0),
            owner        : v0,
            user_address : arg3,
            amount       : *0x2::table::borrow<address, u64>(&arg0.forfeited_rewards, arg3),
            timestamp    : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<ForfeitedRewardsClaimed>(v1);
    }

    public entry fun claim_rewards<T0: store + key>(arg0: &Farm<T0>, arg1: &mut 0x30e8d064f3a69887766cc3af527264aa671f83d8f27f7571f9c1b0e51d668544::reward_vault::RewardVault<T0>, arg2: &mut 0x30e8d064f3a69887766cc3af527264aa671f83d8f27f7571f9c1b0e51d668544::reward_vault::RewardTransmitter<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(is_registered<T0>(arg0, v0), 4);
        assert!(arg0.vault_id == 0x30e8d064f3a69887766cc3af527264aa671f83d8f27f7571f9c1b0e51d668544::reward_vault::get_vault_id<T0>(arg2), 1);
        if (arg0.min_staking_period_days > 0) {
            let v1 = FarmerKey{farmer_address: v0};
            if (0x2::dynamic_field::exists_with_type<FarmerKey, vector<0x2::object::ID>>(&arg0.id, v1)) {
                let v2 = 0x2::dynamic_field::borrow<FarmerKey, vector<0x2::object::ID>>(&arg0.id, v1);
                let v3 = 0;
                while (v3 < 0x1::vector::length<0x2::object::ID>(v2)) {
                    let v4 = NFTStakeInfoKey{nft_id: *0x1::vector::borrow<0x2::object::ID>(v2, v3)};
                    if (0x2::dynamic_field::exists_with_type<NFTStakeInfoKey, NFTStakeInfo>(&arg0.id, v4)) {
                        if (safe_time_diff_ms(0x2::clock::timestamp_ms(arg3), 0x2::dynamic_field::borrow<NFTStakeInfoKey, NFTStakeInfo>(&arg0.id, v4).stake_time) < days_to_ms(arg0.min_staking_period_days)) {
                            abort 18
                        };
                    };
                    v3 = v3 + 1;
                };
            };
        };
        let v5 = 0x30e8d064f3a69887766cc3af527264aa671f83d8f27f7571f9c1b0e51d668544::reward_vault::claim_rewards<T0>(arg1, arg2, v0, arg3, arg4);
        let v6 = 0x2::coin::value<T0>(&v5);
        if (v6 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, v0);
            let v7 = RewardsClaimed{
                farm_id   : 0x2::object::id<Farm<T0>>(arg0),
                farmer    : v0,
                amount    : v6,
                timestamp : 0x2::clock::timestamp_ms(arg3),
            };
            0x2::event::emit<RewardsClaimed>(v7);
        } else {
            0x2::coin::destroy_zero<T0>(v5);
        };
    }

    public fun create_farm<T0: store + key>(arg0: 0x1::type_name::TypeName, arg1: 0x1::type_name::TypeName, arg2: 0x1::type_name::TypeName, arg3: 0x2::balance::Balance<T0>, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : (Farm<T0>, 0x30e8d064f3a69887766cc3af527264aa671f83d8f27f7571f9c1b0e51d668544::bank::Bank, 0x30e8d064f3a69887766cc3af527264aa671f83d8f27f7571f9c1b0e51d668544::reward_vault::RewardVault<T0>, 0x30e8d064f3a69887766cc3af527264aa671f83d8f27f7571f9c1b0e51d668544::reward_vault::RewardTransmitter<T0>) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x30e8d064f3a69887766cc3af527264aa671f83d8f27f7571f9c1b0e51d668544::bank::create_bank(arg6);
        let v2 = 0x2::object::id<0x30e8d064f3a69887766cc3af527264aa671f83d8f27f7571f9c1b0e51d668544::bank::Bank>(&v1);
        let (v3, v4) = 0x30e8d064f3a69887766cc3af527264aa671f83d8f27f7571f9c1b0e51d668544::reward_vault::create_vault<T0>(arg6);
        let v5 = v3;
        let v6 = 0x2::object::id<0x30e8d064f3a69887766cc3af527264aa671f83d8f27f7571f9c1b0e51d668544::reward_vault::RewardVault<T0>>(&v5);
        let v7 = Farm<T0>{
            id                      : 0x2::object::new(arg6),
            name                    : arg0,
            description             : arg1,
            image_url               : arg2,
            owner                   : v0,
            reward_coin_balance     : arg3,
            initial_balance         : arg4,
            enabled                 : true,
            bank_id                 : v2,
            vault_id                : v6,
            farmers                 : 0x1::vector::empty<address>(),
            whitelisted_collections : 0x2::table::new<0x1::type_name::TypeName, u64>(arg6),
            min_staking_period_days : arg5,
            forfeited_rewards       : 0x2::table::new<address, u64>(arg6),
        };
        let v8 = FarmCreated{
            farm_id  : 0x2::object::id<Farm<T0>>(&v7),
            owner    : v0,
            bank_id  : v2,
            vault_id : v6,
        };
        0x2::event::emit<FarmCreated>(v8);
        (v7, v1, v5, v4)
    }

    fun create_zero_modifier() : 0x30e8d064f3a69887766cc3af527264aa671f83d8f27f7571f9c1b0e51d668544::reward_vault::Modifier {
        0x30e8d064f3a69887766cc3af527264aa671f83d8f27f7571f9c1b0e51d668544::reward_vault::create_mul_modifier(0)
    }

    fun days_to_ms(arg0: u64) : u64 {
        safe_multiply(arg0, 86400000)
    }

    public entry fun delist_collection<T0: store + key, T1: store + key>(arg0: &mut Farm<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        remove_collection_from_whitelist<T0, T1>(arg0, arg1);
    }

    public fun find_farm_by_owner(arg0: address) : 0x1::option::Option<0x2::object::ID> {
        0x1::option::none<0x2::object::ID>()
    }

    public entry fun fund_vault<T0: store + key>(arg0: &Farm<T0>, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x30e8d064f3a69887766cc3af527264aa671f83d8f27f7571f9c1b0e51d668544::reward_vault::RewardTransmitter<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg4), 2);
        assert!(arg0.vault_id == 0x30e8d064f3a69887766cc3af527264aa671f83d8f27f7571f9c1b0e51d668544::reward_vault::get_vault_id<T0>(arg2), 1);
        0x30e8d064f3a69887766cc3af527264aa671f83d8f27f7571f9c1b0e51d668544::reward_vault::fund<T0>(arg1, arg2, arg3, arg4);
        let v0 = RewardsFunded{
            farm_id : 0x2::object::id<Farm<T0>>(arg0),
            amount  : arg3,
        };
        0x2::event::emit<RewardsFunded>(v0);
    }

    public fun get_additional_settings<T0>(arg0: &Farm<T0>) : (u64, 0x1::type_name::TypeName) {
        let v0 = AdditionalSettingsKey{dummy_field: false};
        if (0x2::dynamic_field::exists_with_type<AdditionalSettingsKey, AdditionalSettings>(&arg0.id, v0)) {
            let v3 = 0x2::dynamic_field::borrow<AdditionalSettingsKey, AdditionalSettings>(&arg0.id, v0);
            (v3.reserved_value, v3.reserved_type)
        } else {
            (0, 0x1::type_name::get<T0>())
        }
    }

    public fun get_claimable_rewards<T0: store + key>(arg0: &mut 0x30e8d064f3a69887766cc3af527264aa671f83d8f27f7571f9c1b0e51d668544::reward_vault::RewardVault<T0>, arg1: &0x30e8d064f3a69887766cc3af527264aa671f83d8f27f7571f9c1b0e51d668544::reward_vault::RewardTransmitter<T0>, arg2: address, arg3: &0x2::clock::Clock) : u64 {
        if (!0x30e8d064f3a69887766cc3af527264aa671f83d8f27f7571f9c1b0e51d668544::reward_vault::is_subscribed<T0>(arg2, arg0)) {
            return 0
        };
        0x30e8d064f3a69887766cc3af527264aa671f83d8f27f7571f9c1b0e51d668544::reward_vault::get_claimable_amount<T0>(arg0, arg1, arg2, arg3)
    }

    public fun get_collection_bonus<T0: store + key, T1: store + key>(arg0: &Farm<T0>) : u64 {
        let v0 = 0x1::type_name::get<T1>();
        if (0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.whitelisted_collections, v0)) {
            *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.whitelisted_collections, v0)
        } else {
            0
        }
    }

    public fun get_collection_bonuses<T0: store + key>(arg0: &Farm<T0>) : vector<0x1::type_name::TypeName> {
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = get_whitelisted_collections<T0>(arg0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v1)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v1, v2);
            if (0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.whitelisted_collections, v3)) {
                0x1::vector::push_back<0x1::type_name::TypeName>(&mut v0, v3);
            };
            v2 = v2 + 1;
        };
        v0
    }

    public fun get_farm_info<T0>(arg0: &Farm<T0>) : (address, 0x2::object::ID, 0x2::object::ID, bool, u64) {
        (arg0.owner, arg0.bank_id, arg0.vault_id, arg0.enabled, 0x1::vector::length<address>(&arg0.farmers))
    }

    public fun get_farmer_count<T0>(arg0: &Farm<T0>) : u64 {
        0x1::vector::length<address>(&arg0.farmers)
    }

    public fun get_farmers<T0>(arg0: &Farm<T0>) : vector<address> {
        arg0.farmers
    }

    public fun get_forfeited_rewards<T0: store + key>(arg0: &Farm<T0>, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.forfeited_rewards, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.forfeited_rewards, arg1)
        } else {
            0
        }
    }

    public fun get_forfeited_rewards_amount<T0>(arg0: &Farm<T0>, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.forfeited_rewards, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.forfeited_rewards, arg1)
        } else {
            0
        }
    }

    public fun get_forfeited_rewards_for_users<T0>(arg0: &Farm<T0>, arg1: vector<address>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg1)) {
            let v2 = *0x1::vector::borrow<address>(&arg1, v1);
            if (0x2::table::contains<address, u64>(&arg0.forfeited_rewards, v2)) {
                v0 = v0 + *0x2::table::borrow<address, u64>(&arg0.forfeited_rewards, v2);
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_forfeited_rewards_info<T0>(arg0: &Farm<T0>) : u64 {
        get_total_forfeited_rewards<T0>(arg0)
    }

    public fun get_nft_stake_time<T0>(arg0: &Farm<T0>, arg1: 0x2::object::ID) : (u64, 0x1::type_name::TypeName) {
        let v0 = NFTStakeInfoKey{nft_id: arg1};
        if (0x2::dynamic_field::exists_with_type<NFTStakeInfoKey, NFTStakeInfo>(&arg0.id, v0)) {
            let v3 = 0x2::dynamic_field::borrow<NFTStakeInfoKey, NFTStakeInfo>(&arg0.id, v0);
            (v3.stake_time, v3.collection_name)
        } else {
            (0, 0x1::type_name::get<u8>())
        }
    }

    public fun get_pool_stats<T0: store + key>(arg0: &Farm<T0>, arg1: &0x30e8d064f3a69887766cc3af527264aa671f83d8f27f7571f9c1b0e51d668544::reward_vault::RewardVault<T0>, arg2: &0x30e8d064f3a69887766cc3af527264aa671f83d8f27f7571f9c1b0e51d668544::reward_vault::RewardTransmitter<T0>) : (u64, u64, u64, u64, u64) {
        (arg0.initial_balance, 0x30e8d064f3a69887766cc3af527264aa671f83d8f27f7571f9c1b0e51d668544::reward_vault::get_total_rewards_paid<T0>(arg2), 0x30e8d064f3a69887766cc3af527264aa671f83d8f27f7571f9c1b0e51d668544::reward_vault::get_reward_balance<T0>(arg2), get_total_staked_nfts<T0>(arg0), arg0.min_staking_period_days)
    }

    public fun get_staked_nfts<T0>(arg0: &Farm<T0>, arg1: address) : vector<0x2::object::ID> {
        if (!is_registered<T0>(arg0, arg1)) {
            return 0x1::vector::empty<0x2::object::ID>()
        };
        let v0 = FarmerKey{farmer_address: arg1};
        if (0x2::dynamic_field::exists_with_type<FarmerKey, vector<0x2::object::ID>>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow<FarmerKey, vector<0x2::object::ID>>(&arg0.id, v0)
        } else {
            0x1::vector::empty<0x2::object::ID>()
        }
    }

    public fun get_staked_nfts_count<T0>(arg0: &Farm<T0>, arg1: address) : u64 {
        if (!is_registered<T0>(arg0, arg1)) {
            return 0
        };
        0x2::object::id<Farm<T0>>(arg0);
        let v0 = FarmerKey{farmer_address: arg1};
        if (0x2::dynamic_field::exists_with_type<FarmerKey, vector<0x2::object::ID>>(&arg0.id, v0)) {
            let v2 = FarmerKey{farmer_address: arg1};
            0x1::vector::length<0x2::object::ID>(0x2::dynamic_field::borrow<FarmerKey, vector<0x2::object::ID>>(&arg0.id, v2))
        } else {
            0
        }
    }

    public fun get_staking_period_info<T0>(arg0: &Farm<T0>) : (u64, u64, u64) {
        let v0 = arg0.min_staking_period_days;
        (v0, days_to_ms(v0), 100)
    }

    public fun get_total_forfeited_rewards<T0>(arg0: &Farm<T0>) : u64 {
        get_forfeited_rewards_for_users<T0>(arg0, arg0.farmers)
    }

    public fun get_total_staked_nfts<T0>(arg0: &Farm<T0>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg0.farmers)) {
            v0 = v0 + get_staked_nfts_count<T0>(arg0, *0x1::vector::borrow<address>(&arg0.farmers, v1));
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_user_daily_rewards<T0: store + key>(arg0: &Farm<T0>, arg1: &0x30e8d064f3a69887766cc3af527264aa671f83d8f27f7571f9c1b0e51d668544::reward_vault::RewardVault<T0>, arg2: &0x30e8d064f3a69887766cc3af527264aa671f83d8f27f7571f9c1b0e51d668544::reward_vault::RewardTransmitter<T0>, arg3: address) : u64 {
        if (!is_registered<T0>(arg0, arg3) || get_staked_nfts_count<T0>(arg0, arg3) == 0) {
            return 0
        };
        safe_multiply(safe_multiply(0x30e8d064f3a69887766cc3af527264aa671f83d8f27f7571f9c1b0e51d668544::reward_vault::get_base_reward_rate<T0>(arg1), 86400), (0x30e8d064f3a69887766cc3af527264aa671f83d8f27f7571f9c1b0e51d668544::reward_vault::get_modifier<T0>(arg1, arg3) as u64))
    }

    public fun get_user_nft_details<T0>(arg0: &Farm<T0>, arg1: address, arg2: &0x2::clock::Clock) : vector<0x2::object::ID> {
        get_staked_nfts<T0>(arg0, arg1)
    }

    public fun get_user_stats<T0: store + key>(arg0: &Farm<T0>, arg1: &0x30e8d064f3a69887766cc3af527264aa671f83d8f27f7571f9c1b0e51d668544::reward_vault::RewardVault<T0>, arg2: &0x30e8d064f3a69887766cc3af527264aa671f83d8f27f7571f9c1b0e51d668544::reward_vault::RewardTransmitter<T0>, arg3: address, arg4: &0x2::clock::Clock) : (u64, u64, u64, u64, u64) {
        let v0 = get_staked_nfts_count<T0>(arg0, arg3);
        let v1 = 0;
        if (is_registered<T0>(arg0, arg3) && v0 > 0) {
            v1 = 0x30e8d064f3a69887766cc3af527264aa671f83d8f27f7571f9c1b0e51d668544::reward_vault::get_claimable_amount_ro<T0>(arg1, arg2, arg3, arg4);
        };
        (v0, v1, get_user_daily_rewards<T0>(arg0, arg1, arg2, arg3), (0x30e8d064f3a69887766cc3af527264aa671f83d8f27f7571f9c1b0e51d668544::reward_vault::get_modifier<T0>(arg1, arg3) as u64), 0x30e8d064f3a69887766cc3af527264aa671f83d8f27f7571f9c1b0e51d668544::reward_vault::get_last_update_time<T0>(arg1, arg3))
    }

    public fun get_whitelisted_collections<T0: store + key>(arg0: &Farm<T0>) : vector<0x1::type_name::TypeName> {
        let v0 = CollectionWhitelistKey{dummy_field: false};
        if (0x2::dynamic_field::exists_with_type<CollectionWhitelistKey, vector<0x1::type_name::TypeName>>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow<CollectionWhitelistKey, vector<0x1::type_name::TypeName>>(&arg0.id, v0)
        } else {
            0x1::vector::empty<0x1::type_name::TypeName>()
        }
    }

    public fun has_farmer_object<T0>(arg0: &Farm<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : bool {
        if (is_registered<T0>(arg0, arg1)) {
            let v1 = FarmerKey{farmer_address: arg1};
            0x2::dynamic_field::exists_with_type<FarmerKey, vector<0x2::object::ID>>(&arg0.id, v1)
        } else {
            false
        }
    }

    public fun is_registered<T0>(arg0: &Farm<T0>, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.farmers, &arg1)
    }

    public fun is_whitelisted<T0: store + key, T1: store + key>(arg0: &Farm<T0>) : bool {
        0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.whitelisted_collections, 0x1::type_name::get<T1>())
    }

    public entry fun publish_farm<T0: store + key>(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let (v1, v2, v3, v4) = create_farm<T0>(string_to_type_name(arg0), string_to_type_name(arg1), string_to_type_name(arg2), 0x2::balance::zero<T0>(), arg3, arg4, arg5);
        let v5 = v3;
        let v6 = v2;
        let v7 = v1;
        let v8 = FarmCreated{
            farm_id  : 0x2::object::id<Farm<T0>>(&v7),
            owner    : v0,
            bank_id  : 0x2::object::id<0x30e8d064f3a69887766cc3af527264aa671f83d8f27f7571f9c1b0e51d668544::bank::Bank>(&v6),
            vault_id : 0x2::object::id<0x30e8d064f3a69887766cc3af527264aa671f83d8f27f7571f9c1b0e51d668544::reward_vault::RewardVault<T0>>(&v5),
        };
        0x2::event::emit<FarmCreated>(v8);
        0x2::transfer::share_object<Farm<T0>>(v7);
        0x2::transfer::public_share_object<0x30e8d064f3a69887766cc3af527264aa671f83d8f27f7571f9c1b0e51d668544::bank::Bank>(v6);
        0x2::transfer::public_share_object<0x30e8d064f3a69887766cc3af527264aa671f83d8f27f7571f9c1b0e51d668544::reward_vault::RewardVault<T0>>(v5);
        0x2::transfer::public_transfer<0x30e8d064f3a69887766cc3af527264aa671f83d8f27f7571f9c1b0e51d668544::reward_vault::RewardTransmitter<T0>>(v4, v0);
    }

    public fun register_farmer<T0: store + key>(arg0: &mut Farm<T0>, arg1: &mut 0x30e8d064f3a69887766cc3af527264aa671f83d8f27f7571f9c1b0e51d668544::bank::Bank, arg2: &mut 0x30e8d064f3a69887766cc3af527264aa671f83d8f27f7571f9c1b0e51d668544::reward_vault::RewardVault<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg0.enabled, 5);
        assert!(0x2::object::id<0x30e8d064f3a69887766cc3af527264aa671f83d8f27f7571f9c1b0e51d668544::bank::Bank>(arg1) == arg0.bank_id, 0);
        assert!(0x2::object::id<0x30e8d064f3a69887766cc3af527264aa671f83d8f27f7571f9c1b0e51d668544::reward_vault::RewardVault<T0>>(arg2) == arg0.vault_id, 1);
        assert!(!is_registered<T0>(arg0, v0), 6);
        0x2::object::id<Farm<T0>>(arg0);
        0x1::vector::push_back<address>(&mut arg0.farmers, v0);
        let v1 = FarmerRegistered{
            farm_id : 0x2::object::id<Farm<T0>>(arg0),
            farmer  : v0,
        };
        0x2::event::emit<FarmerRegistered>(v1);
    }

    public entry fun register_farmer_entry<T0: store + key>(arg0: &mut Farm<T0>, arg1: &mut 0x30e8d064f3a69887766cc3af527264aa671f83d8f27f7571f9c1b0e51d668544::bank::Bank, arg2: &mut 0x30e8d064f3a69887766cc3af527264aa671f83d8f27f7571f9c1b0e51d668544::reward_vault::RewardVault<T0>, arg3: &mut 0x30e8d064f3a69887766cc3af527264aa671f83d8f27f7571f9c1b0e51d668544::reward_vault::RewardTransmitter<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        register_farmer<T0>(arg0, arg1, arg2, arg5);
        if (!0x30e8d064f3a69887766cc3af527264aa671f83d8f27f7571f9c1b0e51d668544::reward_vault::is_subscribed<T0>(0x2::tx_context::sender(arg5), arg2)) {
            0x30e8d064f3a69887766cc3af527264aa671f83d8f27f7571f9c1b0e51d668544::reward_vault::subscribe_with_modifier<T0>(arg2, arg3, 0x30e8d064f3a69887766cc3af527264aa671f83d8f27f7571f9c1b0e51d668544::reward_vault::create_sum_modifier(1), arg4, arg5);
        };
    }

    public fun remove_collection_from_whitelist<T0: store + key, T1: store + key>(arg0: &mut Farm<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 2);
        let v0 = 0x1::type_name::get<T1>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.whitelisted_collections, v0), 16);
        0x2::table::remove<0x1::type_name::TypeName, u64>(&mut arg0.whitelisted_collections, v0);
        let v1 = CollectionWhitelistKey{dummy_field: false};
        if (0x2::dynamic_field::exists_with_type<CollectionWhitelistKey, vector<0x1::type_name::TypeName>>(&arg0.id, v1)) {
            let v2 = *0x2::dynamic_field::borrow<CollectionWhitelistKey, vector<0x1::type_name::TypeName>>(&arg0.id, v1);
            let (v3, v4) = 0x1::vector::index_of<0x1::type_name::TypeName>(&v2, &v0);
            if (v3) {
                0x1::vector::remove<0x1::type_name::TypeName>(&mut v2, v4);
                0x2::dynamic_field::remove<CollectionWhitelistKey, vector<0x1::type_name::TypeName>>(&mut arg0.id, v1);
                0x2::dynamic_field::add<CollectionWhitelistKey, vector<0x1::type_name::TypeName>>(&mut arg0.id, v1, v2);
            };
        };
        let v5 = CollectionRemoved{
            farm_id         : 0x2::object::id<Farm<T0>>(arg0),
            collection_name : v0,
        };
        0x2::event::emit<CollectionRemoved>(v5);
    }

    fun safe_multiply(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u128) * (arg1 as u128);
        if (v0 > 18446744073709551615) {
            18446744073709551615
        } else {
            (v0 as u64)
        }
    }

    fun safe_time_diff_ms(arg0: u64, arg1: u64) : u64 {
        if (arg0 >= arg1) {
            arg0 - arg1
        } else {
            0
        }
    }

    public entry fun set_farm_enabled<T0>(arg0: &mut Farm<T0>, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 2);
        arg0.enabled = arg1;
    }

    public entry fun set_min_staking_period<T0: store + key>(arg0: &mut Farm<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg0.owner, 7);
        arg0.min_staking_period_days = arg1;
        let v1 = MinStakingPeriodUpdated{
            farm_id                 : 0x2::object::id<Farm<T0>>(arg0),
            owner                   : v0,
            min_staking_period_days : arg1,
            timestamp               : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<MinStakingPeriodUpdated>(v1);
    }

    public entry fun stake_nft<T0: store + key, T1: store + key>(arg0: &mut Farm<T0>, arg1: &mut 0x30e8d064f3a69887766cc3af527264aa671f83d8f27f7571f9c1b0e51d668544::bank::Bank, arg2: &mut 0x30e8d064f3a69887766cc3af527264aa671f83d8f27f7571f9c1b0e51d668544::reward_vault::RewardVault<T0>, arg3: &mut 0x30e8d064f3a69887766cc3af527264aa671f83d8f27f7571f9c1b0e51d668544::reward_vault::RewardTransmitter<T0>, arg4: T1, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(arg0.enabled, 5);
        assert!(is_registered<T0>(arg0, v0), 4);
        let v1 = 0x1::type_name::get<T1>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.whitelisted_collections, v1), 8);
        let v2 = 0x2::object::id<T1>(&arg4);
        let v3 = FarmerKey{farmer_address: v0};
        if (!0x2::dynamic_field::exists_with_type<FarmerKey, vector<0x2::object::ID>>(&arg0.id, v3)) {
            0x2::dynamic_field::add<FarmerKey, vector<0x2::object::ID>>(&mut arg0.id, v3, 0x1::vector::empty<0x2::object::ID>());
        };
        0x1::vector::push_back<0x2::object::ID>(0x2::dynamic_field::borrow_mut<FarmerKey, vector<0x2::object::ID>>(&mut arg0.id, v3), v2);
        let v4 = 0x2::clock::timestamp_ms(arg5);
        let v5 = NFTStakeInfo{
            farmer          : v0,
            stake_time      : v4,
            collection_name : v1,
        };
        let v6 = NFTStakeInfoKey{nft_id: v2};
        0x2::dynamic_field::add<NFTStakeInfoKey, NFTStakeInfo>(&mut arg0.id, v6, v5);
        0x30e8d064f3a69887766cc3af527264aa671f83d8f27f7571f9c1b0e51d668544::bank::deposit<T1>(arg1, arg4, 1, arg6);
        0x30e8d064f3a69887766cc3af527264aa671f83d8f27f7571f9c1b0e51d668544::reward_vault::get_modifier<T0>(arg2, v0);
        let v7 = get_staked_nfts_count<T0>(arg0, v0);
        let v8 = *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.whitelisted_collections, v1);
        let v9 = if (v7 >= 11 && v7 <= 15) {
            4
        } else if (v7 >= 6 && v7 <= 10) {
            3
        } else if (v7 >= 2 && v7 <= 5) {
            2
        } else {
            1
        };
        let v10 = v9;
        if (v8 > 0) {
            v10 = v9 + (v8 as u64) / 100;
            let v11 = CollectionBonusApplied{
                farm_id         : 0x2::object::id<Farm<T0>>(arg0),
                farmer          : v0,
                collection_name : v1,
                bonus           : v8,
            };
            0x2::event::emit<CollectionBonusApplied>(v11);
        };
        0x30e8d064f3a69887766cc3af527264aa671f83d8f27f7571f9c1b0e51d668544::reward_vault::update_modifier<T0>(arg2, arg3, v0, 0x30e8d064f3a69887766cc3af527264aa671f83d8f27f7571f9c1b0e51d668544::reward_vault::create_mul_modifier(v10), arg5, arg6);
        let v12 = NFTStaked{
            farm_id   : 0x2::object::id<Farm<T0>>(arg0),
            farmer_id : 0x2::object::id_from_address(v0),
            nft_id    : v2,
            timestamp : v4,
        };
        0x2::event::emit<NFTStaked>(v12);
    }

    fun string_to_type_name(arg0: vector<u8>) : 0x1::type_name::TypeName {
        0x1::type_name::get<u8>()
    }

    public fun unregister_farmer<T0: store + key>(arg0: &mut Farm<T0>, arg1: &mut 0x30e8d064f3a69887766cc3af527264aa671f83d8f27f7571f9c1b0e51d668544::reward_vault::RewardVault<T0>, arg2: &mut 0x30e8d064f3a69887766cc3af527264aa671f83d8f27f7571f9c1b0e51d668544::reward_vault::RewardTransmitter<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(is_registered<T0>(arg0, v0), 4);
        assert!(get_staked_nfts_count<T0>(arg0, v0) == 0, 12);
        let (v1, v2) = 0x1::vector::index_of<address>(&arg0.farmers, &v0);
        assert!(v1, 4);
        0x1::vector::remove<address>(&mut arg0.farmers, v2);
        if (0x30e8d064f3a69887766cc3af527264aa671f83d8f27f7571f9c1b0e51d668544::reward_vault::is_subscribed<T0>(v0, arg1)) {
            0x30e8d064f3a69887766cc3af527264aa671f83d8f27f7571f9c1b0e51d668544::reward_vault::unsubscribe<T0>(arg1, arg2, arg3);
        };
        let v3 = FarmerUnregistered{
            farm_id : 0x2::object::id<Farm<T0>>(arg0),
            farmer  : v0,
        };
        0x2::event::emit<FarmerUnregistered>(v3);
    }

    public entry fun unstake_nft<T0: store + key, T1: store + key>(arg0: &mut Farm<T0>, arg1: &mut 0x30e8d064f3a69887766cc3af527264aa671f83d8f27f7571f9c1b0e51d668544::bank::Bank, arg2: &mut 0x30e8d064f3a69887766cc3af527264aa671f83d8f27f7571f9c1b0e51d668544::reward_vault::RewardVault<T0>, arg3: &mut 0x30e8d064f3a69887766cc3af527264aa671f83d8f27f7571f9c1b0e51d668544::reward_vault::RewardTransmitter<T0>, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(is_registered<T0>(arg0, v0), 4);
        let v1 = 0x1::type_name::get<T1>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.whitelisted_collections, v1), 8);
        let v2 = FarmerKey{farmer_address: v0};
        assert!(0x2::dynamic_field::exists_with_type<FarmerKey, vector<0x2::object::ID>>(&arg0.id, v2), 3);
        let v3 = NFTStakeInfoKey{nft_id: arg4};
        assert!(0x2::dynamic_field::exists_with_type<NFTStakeInfoKey, NFTStakeInfo>(&arg0.id, v3), 3);
        let v4 = *0x2::dynamic_field::borrow<NFTStakeInfoKey, NFTStakeInfo>(&arg0.id, v3);
        let v5 = 0x2::clock::timestamp_ms(arg5);
        let v6 = safe_time_diff_ms(v5, v4.stake_time);
        let v7 = days_to_ms(arg0.min_staking_period_days);
        if (arg0.min_staking_period_days > 0 && v6 < v7) {
            let v8 = 0x30e8d064f3a69887766cc3af527264aa671f83d8f27f7571f9c1b0e51d668544::reward_vault::get_claimable_amount<T0>(arg2, arg3, v0, arg5);
            if (v8 > 0) {
                if (0x2::table::contains<address, u64>(&arg0.forfeited_rewards, v0)) {
                    let v9 = 0x2::table::borrow_mut<address, u64>(&mut arg0.forfeited_rewards, v0);
                    *v9 = *v9 + v8;
                } else {
                    0x2::table::add<address, u64>(&mut arg0.forfeited_rewards, v0, v8);
                };
                let v10 = 0x30e8d064f3a69887766cc3af527264aa671f83d8f27f7571f9c1b0e51d668544::reward_vault::claim_rewards<T0>(arg2, arg3, v0, arg5, arg6);
                if (0x2::coin::value<T0>(&v10) > 0) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v10, arg0.owner);
                } else {
                    0x2::coin::destroy_zero<T0>(v10);
                };
                let v11 = EarlyUnstakeWithPenalty{
                    farm_id           : 0x2::object::id<Farm<T0>>(arg0),
                    farmer            : v0,
                    nft_id            : arg4,
                    forfeited_rewards : v8,
                    time_staked       : v6,
                    min_required_time : v7,
                    timestamp         : v5,
                };
                0x2::event::emit<EarlyUnstakeWithPenalty>(v11);
            };
        };
        0x2::dynamic_field::remove<NFTStakeInfoKey, NFTStakeInfo>(&mut arg0.id, v3);
        let v12 = 0x2::dynamic_field::borrow_mut<FarmerKey, vector<0x2::object::ID>>(&mut arg0.id, v2);
        let (v13, v14) = 0x1::vector::index_of<0x2::object::ID>(v12, &arg4);
        if (v13) {
            0x1::vector::remove<0x2::object::ID>(v12, v14);
        };
        0x2::transfer::public_transfer<T1>(0x30e8d064f3a69887766cc3af527264aa671f83d8f27f7571f9c1b0e51d668544::bank::withdraw<T1>(arg1, arg4, arg6), v0);
        0x30e8d064f3a69887766cc3af527264aa671f83d8f27f7571f9c1b0e51d668544::reward_vault::get_modifier<T0>(arg2, v0);
        let v15 = get_staked_nfts_count<T0>(arg0, v0);
        let v16 = if (v15 >= 11) {
            4
        } else if (v15 >= 6 && v15 <= 10) {
            3
        } else if (v15 >= 2 && v15 <= 5) {
            2
        } else if (v15 == 1) {
            1
        } else {
            0
        };
        let v17 = v16;
        if (v15 > 0 && 0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.whitelisted_collections, v1)) {
            let v18 = *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.whitelisted_collections, v1);
            if (v18 > 0) {
                v17 = v16 + (v18 as u64) / 100;
            };
        };
        let v19 = if (v17 > 0) {
            0x30e8d064f3a69887766cc3af527264aa671f83d8f27f7571f9c1b0e51d668544::reward_vault::create_mul_modifier(v17)
        } else {
            create_zero_modifier()
        };
        0x30e8d064f3a69887766cc3af527264aa671f83d8f27f7571f9c1b0e51d668544::reward_vault::update_modifier<T0>(arg2, arg3, v0, v19, arg5, arg6);
        let v20 = NFTUnstaked{
            farm_id   : 0x2::object::id<Farm<T0>>(arg0),
            farmer_id : 0x2::object::id_from_address(v0),
            nft_id    : arg4,
            timestamp : v5,
        };
        0x2::event::emit<NFTUnstaked>(v20);
    }

    public entry fun update_collection_modifier<T0, T1: store + key>(arg0: &mut Farm<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 2);
        let v0 = 0x1::type_name::get<T1>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.whitelisted_collections, v0), 8);
        *0x2::table::borrow_mut<0x1::type_name::TypeName, u64>(&mut arg0.whitelisted_collections, v0) = arg1;
    }

    public entry fun whitelist_collection<T0, T1: store + key>(arg0: &mut Farm<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 2);
        let v0 = 0x1::type_name::get<T1>();
        assert!(!0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.whitelisted_collections, v0), 13);
        0x2::table::add<0x1::type_name::TypeName, u64>(&mut arg0.whitelisted_collections, v0, arg1);
        let v1 = CollectionWhitelisted{
            farm_id         : 0x2::object::id<Farm<T0>>(arg0),
            collection_name : v0,
            bonus           : arg1,
        };
        0x2::event::emit<CollectionWhitelisted>(v1);
    }

    public entry fun withdraw_funds<T0: store + key>(arg0: &Farm<T0>, arg1: &mut 0x30e8d064f3a69887766cc3af527264aa671f83d8f27f7571f9c1b0e51d668544::reward_vault::RewardTransmitter<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg0.owner == v0, 2);
        assert!(arg0.vault_id == 0x30e8d064f3a69887766cc3af527264aa671f83d8f27f7571f9c1b0e51d668544::reward_vault::get_vault_id<T0>(arg1), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x30e8d064f3a69887766cc3af527264aa671f83d8f27f7571f9c1b0e51d668544::reward_vault::withdraw<T0>(arg1, arg2, arg3), v0);
    }

    // decompiled from Move bytecode v6
}

