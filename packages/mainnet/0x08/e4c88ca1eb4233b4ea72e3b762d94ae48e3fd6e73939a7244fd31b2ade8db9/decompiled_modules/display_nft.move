module 0x8e4c88ca1eb4233b4ea72e3b762d94ae48e3fd6e73939a7244fd31b2ade8db9::display_nft {
    struct MyNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct DISPLAY_NFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DISPLAY_NFT, arg1: &mut 0x2::tx_context::TxContext) {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://sui-heroes.io"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Unknown Sui Fan"));
        let v4 = 0x2::package::claim<DISPLAY_NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<MyNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<MyNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<MyNFT>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = MyNFT{
            id        : 0x2::object::new(arg1),
            name      : 0x1::string::utf8(b"linqining"),
            image_url : 0x1::string::utf8(b"https://avatars.githubusercontent.com/u/18323181?s=400&u=1a7a274db375e0ffe9f303939d3283c5cedc1e25&v=4"),
        };
        0x2::transfer::public_transfer<MyNFT>(v6, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = MyNFT{
            id        : 0x2::object::new(arg1),
            name      : 0x1::string::utf8(b"linqining"),
            image_url : arg0,
        };
        0x2::transfer::public_transfer<MyNFT>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

