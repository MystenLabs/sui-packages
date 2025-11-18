module 0x1ef7ca9a5ebca9574e2ed4bf579ff17f179dc1119bd81e8c97a432d6068d3b3d::nextum {
    struct NEXTUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEXTUM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"6abcd2e3b66c7b317d08dc907318e9e39976f5f07a32c585ee651c488ae14f63                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<NEXTUM>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"NEXTUM      ")))), trim_right(b"NextumSecure                    "), trim_right(b"NextumVPN - Fast and Reliable Protection. Your privacy under reliable protection. Unlimited traffic, high speed, complete anonymity.                                                                                                                                                                                            "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEXTUM>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEXTUM>>(v4);
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

