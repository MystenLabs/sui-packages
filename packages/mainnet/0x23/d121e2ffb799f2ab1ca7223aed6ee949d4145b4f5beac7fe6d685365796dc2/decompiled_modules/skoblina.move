module 0x23d121e2ffb799f2ab1ca7223aed6ee949d4145b4f5beac7fe6d685365796dc2::skoblina {
    struct SKOBLINA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKOBLINA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"9d4e4b19fde843a853902480ce720c8ed1a0a87c0d168ca1264a32bd3e4cd0d8                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SKOBLINA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Skoblin     ")))), trim_right(b"Skoblin                         "), trim_right(b"Whispered by the roots. Carved in shadow. The Skoblin Token is more than currency  its the soul of a people rising. Each token carries the mark of an ancient tribe long hidden beneath the moss and stone. It speaks of unity, survival, and the quiet power of a world untouched by greed.                                    "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKOBLINA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKOBLINA>>(v4);
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

