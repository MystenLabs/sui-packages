module 0x88eeddd2a7f1cd119741d22c8491a016aa0b89f5abcf356707d37ca96518475b::JANMIE_JAN_NFT {
    struct MyNFT has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct JANMIE_JAN_NFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: JANMIE_JAN_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        let v4 = 0x2::package::claim<JANMIE_JAN_NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<MyNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<MyNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<MyNFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: 0x1::string::String, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = MyNFT{
            id        : 0x2::object::new(arg2),
            name      : 0x1::string::utf8(b"JANMIE_JAN NFT"),
            image_url : arg0,
        };
        let v1 = MyNFT{
            id        : 0x2::object::new(arg2),
            name      : 0x1::string::utf8(b"send_nft"),
            image_url : 0x1::string::utf8(b"https://s1.imagehub.cc/images/2024/12/06/f2f657ee77dd947a09732e86afd886ac.jpg"),
        };
        0x2::transfer::transfer<MyNFT>(v0, 0x2::tx_context::sender(arg2));
        0x2::transfer::transfer<MyNFT>(v1, arg1);
    }

    // decompiled from Move bytecode v6
}

