module 0x316c2a66449bb904c985c5478110520cc523c7012ed64c3107c43cd0c80ffe21::wopill {
    struct WOPILL has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOPILL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"95bd24963210afdc0a2bf89b76070182107768de3b57ddd100e1afa1d9a9e3cb                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<WOPILL>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"wopill      ")))), trim_right(b"wopill                          "), trim_right(x"576f6a616b206469646e74206469652069742065766f6c7665642e2074686520636f6d6d756e6974792073776f6f70656420696e20616e64207475726e656420697420696e746f2024574f50494c4c20616e642067756573732077686174203f204974277320612043544f206e6f772e0a4e6f772065766572796f6e65206f6e2050756d7066756e206b6e6f77733a20746869732069736e7420612070726f6a65637420616e796d6f72652c2069747320612066756c6c20636f6d6d756e6974792074616b656f7665722e0a4e6f206465762c206e6f20726f61646d61702c206a757374207075726520646567656e20656e65726779206b656570696e6720697420616c697665202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOPILL>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOPILL>>(v4);
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

