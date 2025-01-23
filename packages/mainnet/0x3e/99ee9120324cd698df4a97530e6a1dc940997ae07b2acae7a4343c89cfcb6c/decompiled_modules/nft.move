module 0x3e99ee9120324cd698df4a97530e6a1dc940997ae07b2acae7a4343c89cfcb6c::nft {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"ipfs://QmVJHXryF4x6fPYru5iYfKbMVkfWxrtZFc82RisSQtVHmq"));
        let v4 = 0x2::package::claim<NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<SNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<SNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<SNFT>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = SNFT{
            id   : 0x2::object::new(arg1),
            name : 0x1::string::utf8(b"NFT"),
        };
        0x2::transfer::public_transfer<SNFT>(v6, @0x95e32e4b0110cdba9b414c49686c37c3253c8b8432ea0932ddb6b190eeca0080);
    }

    // decompiled from Move bytecode v6
}

