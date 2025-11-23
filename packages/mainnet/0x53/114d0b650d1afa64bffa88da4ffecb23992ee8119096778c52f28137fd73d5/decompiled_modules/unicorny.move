module 0x53114d0b650d1afa64bffa88da4ffecb23992ee8119096778c52f28137fd73d5::unicorny {
    struct UNICORNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNICORNY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"4e0e3a61bd94a999fc64a2ba2cc5a26903e6ce7caa80d362396d14955dc96ef7                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<UNICORNY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"UNICORNY    ")))), trim_right(b"UNICORNY                        "), trim_right(x"46726f6d2046616e7320746f20466f756e646572730a0a57652062656c696576652074686520667574757265206c69657320696e2066617374657220616e642066616972657220646973747269627574696f6e206f66207265736f757263657320746f2074686520626573742069646561732c20676c6f62616c6c792e20576520656d62726163652061207368696674206f6620706f77657266726f6d20676174656b65657065727320746f2063726561746f72733b2066726f6d2062616e6b65727320746f2066616e732e2057652072656675736520746f206365646520626c6f636b636861696e20616e64205765623320746f20677269667465727320616e64206f70706f7274756e697374732e204a7573742061732077652072656a6563742061206d7573696320696e647573747279206d6f64656c2074686174206f"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNICORNY>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UNICORNY>>(v4);
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

