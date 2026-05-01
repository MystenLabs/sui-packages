module 0xd0b37a28050a80d72eee737913e6292562cf61b601fe883139d53a40656893cf::collection {
    struct COLLECTION has drop {
        dummy_field: bool,
    }

    struct ArtworkNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x1::string::String,
    }

    fun init(arg0: COLLECTION, arg1: &mut 0x2::tx_context::TxContext) {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://tradeport.xyz"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Sui Autonomous AI Agent"));
        let v4 = 0x2::package::claim<COLLECTION>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<ArtworkNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<ArtworkNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<ArtworkNFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun mint_nft(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : ArtworkNFT {
        ArtworkNFT{
            id          : 0x2::object::new(arg3),
            name        : arg0,
            description : arg1,
            url         : arg2,
        }
    }

    public fun update_metadata(arg0: &mut ArtworkNFT, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.name = arg1;
        arg0.description = arg2;
    }

    // decompiled from Move bytecode v7
}

