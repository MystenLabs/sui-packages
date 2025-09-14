module 0x5d6bc80118e6fb3612e5c7db5000ec17129e7bf34956ac8957f2c3671092c979::nft {
    struct RWAAdminCap has store, key {
        id: 0x2::object::UID,
        authorized_minter: address,
    }

    struct RWAVerification has copy, drop, store {
        asset_id: 0x1::string::String,
        category: 0x1::string::String,
        jurisdiction: 0x1::string::String,
    }

    struct Collection has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        creator: address,
        royalty_percentage: u64,
        max_supply: 0x1::option::Option<u64>,
        current_supply: u64,
    }

    struct RWAToken has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        animation_url: 0x1::option::Option<0x2::url::Url>,
        external_url: 0x1::option::Option<0x2::url::Url>,
        attributes: vector<Attribute>,
        collection_id: 0x1::option::Option<0x2::object::ID>,
        creator: address,
        royalty_percentage: u64,
        edition_number: 0x1::option::Option<u64>,
        created_at: u64,
        rwa_verification: RWAVerification,
        is_frozen: bool,
        redemption_allowed: bool,
    }

    struct Attribute has copy, drop, store {
        name: 0x1::string::String,
        value: 0x1::string::String,
    }

    struct NFT has drop {
        dummy_field: bool,
    }

    struct RWANFTMinted has copy, drop {
        nft_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        asset_id: 0x1::string::String,
        category: 0x1::string::String,
        collection_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct RWANFTFrozen has copy, drop {
        nft_id: 0x2::object::ID,
        admin: address,
        reason: 0x1::string::String,
    }

    struct RWANFTRedeemed has copy, drop {
        nft_id: 0x2::object::ID,
        redeemer: address,
    }

    struct CollectionCreated has copy, drop {
        collection_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
        max_supply: 0x1::option::Option<u64>,
    }

    public entry fun burn_rwa_nft(arg0: &RWAAdminCap, arg1: RWAToken, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.authorized_minter, 0);
        let RWAToken {
            id                 : v0,
            name               : _,
            description        : _,
            image_url          : _,
            animation_url      : _,
            external_url       : _,
            attributes         : _,
            collection_id      : _,
            creator            : _,
            royalty_percentage : _,
            edition_number     : _,
            created_at         : _,
            rwa_verification   : _,
            is_frozen          : _,
            redemption_allowed : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    public entry fun create_collection(arg0: vector<u8>, arg1: vector<u8>, arg2: u64, arg3: 0x1::option::Option<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg4);
        let v1 = 0x1::string::utf8(arg0);
        let v2 = Collection{
            id                 : v0,
            name               : v1,
            description        : 0x1::string::utf8(arg1),
            creator            : 0x2::tx_context::sender(arg4),
            royalty_percentage : arg2,
            max_supply         : arg3,
            current_supply     : 0,
        };
        let v3 = CollectionCreated{
            collection_id : 0x2::object::uid_to_inner(&v0),
            creator       : 0x2::tx_context::sender(arg4),
            name          : 0x1::string::substring(&v1, 0, 0x1::string::length(&v1)),
            max_supply    : arg3,
        };
        0x2::event::emit<CollectionCreated>(v3);
        0x2::transfer::share_object<Collection>(v2);
    }

    public fun get_asset_id(arg0: &RWAVerification) : vector<u8> {
        *0x1::string::as_bytes(&arg0.asset_id)
    }

    public fun get_attribute_name(arg0: &Attribute) : &0x1::string::String {
        &arg0.name
    }

    public fun get_attribute_value(arg0: &Attribute) : &0x1::string::String {
        &arg0.value
    }

    public fun get_category(arg0: &RWAVerification) : vector<u8> {
        *0x1::string::as_bytes(&arg0.category)
    }

    public fun get_collection_info(arg0: &Collection) : (&0x1::string::String, &0x1::string::String, address, u64, u64) {
        (&arg0.name, &arg0.description, arg0.creator, arg0.royalty_percentage, arg0.current_supply)
    }

    public fun get_creation_time(arg0: &RWAToken) : u64 {
        arg0.created_at
    }

    public fun get_creator_info(arg0: &RWAToken) : (address, u64) {
        (arg0.creator, arg0.royalty_percentage)
    }

    public fun get_description(arg0: &RWAToken) : vector<u8> {
        *0x1::string::as_bytes(&arg0.description)
    }

    public fun get_edition_number(arg0: &RWAToken) : 0x1::option::Option<u64> {
        arg0.edition_number
    }

    public fun get_image_url(arg0: &RWAToken) : vector<u8> {
        let v0 = 0x2::url::inner_url(&arg0.image_url);
        *0x1::ascii::as_bytes(&v0)
    }

    public fun get_name(arg0: &RWAToken) : vector<u8> {
        *0x1::string::as_bytes(&arg0.name)
    }

    public fun get_nft_attributes(arg0: &RWAToken) : &vector<Attribute> {
        &arg0.attributes
    }

    public fun get_nft_collection_id(arg0: &RWAToken) : &0x1::option::Option<0x2::object::ID> {
        &arg0.collection_id
    }

    public fun get_nft_creator(arg0: &RWAToken) : address {
        arg0.creator
    }

    public fun get_nft_info(arg0: &RWAToken) : (&0x1::string::String, &0x1::string::String, &0x2::url::Url, address, u64) {
        (&arg0.name, &arg0.description, &arg0.image_url, arg0.creator, arg0.royalty_percentage)
    }

    public fun get_nft_royalty(arg0: &RWAToken) : u64 {
        arg0.royalty_percentage
    }

    public fun get_rwa_verification(arg0: &RWAToken) : &RWAVerification {
        &arg0.rwa_verification
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = RWAAdminCap{
            id                : 0x2::object::new(arg1),
            authorized_minter : v0,
        };
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"animation_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"external_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"creator"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{animation_url}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{external_url}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"https://suirwa.tech"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{creator}"));
        let v6 = 0x2::package::claim<NFT>(arg0, arg1);
        let v7 = 0x2::display::new_with_fields<RWAToken>(&v6, v2, v4, arg1);
        0x2::display::update_version<RWAToken>(&mut v7);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v6, v0);
        0x2::transfer::public_transfer<0x2::display::Display<RWAToken>>(v7, v0);
        0x2::transfer::public_transfer<RWAAdminCap>(v1, v0);
    }

    public fun is_nft_frozen(arg0: &RWAToken) : bool {
        arg0.is_frozen
    }

    public fun is_part_of_collection(arg0: &RWAToken) : bool {
        0x1::option::is_some<0x2::object::ID>(&arg0.collection_id)
    }

    public fun is_redemption_allowed(arg0: &RWAToken) : bool {
        arg0.redemption_allowed
    }

    public entry fun mint_rwa_nft(arg0: &RWAAdminCap, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: 0x1::option::Option<vector<u8>>, arg5: 0x1::option::Option<vector<u8>>, arg6: vector<vector<u8>>, arg7: vector<vector<u8>>, arg8: 0x1::option::Option<0x2::object::ID>, arg9: u64, arg10: vector<u8>, arg11: vector<u8>, arg12: vector<u8>, arg13: address, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg14) == arg0.authorized_minter, 0);
        assert!(0x1::vector::length<vector<u8>>(&arg6) == 0x1::vector::length<vector<u8>>(&arg7), 1);
        let v0 = 0x2::object::new(arg14);
        assert!(arg9 <= 2500, 5);
        let v1 = 0x1::vector::empty<Attribute>();
        0x1::vector::reverse<vector<u8>>(&mut arg6);
        0x1::vector::reverse<vector<u8>>(&mut arg7);
        while (!0x1::vector::is_empty<vector<u8>>(&arg6)) {
            let v2 = Attribute{
                name  : 0x1::string::utf8(0x1::vector::pop_back<vector<u8>>(&mut arg6)),
                value : 0x1::string::utf8(0x1::vector::pop_back<vector<u8>>(&mut arg7)),
            };
            0x1::vector::push_back<Attribute>(&mut v1, v2);
        };
        let (v3, v4) = if (0x1::option::is_some<0x2::object::ID>(&arg8)) {
            (0x1::option::some<0x2::object::ID>(0x1::option::extract<0x2::object::ID>(&mut arg8)), 0x1::option::some<u64>(1))
        } else {
            (0x1::option::none<0x2::object::ID>(), 0x1::option::none<u64>())
        };
        let v5 = if (0x1::option::is_some<vector<u8>>(&arg4)) {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x1::option::extract<vector<u8>>(&mut arg4)))
        } else {
            0x1::option::none<0x2::url::Url>()
        };
        let v6 = if (0x1::option::is_some<vector<u8>>(&arg5)) {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x1::option::extract<vector<u8>>(&mut arg5)))
        } else {
            0x1::option::none<0x2::url::Url>()
        };
        let v7 = 0x1::string::utf8(arg1);
        let v8 = 0x1::string::utf8(arg2);
        let v9 = 0x1::string::utf8(arg10);
        let v10 = 0x1::string::utf8(arg11);
        let v11 = RWAVerification{
            asset_id     : v9,
            category     : v10,
            jurisdiction : 0x1::string::utf8(arg12),
        };
        let v12 = RWAToken{
            id                 : v0,
            name               : v7,
            description        : v8,
            image_url          : 0x2::url::new_unsafe_from_bytes(arg3),
            animation_url      : v5,
            external_url       : v6,
            attributes         : v1,
            collection_id      : v3,
            creator            : 0x2::tx_context::sender(arg14),
            royalty_percentage : arg9,
            edition_number     : v4,
            created_at         : 0x2::tx_context::epoch(arg14),
            rwa_verification   : v11,
            is_frozen          : false,
            redemption_allowed : true,
        };
        let v13 = RWANFTMinted{
            nft_id        : 0x2::object::uid_to_inner(&v0),
            creator       : 0x2::tx_context::sender(arg14),
            name          : 0x1::string::substring(&v7, 0, 0x1::string::length(&v7)),
            description   : v8,
            image_url     : 0x1::string::utf8(arg3),
            asset_id      : 0x1::string::substring(&v9, 0, 0x1::string::length(&v9)),
            category      : 0x1::string::substring(&v10, 0, 0x1::string::length(&v10)),
            collection_id : v3,
        };
        0x2::event::emit<RWANFTMinted>(v13);
        0x2::transfer::public_transfer<RWAToken>(v12, arg13);
    }

    public entry fun mint_rwa_nft_simple(arg0: &RWAAdminCap, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: 0x1::option::Option<vector<u8>>, arg5: 0x1::option::Option<vector<u8>>, arg6: vector<vector<u8>>, arg7: vector<vector<u8>>, arg8: u64, arg9: vector<u8>, arg10: vector<u8>, arg11: vector<u8>, arg12: address, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg13) == arg0.authorized_minter, 0);
        assert!(0x1::vector::length<vector<u8>>(&arg6) == 0x1::vector::length<vector<u8>>(&arg7), 1);
        let v0 = 0x2::object::new(arg13);
        assert!(arg8 <= 2500, 5);
        let v1 = 0x1::vector::empty<Attribute>();
        0x1::vector::reverse<vector<u8>>(&mut arg6);
        0x1::vector::reverse<vector<u8>>(&mut arg7);
        while (!0x1::vector::is_empty<vector<u8>>(&arg6)) {
            let v2 = Attribute{
                name  : 0x1::string::utf8(0x1::vector::pop_back<vector<u8>>(&mut arg6)),
                value : 0x1::string::utf8(0x1::vector::pop_back<vector<u8>>(&mut arg7)),
            };
            0x1::vector::push_back<Attribute>(&mut v1, v2);
        };
        let v3 = 0x1::option::none<0x2::object::ID>();
        let v4 = if (0x1::option::is_some<vector<u8>>(&arg4)) {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x1::option::extract<vector<u8>>(&mut arg4)))
        } else {
            0x1::option::none<0x2::url::Url>()
        };
        let v5 = if (0x1::option::is_some<vector<u8>>(&arg5)) {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x1::option::extract<vector<u8>>(&mut arg5)))
        } else {
            0x1::option::none<0x2::url::Url>()
        };
        let v6 = 0x1::string::utf8(arg1);
        let v7 = 0x1::string::utf8(arg2);
        let v8 = 0x1::string::utf8(arg9);
        let v9 = 0x1::string::utf8(arg10);
        let v10 = RWAVerification{
            asset_id     : v8,
            category     : v9,
            jurisdiction : 0x1::string::utf8(arg11),
        };
        let v11 = RWAToken{
            id                 : v0,
            name               : v6,
            description        : v7,
            image_url          : 0x2::url::new_unsafe_from_bytes(arg3),
            animation_url      : v4,
            external_url       : v5,
            attributes         : v1,
            collection_id      : v3,
            creator            : 0x2::tx_context::sender(arg13),
            royalty_percentage : arg8,
            edition_number     : 0x1::option::none<u64>(),
            created_at         : 0x2::tx_context::epoch(arg13),
            rwa_verification   : v10,
            is_frozen          : false,
            redemption_allowed : true,
        };
        let v12 = RWANFTMinted{
            nft_id        : 0x2::object::uid_to_inner(&v0),
            creator       : 0x2::tx_context::sender(arg13),
            name          : 0x1::string::substring(&v6, 0, 0x1::string::length(&v6)),
            description   : v7,
            image_url     : 0x1::string::utf8(arg3),
            asset_id      : 0x1::string::substring(&v8, 0, 0x1::string::length(&v8)),
            category      : 0x1::string::substring(&v9, 0, 0x1::string::length(&v9)),
            collection_id : v3,
        };
        0x2::event::emit<RWANFTMinted>(v12);
        0x2::transfer::public_transfer<RWAToken>(v11, arg12);
    }

    public entry fun redeem_rwa_nft(arg0: RWAToken, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_frozen, 3);
        assert!(arg0.redemption_allowed, 4);
        let v0 = RWANFTRedeemed{
            nft_id   : 0x2::object::uid_to_inner(&arg0.id),
            redeemer : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<RWANFTRedeemed>(v0);
        let RWAToken {
            id                 : v1,
            name               : _,
            description        : _,
            image_url          : _,
            animation_url      : _,
            external_url       : _,
            attributes         : _,
            collection_id      : _,
            creator            : _,
            royalty_percentage : _,
            edition_number     : _,
            created_at         : _,
            rwa_verification   : _,
            is_frozen          : _,
            redemption_allowed : _,
        } = arg0;
        0x2::object::delete(v1);
    }

    public entry fun set_nft_frozen(arg0: &RWAAdminCap, arg1: &mut RWAToken, arg2: bool, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.authorized_minter, 0);
        arg1.is_frozen = arg2;
        if (arg2) {
            let v0 = RWANFTFrozen{
                nft_id : 0x2::object::uid_to_inner(&arg1.id),
                admin  : 0x2::tx_context::sender(arg4),
                reason : 0x1::string::utf8(arg3),
            };
            0x2::event::emit<RWANFTFrozen>(v0);
        };
    }

    public entry fun transfer_nft(arg0: RWAToken, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_frozen, 3);
        0x2::transfer::public_transfer<RWAToken>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

