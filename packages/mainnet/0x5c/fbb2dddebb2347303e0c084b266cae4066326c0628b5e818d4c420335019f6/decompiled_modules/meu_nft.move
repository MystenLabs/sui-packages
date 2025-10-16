module 0x5cfbb2dddebb2347303e0c084b266cae4066326c0628b5e818d4c420335019f6::meu_nft {
    struct MEU_NFT has drop {
        dummy_field: bool,
    }

    struct SuiCollectible has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x1::string::String,
        rarity: u8,
        created_at: u64,
        updated_at: u64,
        creator: address,
        level: u64,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        edition: u64,
    }

    struct CollectionStats has key {
        id: 0x2::object::UID,
        total_minted: u64,
        common_count: u64,
        rare_count: u64,
        epic_count: u64,
        legendary_count: u64,
    }

    struct NFTMinted has copy, drop {
        nft_id: 0x2::object::ID,
        name: 0x1::string::String,
        rarity: u8,
        creator: address,
        edition: u64,
    }

    struct NFTUpgraded has copy, drop {
        nft_id: 0x2::object::ID,
        old_rarity: u8,
        new_rarity: u8,
        new_level: u64,
    }

    struct AttributeAdded has copy, drop {
        nft_id: 0x2::object::ID,
        key: 0x1::string::String,
        value: 0x1::string::String,
    }

    struct NFTBurned has copy, drop {
        nft_id: 0x2::object::ID,
        name: 0x1::string::String,
        rarity: u8,
    }

    public entry fun add_attribute(arg0: &mut SuiCollectible, arg1: vector<u8>, arg2: vector<u8>, arg3: &0x2::clock::Clock) {
        assert!(0x2::vec_map::size<0x1::string::String, 0x1::string::String>(&arg0.attributes) < 50, 2);
        let v0 = 0x1::string::utf8(arg1);
        let v1 = 0x1::string::utf8(arg2);
        assert!(!0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg0.attributes, &v0), 5);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut arg0.attributes, v0, v1);
        arg0.updated_at = 0x2::clock::timestamp_ms(arg3);
        let v2 = AttributeAdded{
            nft_id : 0x2::object::uid_to_inner(&arg0.id),
            key    : v0,
            value  : v1,
        };
        0x2::event::emit<AttributeAdded>(v2);
    }

    public entry fun burn(arg0: SuiCollectible, arg1: &mut CollectionStats) {
        let SuiCollectible {
            id          : v0,
            name        : v1,
            description : _,
            url         : _,
            rarity      : v4,
            created_at  : _,
            updated_at  : _,
            creator     : _,
            level       : _,
            attributes  : _,
            edition     : _,
        } = arg0;
        let v11 = v0;
        decrement_rarity_count(arg1, v4);
        let v12 = NFTBurned{
            nft_id : 0x2::object::uid_to_inner(&v11),
            name   : v1,
            rarity : v4,
        };
        0x2::event::emit<NFTBurned>(v12);
        0x2::object::delete(v11);
    }

    public entry fun create_display(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"rarity"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"level"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"edition"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{rarity}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Level {level}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{creator}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"#{edition}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://github.com/yourusername/sui-collectibles"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suiscan.xyz/mainnet/object/{id}"));
        let v4 = 0x2::display::new_with_fields<SuiCollectible>(arg0, v0, v2, arg1);
        0x2::display::update_version<SuiCollectible>(&mut v4);
        0x2::transfer::public_transfer<0x2::display::Display<SuiCollectible>>(v4, 0x2::tx_context::sender(arg1));
    }

    public fun created_at(arg0: &SuiCollectible) : u64 {
        arg0.created_at
    }

    public fun creator(arg0: &SuiCollectible) : address {
        arg0.creator
    }

    fun decrement_rarity_count(arg0: &mut CollectionStats, arg1: u8) {
        if (arg1 == 0) {
            arg0.common_count = arg0.common_count - 1;
        } else if (arg1 == 1) {
            arg0.rare_count = arg0.rare_count - 1;
        } else if (arg1 == 2) {
            arg0.epic_count = arg0.epic_count - 1;
        } else {
            arg0.legendary_count = arg0.legendary_count - 1;
        };
    }

    public fun description(arg0: &SuiCollectible) : 0x1::string::String {
        arg0.description
    }

    public fun edition(arg0: &SuiCollectible) : u64 {
        arg0.edition
    }

    fun increment_rarity_count(arg0: &mut CollectionStats, arg1: u8) {
        if (arg1 == 0) {
            arg0.common_count = arg0.common_count + 1;
        } else if (arg1 == 1) {
            arg0.rare_count = arg0.rare_count + 1;
        } else if (arg1 == 2) {
            arg0.epic_count = arg0.epic_count + 1;
        } else {
            arg0.legendary_count = arg0.legendary_count + 1;
        };
    }

    fun init(arg0: MEU_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = CollectionStats{
            id              : 0x2::object::new(arg1),
            total_minted    : 0,
            common_count    : 0,
            rare_count      : 0,
            epic_count      : 0,
            legendary_count : 0,
        };
        0x2::transfer::share_object<CollectionStats>(v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<MEU_NFT>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun level(arg0: &SuiCollectible) : u64 {
        arg0.level
    }

    public entry fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: u8, arg4: &0x2::clock::Clock, arg5: &mut CollectionStats, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 <= 3, 4);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        arg5.total_minted = arg5.total_minted + 1;
        if (arg3 == 0) {
            arg5.common_count = arg5.common_count + 1;
        } else if (arg3 == 1) {
            arg5.rare_count = arg5.rare_count + 1;
        } else if (arg3 == 2) {
            arg5.epic_count = arg5.epic_count + 1;
        } else {
            arg5.legendary_count = arg5.legendary_count + 1;
        };
        let v1 = 0x2::object::new(arg6);
        let v2 = SuiCollectible{
            id          : v1,
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x1::string::utf8(arg2),
            rarity      : arg3,
            created_at  : v0,
            updated_at  : v0,
            creator     : 0x2::tx_context::sender(arg6),
            level       : 1,
            attributes  : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
            edition     : arg5.total_minted,
        };
        let v3 = NFTMinted{
            nft_id  : 0x2::object::uid_to_inner(&v1),
            name    : v2.name,
            rarity  : arg3,
            creator : 0x2::tx_context::sender(arg6),
            edition : arg5.total_minted,
        };
        0x2::event::emit<NFTMinted>(v3);
        0x2::transfer::public_transfer<SuiCollectible>(v2, 0x2::tx_context::sender(arg6));
    }

    public fun name(arg0: &SuiCollectible) : 0x1::string::String {
        arg0.name
    }

    public fun rarity(arg0: &SuiCollectible) : u8 {
        arg0.rarity
    }

    public fun rarity_to_string(arg0: u8) : 0x1::string::String {
        if (arg0 == 0) {
            0x1::string::utf8(b"Common")
        } else if (arg0 == 1) {
            0x1::string::utf8(b"Rare")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"Epic")
        } else {
            0x1::string::utf8(b"Legendary")
        }
    }

    public fun total_minted(arg0: &CollectionStats) : u64 {
        arg0.total_minted
    }

    public entry fun update_description(arg0: &mut SuiCollectible, arg1: vector<u8>, arg2: &0x2::clock::Clock) {
        arg0.description = 0x1::string::utf8(arg1);
        arg0.updated_at = 0x2::clock::timestamp_ms(arg2);
    }

    public entry fun update_url(arg0: &mut SuiCollectible, arg1: vector<u8>, arg2: &0x2::clock::Clock) {
        arg0.url = 0x1::string::utf8(arg1);
        arg0.updated_at = 0x2::clock::timestamp_ms(arg2);
    }

    public fun updated_at(arg0: &SuiCollectible) : u64 {
        arg0.updated_at
    }

    public entry fun upgrade_rarity(arg0: &mut SuiCollectible, arg1: &0x2::clock::Clock, arg2: &mut CollectionStats) {
        assert!(arg0.rarity < 3, 1);
        let v0 = arg0.rarity;
        arg0.rarity = arg0.rarity + 1;
        arg0.level = arg0.level + 1;
        arg0.updated_at = 0x2::clock::timestamp_ms(arg1);
        decrement_rarity_count(arg2, v0);
        increment_rarity_count(arg2, arg0.rarity);
        let v1 = NFTUpgraded{
            nft_id     : 0x2::object::uid_to_inner(&arg0.id),
            old_rarity : v0,
            new_rarity : arg0.rarity,
            new_level  : arg0.level,
        };
        0x2::event::emit<NFTUpgraded>(v1);
    }

    public fun url(arg0: &SuiCollectible) : 0x1::string::String {
        arg0.url
    }

    // decompiled from Move bytecode v6
}

