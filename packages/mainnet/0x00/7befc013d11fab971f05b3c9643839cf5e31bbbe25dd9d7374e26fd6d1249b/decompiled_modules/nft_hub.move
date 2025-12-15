module 0x7befc013d11fab971f05b3c9643839cf5e31bbbe25dd9d7374e26fd6d1249b::nft_hub {
    struct NFT_HUB has drop {
        dummy_field: bool,
    }

    struct Badge_NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x1::string::String,
        rarity: 0x1::string::String,
        category: 0x1::string::String,
    }

    public entry fun create_display(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"rarity"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"category"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"rarity"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"category"));
        let v4 = 0x2::display::new_with_fields<Badge_NFT>(arg0, v0, v2, arg1);
        0x2::display::update_version<Badge_NFT>(&mut v4);
        0x2::transfer::public_transfer<0x2::display::Display<Badge_NFT>>(v4, 0x2::tx_context::sender(arg1));
    }

    fun init(arg0: NFT_HUB, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<NFT_HUB>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = Badge_NFT{
            id          : 0x2::object::new(arg5),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x1::string::utf8(arg2),
            rarity      : 0x1::string::utf8(arg3),
            category    : 0x1::string::utf8(arg4),
        };
        0x2::transfer::public_transfer<Badge_NFT>(v0, 0x2::tx_context::sender(arg5));
    }

    // decompiled from Move bytecode v6
}

