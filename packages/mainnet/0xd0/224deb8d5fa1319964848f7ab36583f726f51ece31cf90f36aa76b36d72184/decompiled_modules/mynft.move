module 0xd0224deb8d5fa1319964848f7ab36583f726f51ece31cf90f36aa76b36d72184::mynft {
    struct MYNFT has drop {
        dummy_field: bool,
    }

    struct NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::ascii::String,
    }

    fun init(arg0: MYNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"fengnian9527"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://avatars.githubusercontent.com/u/130452683"));
        let v4 = 0x2::package::claim<MYNFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<NFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<NFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<NFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_to(arg0: 0x1::ascii::String, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = NFT{
            id   : 0x2::object::new(arg2),
            name : arg0,
        };
        0x2::transfer::public_transfer<NFT>(v0, arg1);
    }

    // decompiled from Move bytecode v6
}

