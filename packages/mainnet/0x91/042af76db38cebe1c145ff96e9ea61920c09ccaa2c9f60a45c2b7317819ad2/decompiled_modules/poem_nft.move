module 0xc0d6dd00e5cbb87ee0bcc0d2499d2ed02cfdf8d7aa98fa9ab0bb671aea31dcb1::poem_nft {
    struct POEM_NFT has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MintingCap has store, key {
        id: 0x2::object::UID,
        collection_id: 0x2::object::ID,
        owner: address,
    }

    struct PublicMintConfig has key {
        id: 0x2::object::UID,
        collection_id: 0x2::object::ID,
        min_price: u64,
        enabled: bool,
        admin: address,
    }

    struct Attributes has copy, drop, store {
        background_id: u8,
        frame_id: u8,
        pattern_id: u8,
        color_scheme_id: u8,
        text_style_id: u8,
    }

    struct AttributePool has copy, drop, store {
        background_count: u8,
        frame_count: u8,
        pattern_count: u8,
        color_scheme_count: u8,
        text_style_count: u8,
    }

    struct CollectionConfig has key {
        id: 0x2::object::UID,
        collection_id: 0x2::object::ID,
        common_pool: AttributePool,
        epic_pool: AttributePool,
        legendary_pool: AttributePool,
        randomized_minting_enabled: bool,
    }

    struct PoetCap has key {
        id: 0x2::object::UID,
        collection_id: 0x2::object::ID,
        poet_address: address,
        poet_name: 0x1::string::String,
    }

    struct RoyaltyConfig has key {
        id: 0x2::object::UID,
        collection_id: 0x2::object::ID,
        poet_address: address,
        platform_address: address,
        royalty_bps: u64,
    }

    struct PlatformConfig has key {
        id: 0x2::object::UID,
        platform_address: address,
        total_minted: u64,
        total_revenue_mist: u64,
        paused: bool,
        accepted_coin_type: 0x1::type_name::TypeName,
    }

    struct Collection has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        creator: address,
        max_supply: 0x1::option::Option<u64>,
        current_supply: u64,
        royalty_bps: u64,
        is_platform_collection: bool,
    }

    struct PoemNFT has store, key {
        id: 0x2::object::UID,
        poem_db_id: vector<u8>,
        order_db_id: vector<u8>,
        collection_id: 0x2::object::ID,
        title: 0x1::string::String,
        poet_name: 0x1::string::String,
        poet_address: address,
        image_url: 0x1::option::Option<0x2::url::Url>,
        content_hash: vector<u8>,
        price_mist: u64,
        edition_number: u64,
        minted_at: u64,
        rarity: u8,
        attributes: 0x1::option::Option<Attributes>,
    }

    struct NFTMinted has copy, drop {
        nft_id: 0x2::object::ID,
        poem_db_id: vector<u8>,
        order_db_id: vector<u8>,
        collection_id: 0x2::object::ID,
        minter: address,
        poet_address: address,
        price_mist: u64,
        poet_received: u64,
        platform_received: u64,
        edition_number: u64,
        timestamp: u64,
    }

    struct NFTMintedWithRarity has copy, drop {
        nft_id: 0x2::object::ID,
        poem_db_id: vector<u8>,
        order_db_id: vector<u8>,
        collection_id: 0x2::object::ID,
        minter: address,
        poet_address: address,
        price_mist: u64,
        poet_received: u64,
        platform_received: u64,
        edition_number: u64,
        timestamp: u64,
        rarity: u8,
        rarity_roll: u16,
        background_id: u8,
        frame_id: u8,
        pattern_id: u8,
        color_scheme_id: u8,
        text_style_id: u8,
    }

    struct CollectionConfigCreated has copy, drop {
        config_id: 0x2::object::ID,
        collection_id: 0x2::object::ID,
    }

    struct CollectionCreated has copy, drop {
        collection_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
        max_supply: 0x1::option::Option<u64>,
        is_platform_collection: bool,
    }

    struct PlatformStatusChanged has copy, drop {
        paused: bool,
        timestamp: u64,
    }

    struct CoinTypeUpdated has copy, drop {
        old_type: 0x1::type_name::TypeName,
        new_type: 0x1::type_name::TypeName,
    }

    struct RoyaltyPaid has copy, drop {
        nft_id: 0x2::object::ID,
        sale_price: u64,
        total_royalty: u64,
        poet_received: u64,
        platform_received: u64,
        poet_address: address,
        platform_address: address,
    }

    struct RoyaltyConfigCreated has copy, drop {
        royalty_config_id: 0x2::object::ID,
        collection_id: 0x2::object::ID,
        poet_address: address,
        platform_address: address,
        royalty_bps: u64,
    }

    struct TransferPolicyCreated has copy, drop {
        policy_id: 0x2::object::ID,
        policy_cap_id: 0x2::object::ID,
    }

    public fun calculate_payment_split(arg0: u64) : (u64, u64) {
        let v0 = arg0 * 7000 / 10000;
        (v0, arg0 - v0)
    }

    public fun calculate_secondary_royalty(arg0: u64) : (u64, u64, u64) {
        let v0 = arg0 * 150 / 10000;
        let v1 = v0 * 5000 / 10000;
        (v0, v1, v0 - v1)
    }

    public fun can_mint(arg0: &Collection) : bool {
        0x1::option::is_some<u64>(&arg0.max_supply) && arg0.current_supply < *0x1::option::borrow<u64>(&arg0.max_supply) || true
    }

    public fun confirm_transfer_with_royalty(arg0: &0x2::transfer_policy::TransferPolicy<PoemNFT>, arg1: 0x2::transfer_policy::TransferRequest<PoemNFT>, arg2: &PoemNFT, arg3: &RoyaltyConfig, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        pay_royalty(arg2, arg3, arg4, arg5, arg6);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<PoemNFT>(arg0, arg1);
    }

    public fun create_collection_config(arg0: &AdminCap, arg1: &Collection, arg2: AttributePool, arg3: AttributePool, arg4: AttributePool, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = CollectionConfig{
            id                         : 0x2::object::new(arg5),
            collection_id              : 0x2::object::id<Collection>(arg1),
            common_pool                : arg2,
            epic_pool                  : arg3,
            legendary_pool             : arg4,
            randomized_minting_enabled : true,
        };
        let v1 = 0x2::object::id<CollectionConfig>(&v0);
        let v2 = CollectionConfigCreated{
            config_id     : v1,
            collection_id : 0x2::object::id<Collection>(arg1),
        };
        0x2::event::emit<CollectionConfigCreated>(v2);
        0x2::transfer::share_object<CollectionConfig>(v0);
        v1
    }

    public entry fun create_collection_config_default(arg0: &AdminCap, arg1: &Collection, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AttributePool{
            background_count   : 8,
            frame_count        : 6,
            pattern_count      : 8,
            color_scheme_count : 10,
            text_style_count   : 6,
        };
        let v1 = AttributePool{
            background_count   : 12,
            frame_count        : 8,
            pattern_count      : 10,
            color_scheme_count : 15,
            text_style_count   : 8,
        };
        let v2 = AttributePool{
            background_count   : 16,
            frame_count        : 12,
            pattern_count      : 12,
            color_scheme_count : 20,
            text_style_count   : 10,
        };
        create_collection_config(arg0, arg1, v0, v1, v2, arg2);
    }

    public fun create_platform_collection(arg0: &AdminCap, arg1: vector<u8>, arg2: vector<u8>, arg3: 0x1::option::Option<u64>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : MintingCap {
        assert!(arg4 <= 1000, 4);
        let v0 = Collection{
            id                     : 0x2::object::new(arg5),
            name                   : 0x1::string::utf8(arg1),
            description            : 0x1::string::utf8(arg2),
            creator                : 0x2::tx_context::sender(arg5),
            max_supply             : arg3,
            current_supply         : 0,
            royalty_bps            : arg4,
            is_platform_collection : true,
        };
        let v1 = 0x2::object::id<Collection>(&v0);
        let v2 = MintingCap{
            id            : 0x2::object::new(arg5),
            collection_id : v1,
            owner         : 0x2::tx_context::sender(arg5),
        };
        let v3 = CollectionCreated{
            collection_id          : v1,
            creator                : 0x2::tx_context::sender(arg5),
            name                   : 0x1::string::utf8(arg1),
            max_supply             : arg3,
            is_platform_collection : true,
        };
        0x2::event::emit<CollectionCreated>(v3);
        0x2::transfer::share_object<Collection>(v0);
        v2
    }

    public entry fun create_platform_collection_entry(arg0: &AdminCap, arg1: vector<u8>, arg2: vector<u8>, arg3: 0x1::option::Option<u64>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = create_platform_collection(arg0, arg1, arg2, arg3, arg4, arg5);
        0x2::transfer::transfer<MintingCap>(v0, 0x2::tx_context::sender(arg5));
    }

    public fun create_poet_collection(arg0: &PlatformConfig, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: 0x1::option::Option<u64>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : (PoetCap, MintingCap) {
        assert!(arg5 <= 1000, 4);
        assert!(0x1::vector::length<u8>(&arg3) > 0, 7);
        let v0 = Collection{
            id                     : 0x2::object::new(arg6),
            name                   : 0x1::string::utf8(arg1),
            description            : 0x1::string::utf8(arg2),
            creator                : 0x2::tx_context::sender(arg6),
            max_supply             : arg4,
            current_supply         : 0,
            royalty_bps            : arg5,
            is_platform_collection : false,
        };
        let v1 = 0x2::object::id<Collection>(&v0);
        let v2 = CollectionCreated{
            collection_id          : v1,
            creator                : 0x2::tx_context::sender(arg6),
            name                   : 0x1::string::utf8(arg1),
            max_supply             : arg4,
            is_platform_collection : false,
        };
        0x2::event::emit<CollectionCreated>(v2);
        0x2::transfer::share_object<Collection>(v0);
        let v3 = RoyaltyConfig{
            id               : 0x2::object::new(arg6),
            collection_id    : v1,
            poet_address     : 0x2::tx_context::sender(arg6),
            platform_address : arg0.platform_address,
            royalty_bps      : 150,
        };
        let v4 = RoyaltyConfigCreated{
            royalty_config_id : 0x2::object::id<RoyaltyConfig>(&v3),
            collection_id     : v1,
            poet_address      : 0x2::tx_context::sender(arg6),
            platform_address  : arg0.platform_address,
            royalty_bps       : 150,
        };
        0x2::event::emit<RoyaltyConfigCreated>(v4);
        0x2::transfer::share_object<RoyaltyConfig>(v3);
        let v5 = PoetCap{
            id            : 0x2::object::new(arg6),
            collection_id : v1,
            poet_address  : 0x2::tx_context::sender(arg6),
            poet_name     : 0x1::string::utf8(arg3),
        };
        let v6 = MintingCap{
            id            : 0x2::object::new(arg6),
            collection_id : v1,
            owner         : 0x2::tx_context::sender(arg6),
        };
        (v5, v6)
    }

    public entry fun create_poet_collection_entry(arg0: &PlatformConfig, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: 0x1::option::Option<u64>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = create_poet_collection(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0x2::transfer::transfer<PoetCap>(v0, 0x2::tx_context::sender(arg6));
        0x2::transfer::transfer<MintingCap>(v1, 0x2::tx_context::sender(arg6));
    }

    public entry fun create_public_mint_config(arg0: &AdminCap, arg1: &Collection, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = PublicMintConfig{
            id            : 0x2::object::new(arg3),
            collection_id : 0x2::object::id<Collection>(arg1),
            min_price     : arg2,
            enabled       : true,
            admin         : 0x2::tx_context::sender(arg3),
        };
        0x2::transfer::share_object<PublicMintConfig>(v0);
    }

    public fun get_accepted_coin_type(arg0: &PlatformConfig) : 0x1::type_name::TypeName {
        arg0.accepted_coin_type
    }

    public fun get_attribute_pool(arg0: &CollectionConfig, arg1: u8) : AttributePool {
        if (arg1 == 0) {
            arg0.common_pool
        } else if (arg1 == 1) {
            arg0.epic_pool
        } else {
            arg0.legendary_pool
        }
    }

    public fun get_collection_config_info(arg0: &CollectionConfig) : (0x2::object::ID, bool) {
        (arg0.collection_id, arg0.randomized_minting_enabled)
    }

    public fun get_collection_info(arg0: &Collection) : (0x1::string::String, address, u64, 0x1::option::Option<u64>, u64, bool) {
        (arg0.name, arg0.creator, arg0.current_supply, arg0.max_supply, arg0.royalty_bps, arg0.is_platform_collection)
    }

    public fun get_max_safe_price() : u64 {
        2635249153387078
    }

    public fun get_min_price() : u64 {
        1000000
    }

    public fun get_minting_cap_info(arg0: &MintingCap) : (0x2::object::ID, address) {
        (arg0.collection_id, arg0.owner)
    }

    public fun get_nft_image_url(arg0: &PoemNFT) : 0x1::option::Option<0x2::url::Url> {
        arg0.image_url
    }

    public fun get_nft_info(arg0: &PoemNFT) : (vector<u8>, vector<u8>, 0x2::object::ID, 0x1::string::String, 0x1::string::String, address, u64, u64, u64) {
        (arg0.poem_db_id, arg0.order_db_id, arg0.collection_id, arg0.title, arg0.poet_name, arg0.poet_address, arg0.price_mist, arg0.edition_number, arg0.minted_at)
    }

    public fun get_nft_rarity_info(arg0: &PoemNFT) : (u8, 0x1::option::Option<Attributes>) {
        (arg0.rarity, arg0.attributes)
    }

    public fun get_platform_config(arg0: &PlatformConfig) : (address, u64, u64, bool) {
        (arg0.platform_address, arg0.total_minted, arg0.total_revenue_mist, arg0.paused)
    }

    public fun get_poet_cap_info(arg0: &PoetCap) : (0x2::object::ID, address, 0x1::string::String) {
        (arg0.collection_id, arg0.poet_address, arg0.poet_name)
    }

    public fun get_public_mint_config_info(arg0: &PublicMintConfig) : (0x2::object::ID, u64, bool, address) {
        (arg0.collection_id, arg0.min_price, arg0.enabled, arg0.admin)
    }

    public fun get_rarity_common() : u8 {
        0
    }

    public fun get_rarity_epic() : u8 {
        1
    }

    public fun get_rarity_legendary() : u8 {
        2
    }

    public fun get_rarity_thresholds() : (u16, u16) {
        (8000, 9500)
    }

    public fun get_royalty_config(arg0: &RoyaltyConfig) : (0x2::object::ID, address, address, u64) {
        (arg0.collection_id, arg0.poet_address, arg0.platform_address, arg0.royalty_bps)
    }

    public fun get_secondary_royalty_bps() : u64 {
        150
    }

    fun init(arg0: POEM_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = PlatformConfig{
            id                 : 0x2::object::new(arg1),
            platform_address   : 0x2::tx_context::sender(arg1),
            total_minted       : 0,
            total_revenue_mist : 0,
            paused             : false,
            accepted_coin_type : 0x1::type_name::get<POEM_NFT>(),
        };
        0x2::transfer::share_object<PlatformConfig>(v1);
        let v2 = Collection{
            id                     : 0x2::object::new(arg1),
            name                   : 0x1::string::utf8(b"PoetArt Platform Collection"),
            description            : 0x1::string::utf8(b"Official PoetArt platform collection for featured poems"),
            creator                : 0x2::tx_context::sender(arg1),
            max_supply             : 0x1::option::none<u64>(),
            current_supply         : 0,
            royalty_bps            : 500,
            is_platform_collection : true,
        };
        let v3 = 0x2::object::id<Collection>(&v2);
        let v4 = MintingCap{
            id            : 0x2::object::new(arg1),
            collection_id : v3,
            owner         : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::transfer<MintingCap>(v4, 0x2::tx_context::sender(arg1));
        let v5 = CollectionCreated{
            collection_id          : v3,
            creator                : 0x2::tx_context::sender(arg1),
            name                   : 0x1::string::utf8(b"PoetArt Platform Collection"),
            max_supply             : 0x1::option::none<u64>(),
            is_platform_collection : true,
        };
        0x2::event::emit<CollectionCreated>(v5);
        0x2::transfer::share_object<Collection>(v2);
        let v6 = 0x2::package::claim<POEM_NFT>(arg0, arg1);
        let v7 = 0x2::display::new<PoemNFT>(&v6, arg1);
        0x2::display::add<PoemNFT>(&mut v7, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{title}"));
        0x2::display::add<PoemNFT>(&mut v7, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"A unique poem NFT by {poet_name}"));
        0x2::display::add<PoemNFT>(&mut v7, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<PoemNFT>(&mut v7, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"{poet_name}"));
        0x2::display::add<PoemNFT>(&mut v7, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://poetart.io"));
        0x2::display::update_version<PoemNFT>(&mut v7);
        0x2::transfer::public_transfer<0x2::display::Display<PoemNFT>>(v7, 0x2::tx_context::sender(arg1));
        let (v8, v9) = 0x2::transfer_policy::new<PoemNFT>(&v6, arg1);
        let v10 = v9;
        let v11 = v8;
        let v12 = TransferPolicyCreated{
            policy_id     : 0x2::object::id<0x2::transfer_policy::TransferPolicy<PoemNFT>>(&v11),
            policy_cap_id : 0x2::object::id<0x2::transfer_policy::TransferPolicyCap<PoemNFT>>(&v10),
        };
        0x2::event::emit<TransferPolicyCreated>(v12);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<PoemNFT>>(v11);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<PoemNFT>>(v10, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v6, 0x2::tx_context::sender(arg1));
    }

    public fun is_randomized_nft(arg0: &PoemNFT) : bool {
        0x1::option::is_some<Attributes>(&arg0.attributes)
    }

    public entry fun mint_and_transfer<T0>(arg0: &mut PlatformConfig, arg1: &mut Collection, arg2: &MintingCap, arg3: &PoetCap, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: u64, arg10: 0x2::coin::Coin<T0>, arg11: address, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<PoemNFT>(mint_poem_nft<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg12, arg13), arg11);
    }

    public fun mint_poem_nft<T0>(arg0: &mut PlatformConfig, arg1: &mut Collection, arg2: &MintingCap, arg3: &PoetCap, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: u64, arg10: 0x2::coin::Coin<T0>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : PoemNFT {
        assert!(!arg0.paused, 1);
        assert!(0x1::type_name::get<T0>() == arg0.accepted_coin_type, 9);
        assert!(arg2.collection_id == 0x2::object::id<Collection>(arg1), 12);
        assert!(arg3.collection_id == 0x2::object::id<Collection>(arg1), 11);
        let v0 = 0x1::string::utf8(arg6);
        assert!(0x1::string::length(&v0) > 0, 6);
        assert!(0x1::vector::length<u8>(&arg8) > 0, 13);
        assert!(arg9 >= 1000000, 10);
        assert!(arg9 <= 2635249153387078, 14);
        assert!(0x2::coin::value<T0>(&arg10) >= arg9, 2);
        if (0x1::option::is_some<u64>(&arg1.max_supply)) {
            assert!(arg1.current_supply < *0x1::option::borrow<u64>(&arg1.max_supply), 3);
        };
        let v1 = arg9 * 7000 / 10000;
        let v2 = arg9 - v1;
        assert!(v1 + v2 == arg9, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg10, v1, arg12), arg3.poet_address);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg10, v2, arg12), arg0.platform_address);
        if (0x2::coin::value<T0>(&arg10) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg10, 0x2::tx_context::sender(arg12));
        } else {
            0x2::coin::destroy_zero<T0>(arg10);
        };
        arg1.current_supply = arg1.current_supply + 1;
        let v3 = arg1.current_supply;
        arg0.total_minted = arg0.total_minted + 1;
        arg0.total_revenue_mist = arg0.total_revenue_mist + arg9;
        let v4 = PoemNFT{
            id             : 0x2::object::new(arg12),
            poem_db_id     : arg4,
            order_db_id    : arg5,
            collection_id  : 0x2::object::id<Collection>(arg1),
            title          : 0x1::string::utf8(arg6),
            poet_name      : arg3.poet_name,
            poet_address   : arg3.poet_address,
            image_url      : 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(arg7)),
            content_hash   : arg8,
            price_mist     : arg9,
            edition_number : v3,
            minted_at      : 0x2::clock::timestamp_ms(arg11),
            rarity         : 0,
            attributes     : 0x1::option::none<Attributes>(),
        };
        let v5 = NFTMinted{
            nft_id            : 0x2::object::id<PoemNFT>(&v4),
            poem_db_id        : arg4,
            order_db_id       : arg5,
            collection_id     : 0x2::object::id<Collection>(arg1),
            minter            : 0x2::tx_context::sender(arg12),
            poet_address      : arg3.poet_address,
            price_mist        : arg9,
            poet_received     : v1,
            platform_received : v2,
            edition_number    : v3,
            timestamp         : 0x2::clock::timestamp_ms(arg11),
        };
        0x2::event::emit<NFTMinted>(v5);
        v4
    }

    public fun mint_poem_nft_random<T0>(arg0: &mut PlatformConfig, arg1: &mut Collection, arg2: &CollectionConfig, arg3: &MintingCap, arg4: &PoetCap, arg5: &0x2::random::Random, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: u64, arg11: 0x2::coin::Coin<T0>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : PoemNFT {
        assert!(!arg0.paused, 1);
        assert!(arg2.randomized_minting_enabled, 1);
        assert!(0x1::type_name::get<T0>() == arg0.accepted_coin_type, 9);
        assert!(arg3.collection_id == 0x2::object::id<Collection>(arg1), 12);
        assert!(arg4.collection_id == 0x2::object::id<Collection>(arg1), 11);
        assert!(arg2.collection_id == 0x2::object::id<Collection>(arg1), 12);
        let v0 = 0x1::string::utf8(arg8);
        assert!(0x1::string::length(&v0) > 0, 6);
        assert!(0x1::vector::length<u8>(&arg9) > 0, 13);
        assert!(arg10 >= 1000000, 10);
        assert!(arg10 <= 2635249153387078, 14);
        assert!(0x2::coin::value<T0>(&arg11) >= arg10, 2);
        if (0x1::option::is_some<u64>(&arg1.max_supply)) {
            assert!(arg1.current_supply < *0x1::option::borrow<u64>(&arg1.max_supply), 3);
        };
        let v1 = 0x2::random::new_generator(arg5, arg13);
        let v2 = 0x2::random::generate_u16(&mut v1) % 10000;
        let v3 = if (v2 < 8000) {
            0
        } else if (v2 < 9500) {
            1
        } else {
            2
        };
        let v4 = if (v3 == 0) {
            &arg2.common_pool
        } else if (v3 == 1) {
            &arg2.epic_pool
        } else {
            &arg2.legendary_pool
        };
        let v5 = Attributes{
            background_id   : 0x2::random::generate_u8(&mut v1) % v4.background_count,
            frame_id        : 0x2::random::generate_u8(&mut v1) % v4.frame_count,
            pattern_id      : 0x2::random::generate_u8(&mut v1) % v4.pattern_count,
            color_scheme_id : 0x2::random::generate_u8(&mut v1) % v4.color_scheme_count,
            text_style_id   : 0x2::random::generate_u8(&mut v1) % v4.text_style_count,
        };
        let v6 = arg10 * 7000 / 10000;
        let v7 = arg10 - v6;
        assert!(v6 + v7 == arg10, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg11, v6, arg13), arg4.poet_address);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg11, v7, arg13), arg0.platform_address);
        if (0x2::coin::value<T0>(&arg11) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg11, 0x2::tx_context::sender(arg13));
        } else {
            0x2::coin::destroy_zero<T0>(arg11);
        };
        arg1.current_supply = arg1.current_supply + 1;
        let v8 = arg1.current_supply;
        arg0.total_minted = arg0.total_minted + 1;
        arg0.total_revenue_mist = arg0.total_revenue_mist + arg10;
        let v9 = 0x2::clock::timestamp_ms(arg12);
        let v10 = PoemNFT{
            id             : 0x2::object::new(arg13),
            poem_db_id     : arg6,
            order_db_id    : arg7,
            collection_id  : 0x2::object::id<Collection>(arg1),
            title          : 0x1::string::utf8(arg8),
            poet_name      : arg4.poet_name,
            poet_address   : arg4.poet_address,
            image_url      : 0x1::option::none<0x2::url::Url>(),
            content_hash   : arg9,
            price_mist     : arg10,
            edition_number : v8,
            minted_at      : v9,
            rarity         : v3,
            attributes     : 0x1::option::some<Attributes>(v5),
        };
        let v11 = NFTMintedWithRarity{
            nft_id            : 0x2::object::id<PoemNFT>(&v10),
            poem_db_id        : arg6,
            order_db_id       : arg7,
            collection_id     : 0x2::object::id<Collection>(arg1),
            minter            : 0x2::tx_context::sender(arg13),
            poet_address      : arg4.poet_address,
            price_mist        : arg10,
            poet_received     : v6,
            platform_received : v7,
            edition_number    : v8,
            timestamp         : v9,
            rarity            : v3,
            rarity_roll       : v2,
            background_id     : v5.background_id,
            frame_id          : v5.frame_id,
            pattern_id        : v5.pattern_id,
            color_scheme_id   : v5.color_scheme_id,
            text_style_id     : v5.text_style_id,
        };
        0x2::event::emit<NFTMintedWithRarity>(v11);
        v10
    }

    public entry fun mint_random_and_transfer<T0>(arg0: &mut PlatformConfig, arg1: &mut Collection, arg2: &CollectionConfig, arg3: &MintingCap, arg4: &PoetCap, arg5: &0x2::random::Random, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: u64, arg11: 0x2::coin::Coin<T0>, arg12: address, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<PoemNFT>(mint_poem_nft_random<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg13, arg14), arg12);
    }

    public fun pause_platform(arg0: &AdminCap, arg1: &mut PlatformConfig, arg2: &0x2::clock::Clock) {
        arg1.paused = true;
        let v0 = PlatformStatusChanged{
            paused    : true,
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<PlatformStatusChanged>(v0);
    }

    public fun pay_royalty(arg0: &PoemNFT, arg1: &RoyaltyConfig, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.collection_id == arg0.collection_id, 11);
        let (v0, v1, v2) = calculate_secondary_royalty(arg3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v0, 15);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v1, arg4), arg1.poet_address);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v2, arg4), arg1.platform_address);
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0x2::tx_context::sender(arg4));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
        };
        let v3 = RoyaltyPaid{
            nft_id            : 0x2::object::id<PoemNFT>(arg0),
            sale_price        : arg3,
            total_royalty     : v0,
            poet_received     : v1,
            platform_received : v2,
            poet_address      : arg1.poet_address,
            platform_address  : arg1.platform_address,
        };
        0x2::event::emit<RoyaltyPaid>(v3);
    }

    public entry fun public_mint_random<T0>(arg0: &PublicMintConfig, arg1: &mut PlatformConfig, arg2: &mut Collection, arg3: &CollectionConfig, arg4: &0x2::random::Random, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: address, arg10: vector<u8>, arg11: vector<u8>, arg12: u64, arg13: 0x2::coin::Coin<T0>, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.enabled, 18);
        assert!(arg0.collection_id == 0x2::object::id<Collection>(arg2), 19);
        assert!(arg3.collection_id == 0x2::object::id<Collection>(arg2), 19);
        assert!(!arg1.paused, 1);
        assert!(arg3.randomized_minting_enabled, 1);
        assert!(0x1::type_name::get<T0>() == arg1.accepted_coin_type, 9);
        let v0 = 0x1::string::utf8(arg7);
        assert!(0x1::string::length(&v0) > 0, 6);
        assert!(0x1::vector::length<u8>(&arg8) > 0, 7);
        assert!(0x1::vector::length<u8>(&arg11) > 0, 13);
        assert!(arg12 >= arg0.min_price, 10);
        assert!(arg12 <= 2635249153387078, 14);
        assert!(0x2::coin::value<T0>(&arg13) >= arg12, 2);
        if (0x1::option::is_some<u64>(&arg2.max_supply)) {
            assert!(arg2.current_supply < *0x1::option::borrow<u64>(&arg2.max_supply), 3);
        };
        let v1 = 0x2::random::new_generator(arg4, arg15);
        let v2 = 0x2::random::generate_u16(&mut v1) % 10000;
        let v3 = if (v2 < 8000) {
            0
        } else if (v2 < 9500) {
            1
        } else {
            2
        };
        let v4 = if (v3 == 0) {
            &arg3.common_pool
        } else if (v3 == 1) {
            &arg3.epic_pool
        } else {
            &arg3.legendary_pool
        };
        let v5 = Attributes{
            background_id   : 0x2::random::generate_u8(&mut v1) % v4.background_count,
            frame_id        : 0x2::random::generate_u8(&mut v1) % v4.frame_count,
            pattern_id      : 0x2::random::generate_u8(&mut v1) % v4.pattern_count,
            color_scheme_id : 0x2::random::generate_u8(&mut v1) % v4.color_scheme_count,
            text_style_id   : 0x2::random::generate_u8(&mut v1) % v4.text_style_count,
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg13, arg12, arg15), arg1.platform_address);
        if (0x2::coin::value<T0>(&arg13) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg13, 0x2::tx_context::sender(arg15));
        } else {
            0x2::coin::destroy_zero<T0>(arg13);
        };
        arg2.current_supply = arg2.current_supply + 1;
        let v6 = arg2.current_supply;
        arg1.total_minted = arg1.total_minted + 1;
        arg1.total_revenue_mist = arg1.total_revenue_mist + arg12;
        let v7 = 0x2::clock::timestamp_ms(arg14);
        let v8 = PoemNFT{
            id             : 0x2::object::new(arg15),
            poem_db_id     : arg5,
            order_db_id    : arg6,
            collection_id  : 0x2::object::id<Collection>(arg2),
            title          : 0x1::string::utf8(arg7),
            poet_name      : 0x1::string::utf8(arg8),
            poet_address   : arg9,
            image_url      : 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(arg10)),
            content_hash   : arg11,
            price_mist     : arg12,
            edition_number : v6,
            minted_at      : v7,
            rarity         : v3,
            attributes     : 0x1::option::some<Attributes>(v5),
        };
        let v9 = NFTMintedWithRarity{
            nft_id            : 0x2::object::id<PoemNFT>(&v8),
            poem_db_id        : arg5,
            order_db_id       : arg6,
            collection_id     : 0x2::object::id<Collection>(arg2),
            minter            : 0x2::tx_context::sender(arg15),
            poet_address      : arg9,
            price_mist        : arg12,
            poet_received     : 0,
            platform_received : arg12,
            edition_number    : v6,
            timestamp         : v7,
            rarity            : v3,
            rarity_roll       : v2,
            background_id     : v5.background_id,
            frame_id          : v5.frame_id,
            pattern_id        : v5.pattern_id,
            color_scheme_id   : v5.color_scheme_id,
            text_style_id     : v5.text_style_id,
        };
        0x2::event::emit<NFTMintedWithRarity>(v9);
        0x2::transfer::public_transfer<PoemNFT>(v8, 0x2::tx_context::sender(arg15));
    }

    public fun set_accepted_coin_type<T0>(arg0: &AdminCap, arg1: &mut PlatformConfig) {
        let v0 = 0x1::type_name::get<T0>();
        arg1.accepted_coin_type = v0;
        let v1 = CoinTypeUpdated{
            old_type : arg1.accepted_coin_type,
            new_type : v0,
        };
        0x2::event::emit<CoinTypeUpdated>(v1);
    }

    public fun set_nft_image_url(arg0: &AdminCap, arg1: &mut PoemNFT, arg2: vector<u8>) {
        arg1.image_url = 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(arg2));
    }

    public entry fun set_public_mint_enabled(arg0: &AdminCap, arg1: &mut PublicMintConfig, arg2: bool) {
        arg1.enabled = arg2;
    }

    public entry fun set_public_mint_min_price(arg0: &AdminCap, arg1: &mut PublicMintConfig, arg2: u64) {
        arg1.min_price = arg2;
    }

    public fun set_randomized_minting_enabled(arg0: &AdminCap, arg1: &mut CollectionConfig, arg2: bool) {
        arg1.randomized_minting_enabled = arg2;
    }

    public fun unpause_platform(arg0: &AdminCap, arg1: &mut PlatformConfig, arg2: &0x2::clock::Clock) {
        arg1.paused = false;
        let v0 = PlatformStatusChanged{
            paused    : false,
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<PlatformStatusChanged>(v0);
    }

    public fun update_attribute_pool(arg0: &AdminCap, arg1: &mut CollectionConfig, arg2: u8, arg3: AttributePool) {
        if (arg2 == 0) {
            arg1.common_pool = arg3;
        } else if (arg2 == 1) {
            arg1.epic_pool = arg3;
        } else if (arg2 == 2) {
            arg1.legendary_pool = arg3;
        };
    }

    public entry fun update_attribute_pool_entry(arg0: &AdminCap, arg1: &mut CollectionConfig, arg2: u8, arg3: u8, arg4: u8, arg5: u8, arg6: u8, arg7: u8) {
        let v0 = AttributePool{
            background_count   : arg3,
            frame_count        : arg4,
            pattern_count      : arg5,
            color_scheme_count : arg6,
            text_style_count   : arg7,
        };
        update_attribute_pool(arg0, arg1, arg2, v0);
    }

    public fun update_platform_address(arg0: &AdminCap, arg1: &mut PlatformConfig, arg2: address) {
        assert!(arg2 != @0x0, 17);
        arg1.platform_address = arg2;
    }

    // decompiled from Move bytecode v6
}

