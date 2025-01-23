module 0x74d5aa71649f8a687d0b6567c2803f58ec0015b6338e9e9ed0e59ab52d3d2633::nft {
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
        0x2::transfer::public_transfer<SNFT>(v6, @0x5e4c4a097b9abbcc51b9d5be406cafc8c64a1bcc3a8a64eb5293407882b469e1);
    }

    // decompiled from Move bytecode v6
}

