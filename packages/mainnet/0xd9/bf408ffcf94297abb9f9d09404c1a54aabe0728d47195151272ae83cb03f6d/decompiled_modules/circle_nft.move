module 0xd9bf408ffcf94297abb9f9d09404c1a54aabe0728d47195151272ae83cb03f6d::circle_nft {
    struct CircleNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        svg_data: 0x1::string::String,
    }

    struct CIRCLE_NFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CIRCLE_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<CIRCLE_NFT>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"data:image/svg+xml;utf8,{svg_data}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"A 100% on-chain generated circle on Sui."));
        let v5 = 0x2::display::new_with_fields<CircleNFT>(&v0, v1, v3, arg1);
        0x2::display::update_version<CircleNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<CircleNFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"<svg viewBox='0 0 100 100' xmlns='http://www.w3.org/2000/svg'>");
        0x1::string::append(&mut v0, 0x1::string::utf8(b"<circle cx='50' cy='50' r='40' fill='"));
        0x1::string::append(&mut v0, arg0);
        0x1::string::append(&mut v0, 0x1::string::utf8(b"' />"));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"</svg>"));
        let v1 = CircleNFT{
            id       : 0x2::object::new(arg1),
            name     : 0x1::string::utf8(b"On-Chain Circle"),
            svg_data : v0,
        };
        0x2::transfer::public_transfer<CircleNFT>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

