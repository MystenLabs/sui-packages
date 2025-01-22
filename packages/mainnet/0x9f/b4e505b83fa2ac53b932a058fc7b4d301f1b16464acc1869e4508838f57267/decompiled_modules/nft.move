module 0x9fb4e505b83fa2ac53b932a058fc7b4d301f1b16464acc1869e4508838f57267::nft {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"ipfs://QmVJZ8xTmGZtVHNZMyrt8cptTFAXCDCzSYnH46txD4ASVE"));
        let v4 = 0x2::package::claim<NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<SNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<SNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<SNFT>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = SNFT{
            id   : 0x2::object::new(arg1),
            name : 0x1::string::utf8(b"NFT"),
        };
        0x2::transfer::public_transfer<SNFT>(v6, @0x9ae075f4f2856de14edfc49f08e23d5a9abff893787d1a289e8ccfdc03826464);
    }

    // decompiled from Move bytecode v6
}

