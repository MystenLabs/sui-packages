module 0x7c0e2e84170627f572d55895b569e070d98e7379d419acdc591a73710d4eca50::bull {
    struct BULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"47ef260565e3ad9e8cb28a8fe157f21b495e756de61ffc95534f11d83057b78f                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BULL>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BULL        ")))), trim_right(b"Bull Run                        "), trim_right(x"596f75206469646e27742062757920656e6f7567682064696420796f753f200a0a596f75206661646564204254432c2045544820616e6420534f4c20616e64206e6f77206861766520464f4d4f2121210a0a5468652042756c6c2052756e206973206865726520616e64206e6f77207468697320697320796f757220736176696f722e0a0a427579202442756c6c20616e6420636f6c6c65637420534f4c2c2045544820616e642042544320696e20726577617264732e0a0a47656e65726f75732072657761726473207061696420666f72206a75737420686f6c64696e67206261736564206f666620566f6c756d652e0a0a4c6574207468652042756c6c2052756e20626567696e2e2e2e2e2e2e2e2e2e2e2e2e20202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULL>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BULL>>(v4);
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

