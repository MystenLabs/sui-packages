module 0x76fe5fa42846a0fee855559f728570f929413e732b2f1fe485a7ad5f332306e8::display_nft {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suivision.xyz/object/{id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"sui move dev!"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://docs.sui.io/standards/display"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"0x-zeros"));
        let v4 = 0x2::package::claim<DISPLAY_NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<MyNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<MyNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<MyNFT>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = MyNFT{
            id        : 0x2::object::new(arg1),
            name      : 0x1::string::utf8(b"0x-zeros display nft"),
            image_url : 0x1::string::utf8(b"https://img2.baidu.com/it/u=883245903,2894896770&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=889"),
        };
        0x2::transfer::public_transfer<MyNFT>(v6, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = MyNFT{
            id        : 0x2::object::new(arg2),
            name      : arg0,
            image_url : arg1,
        };
        0x2::transfer::public_transfer<MyNFT>(v0, 0x2::tx_context::sender(arg2));
    }

    public entry fun mintTo(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = MyNFT{
            id        : 0x2::object::new(arg1),
            name      : 0x1::string::utf8(b"0x-zeros display nft"),
            image_url : 0x1::string::utf8(b"https://img2.baidu.com/it/u=883245903,2894896770&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=889"),
        };
        0x2::transfer::public_transfer<MyNFT>(v0, arg0);
    }

    // decompiled from Move bytecode v6
}

