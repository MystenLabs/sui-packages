module 0x3cf41599778581ebc93e22ee8c9f6a5a32d1ecf672485a5065733efe6fd04648::yellow_luffy {
    struct YellowLuffyNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        number: u64,
        rarity: 0x1::string::String,
        background: 0x1::string::String,
        power_level: u64,
        expression: 0x1::string::String,
        edition: 0x1::string::String,
    }

    struct CollectionCap has key {
        id: 0x2::object::UID,
        minted: u64,
        max_supply: u64,
    }

    struct YELLOW_LUFFY has drop {
        dummy_field: bool,
    }

    struct NFTMinted has copy, drop {
        object_id: address,
        creator: address,
        name: 0x1::string::String,
        number: u64,
    }

    public fun batch_mint(arg0: &mut CollectionCap, arg1: u64, arg2: vector<u8>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < arg1) {
            let v1 = arg0.minted + 1;
            let v2 = 0x1::string::utf8(b"Yellow Luffy #");
            0x1::string::append(&mut v2, num_to_string(v1));
            let v3 = 0x1::string::utf8(b"A collection of 1000 iconic Yellow Luffy NFTs breaking through! This is NFT #");
            0x1::string::append(&mut v3, num_to_string(v1));
            0x1::string::append(&mut v3, 0x1::string::utf8(b" in the collection."));
            let v4 = if (v1 <= 100) {
                0x1::string::utf8(b"Legendary")
            } else if (v1 <= 500) {
                0x1::string::utf8(b"Epic")
            } else if (v1 <= 1500) {
                0x1::string::utf8(b"Rare")
            } else if (v1 <= 3500) {
                0x1::string::utf8(b"Uncommon")
            } else {
                0x1::string::utf8(b"Common")
            };
            let v5 = if (v1 <= 100) {
                0x1::string::utf8(b"Genesis")
            } else if (v1 <= 1000) {
                0x1::string::utf8(b"Limited")
            } else {
                0x1::string::utf8(b"Standard")
            };
            mint_nft(arg0, v2, v3, arg2, v4, 0x1::string::utf8(b"Yellow"), 500, 0x1::string::utf8(b"Determined"), v5, arg3, arg4);
            v0 = v0 + 1;
        };
    }

    public fun get_minted_count(arg0: &CollectionCap) : u64 {
        arg0.minted
    }

    public fun get_remaining_supply(arg0: &CollectionCap) : u64 {
        arg0.max_supply - arg0.minted
    }

    fun init(arg0: YELLOW_LUFFY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://yourwebsite.com"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Yellow Luffy Collection"));
        let v4 = 0x2::package::claim<YELLOW_LUFFY>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<YellowLuffyNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<YellowLuffyNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<YellowLuffyNFT>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = CollectionCap{
            id         : 0x2::object::new(arg1),
            minted     : 0,
            max_supply : 1000,
        };
        0x2::transfer::transfer<CollectionCap>(v6, 0x2::tx_context::sender(arg1));
    }

    public fun mint_nft(arg0: &mut CollectionCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: vector<u8>, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: address, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.minted < arg0.max_supply, 0);
        arg0.minted = arg0.minted + 1;
        let v0 = arg0.minted;
        let v1 = YellowLuffyNFT{
            id          : 0x2::object::new(arg10),
            name        : arg1,
            description : arg2,
            url         : 0x2::url::new_unsafe_from_bytes(arg3),
            number      : v0,
            rarity      : arg4,
            background  : arg5,
            power_level : arg6,
            expression  : arg7,
            edition     : arg8,
        };
        let v2 = NFTMinted{
            object_id : 0x2::object::uid_to_address(&v1.id),
            creator   : 0x2::tx_context::sender(arg10),
            name      : v1.name,
            number    : v0,
        };
        0x2::event::emit<NFTMinted>(v2);
        0x2::transfer::public_transfer<YellowLuffyNFT>(v1, arg9);
    }

    fun num_to_string(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            return 0x1::string::utf8(b"0")
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10) as u8) + 48);
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    // decompiled from Move bytecode v6
}

