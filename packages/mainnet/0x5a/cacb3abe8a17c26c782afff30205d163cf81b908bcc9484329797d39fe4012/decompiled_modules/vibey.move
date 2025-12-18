module 0x5acacb3abe8a17c26c782afff30205d163cf81b908bcc9484329797d39fe4012::vibey {
    struct VIBEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: VIBEY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"bbecb2ef95a7697936206b19618c6d80bc8ca3c644f6b463545c3d0bc3e99e3b                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<VIBEY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"VIBEY       ")))), trim_right(b"Vibey Turtle                    "), trim_right(x"46697273742067616d696e67206c61756e6368706164206f6e20536f6c616e612c20706f7765726564206279206e6f2d636f64652067616d6520656e67696e6520616e64204149206368617261637465722067656e206167656e742e0a0a4275696c6420616e6420746f6b656e697365206172636164652067616d6573206f6e20536f6c616e612c20696e7374616e746c792077697468206472616720262064726f7020626c6f636b7320696e207e35206d696e732e0a0a4561726e2063726561746f7220666565732c20706f77657265642062792053656e6453686f742e20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VIBEY>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VIBEY>>(v4);
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

