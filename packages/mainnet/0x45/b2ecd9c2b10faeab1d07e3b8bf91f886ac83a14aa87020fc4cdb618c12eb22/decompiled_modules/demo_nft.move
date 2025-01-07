module 0x45b2ecd9c2b10faeab1d07e3b8bf91f886ac83a14aa87020fc4cdb618c12eb22::demo_nft {
    struct DEMO_NFT has drop {
        dummy_field: bool,
    }

    struct DemoNFT has store, key {
        id: 0x2::object::UID,
        title: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    public entry fun create_nft(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = DemoNFT{
            id        : 0x2::object::new(arg2),
            title     : arg0,
            image_url : arg1,
        };
        0x2::transfer::public_transfer<DemoNFT>(v0, 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: DEMO_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"This is an NFT that anyone can display how they want. Name / Image URL is free to be chosen."));
        let v4 = 0x2::package::claim<DEMO_NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<DemoNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<DemoNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<DemoNFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

