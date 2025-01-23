module 0xb2d6c3967f9bebeae5378e5da280bb1bcfab580e6c52003dfeab8136b99c4257::nft {
    struct NFT has drop {
        dummy_field: bool,
    }

    struct SNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"NFT"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"ipfs://Qmd2bgDEe3tmP4EyAacHGPaaaaZpYFLiKCdV3NJYZpk7Bi"));
        let v4 = 0x2::package::claim<NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<SNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<SNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<SNFT>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = SNFT{
            id   : 0x2::object::new(arg1),
            name : 0x1::string::utf8(b"NFT"),
        };
        0x2::transfer::public_transfer<SNFT>(v6, @0x3361f74a9d0e27f7b59c6d913d6c4a6f16684e2b6d0d1ffae98c704eb2ec7792);
    }

    // decompiled from Move bytecode v6
}

