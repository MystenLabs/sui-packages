module 0xe4e3885a31523d9f02af4883b182393983772e9bf753abe433cd24138a3c842e::simple_nft {
    struct SimpleNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct SIMPLE_NFT has drop {
        dummy_field: bool,
    }

    public entry fun create_simple_nft(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = SimpleNFT{
            id          : 0x2::object::new(arg1),
            name        : arg0,
            description : 0x1::string::utf8(b"A simple NFT"),
            image_url   : 0x1::string::utf8(b"https://i.imgur.com/5LOzwSR.png"),
        };
        0x2::transfer::transfer<SimpleNFT>(v0, 0x2::tx_context::sender(arg1));
    }

    fun init(arg0: SIMPLE_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        let v4 = 0x2::package::claim<SIMPLE_NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<SimpleNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<SimpleNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<SimpleNFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun mint_nft_batch(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        loop {
            let v1 = SimpleNFT{
                id          : 0x2::object::new(arg1),
                name        : arg0,
                description : 0x1::string::utf8(b"A simple NFT"),
                image_url   : 0x1::string::utf8(b"https://i.imgur.com/5LOzwSR.png"),
            };
            0x2::transfer::public_transfer<SimpleNFT>(v1, 0x2::tx_context::sender(arg1));
            v0 = v0 + 1;
            if (v0 == 1000) {
                break
            };
        };
    }

    // decompiled from Move bytecode v6
}

