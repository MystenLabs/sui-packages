module 0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::core {
    struct CORE has drop {
        dummy_field: bool,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        collections: 0x2::table::Table<0x2::object::ID, Collection>,
        platform_address: address,
        platform_fee_bps: u16,
        deployment_fee: u64,
        total_collections: u64,
        total_minted: u64,
        paused: bool,
    }

    struct Collection has store {
        collection_type: u8,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        description: 0x1::string::String,
        creator: address,
        max_supply: u64,
        minted: u64,
        base_uri: 0x2::url::Url,
        royalty_bps: u16,
        treasury: 0x2::balance::Balance<0x2::sui::SUI>,
        stages: 0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::mint_stage::MintStageConfig,
        mint_records: 0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::mint_stage::MintRecords,
        distribution: 0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::revenue::Distribution,
        reveal_time: 0x1::option::Option<u64>,
        placeholder_uri: 0x1::option::Option<0x2::url::Url>,
        items: 0x2::table::Table<u64, DropItem>,
        items_count: u64,
        next_available_token: u64,
        paused: bool,
        created_at: u64,
        updated_at: u64,
    }

    struct DropItem has store {
        token_id: u64,
        name: 0x1::string::String,
        uri: 0x2::url::Url,
        attributes: vector<0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::nft::Attribute>,
        reserved: bool,
        minted: bool,
    }

    struct CollectionCap has store, key {
        id: 0x2::object::UID,
        collection_id: 0x2::object::ID,
        creator: address,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun add_items(arg0: &mut Registry, arg1: &CollectionCap, arg2: vector<0x1::string::String>, arg3: vector<vector<u8>>, arg4: vector<vector<0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::nft::Attribute>>, arg5: vector<bool>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x2::object::ID, Collection>(&arg0.collections, arg1.collection_id), 6);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, Collection>(&mut arg0.collections, arg1.collection_id);
        assert!(v0.creator == arg1.creator, 1);
        assert!(0x2::tx_context::sender(arg7) == arg1.creator, 1);
        assert!(v0.collection_type == 1, 19);
        let v1 = 0x1::vector::length<0x1::string::String>(&arg2);
        assert!(v1 == 0x1::vector::length<vector<u8>>(&arg3), 15);
        assert!(v1 == 0x1::vector::length<vector<0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::nft::Attribute>>(&arg4), 15);
        assert!(v1 == 0x1::vector::length<bool>(&arg5), 15);
        assert!(v0.items_count + v1 <= v0.max_supply, 4);
        let v2 = 0;
        while (v2 < v1) {
            let v3 = v0.items_count + 1 + (v2 as u64);
            let v4 = DropItem{
                token_id   : v3,
                name       : *0x1::vector::borrow<0x1::string::String>(&arg2, v2),
                uri        : 0x2::url::new_unsafe_from_bytes(*0x1::vector::borrow<vector<u8>>(&arg3, v2)),
                attributes : *0x1::vector::borrow<vector<0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::nft::Attribute>>(&arg4, v2),
                reserved   : *0x1::vector::borrow<bool>(&arg5, v2),
                minted     : false,
            };
            0x2::table::add<u64, DropItem>(&mut v0.items, v3, v4);
            v2 = v2 + 1;
        };
        v0.items_count = v0.items_count + v1;
        v0.updated_at = 0x2::clock::timestamp_ms(arg6);
        0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::events::emit_drop_items_added(arg1.collection_id, v1, v0.items_count);
    }

    public(friend) fun add_to_treasury(arg0: &mut Collection, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury, arg1);
    }

    public(friend) fun borrow_collection_mut(arg0: &mut Registry, arg1: 0x2::object::ID) : &mut Collection {
        assert!(0x2::table::contains<0x2::object::ID, Collection>(&arg0.collections, arg1), 6);
        0x2::table::borrow_mut<0x2::object::ID, Collection>(&mut arg0.collections, arg1)
    }

    public fun cap_collection_id(arg0: &CollectionCap) : 0x2::object::ID {
        arg0.collection_id
    }

    public fun cap_creator(arg0: &CollectionCap) : address {
        arg0.creator
    }

    public(friend) fun collection_base_uri(arg0: &Collection) : 0x2::url::Url {
        arg0.base_uri
    }

    public(friend) fun collection_creator(arg0: &Collection) : address {
        arg0.creator
    }

    public(friend) fun collection_description(arg0: &Collection) : 0x1::string::String {
        arg0.description
    }

    public(friend) fun collection_max_supply(arg0: &Collection) : u64 {
        arg0.max_supply
    }

    public(friend) fun collection_mint_records_mut(arg0: &mut Collection) : &mut 0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::mint_stage::MintRecords {
        &mut arg0.mint_records
    }

    public(friend) fun collection_minted(arg0: &Collection) : u64 {
        arg0.minted
    }

    public(friend) fun collection_name(arg0: &Collection) : 0x1::string::String {
        arg0.name
    }

    public(friend) fun collection_paused(arg0: &Collection) : bool {
        arg0.paused
    }

    public(friend) fun collection_placeholder_uri(arg0: &Collection) : 0x1::option::Option<0x2::url::Url> {
        arg0.placeholder_uri
    }

    public(friend) fun collection_reveal_time(arg0: &Collection) : 0x1::option::Option<u64> {
        arg0.reveal_time
    }

    public(friend) fun collection_royalty_bps(arg0: &Collection) : u16 {
        arg0.royalty_bps
    }

    public(friend) fun collection_stages(arg0: &Collection) : &0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::mint_stage::MintStageConfig {
        &arg0.stages
    }

    public(friend) fun collection_type(arg0: &Collection) : u8 {
        arg0.collection_type
    }

    public fun configure_distribution(arg0: &mut Registry, arg1: &CollectionCap, arg2: vector<address>, arg3: vector<u64>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x2::object::ID, Collection>(&arg0.collections, arg1.collection_id), 6);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, Collection>(&mut arg0.collections, arg1.collection_id);
        assert!(v0.creator == arg1.creator, 1);
        assert!(0x2::tx_context::sender(arg5) == arg1.creator, 1);
        v0.distribution = 0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::revenue::new_distribution(arg2, arg3);
        v0.updated_at = 0x2::clock::timestamp_ms(arg4);
    }

    public fun configure_stages(arg0: &mut Registry, arg1: &CollectionCap, arg2: vector<0x1::string::String>, arg3: vector<u64>, arg4: vector<u64>, arg5: vector<u64>, arg6: vector<u64>, arg7: vector<bool>, arg8: vector<0x1::option::Option<vector<u8>>>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x2::object::ID, Collection>(&arg0.collections, arg1.collection_id), 6);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, Collection>(&mut arg0.collections, arg1.collection_id);
        assert!(v0.creator == arg1.creator, 1);
        assert!(0x2::tx_context::sender(arg10) == arg1.creator, 1);
        let v1 = 0x1::vector::length<0x1::string::String>(&arg2);
        assert!(v1 == 0x1::vector::length<u64>(&arg3), 15);
        assert!(v1 == 0x1::vector::length<u64>(&arg4), 15);
        assert!(v1 == 0x1::vector::length<u64>(&arg5), 15);
        assert!(v1 == 0x1::vector::length<u64>(&arg6), 15);
        assert!(v1 == 0x1::vector::length<bool>(&arg7), 15);
        assert!(v1 == 0x1::vector::length<0x1::option::Option<vector<u8>>>(&arg8), 15);
        let v2 = 0x1::vector::empty<0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::mint_stage::MintStage>();
        let v3 = 0;
        while (v3 < v1) {
            0x1::vector::push_back<0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::mint_stage::MintStage>(&mut v2, 0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::mint_stage::new_stage(*0x1::vector::borrow<0x1::string::String>(&arg2, v3), *0x1::vector::borrow<u64>(&arg3, v3), *0x1::vector::borrow<u64>(&arg4, v3), *0x1::vector::borrow<u64>(&arg5, v3), *0x1::vector::borrow<u64>(&arg6, v3), *0x1::vector::borrow<bool>(&arg7, v3), *0x1::vector::borrow<0x1::option::Option<vector<u8>>>(&arg8, v3)));
            v3 = v3 + 1;
        };
        v0.stages = 0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::mint_stage::new_config(v2);
        v0.updated_at = 0x2::clock::timestamp_ms(arg9);
        0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::events::emit_mint_stages_configured(arg1.collection_id, v1);
    }

    public fun delete_collection(arg0: &mut Registry, arg1: CollectionCap, arg2: &mut 0x2::tx_context::TxContext) {
        let CollectionCap {
            id            : v0,
            collection_id : v1,
            creator       : v2,
        } = arg1;
        0x2::object::delete(v0);
        assert!(0x2::tx_context::sender(arg2) == v2, 1);
        assert!(0x2::table::contains<0x2::object::ID, Collection>(&arg0.collections, v1), 6);
        let v3 = 0x2::table::remove<0x2::object::ID, Collection>(&mut arg0.collections, v1);
        assert!(v3.minted == 0, 16);
        let Collection {
            collection_type      : _,
            name                 : _,
            symbol               : _,
            description          : _,
            creator              : _,
            max_supply           : _,
            minted               : _,
            base_uri             : _,
            royalty_bps          : _,
            treasury             : v13,
            stages               : _,
            mint_records         : v15,
            distribution         : _,
            reveal_time          : _,
            placeholder_uri      : _,
            items                : v19,
            items_count          : v20,
            next_available_token : _,
            paused               : _,
            created_at           : _,
            updated_at           : _,
        } = v3;
        let v25 = v19;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v13);
        0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::mint_stage::destroy_records(v15);
        let v26 = 1;
        while (v26 <= v20) {
            if (0x2::table::contains<u64, DropItem>(&v25, v26)) {
                let DropItem {
                    token_id   : _,
                    name       : _,
                    uri        : _,
                    attributes : _,
                    reserved   : _,
                    minted     : _,
                } = 0x2::table::remove<u64, DropItem>(&mut v25, v26);
            };
            v26 = v26 + 1;
        };
        0x2::table::destroy_empty<u64, DropItem>(v25);
        arg0.total_collections = arg0.total_collections - 1;
        0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::events::emit_collection_deleted(v1);
    }

    public fun deploy_collection(arg0: &mut Registry, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: vector<u8>, arg7: u16, arg8: u8, arg9: 0x1::option::Option<u64>, arg10: 0x1::option::Option<vector<u8>>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 13);
        assert!(arg5 > 0, 2);
        assert!(arg7 <= 1000, 3);
        assert!(arg8 == 0 || arg8 == 1, 18);
        if (arg0.deployment_fee > 0) {
            assert!(0x2::coin::value<0x2::sui::SUI>(arg1) >= arg0.deployment_fee, 5);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg1, arg0.deployment_fee, arg12), arg0.platform_address);
        };
        let v0 = 0x2::tx_context::sender(arg12);
        let v1 = 0x2::object::new(arg12);
        let v2 = 0x2::object::uid_to_inner(&v1);
        0x2::object::delete(v1);
        let v3 = if (0x1::option::is_some<vector<u8>>(&arg10)) {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x1::option::destroy_some<vector<u8>>(arg10)))
        } else {
            0x1::option::destroy_none<vector<u8>>(arg10);
            0x1::option::none<0x2::url::Url>()
        };
        let v4 = Collection{
            collection_type      : arg8,
            name                 : 0x1::string::utf8(arg2),
            symbol               : 0x1::string::utf8(arg3),
            description          : 0x1::string::utf8(arg4),
            creator              : v0,
            max_supply           : arg5,
            minted               : 0,
            base_uri             : 0x2::url::new_unsafe_from_bytes(arg6),
            royalty_bps          : arg7,
            treasury             : 0x2::balance::zero<0x2::sui::SUI>(),
            stages               : 0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::mint_stage::empty_config(),
            mint_records         : 0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::mint_stage::new_records(arg12),
            distribution         : 0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::revenue::default_distribution(v0),
            reveal_time          : arg9,
            placeholder_uri      : v3,
            items                : 0x2::table::new<u64, DropItem>(arg12),
            items_count          : 0,
            next_available_token : 1,
            paused               : true,
            created_at           : 0x2::clock::timestamp_ms(arg11),
            updated_at           : 0x2::clock::timestamp_ms(arg11),
        };
        0x2::table::add<0x2::object::ID, Collection>(&mut arg0.collections, v2, v4);
        arg0.total_collections = arg0.total_collections + 1;
        let v5 = CollectionCap{
            id            : 0x2::object::new(arg12),
            collection_id : v2,
            creator       : v0,
        };
        0x2::transfer::transfer<CollectionCap>(v5, v0);
        0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::events::emit_collection_created(v2, 0x1::string::utf8(arg2), 0x1::string::utf8(arg3), v0, arg8, arg5, arg7, arg0.platform_fee_bps);
    }

    public fun distribute_revenue(arg0: &mut Registry, arg1: &CollectionCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x2::object::ID, Collection>(&arg0.collections, arg1.collection_id), 6);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, Collection>(&mut arg0.collections, arg1.collection_id);
        assert!(v0.creator == arg1.creator, 1);
        assert!(0x2::tx_context::sender(arg2) == arg1.creator, 1);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&v0.treasury);
        if (v1 == 0) {
            return
        };
        let v2 = *0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::revenue::addresses(&v0.distribution);
        let v3 = *0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::revenue::shares(&v0.distribution);
        let v4 = 0x1::vector::length<address>(&v2);
        let v5 = 0;
        let v6 = 0;
        while (v6 < 0x1::vector::length<u64>(&v3)) {
            v5 = v5 + *0x1::vector::borrow<u64>(&v3, v6);
            v6 = v6 + 1;
        };
        let v7 = 0;
        while (v7 < v4) {
            let v8 = if (v7 == v4 - 1) {
                0x2::balance::value<0x2::sui::SUI>(&v0.treasury)
            } else {
                (((v1 as u128) * (*0x1::vector::borrow<u64>(&v3, v7) as u128) / (v5 as u128)) as u64)
            };
            if (v8 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v0.treasury, v8), arg2), *0x1::vector::borrow<address>(&v2, v7));
            };
            v7 = v7 + 1;
        };
        0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::events::emit_revenue_distributed(arg1.collection_id, v1);
    }

    public(friend) fun drop_item_attributes(arg0: &DropItem) : vector<0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::nft::Attribute> {
        arg0.attributes
    }

    public(friend) fun drop_item_name(arg0: &DropItem) : 0x1::string::String {
        arg0.name
    }

    public(friend) fun drop_item_reserved(arg0: &DropItem) : bool {
        arg0.reserved
    }

    public(friend) fun drop_item_uri(arg0: &DropItem) : 0x2::url::Url {
        arg0.uri
    }

    public fun get_collection_info(arg0: &Registry, arg1: 0x2::object::ID) : (0x1::string::String, 0x1::string::String, 0x1::string::String, address, u64, u64, u16, bool, u64, u8) {
        assert!(0x2::table::contains<0x2::object::ID, Collection>(&arg0.collections, arg1), 6);
        let v0 = 0x2::table::borrow<0x2::object::ID, Collection>(&arg0.collections, arg1);
        (v0.name, v0.symbol, v0.description, v0.creator, v0.max_supply, v0.minted, v0.royalty_bps, v0.paused, 0x2::balance::value<0x2::sui::SUI>(&v0.treasury), v0.collection_type)
    }

    public(friend) fun get_drop_item(arg0: &Collection, arg1: u64) : &DropItem {
        0x2::table::borrow<u64, DropItem>(&arg0.items, arg1)
    }

    public(friend) fun get_next_unminted_item(arg0: &Collection) : (u64, &DropItem) {
        let v0 = arg0.next_available_token;
        while (v0 <= arg0.items_count) {
            if (0x2::table::contains<u64, DropItem>(&arg0.items, v0)) {
                let v1 = 0x2::table::borrow<u64, DropItem>(&arg0.items, v0);
                if (!v1.minted && !v1.reserved) {
                    return (v0, v1)
                };
            };
            v0 = v0 + 1;
        };
        abort 20
    }

    public fun get_registry_stats(arg0: &Registry) : (u64, u64, u16, bool) {
        (arg0.total_collections, arg0.total_minted, arg0.platform_fee_bps, arg0.paused)
    }

    public(friend) fun increment_minted(arg0: &mut Collection) {
        arg0.minted = arg0.minted + 1;
    }

    public(friend) fun increment_registry_minted(arg0: &mut Registry) {
        arg0.total_minted = arg0.total_minted + 1;
    }

    fun init(arg0: CORE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id                : 0x2::object::new(arg1),
            collections       : 0x2::table::new<0x2::object::ID, Collection>(arg1),
            platform_address  : 0x2::tx_context::sender(arg1),
            platform_fee_bps  : 500,
            deployment_fee    : 1000000000,
            total_collections : 0,
            total_minted      : 0,
            paused            : false,
        };
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::share_object<Registry>(v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<CORE>(arg0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun mark_item_minted(arg0: &mut Collection, arg1: u64) {
        let v0 = 0x2::table::borrow_mut<u64, DropItem>(&mut arg0.items, arg1);
        assert!(!v0.minted, 21);
        v0.minted = true;
        if (arg1 == arg0.next_available_token) {
            arg0.next_available_token = arg1 + 1;
        };
    }

    public(friend) fun registry_paused(arg0: &Registry) : bool {
        arg0.paused
    }

    public(friend) fun registry_platform_address(arg0: &Registry) : address {
        arg0.platform_address
    }

    public(friend) fun registry_platform_fee_bps(arg0: &Registry) : u16 {
        arg0.platform_fee_bps
    }

    public fun set_paused(arg0: &mut Registry, arg1: &CollectionCap, arg2: bool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x2::object::ID, Collection>(&arg0.collections, arg1.collection_id), 6);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, Collection>(&mut arg0.collections, arg1.collection_id);
        assert!(v0.creator == arg1.creator, 1);
        assert!(0x2::tx_context::sender(arg4) == arg1.creator, 1);
        v0.paused = arg2;
        v0.updated_at = 0x2::clock::timestamp_ms(arg3);
        if (arg2) {
            0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::events::emit_collection_paused(arg1.collection_id, 0x2::clock::timestamp_ms(arg3));
        } else {
            0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::events::emit_collection_unpaused(arg1.collection_id, 0x2::clock::timestamp_ms(arg3));
        };
    }

    public fun set_registry_paused(arg0: &mut Registry, arg1: &AdminCap, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.paused = arg2;
        0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::events::emit_registry_paused_changed(arg2);
    }

    public fun update_deployment_fee(arg0: &mut Registry, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.deployment_fee = arg2;
        0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::events::emit_deployment_fee_updated(arg0.deployment_fee, arg2);
    }

    public fun update_platform_address(arg0: &mut Registry, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 != @0x0, 17);
        arg0.platform_address = arg2;
        0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::events::emit_platform_address_updated(arg0.platform_address, arg2);
    }

    public fun update_platform_fee(arg0: &mut Registry, arg1: &AdminCap, arg2: u16, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 1000, 14);
        arg0.platform_fee_bps = arg2;
        0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::events::emit_platform_fee_updated(arg0.platform_fee_bps, arg2);
    }

    // decompiled from Move bytecode v6
}

