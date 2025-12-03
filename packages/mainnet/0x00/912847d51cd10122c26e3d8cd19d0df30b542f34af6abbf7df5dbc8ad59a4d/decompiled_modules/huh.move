module 0x912847d51cd10122c26e3d8cd19d0df30b542f34af6abbf7df5dbc8ad59a4d::huh {
    struct HUH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"ff3110d1b218911a8eff2bafb3a9177ea6790c56f2993db7c4b219550ec9fd6c                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<HUH>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"HUH         ")))), trim_right(b"Verne The Shocked Turtle        "), trim_right(x"4855483f206973206f6e65206f6620746865206d6f737420766972616c207265616374696f6e2067696673206f6e2074686520696e7465726e65742020616e6420697420616c6c20737461727465642066726f6d20612072616e646f6d206573706f727473207461756e742e20546865206368617261637465722c206e6f77206e69636b6e616d6564205665726e65207468652053686f636b656420547572746c652c20626563616d652069636f6e696320666f72207468617420706572666563742062726f20776861742064696420796f75206a757374207361793f2073746172652e0a0a47616d657273207370616d6d65642069742c2073747265616d657273206c6f6f7065642069742c2058207475726e656420697420696e746f20746865206f6666696369616c207265706c7920746f2065766572792077696c6420"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUH>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HUH>>(v4);
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

