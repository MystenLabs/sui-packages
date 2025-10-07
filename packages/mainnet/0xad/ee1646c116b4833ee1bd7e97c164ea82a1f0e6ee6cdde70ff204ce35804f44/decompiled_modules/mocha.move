module 0xadee1646c116b4833ee1bd7e97c164ea82a1f0e6ee6cdde70ff204ce35804f44::mocha {
    struct MOCHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOCHA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"4f81b2a0f00c2427135b3f70ef7291e031c301a7a6ae93d169baae2b5bcb3b65                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MOCHA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MOCHA       ")))), trim_right(b"MOCHA                           "), trim_right(b"$MOCHA is a little brew of joy  lighthearted, playful, and made to be shared. Its about laughing together, passing around good vibes, and keeping things warm even in the busiest days. Think of it as a cozy table where friends gather, stories flow, and fun keeps pouring.                                                  "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOCHA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOCHA>>(v4);
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

