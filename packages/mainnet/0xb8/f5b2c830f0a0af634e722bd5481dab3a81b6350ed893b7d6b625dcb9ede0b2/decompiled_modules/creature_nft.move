module 0x1f246b075220ec5f49435224ca862fa60c254b9c544c8961764b1bfe77bf8728::creature_nft {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct BrainrotCollection has key {
        id: 0x2::object::UID,
        minted_count: u64,
        treasury: 0x2::balance::Balance<0x2::sui::SUI>,
        config: CollectionConfig,
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

    struct CreatureNFT has store, key {
        id: 0x2::object::UID,
        metadata: NFTMetadata,
        recipe_hash: vector<u8>,
        creator: address,
        created_at: u64,
    }

    struct CreatureNFTv2 has store, key {
        id: 0x2::object::UID,
        metadata: NFTMetadataV2,
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

    struct NFTMetadataV2 has copy, drop, store {
        name: 0x1::string::String,
        material_items: vector<ItemInfo>,
        image_uri: 0x1::string::String,
        created_at: u64,
        prompt: 0x1::string::String,
    }

    struct NFTMinted has copy, drop {
        nft_id: 0x2::object::ID,
        name: 0x1::string::String,
        creator: address,
        is_duplicate_recipe: bool,
    }

    struct CREATURE_NFT has drop {
        dummy_field: bool,
    }

    public fun add_treasury_funds(arg0: &AdminCap, arg1: &mut BrainrotCollection, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.treasury, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg2, arg3, arg4)));
    }

    public fun admin_mint_nft_v2(arg0: &AdminCap, arg1: &mut BrainrotCollection, arg2: 0x1::string::String, arg3: vector<u64>, arg4: vector<u64>, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: address, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(is_name_available(arg1, &arg2), 11);
        validate_name(&arg2);
        reserve_name(arg1, arg2, 0x2::tx_context::sender(arg9));
        let v0 = build_simple_items(arg3, arg4);
        let v1 = 0x1::hash::sha2_256(*0x1::string::as_bytes(&arg5));
        let v2 = false;
        if (0x2::table::contains<vector<u8>, PublicRecipe>(&arg1.public_recipes, v1)) {
            v2 = true;
            increment_recipe_usage(arg1, &v1);
        } else {
            let v3 = NFTMetadata{
                name              : arg2,
                leg_items         : 0x1::vector::empty<ItemInfo>(),
                body_items        : 0x1::vector::empty<ItemInfo>(),
                hand_items        : 0x1::vector::empty<ItemInfo>(),
                head_items        : 0x1::vector::empty<ItemInfo>(),
                style_items       : 0x1::vector::empty<ItemInfo>(),
                material_items    : v0,
                environment_items : 0x1::vector::empty<ItemInfo>(),
                image_uri         : arg6,
                created_at        : 0x2::clock::timestamp_ms(arg8),
            };
            let v4 = PublicRecipe{
                recipe_hash   : v1,
                creator       : 0x2::tx_context::sender(arg9),
                name          : arg2,
                metadata      : v3,
                creation_time : 0x2::clock::timestamp_ms(arg8),
                usage_count   : 1,
            };
            0x2::table::add<vector<u8>, PublicRecipe>(&mut arg1.public_recipes, v1, v4);
            0x1::vector::push_back<vector<u8>>(&mut arg1.recipe_list, v1);
        };
        let v5 = NFTMetadataV2{
            name           : arg2,
            material_items : v0,
            image_uri      : arg6,
            created_at     : 0x2::clock::timestamp_ms(arg8),
            prompt         : arg5,
        };
        let v6 = 0x2::object::new(arg9);
        arg1.minted_count = arg1.minted_count + 1;
        let v7 = NFTMinted{
            nft_id              : 0x2::object::uid_to_inner(&v6),
            name                : v5.name,
            creator             : 0x2::tx_context::sender(arg9),
            is_duplicate_recipe : v2,
        };
        0x2::event::emit<NFTMinted>(v7);
        let v8 = CreatureNFTv2{
            id         : v6,
            metadata   : v5,
            creator    : 0x2::tx_context::sender(arg9),
            created_at : 0x2::clock::timestamp_ms(arg8),
        };
        0x2::transfer::public_transfer<CreatureNFTv2>(v8, arg7);
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

    public fun check_recipe(arg0: &BrainrotCollection, arg1: &vector<u8>) : (bool, address) {
        if (0x2::table::contains<vector<u8>, address>(&arg0.config.recipes, *arg1)) {
            (true, *0x2::table::borrow<vector<u8>, address>(&arg0.config.recipes, *arg1))
        } else {
            (false, @0x0)
        }
    }

    fun create_default_config(arg0: &mut 0x2::tx_context::TxContext) : CollectionConfig {
        CollectionConfig{
            creator_fee_bps      : 250,
            duplicate_recipe_fee : 10000000,
            recipes              : 0x2::table::new<vector<u8>, address>(arg0),
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

    fun extract_ids_from_items(arg0: &mut vector<u64>, arg1: &vector<ItemInfo>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<ItemInfo>(arg1)) {
            let v1 = 0x1::vector::borrow<ItemInfo>(arg1, v0);
            if (!0x1::vector::contains<u64>(arg0, &v1.item_id)) {
                0x1::vector::push_back<u64>(arg0, v1.item_id);
            };
            v0 = v0 + 1;
        };
    }

    public fun get_all_item_ids(arg0: &CreatureNFT) : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = &mut v0;
        extract_ids_from_items(v1, &arg0.metadata.leg_items);
        let v2 = &mut v0;
        extract_ids_from_items(v2, &arg0.metadata.body_items);
        let v3 = &mut v0;
        extract_ids_from_items(v3, &arg0.metadata.hand_items);
        let v4 = &mut v0;
        extract_ids_from_items(v4, &arg0.metadata.head_items);
        let v5 = &mut v0;
        extract_ids_from_items(v5, &arg0.metadata.style_items);
        let v6 = &mut v0;
        extract_ids_from_items(v6, &arg0.metadata.material_items);
        let v7 = &mut v0;
        extract_ids_from_items(v7, &arg0.metadata.environment_items);
        v0
    }

    public fun get_collection_stats(arg0: &BrainrotCollection) : (u64, u64) {
        (arg0.minted_count, 0x2::balance::value<0x2::sui::SUI>(&arg0.treasury))
    }

    public fun get_nft_info(arg0: &CreatureNFT) : (&0x1::string::String, address, u64) {
        (&arg0.metadata.name, arg0.creator, arg0.created_at)
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
            treasury        : 0x2::balance::zero<0x2::sui::SUI>(),
            config          : v4,
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

    public fun mint_creature_entry(arg0: &AdminCap, arg1: &mut BrainrotCollection, arg2: 0x1::string::String, arg3: vector<u64>, arg4: vector<u64>, arg5: vector<u64>, arg6: vector<u64>, arg7: vector<u64>, arg8: vector<u64>, arg9: vector<u64>, arg10: vector<u64>, arg11: vector<u64>, arg12: vector<u64>, arg13: vector<u64>, arg14: vector<u64>, arg15: vector<u64>, arg16: vector<u64>, arg17: 0x1::string::String, arg18: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg19: address, arg20: &0x2::clock::Clock, arg21: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(arg18) == arg1.config.duplicate_recipe_fee, 14);
        0x2::transfer::public_transfer<CreatureNFT>(mint_creature_nft(arg1, create_nft_metadata(arg2, build_simple_items(arg3, arg4), build_simple_items(arg5, arg6), build_simple_items(arg7, arg8), build_simple_items(arg9, arg10), build_simple_items(arg11, arg12), build_simple_items(arg13, arg14), build_simple_items(arg15, arg16), arg17, arg20), arg18, arg20, arg19, arg21), arg19);
    }

    public fun mint_creature_nft(arg0: &mut BrainrotCollection, arg1: NFTMetadata, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: address, arg5: &mut 0x2::tx_context::TxContext) : CreatureNFT {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(is_name_available(arg0, &arg1.name), 11);
        reserve_name(arg0, arg1.name, v0);
        let v1 = calculate_recipe_hash(&arg1);
        let v2 = 0x2::table::contains<vector<u8>, PublicRecipe>(&arg0.public_recipes, v1);
        if (v2) {
            handle_duplicate_payment(arg0, arg2, &v1, arg5);
            increment_recipe_usage(arg0, &v1);
        } else {
            store_recipe(arg0, v1, arg4, &arg1, arg3);
        };
        let v3 = CreatureNFT{
            id          : 0x2::object::new(arg5),
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

    public fun mint_from_elements(arg0: &mut BrainrotCollection, arg1: 0x1::string::String, arg2: vector<u64>, arg3: vector<u64>, arg4: 0x1::string::String, arg5: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg6: address, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(arg5) == arg0.config.duplicate_recipe_fee, 14);
        0x2::transfer::public_transfer<CreatureNFT>(mint_creature_nft(arg0, create_nft_metadata(arg1, 0x1::vector::empty<ItemInfo>(), 0x1::vector::empty<ItemInfo>(), 0x1::vector::empty<ItemInfo>(), 0x1::vector::empty<ItemInfo>(), 0x1::vector::empty<ItemInfo>(), build_simple_items(arg2, arg3), 0x1::vector::empty<ItemInfo>(), arg4, arg7), arg5, arg7, arg6, arg8), arg6);
    }

    public fun mint_from_prompt(arg0: &AdminCap, arg1: &mut BrainrotCollection, arg2: 0x1::string::String, arg3: vector<u64>, arg4: vector<u64>, arg5: 0x1::string::String, arg6: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg7: address, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(arg6) == arg1.config.duplicate_recipe_fee, 14);
        0x2::transfer::public_transfer<CreatureNFT>(mint_creature_nft(arg1, create_nft_metadata(arg2, 0x1::vector::empty<ItemInfo>(), 0x1::vector::empty<ItemInfo>(), 0x1::vector::empty<ItemInfo>(), 0x1::vector::empty<ItemInfo>(), 0x1::vector::empty<ItemInfo>(), build_simple_items(arg3, arg4), 0x1::vector::empty<ItemInfo>(), arg5, arg8), arg6, arg8, arg7, arg9), arg7);
    }

    public fun mint_nft_v2(arg0: &mut BrainrotCollection, arg1: 0x1::string::String, arg2: vector<u64>, arg3: vector<u64>, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg7: address, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
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

    public fun update_creator_fee(arg0: &AdminCap, arg1: &mut BrainrotCollection, arg2: u16) {
        assert!(arg2 <= 10000, 10);
        arg1.config.creator_fee_bps = arg2;
    }

    public fun update_duplicate_recipe_fee(arg0: &AdminCap, arg1: &mut BrainrotCollection, arg2: u64) {
        arg1.config.duplicate_recipe_fee = arg2;
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

    // decompiled from Move bytecode v6
}

