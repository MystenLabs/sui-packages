module 0xd43246b4764c41eb95cc4dc7bbc8172136505b2cdefc4b1311a432d08f499ed4::optimus {
    struct OPTIMUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: OPTIMUS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/BSDgWLrq4APK14xU2GN66qtDJhwB1ayyNsXLpHqbbonk.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<OPTIMUS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"OPTIMUS     ")))), trim_right(b"Optimus Grok Companion          "), trim_right(b"OPTIMUS is Tesla's humanoid robot designed to perform general-purpose tasks. Built with advanced AI and robotics technology, OPTIMUS aims to assist humans in various activities, from household chores to industrial applications. This revolutionary robot represents the future of human-robot collaboration and automation. "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OPTIMUS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OPTIMUS>>(v4);
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

