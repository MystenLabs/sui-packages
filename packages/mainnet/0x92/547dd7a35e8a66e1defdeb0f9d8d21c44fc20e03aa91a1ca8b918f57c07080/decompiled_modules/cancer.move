module 0x92547dd7a35e8a66e1defdeb0f9d8d21c44fc20e03aa91a1ca8b918f57c07080::cancer {
    struct CANCER has drop {
        dummy_field: bool,
    }

    fun init(arg0: CANCER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"00ff6ab4aa6b68cb09b51827824e25cf9e9103ed00e9b0a5e7deb9cd31bf4c35                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CANCER>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"CANCER      ")))), trim_right(b"HELP ME BEAT CANCER             "), trim_right(x"486579206672656e732c2069747320526169766f20686572652e20496d206669676874696e67207374616765203420736172636f6d6120616e6420747279696e6720746f2072616973652066756e647320666f722074726561746d656e74206162726f61642e2049766520616c77617973206c6f766564207468652063727970746f2073706163652c2063686173696e672070756d707320616e64206c6976696e672074686520646567656e206c6966652c20627574206e6f77206c69666520686974206d6520776974682074686520746f75676865737420626f7373206669676874207965742e20546869732069736e74206a75737420616e6f7468657220727567206f72206d656d652020697473206d79207265616c20737572766976616c2e200a0a4576657279206275792c2073686172652c206f72206b696e642077"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CANCER>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CANCER>>(v4);
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

