module 0xf8f092dff633d77c2c083a90129fda9ea3b5edc2f2ab992bad5231290d4f5fb7::poetart_nft {
    struct POETART_NFT has drop {
        dummy_field: bool,
    }

    struct CollectionConfig has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        total_minted: u64,
        max_supply: u64,
        mint_price: u64,
        is_minting_active: bool,
        common_attributes: AttributePool,
        epic_attributes: AttributePool,
        legendary_attributes: AttributePool,
    }

    struct AttributePool has copy, drop, store {
        background_count: u8,
        frame_count: u8,
        pattern_count: u8,
        color_scheme_count: u8,
        text_style_count: u8,
    }

    struct PoetArtNFT has store, key {
        id: 0x2::object::UID,
        token_id: u64,
        name: 0x1::string::String,
        rarity: u8,
        attributes: Attributes,
        created_at: u64,
        creator: address,
    }

    struct Attributes has copy, drop, store {
        background_id: u8,
        frame_id: u8,
        pattern_id: u8,
        color_scheme_id: u8,
        text_style_id: u8,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct NFTMinted has copy, drop {
        nft_id: 0x2::object::ID,
        token_id: u64,
        rarity: u8,
        minter: address,
        attributes: Attributes,
    }

    struct RarityRolled has copy, drop {
        token_id: u64,
        random_value: u16,
        rarity: u8,
    }

    public fun decompose_attributes(arg0: &Attributes) : (u8, u8, u8, u8, u8) {
        (arg0.background_id, arg0.frame_id, arg0.pattern_id, arg0.color_scheme_id, arg0.text_style_id)
    }

    fun determine_rarity(arg0: &mut 0x2::random::RandomGenerator, arg1: u64) : u8 {
        let v0 = 0x2::random::generate_u16(arg0) % 10000;
        let v1 = if (v0 < 8000) {
            0
        } else if (v0 < 9500) {
            1
        } else {
            2
        };
        let v2 = RarityRolled{
            token_id     : arg1,
            random_value : v0,
            rarity       : v1,
        };
        0x2::event::emit<RarityRolled>(v2);
        v1
    }

    public fun get_attributes(arg0: &PoetArtNFT) : Attributes {
        arg0.attributes
    }

    public fun get_collection_stats(arg0: &CollectionConfig) : (u64, u64, bool) {
        (arg0.total_minted, arg0.max_supply, arg0.is_minting_active)
    }

    public fun get_metadata<T0: copy + store>(arg0: &PoetArtNFT, arg1: vector<u8>) : T0 {
        *0x2::dynamic_field::borrow<0x1::string::String, T0>(&arg0.id, 0x1::string::utf8(arg1))
    }

    public fun get_rarity(arg0: &PoetArtNFT) : u8 {
        arg0.rarity
    }

    public fun get_rarity_name(arg0: u8) : 0x1::string::String {
        if (arg0 == 0) {
            0x1::string::utf8(b"Common")
        } else if (arg0 == 1) {
            0x1::string::utf8(b"Epic")
        } else {
            0x1::string::utf8(b"Legendary")
        }
    }

    fun init(arg0: POETART_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = AttributePool{
            background_count   : 10,
            frame_count        : 8,
            pattern_count      : 12,
            color_scheme_count : 15,
            text_style_count   : 6,
        };
        let v2 = AttributePool{
            background_count   : 8,
            frame_count        : 6,
            pattern_count      : 10,
            color_scheme_count : 12,
            text_style_count   : 5,
        };
        let v3 = AttributePool{
            background_count   : 5,
            frame_count        : 4,
            pattern_count      : 6,
            color_scheme_count : 8,
            text_style_count   : 3,
        };
        let v4 = CollectionConfig{
            id                   : 0x2::object::new(arg1),
            name                 : 0x1::string::utf8(b"PoetArt Genesis Collection"),
            description          : 0x1::string::utf8(b"Generative poetry NFTs with randomized rarity tiers"),
            total_minted         : 0,
            max_supply           : 10000,
            mint_price           : 1000000000,
            is_minting_active    : true,
            common_attributes    : v1,
            epic_attributes      : v2,
            legendary_attributes : v3,
        };
        0x2::transfer::share_object<CollectionConfig>(v4);
    }

    public entry fun mint_nft(arg0: &mut CollectionConfig, arg1: &0x2::random::Random, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_minting_active, 2);
        assert!(arg0.total_minted < arg0.max_supply, 4);
        let v0 = 0x2::random::new_generator(arg1, arg3);
        arg0.total_minted = arg0.total_minted + 1;
        let v1 = arg0.total_minted;
        let v2 = &mut v0;
        let v3 = determine_rarity(v2, v1);
        let v4 = &mut v0;
        let v5 = select_attributes(v4, v3, arg0);
        let v6 = PoetArtNFT{
            id         : 0x2::object::new(arg3),
            token_id   : v1,
            name       : 0x1::string::utf8(arg2),
            rarity     : v3,
            attributes : v5,
            created_at : 0x2::tx_context::epoch(arg3),
            creator    : 0x2::tx_context::sender(arg3),
        };
        let v7 = NFTMinted{
            nft_id     : 0x2::object::id<PoetArtNFT>(&v6),
            token_id   : v1,
            rarity     : v3,
            minter     : 0x2::tx_context::sender(arg3),
            attributes : v5,
        };
        0x2::event::emit<NFTMinted>(v7);
        0x2::transfer::public_transfer<PoetArtNFT>(v6, 0x2::tx_context::sender(arg3));
    }

    fun select_attributes(arg0: &mut 0x2::random::RandomGenerator, arg1: u8, arg2: &CollectionConfig) : Attributes {
        let v0 = if (arg1 == 0) {
            &arg2.common_attributes
        } else if (arg1 == 1) {
            &arg2.epic_attributes
        } else {
            &arg2.legendary_attributes
        };
        Attributes{
            background_id   : 0x2::random::generate_u8(arg0) % v0.background_count,
            frame_id        : 0x2::random::generate_u8(arg0) % v0.frame_count,
            pattern_id      : 0x2::random::generate_u8(arg0) % v0.pattern_count,
            color_scheme_id : 0x2::random::generate_u8(arg0) % v0.color_scheme_count,
            text_style_id   : 0x2::random::generate_u8(arg0) % v0.text_style_count,
        }
    }

    public entry fun set_mint_price(arg0: &AdminCap, arg1: &mut CollectionConfig, arg2: u64) {
        arg1.mint_price = arg2;
    }

    public entry fun set_minting_active(arg0: &AdminCap, arg1: &mut CollectionConfig, arg2: bool) {
        arg1.is_minting_active = arg2;
    }

    public fun store_metadata<T0: store>(arg0: &mut PoetArtNFT, arg1: vector<u8>, arg2: T0) {
        0x2::dynamic_field::add<0x1::string::String, T0>(&mut arg0.id, 0x1::string::utf8(arg1), arg2);
    }

    public entry fun update_attribute_pool(arg0: &AdminCap, arg1: &mut CollectionConfig, arg2: u8, arg3: u8, arg4: u8, arg5: u8, arg6: u8, arg7: u8) {
        assert!(arg2 <= 2, 0);
        let v0 = AttributePool{
            background_count   : arg3,
            frame_count        : arg4,
            pattern_count      : arg5,
            color_scheme_count : arg6,
            text_style_count   : arg7,
        };
        if (arg2 == 0) {
            arg1.common_attributes = v0;
        } else if (arg2 == 1) {
            arg1.epic_attributes = v0;
        } else {
            arg1.legendary_attributes = v0;
        };
    }

    // decompiled from Move bytecode v6
}

