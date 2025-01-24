module 0x46b707eb1933d2a55439b2c7d436c3dfb9158ea8ce6f4bdf57e6bd462cc4ca14::fennec {
    struct FENNEC has drop {
        dummy_field: bool,
    }

    fun init(arg0: FENNEC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"ZgUS4WCkZ6Eee2vc                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<FENNEC>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"FENNEC      ")))), trim_right(b"Fennec Fox                      "), trim_right(x"46656e6e65632069732074686520656e6368616e74696e672c206c6f7661626c652c20796574206564677920666f782077686f206973206f6e65206f662063727970746f277320626967676573742066616e732e2020446f696e67206974206f6c64207363686f6f6c20776974682070656f706c6520616e64206120766973696f6e2e202057652077656c636f6d6520796f7520746f206a6f696e206f757220636f6d6d756e697479206f6e2054656c656772616d2c2077686572652077652063616e20616e7377657220616e79207175657374696f6e7320796f75206d61792068617665210d0a0d0a4e6f7720776974682050726f2057726573746c696e6720696e64757374727920757064617465732f6368617420696e207468652054656c656772616d2067726f75702120204c65747320676f210d0a0d0a2020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FENNEC>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FENNEC>>(v4);
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

