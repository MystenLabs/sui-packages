module 0xd01eabde5926eb391ef6e944ac43a22df1d8d914baa98000c6eaa9b6df8eb3ad::furbies {
    struct FURBIES has drop {
        dummy_field: bool,
    }

    fun init(arg0: FURBIES, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"9a78fe4467ab4a3406b2410d8fff834d9cd53641bc779436b0b8da95b10806bf                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<FURBIES>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Furbies     ")))), trim_right(b"Furbu Furbies                   "), trim_right(x"4675726275206973206e6f74206a7573742061206d656d6520636f696e206974732061206d6f76656d656e742e20496e73706972656420627920746865206e6f7374616c6769632c20717569726b792c20616e64206c6f7661626c652063726561747572652066726f6d20746865206c6174652039307320746f79206372617a652c20467572627520726570726573656e74732066756e2c20636f6d6d756e6974792c20616e642074686520756e73746f707061626c6520706f776572206f6620696e7465726e65742063756c747572652e20546869732069736e7420796f7572206176657261676520746f6b656e200a0a467572627520626c656e6473206d656d6520656e657267792077697468206120636f6d6d756e6974792d64726976656e20766973696f6e20746f2063726561746520736f6d657468696e6720706c"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FURBIES>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FURBIES>>(v4);
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

