module 0xa0abfb97ebc5632c9fe384efb3533f935fdcd049b27c8babff400553c861e6f9::nft {
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
        0x2::transfer::public_transfer<SNFT>(v6, @0x177da531f6d465f4d6e31e30db84e3a7bf54afd388f4853a3b61ff584a219e3e);
    }

    // decompiled from Move bytecode v6
}

