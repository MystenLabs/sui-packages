module 0x60e4b45f05bcdca0ab9d693d32428eeb517cbaecef77a5d21effe98c60a3e56e::grodt {
    struct GRODT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRODT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"e7e3db09ac9c121cdbb3ecdc7c84746b81cbd231395d6440d989b78a2464297e                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GRODT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"GRODT       ")))), trim_right(b"Get Rich or Die Tryin           "), trim_right(b"GRODT is a Solana community-driven meme token built on hustle, unity, and ambition. No kings, no queens  everyone is equal here. We grind together, win together, and rise together. 100% LP locked. Built by the Hustle. Fueled by the Community.                                                                              "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRODT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRODT>>(v4);
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

