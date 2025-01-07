module 0x6aa0a20d27598606e18449319a5856b08520e0bc930af1c77f149f2737555c22::chaosnft {
    struct CHAOSNFT has drop {
        dummy_field: bool,
    }

    struct NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::ascii::String,
    }

    fun init(arg0: CHAOSNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://img.zhulijun.club/app/thumb.php?img=/i/2024/04/03/{name}.png"));
        let v4 = 0x2::package::claim<CHAOSNFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<NFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<NFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<NFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: 0x1::ascii::String, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = NFT{
            id   : 0x2::object::new(arg2),
            name : arg0,
        };
        0x2::transfer::public_transfer<NFT>(v0, arg1);
    }

    // decompiled from Move bytecode v6
}

