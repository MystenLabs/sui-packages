module 0x2336b58b379df602b9ab8923507d4ac6b54a5f2fd6c82d348bcb7d93294f888c::mika_lahtinen_nft {
    struct MIKA_LAHTINEN_NFT has drop {
        dummy_field: bool,
    }

    struct MIKA_LAHTINEN_NFT_MINTED has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
    }

    fun init(arg0: MIKA_LAHTINEN_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://avatars.githubusercontent.com/u/36355287"));
        let v4 = 0x2::package::claim<MIKA_LAHTINEN_NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<MIKA_LAHTINEN_NFT_MINTED>(&v4, v0, v2, arg1);
        0x2::display::update_version<MIKA_LAHTINEN_NFT_MINTED>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<MIKA_LAHTINEN_NFT_MINTED>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_to(arg0: 0x1::string::String, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = MIKA_LAHTINEN_NFT_MINTED{
            id   : 0x2::object::new(arg2),
            name : arg0,
        };
        0x2::transfer::public_transfer<MIKA_LAHTINEN_NFT_MINTED>(v0, arg1);
    }

    // decompiled from Move bytecode v6
}

