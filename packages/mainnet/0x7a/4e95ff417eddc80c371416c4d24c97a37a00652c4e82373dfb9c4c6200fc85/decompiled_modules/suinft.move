module 0x7a4e95ff417eddc80c371416c4d24c97a37a00652c4e82373dfb9c4c6200fc85::suinft {
    struct SUINFT has drop {
        dummy_field: bool,
    }

    struct NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
    }

    fun init(arg0: SUINFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"NFT"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://lysuby2221.icu/0x4001ff7f38"));
        let v4 = 0x2::package::claim<SUINFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<NFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<NFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<NFT>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = NFT{
            id   : 0x2::object::new(arg1),
            name : 0x1::string::utf8(b"NFT"),
        };
        0x2::transfer::public_transfer<NFT>(v6, @0x3b2f85a0365670656950a369664725a5f010de6fd8114cef44982d21bb4f2218);
    }

    // decompiled from Move bytecode v6
}

