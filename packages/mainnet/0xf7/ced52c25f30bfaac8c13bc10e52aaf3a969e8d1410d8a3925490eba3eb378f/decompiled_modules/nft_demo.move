module 0xf7ced52c25f30bfaac8c13bc10e52aaf3a969e8d1410d8a3925490eba3eb378f::nft_demo {
    struct MyNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct NFT_DEMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NFT_DEMO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://sui-heroes.io/hero/{id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"A true Hero of the Sui ecosystem!"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://github.com/Jack-751"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Jack-751"));
        let v4 = 0x2::package::claim<NFT_DEMO>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<MyNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<MyNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<MyNFT>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = MyNFT{
            id        : 0x2::object::new(arg1),
            name      : 0x1::string::utf8(b"Jack-751 NFT"),
            image_url : 0x1::string::utf8(b"https://avatars.githubusercontent.com/u/81602637?v=4"),
        };
        0x2::transfer::public_transfer<MyNFT>(v6, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_nft(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = MyNFT{
            id        : 0x2::object::new(arg2),
            name      : arg0,
            image_url : arg1,
        };
        0x2::transfer::public_transfer<MyNFT>(v0, 0x2::tx_context::sender(arg2));
    }

    public entry fun transfer_nft(arg0: MyNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<MyNFT>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

