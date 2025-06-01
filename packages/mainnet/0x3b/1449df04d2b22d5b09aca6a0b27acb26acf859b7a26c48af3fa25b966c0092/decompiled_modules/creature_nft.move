module 0xde0a3bc72b5348ab109ce52ba8a6d9a9e20a52e96330ec3db310473b074dc477::creature_nft {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct BrainrotCollection has key {
        id: 0x2::object::UID,
        minted_count: u64,
        staking_stats: StakingStats,
        treasury: 0x2::balance::Balance<0x2::sui::SUI>,
        config: CollectionConfig,
        events: EnvironmentEvents,
        pending_rewards: 0x2::table::Table<0x2::object::ID, u64>,
        public_recipes: 0x2::table::Table<vector<u8>, PublicRecipe>,
        recipe_list: vector<vector<u8>>,
        used_names: 0x2::table::Table<0x1::string::String, address>,
        names_list: vector<0x1::string::String>,
        recipes_by_item: 0x2::table::Table<u64, vector<vector<u8>>>,
    }

    struct PublicRecipe has copy, drop, store {
        recipe_hash: vector<u8>,
        creator: address,
        name: 0x1::string::String,
        metadata: NFTMetadata,
        creation_time: u64,
        usage_count: u64,
    }

    struct CollectionConfig has store {
        creator_fee_bps: u16,
        duplicate_recipe_fee: u64,
        recipes: 0x2::table::Table<vector<u8>, address>,
    }

    struct StakingStats has store {
        staked_universe: u64,
        staked_sky: u64,
        staked_seabed: u64,
    }

    struct EnvironmentEvents has store {
        universe_event: EventStatus,
        sky_event: EventStatus,
        seabed_event: EventStatus,
    }

    struct EventStatus has copy, drop, store {
        active: bool,
        start_time: u64,
        duration: u64,
        reward_rate: u64,
    }

    struct CreatureNFT has store, key {
        id: 0x2::object::UID,
        metadata: NFTMetadata,
        recipe_hash: vector<u8>,
        creator: address,
        created_at: u64,
    }

    struct ItemInfo has copy, drop, store {
        item_id: u64,
        quantity: u64,
    }

    struct NFTMetadata has copy, drop, store {
        name: 0x1::string::String,
        leg_items: vector<ItemInfo>,
        body_items: vector<ItemInfo>,
        hand_items: vector<ItemInfo>,
        head_items: vector<ItemInfo>,
        style_items: vector<ItemInfo>,
        material_items: vector<ItemInfo>,
        environment_items: vector<ItemInfo>,
        image_uri: 0x1::string::String,
        created_at: u64,
    }

    struct StakeInfo has store, key {
        id: 0x2::object::UID,
        nft: CreatureNFT,
        owner: address,
        environment: u8,
        stake_time: u64,
        last_reward_time: u64,
    }

    struct NFTMinted has copy, drop {
        nft_id: 0x2::object::ID,
        name: 0x1::string::String,
        creator: address,
        is_duplicate_recipe: bool,
    }

    struct NFTStaked has copy, drop {
        nft_id: 0x2::object::ID,
        owner: address,
        environment: u8,
        stake_time: u64,
    }

    struct NFTUnstaked has copy, drop {
        nft_id: 0x2::object::ID,
        owner: address,
        environment: u8,
        total_staked_time: u64,
    }

    struct RewardClaimed has copy, drop {
        owner: address,
        nft_id: 0x2::object::ID,
        amount: u64,
    }

    struct EventStarted has copy, drop {
        environment: u8,
        start_time: u64,
        duration: u64,
        reward_rate: u64,
    }

    struct EventEnded has copy, drop {
        environment: u8,
        total_duration: u64,
    }

    struct CREATURE_NFT has drop {
        dummy_field: bool,
    }

    struct RewardCalculation has drop {
        amount: u64,
        valid: bool,
    }

    public entry fun add_treasury_funds(arg0: &AdminCap, arg1: &mut BrainrotCollection, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.treasury, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg2, arg3, arg4)));
    }

    fun build_simple_items(arg0: vector<u64>, arg1: vector<u64>) : vector<ItemInfo> {
        assert!(0x1::vector::length<u64>(&arg0) == 0x1::vector::length<u64>(&arg1), 1001);
        let v0 = 0x1::vector::empty<ItemInfo>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg0)) {
            let v2 = ItemInfo{
                item_id  : *0x1::vector::borrow<u64>(&arg0, v1),
                quantity : *0x1::vector::borrow<u64>(&arg1, v1),
            };
            0x1::vector::push_back<ItemInfo>(&mut v0, v2);
            v1 = v1 + 1;
        };
        v0
    }

    public fun calculate_recipe_hash(arg0: &NFTMetadata) : vector<u8> {
        0x1::hash::sha2_256(serialize_recipe_data(arg0))
    }

    fun calculate_reward_amount(arg0: &EventStatus, arg1: u64, arg2: u64) : u64 {
        let v0 = max(arg1, arg0.start_time);
        let v1 = min(arg2, arg0.start_time + arg0.duration);
        if (v1 <= v0) {
            return 0
        };
        let v2 = v1 - v0;
        let v3 = v2 % 86400000;
        let v4 = arg0.reward_rate * v2 / 86400000;
        let v5 = v4;
        if (v3 > 0) {
            v5 = v4 + arg0.reward_rate * v3 / 86400000;
        };
        v5
    }

    fun calculate_rewards(arg0: &BrainrotCollection, arg1: u64, arg2: u8, arg3: u64) : RewardCalculation {
        if (arg3 <= arg1) {
            return RewardCalculation{
                amount : 0,
                valid  : false,
            }
        };
        let v0 = get_event_status(arg0, arg2);
        if (!v0.active) {
            return RewardCalculation{
                amount : 0,
                valid  : false,
            }
        };
        RewardCalculation{
            amount : calculate_reward_amount(v0, arg1, arg3),
            valid  : true,
        }
    }

    public fun check_recipe(arg0: &BrainrotCollection, arg1: &vector<u8>) : (bool, address) {
        if (0x2::table::contains<vector<u8>, address>(&arg0.config.recipes, *arg1)) {
            (true, *0x2::table::borrow<vector<u8>, address>(&arg0.config.recipes, *arg1))
        } else {
            (false, @0x0)
        }
    }

    public fun claim_rewards(arg0: &mut BrainrotCollection, arg1: &mut StakeInfo, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg1.owner == 0x2::tx_context::sender(arg3), 2);
        let v0 = 0x2::object::id<StakeInfo>(arg1);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = calculate_rewards(arg0, arg1.last_reward_time, arg1.environment, v1);
        if (v2.valid && v2.amount > 0) {
            let v3 = &mut arg0.pending_rewards;
            update_pending_rewards(v3, v0, v2.amount);
        };
        arg1.last_reward_time = v1;
        let v4 = &mut arg0.pending_rewards;
        let v5 = extract_pending_reward(v4, v0);
        validate_reward_claim(&arg0.treasury, v5);
        let v6 = RewardClaimed{
            owner  : arg1.owner,
            nft_id : 0x2::object::id<CreatureNFT>(&arg1.nft),
            amount : v5,
        };
        0x2::event::emit<RewardClaimed>(v6);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.treasury, v5), arg3)
    }

    public entry fun claim_staking_rewards_entry(arg0: &mut BrainrotCollection, arg1: &mut StakeInfo, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = claim_rewards(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg3));
    }

    fun create_default_config(arg0: &mut 0x2::tx_context::TxContext) : CollectionConfig {
        CollectionConfig{
            creator_fee_bps      : 250,
            duplicate_recipe_fee : 10000000,
            recipes              : 0x2::table::new<vector<u8>, address>(arg0),
        }
    }

    fun create_default_event_status(arg0: u64) : EventStatus {
        EventStatus{
            active      : false,
            start_time  : 0,
            duration    : 0,
            reward_rate : arg0,
        }
    }

    fun create_default_events() : EnvironmentEvents {
        EnvironmentEvents{
            universe_event : create_default_event_status(600000000),
            sky_event      : create_default_event_status(200000000),
            seabed_event   : create_default_event_status(100000000),
        }
    }

    fun create_default_staking_stats() : StakingStats {
        StakingStats{
            staked_universe : 0,
            staked_sky      : 0,
            staked_seabed   : 0,
        }
    }

    public fun create_nft_metadata(arg0: 0x1::string::String, arg1: vector<ItemInfo>, arg2: vector<ItemInfo>, arg3: vector<ItemInfo>, arg4: vector<ItemInfo>, arg5: vector<ItemInfo>, arg6: vector<ItemInfo>, arg7: vector<ItemInfo>, arg8: 0x1::string::String, arg9: &0x2::clock::Clock) : NFTMetadata {
        validate_name(&arg0);
        NFTMetadata{
            name              : arg0,
            leg_items         : arg1,
            body_items        : arg2,
            hand_items        : arg3,
            head_items        : arg4,
            style_items       : arg5,
            material_items    : arg6,
            environment_items : arg7,
            image_uri         : arg8,
            created_at        : 0x2::clock::timestamp_ms(arg9),
        }
    }

    public entry fun end_event(arg0: &AdminCap, arg1: &mut BrainrotCollection, arg2: u8, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        validate_environment(arg2);
        let v0 = get_event_status_mut(arg1, arg2);
        assert!(v0.active, 7);
        let v1 = 0x2::clock::timestamp_ms(arg3) - v0.start_time;
        v0.duration = v1;
        v0.active = false;
        let v2 = EventEnded{
            environment    : arg2,
            total_duration : v1,
        };
        0x2::event::emit<EventEnded>(v2);
    }

    fun extract_pending_reward(arg0: &mut 0x2::table::Table<0x2::object::ID, u64>, arg1: 0x2::object::ID) : u64 {
        if (0x2::table::contains<0x2::object::ID, u64>(arg0, arg1)) {
            0x2::table::remove<0x2::object::ID, u64>(arg0, arg1)
        } else {
            0
        }
    }

    public fun get_collection_stats(arg0: &BrainrotCollection) : (u64, u64, u64, u64, u64) {
        (arg0.minted_count, arg0.staking_stats.staked_universe, arg0.staking_stats.staked_sky, arg0.staking_stats.staked_seabed, 0x2::balance::value<0x2::sui::SUI>(&arg0.treasury))
    }

    fun get_event_status(arg0: &BrainrotCollection, arg1: u8) : &EventStatus {
        let v0 = &arg1;
        let v1 = 0;
        if (v0 == &v1) {
            &arg0.events.universe_event
        } else {
            let v3 = 1;
            if (v0 == &v3) {
                &arg0.events.sky_event
            } else {
                let v4 = 2;
                assert!(v0 == &v4, 9);
                &arg0.events.seabed_event
            }
        }
    }

    fun get_event_status_mut(arg0: &mut BrainrotCollection, arg1: u8) : &mut EventStatus {
        let v0 = &arg1;
        let v1 = 0;
        if (v0 == &v1) {
            &mut arg0.events.universe_event
        } else {
            let v3 = 1;
            if (v0 == &v3) {
                &mut arg0.events.sky_event
            } else {
                let v4 = 2;
                assert!(v0 == &v4, 9);
                &mut arg0.events.seabed_event
            }
        }
    }

    public fun get_nft_info(arg0: &CreatureNFT) : (&0x1::string::String, address, u64) {
        (&arg0.metadata.name, arg0.creator, arg0.created_at)
    }

    public fun get_stake_info(arg0: &StakeInfo) : (0x2::object::ID, address, u8, u64, u64) {
        (0x2::object::id<CreatureNFT>(&arg0.nft), arg0.owner, arg0.environment, arg0.stake_time, arg0.last_reward_time)
    }

    fun handle_duplicate_payment(arg0: &BrainrotCollection, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: &vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.config.duplicate_recipe_fee;
        assert!(0x2::coin::value<0x2::sui::SUI>(arg1) >= v0, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg1, v0, arg3), 0x2::table::borrow<vector<u8>, PublicRecipe>(&arg0.public_recipes, *arg2).creator);
    }

    fun increment_recipe_usage(arg0: &mut BrainrotCollection, arg1: &vector<u8>) {
        if (0x2::table::contains<vector<u8>, PublicRecipe>(&arg0.public_recipes, *arg1)) {
            let v0 = 0x2::table::borrow_mut<vector<u8>, PublicRecipe>(&mut arg0.public_recipes, *arg1);
            v0.usage_count = v0.usage_count + 1;
        };
    }

    fun index_items_list(arg0: &mut BrainrotCollection, arg1: &vector<u8>, arg2: &vector<ItemInfo>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<ItemInfo>(arg2)) {
            let v1 = 0x1::vector::borrow<ItemInfo>(arg2, v0);
            if (0x2::table::contains<u64, vector<vector<u8>>>(&arg0.recipes_by_item, v1.item_id)) {
                0x1::vector::push_back<vector<u8>>(0x2::table::borrow_mut<u64, vector<vector<u8>>>(&mut arg0.recipes_by_item, v1.item_id), *arg1);
            } else {
                let v2 = 0x1::vector::empty<vector<u8>>();
                0x1::vector::push_back<vector<u8>>(&mut v2, *arg1);
                0x2::table::add<u64, vector<vector<u8>>>(&mut arg0.recipes_by_item, v1.item_id, v2);
            };
            v0 = v0 + 1;
        };
    }

    fun index_recipe_by_items(arg0: &mut BrainrotCollection, arg1: &vector<u8>, arg2: &NFTMetadata) {
        index_items_list(arg0, arg1, &arg2.leg_items);
        index_items_list(arg0, arg1, &arg2.body_items);
        index_items_list(arg0, arg1, &arg2.hand_items);
        index_items_list(arg0, arg1, &arg2.head_items);
        index_items_list(arg0, arg1, &arg2.style_items);
        index_items_list(arg0, arg1, &arg2.material_items);
        index_items_list(arg0, arg1, &arg2.environment_items);
    }

    fun init(arg0: CREATURE_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<CREATURE_NFT>(arg0, arg1);
        let (v1, v2) = 0x2::transfer_policy::new<CreatureNFT>(&v0, arg1);
        let v3 = 0x2::object::new(arg1);
        let v4 = create_default_config(arg1);
        let v5 = BrainrotCollection{
            id              : v3,
            minted_count    : 0,
            staking_stats   : create_default_staking_stats(),
            treasury        : 0x2::balance::zero<0x2::sui::SUI>(),
            config          : v4,
            events          : create_default_events(),
            pending_rewards : 0x2::table::new<0x2::object::ID, u64>(arg1),
            public_recipes  : 0x2::table::new<vector<u8>, PublicRecipe>(arg1),
            recipe_list     : 0x1::vector::empty<vector<u8>>(),
            used_names      : 0x2::table::new<0x1::string::String, address>(arg1),
            names_list      : 0x1::vector::empty<0x1::string::String>(),
            recipes_by_item : 0x2::table::new<u64, vector<vector<u8>>>(arg1),
        };
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<CreatureNFT>>(v1);
        let v6 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<CreatureNFT>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<BrainrotCollection>(v5);
    }

    public fun is_name_available(arg0: &BrainrotCollection, arg1: &0x1::string::String) : bool {
        !0x2::table::contains<0x1::string::String, address>(&arg0.used_names, *arg1)
    }

    fun max(arg0: u64, arg1: u64) : u64 {
        if (arg0 > arg1) {
            arg0
        } else {
            arg1
        }
    }

    fun min(arg0: u64, arg1: u64) : u64 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    public entry fun mint_creature_entry(arg0: &AdminCap, arg1: &mut BrainrotCollection, arg2: 0x1::string::String, arg3: vector<u64>, arg4: vector<u64>, arg5: vector<u64>, arg6: vector<u64>, arg7: vector<u64>, arg8: vector<u64>, arg9: vector<u64>, arg10: vector<u64>, arg11: vector<u64>, arg12: vector<u64>, arg13: vector<u64>, arg14: vector<u64>, arg15: vector<u64>, arg16: vector<u64>, arg17: 0x1::string::String, arg18: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg19: address, arg20: &0x2::clock::Clock, arg21: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<CreatureNFT>(mint_creature_nft(arg1, create_nft_metadata(arg2, build_simple_items(arg3, arg4), build_simple_items(arg5, arg6), build_simple_items(arg7, arg8), build_simple_items(arg9, arg10), build_simple_items(arg11, arg12), build_simple_items(arg13, arg14), build_simple_items(arg15, arg16), arg17, arg20), arg18, arg20, arg21), arg19);
    }

    public fun mint_creature_nft(arg0: &mut BrainrotCollection, arg1: NFTMetadata, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : CreatureNFT {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(is_name_available(arg0, &arg1.name), 11);
        reserve_name(arg0, arg1.name, v0);
        let v1 = calculate_recipe_hash(&arg1);
        let v2 = 0x2::table::contains<vector<u8>, PublicRecipe>(&arg0.public_recipes, v1);
        if (v2) {
            handle_duplicate_payment(arg0, arg2, &v1, arg4);
            increment_recipe_usage(arg0, &v1);
        } else {
            store_recipe(arg0, v1, v0, &arg1, arg3);
        };
        let v3 = CreatureNFT{
            id          : 0x2::object::new(arg4),
            metadata    : arg1,
            recipe_hash : v1,
            creator     : v0,
            created_at  : 0x2::clock::timestamp_ms(arg3),
        };
        arg0.minted_count = arg0.minted_count + 1;
        let v4 = NFTMinted{
            nft_id              : 0x2::object::id<CreatureNFT>(&v3),
            name                : v3.metadata.name,
            creator             : v3.creator,
            is_duplicate_recipe : v2,
        };
        0x2::event::emit<NFTMinted>(v4);
        v3
    }

    fun reserve_name(arg0: &mut BrainrotCollection, arg1: 0x1::string::String, arg2: address) {
        assert!(!0x2::table::contains<0x1::string::String, address>(&arg0.used_names, arg1), 11);
        0x2::table::add<0x1::string::String, address>(&mut arg0.used_names, arg1, arg2);
        0x1::vector::push_back<0x1::string::String>(&mut arg0.names_list, arg1);
    }

    fun serialize_items(arg0: &mut vector<u8>, arg1: &vector<ItemInfo>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<ItemInfo>(arg1)) {
            let v1 = 0x1::vector::borrow<ItemInfo>(arg1, v0);
            0x1::vector::append<u8>(arg0, u64_to_bytes(v1.item_id));
            0x1::vector::push_back<u8>(arg0, 0);
            0x1::vector::append<u8>(arg0, u64_to_bytes(v1.quantity));
            0x1::vector::push_back<u8>(arg0, 0);
            v0 = v0 + 1;
        };
    }

    fun serialize_recipe_data(arg0: &NFTMetadata) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = &mut v0;
        serialize_items(v1, &arg0.leg_items);
        let v2 = &mut v0;
        serialize_items(v2, &arg0.body_items);
        let v3 = &mut v0;
        serialize_items(v3, &arg0.hand_items);
        let v4 = &mut v0;
        serialize_items(v4, &arg0.head_items);
        let v5 = &mut v0;
        serialize_items(v5, &arg0.style_items);
        let v6 = &mut v0;
        serialize_items(v6, &arg0.material_items);
        let v7 = &mut v0;
        serialize_items(v7, &arg0.environment_items);
        v0
    }

    public entry fun stake_creature_entry(arg0: &mut BrainrotCollection, arg1: CreatureNFT, arg2: u8, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = stake_nft(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<StakeInfo>(v0, 0x2::tx_context::sender(arg4));
    }

    public fun stake_nft(arg0: &mut BrainrotCollection, arg1: CreatureNFT, arg2: u8, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : StakeInfo {
        validate_environment(arg2);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = StakeInfo{
            id               : 0x2::object::new(arg4),
            nft              : arg1,
            owner            : 0x2::tx_context::sender(arg4),
            environment      : arg2,
            stake_time       : v0,
            last_reward_time : v0,
        };
        let v2 = &mut arg0.staking_stats;
        update_staking_count(v2, arg2, true);
        let v3 = NFTStaked{
            nft_id      : 0x2::object::id<CreatureNFT>(&arg1),
            owner       : 0x2::tx_context::sender(arg4),
            environment : arg2,
            stake_time  : v0,
        };
        0x2::event::emit<NFTStaked>(v3);
        v1
    }

    public entry fun start_event(arg0: &AdminCap, arg1: &mut BrainrotCollection, arg2: u8, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        validate_environment(arg2);
        let v0 = get_event_status_mut(arg1, arg2);
        assert!(!v0.active, 8);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        let v2 = arg3 * 86400000;
        let v3 = EventStatus{
            active      : true,
            start_time  : v1,
            duration    : v2,
            reward_rate : arg4,
        };
        *v0 = v3;
        let v4 = EventStarted{
            environment : arg2,
            start_time  : v1,
            duration    : v2,
            reward_rate : arg4,
        };
        0x2::event::emit<EventStarted>(v4);
    }

    fun store_recipe(arg0: &mut BrainrotCollection, arg1: vector<u8>, arg2: address, arg3: &NFTMetadata, arg4: &0x2::clock::Clock) {
        let v0 = PublicRecipe{
            recipe_hash   : arg1,
            creator       : arg2,
            name          : arg3.name,
            metadata      : *arg3,
            creation_time : 0x2::clock::timestamp_ms(arg4),
            usage_count   : 1,
        };
        0x2::table::add<vector<u8>, PublicRecipe>(&mut arg0.public_recipes, arg1, v0);
        0x1::vector::push_back<vector<u8>>(&mut arg0.recipe_list, arg1);
        index_recipe_by_items(arg0, &arg1, arg3);
    }

    fun u64_to_bytes(arg0: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        if (arg0 == 0) {
            0x1::vector::push_back<u8>(&mut v0, 0);
            return v0
        };
        while (arg0 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 256) as u8));
            arg0 = arg0 / 256;
        };
        0x1::vector::reverse<u8>(&mut v0);
        v0
    }

    public entry fun unstake_creature_entry(arg0: &mut BrainrotCollection, arg1: StakeInfo, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<CreatureNFT>(unstake_nft(arg0, arg1, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    public fun unstake_nft(arg0: &mut BrainrotCollection, arg1: StakeInfo, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) : CreatureNFT {
        assert!(arg1.owner == 0x2::tx_context::sender(arg3), 2);
        let v0 = arg1.environment;
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = &mut arg0.staking_stats;
        update_staking_count(v2, v0, false);
        let v3 = calculate_rewards(arg0, arg1.last_reward_time, v0, v1);
        if (v3.valid && v3.amount > 0) {
            let v4 = &mut arg0.pending_rewards;
            update_pending_rewards(v4, 0x2::object::id<StakeInfo>(&arg1), v3.amount);
        };
        let v5 = NFTUnstaked{
            nft_id            : 0x2::object::id<CreatureNFT>(&arg1.nft),
            owner             : 0x2::tx_context::sender(arg3),
            environment       : v0,
            total_staked_time : v1 - arg1.stake_time,
        };
        0x2::event::emit<NFTUnstaked>(v5);
        let StakeInfo {
            id               : v6,
            nft              : v7,
            owner            : _,
            environment      : _,
            stake_time       : _,
            last_reward_time : _,
        } = arg1;
        0x2::object::delete(v6);
        v7
    }

    public entry fun update_creator_fee(arg0: &AdminCap, arg1: &mut BrainrotCollection, arg2: u16) {
        assert!(arg2 <= 10000, 10);
        arg1.config.creator_fee_bps = arg2;
    }

    public entry fun update_duplicate_recipe_fee(arg0: &AdminCap, arg1: &mut BrainrotCollection, arg2: u64) {
        arg1.config.duplicate_recipe_fee = arg2;
    }

    fun update_pending_rewards(arg0: &mut 0x2::table::Table<0x2::object::ID, u64>, arg1: 0x2::object::ID, arg2: u64) {
        if (0x2::table::contains<0x2::object::ID, u64>(arg0, arg1)) {
            let v0 = 0x2::table::borrow_mut<0x2::object::ID, u64>(arg0, arg1);
            *v0 = *v0 + arg2;
        } else {
            0x2::table::add<0x2::object::ID, u64>(arg0, arg1, arg2);
        };
    }

    public entry fun update_reward_rate(arg0: &AdminCap, arg1: &mut BrainrotCollection, arg2: u8, arg3: u64) {
        validate_environment(arg2);
        get_event_status_mut(arg1, arg2).reward_rate = arg3;
    }

    fun update_staking_count(arg0: &mut StakingStats, arg1: u8, arg2: bool) {
        let v0 = &arg1;
        let v1 = 0;
        if (v0 == &v1) {
            if (arg2) {
                arg0.staked_universe = arg0.staked_universe + 1;
            } else {
                arg0.staked_universe = arg0.staked_universe - 1;
            };
        } else {
            let v2 = 1;
            if (v0 == &v2) {
                if (arg2) {
                    arg0.staked_sky = arg0.staked_sky + 1;
                } else {
                    arg0.staked_sky = arg0.staked_sky - 1;
                };
            } else {
                let v3 = 2;
                assert!(v0 == &v3, 9);
                if (arg2) {
                    arg0.staked_seabed = arg0.staked_seabed + 1;
                } else {
                    arg0.staked_seabed = arg0.staked_seabed - 1;
                };
            };
        };
    }

    public fun validate_environment(arg0: u8) {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else {
            arg0 == 2
        };
        assert!(v0, 9);
    }

    fun validate_name(arg0: &0x1::string::String) {
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = 0x1::vector::length<u8>(v0);
        assert!(v1 > 0 && v1 <= 50, 12);
        let v2 = false;
        let v3 = 0;
        while (v3 < v1) {
            let v4 = *0x1::vector::borrow<u8>(v0, v3);
            let v5 = if (v4 != 32) {
                if (v4 != 9) {
                    if (v4 != 10) {
                        v4 != 13
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            if (v5) {
                v2 = true;
                break
            };
            v3 = v3 + 1;
        };
        assert!(v2, 12);
    }

    fun validate_reward_claim(arg0: &0x2::balance::Balance<0x2::sui::SUI>, arg1: u64) {
        assert!(arg1 > 0, 6);
        assert!(0x2::balance::value<0x2::sui::SUI>(arg0) >= arg1, 1);
    }

    // decompiled from Move bytecode v6
}

