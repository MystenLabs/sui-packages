module 0x97e6c267e6887d5cdb11543e87b22c1ae67c81dbc8d17ab8541066d31d279bc4::creature_nft {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Collection has key {
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
        creator: address,
        created_at: u64,
    }

    struct ItemInfo has copy, drop, store {
        item_id: u64,
        quantity: u64,
    }

    struct NFTMetadata has copy, drop, store {
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

    public fun add_treasury_funds(arg0: &AdminCap, arg1: &mut Collection, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.treasury, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg2, arg3, arg4)));
    }

    public fun admin_mint_nft(arg0: &AdminCap, arg1: &mut Collection, arg2: 0x1::string::String, arg3: vector<u64>, arg4: vector<u64>, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg8: address, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(is_name_available(arg1, &arg2), 11);
        validate_name(&arg2);
        reserve_name(arg1, arg2, 0x2::tx_context::sender(arg10));
        let v0 = build_simple_items(arg3, arg4);
        let v1 = 0x1::hash::sha2_256(*0x1::string::as_bytes(&arg5));
        let v2 = false;
        if (0x2::table::contains<vector<u8>, PublicRecipe>(&arg1.public_recipes, v1)) {
            v2 = true;
            let v3 = 0x2::coin::value<0x2::sui::SUI>(arg7);
            if (v3 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg7, v3, arg10), 0x2::table::borrow<vector<u8>, PublicRecipe>(&arg1.public_recipes, v1).creator);
            };
            increment_recipe_usage(arg1, &v1);
        } else {
            let v4 = 0x2::coin::value<0x2::sui::SUI>(arg7);
            if (v4 > 0) {
                0x2::balance::join<0x2::sui::SUI>(&mut arg1.treasury, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg7, v4, arg10)));
            };
            let v5 = NFTMetadata{
                name           : arg2,
                material_items : v0,
                image_uri      : arg6,
                created_at     : 0x2::clock::timestamp_ms(arg9),
                prompt         : arg5,
            };
            let v6 = PublicRecipe{
                recipe_hash   : v1,
                creator       : 0x2::tx_context::sender(arg10),
                name          : arg2,
                metadata      : v5,
                creation_time : 0x2::clock::timestamp_ms(arg9),
                usage_count   : 1,
            };
            0x2::table::add<vector<u8>, PublicRecipe>(&mut arg1.public_recipes, v1, v6);
            0x1::vector::push_back<vector<u8>>(&mut arg1.recipe_list, v1);
        };
        let v7 = NFTMetadata{
            name           : arg2,
            material_items : v0,
            image_uri      : arg6,
            created_at     : 0x2::clock::timestamp_ms(arg9),
            prompt         : arg5,
        };
        let v8 = 0x2::object::new(arg10);
        arg1.minted_count = arg1.minted_count + 1;
        let v9 = NFTMinted{
            nft_id              : 0x2::object::uid_to_inner(&v8),
            name                : v7.name,
            creator             : 0x2::tx_context::sender(arg10),
            is_duplicate_recipe : v2,
        };
        0x2::event::emit<NFTMinted>(v9);
        let v10 = CreatureNFT{
            id         : v8,
            metadata   : v7,
            creator    : 0x2::tx_context::sender(arg10),
            created_at : 0x2::clock::timestamp_ms(arg9),
        };
        0x2::transfer::public_transfer<CreatureNFT>(v10, arg8);
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

    public fun check_recipe(arg0: &Collection, arg1: &vector<u8>) : (bool, address) {
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
        extract_ids_from_items(v1, &arg0.metadata.material_items);
        v0
    }

    public fun get_collection_stats(arg0: &Collection) : (u64, u64) {
        (arg0.minted_count, 0x2::balance::value<0x2::sui::SUI>(&arg0.treasury))
    }

    public fun get_nft_info(arg0: &CreatureNFT) : (&0x1::string::String, address, u64) {
        (&arg0.metadata.name, arg0.creator, arg0.created_at)
    }

    fun increment_recipe_usage(arg0: &mut Collection, arg1: &vector<u8>) {
        if (0x2::table::contains<vector<u8>, PublicRecipe>(&arg0.public_recipes, *arg1)) {
            let v0 = 0x2::table::borrow_mut<vector<u8>, PublicRecipe>(&mut arg0.public_recipes, *arg1);
            v0.usage_count = v0.usage_count + 1;
        };
    }

    fun init(arg0: CREATURE_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<CREATURE_NFT>(arg0, arg1);
        let (v1, v2) = 0x2::transfer_policy::new<CreatureNFT>(&v0, arg1);
        let v3 = 0x2::object::new(arg1);
        let v4 = create_default_config(arg1);
        let v5 = Collection{
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
        0x2::transfer::share_object<Collection>(v5);
    }

    public fun is_name_available(arg0: &Collection, arg1: &0x1::string::String) : bool {
        !0x2::table::contains<0x1::string::String, address>(&arg0.used_names, *arg1)
    }

    fun reserve_name(arg0: &mut Collection, arg1: 0x1::string::String, arg2: address) {
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
        serialize_items(v1, &arg0.material_items);
        v0
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

    public fun update_creator_fee(arg0: &AdminCap, arg1: &mut Collection, arg2: u16) {
        assert!(arg2 <= 10000, 10);
        arg1.config.creator_fee_bps = arg2;
    }

    public fun update_duplicate_recipe_fee(arg0: &AdminCap, arg1: &mut Collection, arg2: u64) {
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

