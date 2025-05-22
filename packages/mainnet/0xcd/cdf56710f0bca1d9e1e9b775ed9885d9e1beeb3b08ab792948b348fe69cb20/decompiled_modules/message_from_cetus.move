module 0xcdcdf56710f0bca1d9e1e9b775ed9885d9e1beeb3b08ab792948b348fe69cb20::message_from_cetus {
    struct MessageFromCetus has store, key {
        id: 0x2::object::UID,
    }

    struct MESSAGE_FROM_CETUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MESSAGE_FROM_CETUS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Message from Cetus"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://node1.irys.xyz/DBQDfC6ryUbdUysbArZE8SrtUE2ZZQ6KUgFJIC7IgTc"));
        let v4 = 0x2::package::claim<MESSAGE_FROM_CETUS>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<MessageFromCetus>(&v4, v0, v2, arg1);
        0x2::display::update_version<MessageFromCetus>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<MessageFromCetus>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = MessageFromCetus{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<MessageFromCetus>(v6, @0xe28b50cef1d633ea43d3296a3f6b67ff0312a5f1a99f0af753c85b8b5de8ff06);
        let v7 = MessageFromCetus{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<MessageFromCetus>(v7, @0xcd8962dad278d8b50fa0f9eb0186bfa4cbdecc6d59377214c88d0286a0ac9562);
    }

    // decompiled from Move bytecode v6
}

