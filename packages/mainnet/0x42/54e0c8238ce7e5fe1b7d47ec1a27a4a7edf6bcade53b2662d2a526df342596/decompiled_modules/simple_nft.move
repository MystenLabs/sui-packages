module 0x4254e0c8238ce7e5fe1b7d47ec1a27a4a7edf6bcade53b2662d2a526df342596::simple_nft {
    struct SIMPLE_NFT has drop {
        dummy_field: bool,
    }

    struct Witness has drop, store {
        dummy_field: bool,
    }

    struct Collection has key {
        id: 0x2::object::UID,
        initialized: bool,
        name: 0x1::option::Option<0x1::string::String>,
        description: 0x1::option::Option<0x1::string::String>,
        symbol: 0x1::option::Option<0x1::string::String>,
        creator: address,
        total_supply: u64,
        max_supply: 0x1::option::Option<u64>,
        project_url: 0x1::option::Option<0x1::string::String>,
        creator_name: 0x1::option::Option<0x1::string::String>,
        base_image_uri: 0x1::option::Option<0x1::string::String>,
        base_thumbnail_uri: 0x1::option::Option<0x1::string::String>,
        name_prefix: 0x1::string::String,
        description_template: 0x1::string::String,
        is_frozen: bool,
        price_config: 0x1::option::Option<PriceConfig>,
        free_mint_config: MintConfig,
        public_mint_config: MintConfig,
        allowlist_mint_config: MintConfig,
        allowlist_merkle_root: 0x1::option::Option<vector<u8>>,
        registry_ids: RegistryIds,
    }

    struct NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        serial_number: u64,
        collection: 0x2::object::ID,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        collection: 0x2::object::ID,
    }

    struct MintCapFields has store {
        collection: 0x2::object::ID,
        mint_limit_per_address: u64,
        mint_count_by_address: 0x2::table::Table<address, u64>,
        expires_at: 0x1::option::Option<u64>,
    }

    struct FreeMintCap has store, key {
        id: 0x2::object::UID,
        fields: MintCapFields,
    }

    struct PublicMintCap has store, key {
        id: 0x2::object::UID,
        fields: MintCapFields,
    }

    struct AllowListCap has store, key {
        id: 0x2::object::UID,
        fields: MintCapFields,
    }

    struct MintConfig has drop, store {
        is_active: bool,
        start_time: 0x1::option::Option<u64>,
        end_time: 0x1::option::Option<u64>,
        mint_limit: u64,
    }

    struct PriceConfig has copy, drop, store {
        public_price: u64,
        allowlist_price: u64,
    }

    struct FreeMintCapRegistry has store, key {
        id: 0x2::object::UID,
        caps_by_address: 0x2::table::Table<address, vector<0x2::object::ID>>,
    }

    struct PublicMintCapRegistry has store, key {
        id: 0x2::object::UID,
        caps_by_address: 0x2::table::Table<address, vector<0x2::object::ID>>,
    }

    struct AllowListMintCapRegistry has store, key {
        id: 0x2::object::UID,
        caps_by_address: 0x2::table::Table<address, vector<0x2::object::ID>>,
    }

    struct RegistryIds has copy, drop, store {
        free_mint: 0x2::object::ID,
        public_mint: 0x2::object::ID,
        allowlist: 0x2::object::ID,
    }

    struct MintCapRegistryMarker has copy, drop, store {
        dummy_field: bool,
    }

    struct FreeMintRegistryMarker has copy, drop, store {
        dummy_field: bool,
    }

    struct PublicMintRegistryMarker has copy, drop, store {
        dummy_field: bool,
    }

    struct AllowListRegistryMarker has copy, drop, store {
        dummy_field: bool,
    }

    struct PriceConfigKey has copy, drop, store {
        dummy_field: bool,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        collection: 0x2::object::ID,
        name: 0x1::string::String,
        serial_number: u64,
    }

    struct CollectionInitialized has copy, drop {
        collection_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
    }

    struct DisplayInitialized has copy, drop {
        collection_id: 0x2::object::ID,
        creator: address,
    }

    struct BaseURIUpdated has copy, drop {
        collection_id: 0x2::object::ID,
        image_uri: 0x1::option::Option<0x1::string::String>,
        thumbnail_uri: 0x1::option::Option<0x1::string::String>,
        updated_by: address,
    }

    public fun add_rule<T0: drop, T1: drop + store>(arg0: &mut 0x2::transfer_policy::TransferPolicy<NFT>, arg1: &0x2::transfer_policy::TransferPolicyCap<NFT>, arg2: T0, arg3: T1) {
        0x2::transfer_policy::add_rule<NFT, T0, T1>(arg2, arg0, arg1, arg3);
    }

    public fun add_to_balance<T0: drop>(arg0: &mut 0x2::transfer_policy::TransferPolicy<NFT>, arg1: T0, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::transfer_policy::add_to_balance<NFT, T0>(arg1, arg0, arg2);
    }

    public entry fun allowlist_mint_nft(arg0: &mut Collection, arg1: &mut AllowListCap, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<Collection>(arg0) == arg1.fields.collection, 16);
        validate_allowlist_mint_conditions(arg0, arg2, arg3);
        validate_mint_cap_expiration(&arg1.fields, arg3);
        let v0 = &mut arg1.fields;
        update_mint_count(v0, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg2, get_allowlist_mint_price(arg0), arg3), arg0.creator);
        let v1 = create_nft(arg0, arg3);
        0x2::transfer::public_transfer<NFT>(v1, 0x2::tx_context::sender(arg3));
    }

    public entry fun claim_allowlist_mint_cap(arg0: &mut Collection, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = &arg0.allowlist_mint_config;
        assert!(v0.is_active, 10);
        let v1 = MintCapFields{
            collection             : 0x2::object::id<Collection>(arg0),
            mint_limit_per_address : v0.mint_limit,
            mint_count_by_address  : 0x2::table::new<address, u64>(arg1),
            expires_at             : v0.end_time,
        };
        let v2 = AllowListCap{
            id     : 0x2::object::new(arg1),
            fields : v1,
        };
        register_allowlist_mint_cap_internal(arg0, 0x2::object::id<AllowListCap>(&v2), arg1);
        0x2::transfer::public_transfer<AllowListCap>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun claim_free_mint_cap(arg0: &mut Collection, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = &arg0.free_mint_config;
        assert!(v0.is_active, 10);
        let v1 = MintCapFields{
            collection             : 0x2::object::id<Collection>(arg0),
            mint_limit_per_address : v0.mint_limit,
            mint_count_by_address  : 0x2::table::new<address, u64>(arg1),
            expires_at             : v0.end_time,
        };
        let v2 = FreeMintCap{
            id     : 0x2::object::new(arg1),
            fields : v1,
        };
        register_free_mint_cap_internal(arg0, 0x2::object::id<FreeMintCap>(&v2), arg1);
        0x2::transfer::public_transfer<FreeMintCap>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun claim_public_mint_cap(arg0: &mut Collection, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = &arg0.public_mint_config;
        assert!(v0.is_active, 10);
        let v1 = MintCapFields{
            collection             : 0x2::object::id<Collection>(arg0),
            mint_limit_per_address : v0.mint_limit,
            mint_count_by_address  : 0x2::table::new<address, u64>(arg1),
            expires_at             : v0.end_time,
        };
        let v2 = PublicMintCap{
            id     : 0x2::object::new(arg1),
            fields : v1,
        };
        register_public_mint_cap_internal(arg0, 0x2::object::id<PublicMintCap>(&v2), arg1);
        0x2::transfer::public_transfer<PublicMintCap>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun collection_base_image_uri(arg0: &Collection) : &0x1::option::Option<0x1::string::String> {
        &arg0.base_image_uri
    }

    public fun collection_base_thumbnail_uri(arg0: &Collection) : &0x1::option::Option<0x1::string::String> {
        &arg0.base_thumbnail_uri
    }

    public fun collection_creator(arg0: &Collection) : address {
        arg0.creator
    }

    public fun collection_creator_name(arg0: &Collection) : &0x1::option::Option<0x1::string::String> {
        &arg0.creator_name
    }

    public fun collection_description(arg0: &Collection) : &0x1::option::Option<0x1::string::String> {
        &arg0.description
    }

    public fun collection_name(arg0: &Collection) : &0x1::option::Option<0x1::string::String> {
        &arg0.name
    }

    public fun collection_project_url(arg0: &Collection) : &0x1::option::Option<0x1::string::String> {
        &arg0.project_url
    }

    public fun collection_symbol(arg0: &Collection) : &0x1::option::Option<0x1::string::String> {
        &arg0.symbol
    }

    public fun collection_total_supply(arg0: &Collection) : u64 {
        arg0.total_supply
    }

    fun create_nft(arg0: &mut Collection, arg1: &mut 0x2::tx_context::TxContext) : NFT {
        let v0 = 0x2::object::id<Collection>(arg0);
        let v1 = arg0.total_supply;
        let v2 = 0x4254e0c8238ce7e5fe1b7d47ec1a27a4a7edf6bcade53b2662d2a526df342596::string_utils::u64_to_string(v1);
        let v3 = 0x4254e0c8238ce7e5fe1b7d47ec1a27a4a7edf6bcade53b2662d2a526df342596::string_utils::u64_to_string(v1);
        let v4 = NFT{
            id            : 0x2::object::new(arg1),
            name          : 0x4254e0c8238ce7e5fe1b7d47ec1a27a4a7edf6bcade53b2662d2a526df342596::string_utils::concat(&arg0.name_prefix, &v2),
            description   : 0x4254e0c8238ce7e5fe1b7d47ec1a27a4a7edf6bcade53b2662d2a526df342596::string_utils::concat(&arg0.description_template, &v3),
            serial_number : v1,
            collection    : v0,
        };
        arg0.total_supply = arg0.total_supply + 1;
        let v5 = NFTMinted{
            object_id     : 0x2::object::id<NFT>(&v4),
            creator       : arg0.creator,
            collection    : v0,
            name          : v4.name,
            serial_number : v1,
        };
        0x2::event::emit<NFTMinted>(v5);
        v4
    }

    public fun description(arg0: &NFT) : &0x1::string::String {
        &arg0.description
    }

    public entry fun free_mint_nft(arg0: &mut Collection, arg1: &mut FreeMintCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<Collection>(arg0) == arg1.fields.collection, 16);
        validate_base_mint_conditions(arg0, &arg0.free_mint_config, arg2);
        validate_mint_cap_expiration(&arg1.fields, arg2);
        let v0 = &mut arg1.fields;
        update_mint_count(v0, arg2);
        let v1 = create_nft(arg0, arg2);
        0x2::transfer::public_transfer<NFT>(v1, 0x2::tx_context::sender(arg2));
    }

    public entry fun freeze_collection(arg0: &mut Collection, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<Collection>(arg0) == arg1.collection, 3);
        assert!(!arg0.is_frozen, 15);
        arg0.is_frozen = true;
    }

    fun generate_uri(arg0: &0x1::option::Option<0x1::string::String>, arg1: u64) : 0x1::string::String {
        if (0x1::option::is_none<0x1::string::String>(arg0)) {
            return 0x1::string::utf8(b"")
        };
        let v0 = normalize_base_uri(0x1::option::borrow<0x1::string::String>(arg0));
        if (0x1::string::is_empty(&v0)) {
            0x1::string::utf8(b"")
        } else {
            let v2 = 0x4254e0c8238ce7e5fe1b7d47ec1a27a4a7edf6bcade53b2662d2a526df342596::string_utils::u64_to_string(arg1);
            0x4254e0c8238ce7e5fe1b7d47ec1a27a4a7edf6bcade53b2662d2a526df342596::string_utils::concat(&v0, &v2)
        }
    }

    public fun get_allowlist_mint_count(arg0: &MintCapFields, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.mint_count_by_address, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.mint_count_by_address, arg1)
        } else {
            0
        }
    }

    fun get_allowlist_mint_price(arg0: &Collection) : u64 {
        assert!(0x1::option::is_some<PriceConfig>(&arg0.price_config), 20);
        0x1::option::borrow<PriceConfig>(&arg0.price_config).allowlist_price
    }

    public fun get_free_mint_count(arg0: &MintCapFields, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.mint_count_by_address, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.mint_count_by_address, arg1)
        } else {
            0
        }
    }

    public fun get_mint_config_allowlist(arg0: &Collection) : &MintConfig {
        &arg0.allowlist_mint_config
    }

    public fun get_mint_config_free(arg0: &Collection) : &MintConfig {
        &arg0.free_mint_config
    }

    public fun get_mint_config_public(arg0: &Collection) : &MintConfig {
        &arg0.public_mint_config
    }

    public fun get_public_mint_count(arg0: &MintCapFields, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.mint_count_by_address, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.mint_count_by_address, arg1)
        } else {
            0
        }
    }

    fun get_public_mint_price(arg0: &Collection) : u64 {
        assert!(0x1::option::is_some<PriceConfig>(&arg0.price_config), 20);
        0x1::option::borrow<PriceConfig>(&arg0.price_config).public_price
    }

    public fun get_user_allowlist_mint_caps(arg0: &Collection, arg1: address) : vector<0x2::object::ID> {
        let v0 = AllowListRegistryMarker{dummy_field: false};
        let v1 = 0x2::dynamic_object_field::borrow<AllowListRegistryMarker, AllowListMintCapRegistry>(&arg0.id, v0);
        if (0x2::table::contains<address, vector<0x2::object::ID>>(&v1.caps_by_address, arg1)) {
            *0x2::table::borrow<address, vector<0x2::object::ID>>(&v1.caps_by_address, arg1)
        } else {
            0x1::vector::empty<0x2::object::ID>()
        }
    }

    public fun get_user_free_mint_caps(arg0: &Collection, arg1: address) : vector<0x2::object::ID> {
        let v0 = FreeMintRegistryMarker{dummy_field: false};
        let v1 = 0x2::dynamic_object_field::borrow<FreeMintRegistryMarker, FreeMintCapRegistry>(&arg0.id, v0);
        if (0x2::table::contains<address, vector<0x2::object::ID>>(&v1.caps_by_address, arg1)) {
            *0x2::table::borrow<address, vector<0x2::object::ID>>(&v1.caps_by_address, arg1)
        } else {
            0x1::vector::empty<0x2::object::ID>()
        }
    }

    public fun get_user_public_mint_caps(arg0: &Collection, arg1: address) : vector<0x2::object::ID> {
        let v0 = PublicMintRegistryMarker{dummy_field: false};
        let v1 = 0x2::dynamic_object_field::borrow<PublicMintRegistryMarker, PublicMintCapRegistry>(&arg0.id, v0);
        if (0x2::table::contains<address, vector<0x2::object::ID>>(&v1.caps_by_address, arg1)) {
            *0x2::table::borrow<address, vector<0x2::object::ID>>(&v1.caps_by_address, arg1)
        } else {
            0x1::vector::empty<0x2::object::ID>()
        }
    }

    fun init(arg0: SIMPLE_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::object::new(arg1);
        let v2 = FreeMintCapRegistry{
            id              : 0x2::object::new(arg1),
            caps_by_address : 0x2::table::new<address, vector<0x2::object::ID>>(arg1),
        };
        let v3 = PublicMintCapRegistry{
            id              : 0x2::object::new(arg1),
            caps_by_address : 0x2::table::new<address, vector<0x2::object::ID>>(arg1),
        };
        let v4 = AllowListMintCapRegistry{
            id              : 0x2::object::new(arg1),
            caps_by_address : 0x2::table::new<address, vector<0x2::object::ID>>(arg1),
        };
        let v5 = RegistryIds{
            free_mint   : 0x2::object::id<FreeMintCapRegistry>(&v2),
            public_mint : 0x2::object::id<PublicMintCapRegistry>(&v3),
            allowlist   : 0x2::object::id<AllowListMintCapRegistry>(&v4),
        };
        let v6 = FreeMintRegistryMarker{dummy_field: false};
        0x2::dynamic_object_field::add<FreeMintRegistryMarker, FreeMintCapRegistry>(&mut v1, v6, v2);
        let v7 = PublicMintRegistryMarker{dummy_field: false};
        0x2::dynamic_object_field::add<PublicMintRegistryMarker, PublicMintCapRegistry>(&mut v1, v7, v3);
        let v8 = AllowListRegistryMarker{dummy_field: false};
        0x2::dynamic_object_field::add<AllowListRegistryMarker, AllowListMintCapRegistry>(&mut v1, v8, v4);
        let v9 = MintConfig{
            is_active  : false,
            start_time : 0x1::option::none<u64>(),
            end_time   : 0x1::option::none<u64>(),
            mint_limit : 0,
        };
        let v10 = MintConfig{
            is_active  : false,
            start_time : 0x1::option::none<u64>(),
            end_time   : 0x1::option::none<u64>(),
            mint_limit : 0,
        };
        let v11 = MintConfig{
            is_active  : false,
            start_time : 0x1::option::none<u64>(),
            end_time   : 0x1::option::none<u64>(),
            mint_limit : 0,
        };
        let v12 = Collection{
            id                    : v1,
            initialized           : false,
            name                  : 0x1::option::none<0x1::string::String>(),
            description           : 0x1::option::none<0x1::string::String>(),
            symbol                : 0x1::option::none<0x1::string::String>(),
            creator               : v0,
            total_supply          : 0,
            max_supply            : 0x1::option::none<u64>(),
            project_url           : 0x1::option::none<0x1::string::String>(),
            creator_name          : 0x1::option::none<0x1::string::String>(),
            base_image_uri        : 0x1::option::none<0x1::string::String>(),
            base_thumbnail_uri    : 0x1::option::none<0x1::string::String>(),
            name_prefix           : 0x1::string::utf8(b""),
            description_template  : 0x1::string::utf8(b""),
            is_frozen             : false,
            price_config          : 0x1::option::none<PriceConfig>(),
            free_mint_config      : v9,
            public_mint_config    : v10,
            allowlist_mint_config : v11,
            allowlist_merkle_root : 0x1::option::none<vector<u8>>(),
            registry_ids          : v5,
        };
        let v13 = AdminCap{
            id         : 0x2::object::new(arg1),
            collection : 0x2::object::id<Collection>(&v12),
        };
        let v14 = 0x2::package::claim<SIMPLE_NFT>(arg0, arg1);
        let (v15, v16) = 0x2::transfer_policy::new<NFT>(&v14, arg1);
        0x2::transfer::transfer<AdminCap>(v13, v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v14, v0);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<NFT>>(v16, v0);
        0x2::transfer::share_object<Collection>(v12);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<NFT>>(v15);
    }

    public entry fun initialize_collection(arg0: &mut Collection, arg1: &AdminCap, arg2: &0x2::package::Publisher, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::option::Option<u64>, arg7: 0x1::option::Option<0x1::string::String>, arg8: 0x1::option::Option<0x1::string::String>, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: 0x1::option::Option<0x1::string::String>, arg12: 0x1::option::Option<0x1::string::String>, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<Collection>(arg0) == arg1.collection, 3);
        assert!(!arg0.initialized, 5);
        assert!(!0x1::string::is_empty(&arg9), 1);
        assert!(!0x1::string::is_empty(&arg10), 2);
        if (0x1::option::is_some<0x1::string::String>(&arg11)) {
            assert!(!0x1::string::is_empty(0x1::option::borrow<0x1::string::String>(&arg11)), 7);
        };
        if (0x1::option::is_some<0x1::string::String>(&arg12)) {
            assert!(!0x1::string::is_empty(0x1::option::borrow<0x1::string::String>(&arg12)), 7);
        };
        arg0.name = 0x1::option::some<0x1::string::String>(arg3);
        arg0.description = 0x1::option::some<0x1::string::String>(arg4);
        arg0.symbol = 0x1::option::some<0x1::string::String>(arg5);
        arg0.max_supply = arg6;
        arg0.project_url = arg7;
        arg0.creator_name = arg8;
        arg0.name_prefix = arg9;
        arg0.description_template = arg10;
        arg0.base_image_uri = arg11;
        arg0.base_thumbnail_uri = arg12;
        arg0.initialized = true;
        let v0 = CollectionInitialized{
            collection_id : 0x2::object::id<Collection>(arg0),
            creator       : arg0.creator,
            name          : arg3,
            symbol        : arg5,
        };
        0x2::event::emit<CollectionInitialized>(v0);
        initialize_display_internal(arg0, arg2, arg13);
    }

    fun initialize_display_internal(arg0: &Collection, arg1: &0x2::package::Publisher, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = if (0x1::option::is_some<0x1::string::String>(&arg0.project_url)) {
            *0x1::option::borrow<0x1::string::String>(&arg0.project_url)
        } else {
            0x1::string::utf8(b"")
        };
        let v1 = if (0x1::option::is_some<0x1::string::String>(&arg0.creator_name)) {
            *0x1::option::borrow<0x1::string::String>(&arg0.creator_name)
        } else {
            0x1::string::utf8(b"")
        };
        let v2 = 0x1::string::utf8(b"");
        if (0x1::option::is_some<0x1::string::String>(&arg0.base_image_uri)) {
            let v3 = normalize_base_uri(0x1::option::borrow<0x1::string::String>(&arg0.base_image_uri));
            let v4 = 0x1::string::utf8(b"{serial_number}");
            v2 = 0x4254e0c8238ce7e5fe1b7d47ec1a27a4a7edf6bcade53b2662d2a526df342596::string_utils::concat(&v3, &v4);
        };
        let v5 = 0x1::string::utf8(b"");
        if (0x1::option::is_some<0x1::string::String>(&arg0.base_thumbnail_uri)) {
            let v6 = normalize_base_uri(0x1::option::borrow<0x1::string::String>(&arg0.base_thumbnail_uri));
            let v7 = 0x1::string::utf8(b"{serial_number}");
            v5 = 0x4254e0c8238ce7e5fe1b7d47ec1a27a4a7edf6bcade53b2662d2a526df342596::string_utils::concat(&v6, &v7);
        };
        let v8 = 0x1::vector::empty<0x1::string::String>();
        let v9 = &mut v8;
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"thumbnail_url"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"collection"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"serial_number"));
        let v10 = 0x1::vector::empty<0x1::string::String>();
        let v11 = &mut v10;
        0x1::vector::push_back<0x1::string::String>(v11, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v11, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v11, v2);
        0x1::vector::push_back<0x1::string::String>(v11, v5);
        0x1::vector::push_back<0x1::string::String>(v11, v0);
        0x1::vector::push_back<0x1::string::String>(v11, v1);
        0x1::vector::push_back<0x1::string::String>(v11, *0x1::option::borrow<0x1::string::String>(&arg0.name));
        0x1::vector::push_back<0x1::string::String>(v11, 0x1::string::utf8(b"#{serial_number}"));
        let v12 = 0x2::display::new_with_fields<NFT>(arg1, v8, v10, arg2);
        0x2::display::update_version<NFT>(&mut v12);
        let v13 = DisplayInitialized{
            collection_id : 0x2::object::id<Collection>(arg0),
            creator       : arg0.creator,
        };
        0x2::event::emit<DisplayInitialized>(v13);
        0x2::transfer::public_transfer<0x2::display::Display<NFT>>(v12, 0x2::tx_context::sender(arg2));
    }

    public fun is_frozen(arg0: &Collection) : bool {
        arg0.is_frozen
    }

    public fun is_initialized(arg0: &Collection) : bool {
        arg0.initialized
    }

    public fun is_mint_active(arg0: &MintConfig, arg1: u64) : bool {
        if (!arg0.is_active) {
            return false
        };
        if (0x1::option::is_some<u64>(&arg0.start_time)) {
            if (arg1 < *0x1::option::borrow<u64>(&arg0.start_time)) {
                return false
            };
        };
        if (0x1::option::is_some<u64>(&arg0.end_time)) {
            if (arg1 > *0x1::option::borrow<u64>(&arg0.end_time)) {
                return false
            };
        };
        true
    }

    public fun mint_limit_allowlist(arg0: &AllowListCap) : u64 {
        arg0.fields.mint_limit_per_address
    }

    public fun mint_limit_free(arg0: &FreeMintCap) : u64 {
        arg0.fields.mint_limit_per_address
    }

    public fun mint_limit_public(arg0: &PublicMintCap) : u64 {
        arg0.fields.mint_limit_per_address
    }

    public fun name(arg0: &NFT) : &0x1::string::String {
        &arg0.name
    }

    fun normalize_base_uri(arg0: &0x1::string::String) : 0x1::string::String {
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = 0x1::vector::length<u8>(v0);
        if (v1 == 0) {
            return 0x1::string::utf8(b"")
        };
        if (*0x1::vector::borrow<u8>(v0, v1 - 1) != 47) {
            let v3 = 0x1::string::utf8(b"/");
            0x4254e0c8238ce7e5fe1b7d47ec1a27a4a7edf6bcade53b2662d2a526df342596::string_utils::concat(arg0, &v3)
        } else {
            *arg0
        }
    }

    public entry fun public_mint_nft(arg0: &mut Collection, arg1: &mut PublicMintCap, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<Collection>(arg0) == arg1.fields.collection, 16);
        validate_public_mint_conditions(arg0, arg2, arg3);
        validate_mint_cap_expiration(&arg1.fields, arg3);
        let v0 = &mut arg1.fields;
        update_mint_count(v0, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg2, get_public_mint_price(arg0), arg3), arg0.creator);
        let v1 = create_nft(arg0, arg3);
        0x2::transfer::public_transfer<NFT>(v1, 0x2::tx_context::sender(arg3));
    }

    fun register_allowlist_mint_cap_internal(arg0: &mut Collection, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AllowListRegistryMarker{dummy_field: false};
        let v1 = &mut 0x2::dynamic_object_field::borrow_mut<AllowListRegistryMarker, AllowListMintCapRegistry>(&mut arg0.id, v0).caps_by_address;
        register_mint_cap(v1, arg1, arg2);
    }

    fun register_free_mint_cap_internal(arg0: &mut Collection, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = FreeMintRegistryMarker{dummy_field: false};
        let v1 = &mut 0x2::dynamic_object_field::borrow_mut<FreeMintRegistryMarker, FreeMintCapRegistry>(&mut arg0.id, v0).caps_by_address;
        register_mint_cap(v1, arg1, arg2);
    }

    fun register_mint_cap(arg0: &mut 0x2::table::Table<address, vector<0x2::object::ID>>, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(arg0, v0)) {
            0x2::table::add<address, vector<0x2::object::ID>>(arg0, v0, 0x1::vector::empty<0x2::object::ID>());
        };
        0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, vector<0x2::object::ID>>(arg0, v0), arg1);
    }

    public fun register_or_update_listing_admin(arg0: &mut Collection, arg1: &AdminCap, arg2: &mut 0x4254e0c8238ce7e5fe1b7d47ec1a27a4a7edf6bcade53b2662d2a526df342596::listing_registry::ListingRegistry, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: u64, arg6: address) {
        assert!(0x2::object::id<Collection>(arg0) == arg1.collection, 3);
        0x4254e0c8238ce7e5fe1b7d47ec1a27a4a7edf6bcade53b2662d2a526df342596::listing_registry::register_or_update_listing(arg2, arg3, arg4, arg5, arg6);
    }

    fun register_public_mint_cap_internal(arg0: &mut Collection, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = PublicMintRegistryMarker{dummy_field: false};
        let v1 = &mut 0x2::dynamic_object_field::borrow_mut<PublicMintRegistryMarker, PublicMintCapRegistry>(&mut arg0.id, v0).caps_by_address;
        register_mint_cap(v1, arg1, arg2);
    }

    public fun serial_number(arg0: &NFT) : u64 {
        arg0.serial_number
    }

    public entry fun set_base_uris(arg0: &mut Collection, arg1: &AdminCap, arg2: 0x1::option::Option<0x1::string::String>, arg3: 0x1::option::Option<0x1::string::String>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<Collection>(arg0) == arg1.collection, 3);
        assert!(!arg0.is_frozen, 15);
        if (0x1::option::is_some<0x1::string::String>(&arg2)) {
            assert!(!0x1::string::is_empty(0x1::option::borrow<0x1::string::String>(&arg2)), 7);
        };
        if (0x1::option::is_some<0x1::string::String>(&arg3)) {
            assert!(!0x1::string::is_empty(0x1::option::borrow<0x1::string::String>(&arg3)), 7);
        };
        arg0.base_image_uri = arg2;
        arg0.base_thumbnail_uri = arg3;
        let v0 = BaseURIUpdated{
            collection_id : 0x2::object::id<Collection>(arg0),
            image_uri     : arg2,
            thumbnail_uri : arg3,
            updated_by    : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<BaseURIUpdated>(v0);
    }

    public entry fun set_mint_prices(arg0: &mut Collection, arg1: &AdminCap, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<Collection>(arg0) == arg1.collection, 3);
        assert!(arg2 >= 100000000, 19);
        assert!(arg3 >= 100000000, 19);
        let v0 = PriceConfig{
            public_price    : arg2,
            allowlist_price : arg3,
        };
        arg0.price_config = 0x1::option::some<PriceConfig>(v0);
    }

    public entry fun update_allowlist_mint_config(arg0: &mut Collection, arg1: &AdminCap, arg2: bool, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<u64>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<Collection>(arg0) == arg1.collection, 3);
        if (0x1::option::is_some<u64>(&arg3) && 0x1::option::is_some<u64>(&arg4)) {
            assert!(*0x1::option::borrow<u64>(&arg3) < *0x1::option::borrow<u64>(&arg4), 13);
        };
        let v0 = MintConfig{
            is_active  : arg2,
            start_time : arg3,
            end_time   : arg4,
            mint_limit : arg5,
        };
        arg0.allowlist_mint_config = v0;
    }

    public entry fun update_collection_info(arg0: &mut Collection, arg1: &AdminCap, arg2: 0x1::option::Option<0x1::string::String>, arg3: 0x1::option::Option<0x1::string::String>, arg4: 0x1::option::Option<0x1::string::String>, arg5: 0x1::option::Option<0x1::string::String>, arg6: 0x1::option::Option<0x1::string::String>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<Collection>(arg0) == arg1.collection, 3);
        assert!(!arg0.is_frozen, 15);
        if (0x1::option::is_some<0x1::string::String>(&arg2)) {
            arg0.name = 0x1::option::some<0x1::string::String>(*0x1::option::borrow<0x1::string::String>(&arg2));
        };
        if (0x1::option::is_some<0x1::string::String>(&arg3)) {
            arg0.description = 0x1::option::some<0x1::string::String>(*0x1::option::borrow<0x1::string::String>(&arg3));
        };
        if (0x1::option::is_some<0x1::string::String>(&arg4)) {
            arg0.symbol = 0x1::option::some<0x1::string::String>(*0x1::option::borrow<0x1::string::String>(&arg4));
        };
        if (0x1::option::is_some<0x1::string::String>(&arg5)) {
            arg0.project_url = 0x1::option::some<0x1::string::String>(*0x1::option::borrow<0x1::string::String>(&arg5));
        };
        if (0x1::option::is_some<0x1::string::String>(&arg6)) {
            arg0.creator_name = 0x1::option::some<0x1::string::String>(*0x1::option::borrow<0x1::string::String>(&arg6));
        };
    }

    public entry fun update_display(arg0: &Collection, arg1: &AdminCap, arg2: &0x2::package::Publisher, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<Collection>(arg0) == arg1.collection, 3);
        assert!(arg0.initialized, 6);
        assert!(!arg0.is_frozen, 15);
        initialize_display_internal(arg0, arg2, arg3);
    }

    public entry fun update_free_mint_config(arg0: &mut Collection, arg1: &AdminCap, arg2: bool, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<u64>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<Collection>(arg0) == arg1.collection, 3);
        if (0x1::option::is_some<u64>(&arg3) && 0x1::option::is_some<u64>(&arg4)) {
            assert!(*0x1::option::borrow<u64>(&arg3) < *0x1::option::borrow<u64>(&arg4), 13);
        };
        let v0 = MintConfig{
            is_active  : arg2,
            start_time : arg3,
            end_time   : arg4,
            mint_limit : arg5,
        };
        arg0.free_mint_config = v0;
    }

    fun update_mint_count(arg0: &mut MintCapFields, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = if (0x2::table::contains<address, u64>(&arg0.mint_count_by_address, v0)) {
            let v2 = 0x2::table::borrow_mut<address, u64>(&mut arg0.mint_count_by_address, v0);
            assert!(*v2 < arg0.mint_limit_per_address, 8);
            v2
        } else {
            0x2::table::add<address, u64>(&mut arg0.mint_count_by_address, v0, 0);
            0x2::table::borrow_mut<address, u64>(&mut arg0.mint_count_by_address, v0)
        };
        assert!(*v1 < arg0.mint_limit_per_address, 8);
        *v1 = *v1 + 1;
    }

    public entry fun update_public_mint_config(arg0: &mut Collection, arg1: &AdminCap, arg2: bool, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<u64>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<Collection>(arg0) == arg1.collection, 3);
        if (0x1::option::is_some<u64>(&arg3) && 0x1::option::is_some<u64>(&arg4)) {
            assert!(*0x1::option::borrow<u64>(&arg3) < *0x1::option::borrow<u64>(&arg4), 13);
        };
        let v0 = MintConfig{
            is_active  : arg2,
            start_time : arg3,
            end_time   : arg4,
            mint_limit : arg5,
        };
        arg0.public_mint_config = v0;
    }

    fun validate_allowlist_mint_conditions(arg0: &Collection, arg1: &0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::tx_context::TxContext) {
        validate_base_mint_conditions(arg0, &arg0.allowlist_mint_config, arg2);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg1) >= get_allowlist_mint_price(arg0), 17);
    }

    fun validate_base_mint_conditions(arg0: &Collection, arg1: &MintConfig, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.initialized, 6);
        if (0x1::option::is_some<u64>(&arg0.max_supply)) {
            assert!(arg0.total_supply < *0x1::option::borrow<u64>(&arg0.max_supply), 14);
        };
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg2);
        assert!(arg1.is_active, 10);
        if (0x1::option::is_some<u64>(&arg1.start_time)) {
            assert!(v0 >= *0x1::option::borrow<u64>(&arg1.start_time), 11);
        };
        if (0x1::option::is_some<u64>(&arg1.end_time)) {
            assert!(v0 <= *0x1::option::borrow<u64>(&arg1.end_time), 12);
        };
    }

    fun validate_mint_cap_expiration(arg0: &MintCapFields, arg1: &0x2::tx_context::TxContext) {
        assert!(0x1::option::is_none<u64>(&arg0.expires_at) || 0x2::tx_context::epoch_timestamp_ms(arg1) <= *0x1::option::borrow<u64>(&arg0.expires_at), 18);
    }

    fun validate_public_mint_conditions(arg0: &Collection, arg1: &0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::tx_context::TxContext) {
        validate_base_mint_conditions(arg0, &arg0.public_mint_config, arg2);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg1) >= get_public_mint_price(arg0), 17);
    }

    // decompiled from Move bytecode v6
}

