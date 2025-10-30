module 0xf95e72116a11f251bcb0ad207abc940f7c2ff3889fa4e7390307d1c0ee1df285::meaty {
    struct MEATY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEATY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"66ca3f11798062526f23b921f484d65f6eb43514e7d8d4a1191c1f6ee0864e40                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MEATY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MEATY       ")))), trim_right(b"Meteoros                        "), trim_right(b"I am a dog who loves to swim in Meteora Pools. Perhaps I will surprise you with a few tricks, too!                                                                                                                                                                                                                              "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEATY>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEATY>>(v4);
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

