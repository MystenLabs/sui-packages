module 0xd5fdee7a73b7bd03b489777b4b195ba2ca9ed1cb0717f049610d9721001475c2::meet {
    struct MEET has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEET, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"4791cec15825c441c4395e5ff93e1d7ec3fa68a55a13b86a3875d4fc7a4b01e4                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MEET>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Meet        ")))), trim_right(b"May I Meet You?                 "), trim_right(b"Bill Ackman's Advice on meeting women is catching steam as a new trend                                                                                                                                                                                                                                                          "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEET>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEET>>(v4);
    }

    fun trim_right(arg0: vector<u8>) : vector<u8> {
        let v0 = 32;
        let v1 = &v0;
        while (0x1::vector::length<u8>(&arg0) > 0) {
            if (0x1::vector::borrow<u8>(&arg0, 0x1::vector::length<u8>(&arg0) - 1) != v1) {
                break
            };
            0x1::vector::pop_back<u8>(&mut arg0);
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

