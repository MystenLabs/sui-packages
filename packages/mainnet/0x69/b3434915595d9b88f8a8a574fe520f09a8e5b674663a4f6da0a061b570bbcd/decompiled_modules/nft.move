module 0x69b3434915595d9b88f8a8a574fe520f09a8e5b674663a4f6da0a061b570bbcd::nft {
    struct Hero has store, key {
        id: 0x2::object::UID,
    }

    struct NFT has drop {
        dummy_field: bool,
    }

    public entry fun MagmaFinance(arg0: vector<address>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0)) {
            let v1 = Hero{id: 0x2::object::new(arg1)};
            0x2::transfer::transfer<Hero>(v1, *0x1::vector::borrow<address>(&arg0, v0));
            v0 = v0 + 1;
        };
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(x"737569e285bc6162732ecebf7267"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://ipfs.io/ipfs/QmZEH8DqLPnSjDqkTPcpWQ4bKGF6ncTj5FBtTkdAtHUPMG"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(x"737569e285bc6162732ecebf7267202d20612067726f7774682d6f7269656e7465642063727970746f20706c6174666f726d20666f6375736564206f6e2068656c70696e67205375692d62617365642070726f6a6563747320616e6420746f6b656e73206761696e207472616374696f6e2e2057652070726f766964652070726f6d6f74696f6e2c207669736962696c6974792c20616e642065636f73797374656d20737570706f727420746f2064726976652061646f7074696f6e20616e64206c6f6e672d7465726d2067726f777468206163726f73732074686520537569206e6574776f726b2e"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"suipool"));
        let v4 = 0x2::package::claim<NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Hero>(&v4, v0, v2, arg1);
        0x2::display::update_version<Hero>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Hero>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Hero{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<Hero>(v0, arg0);
    }

    // decompiled from Move bytecode v6
}

