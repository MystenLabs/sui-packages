module 0x76cd5624bd81e950d3365a37a010fdb4a09c92c6ece5ef80ed0775d506b4853b::hoodgold {
    struct HOODGOLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOODGOLD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/AkfgYS26wK9xBmh9gtAGZ2umtVecJYa4co5NayqWpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<HOODGOLD>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"HoodGold    ")))), trim_right(b"Robinhood Gold                  "), trim_right(b"This project is more than a cryptocurrency; it's a movement. Inspired by Robin Hood and the resilience of everyday people, our mission is to empower a decentralised future where everyone has a shot at financial independence irrespective of their livelihood or influence. It's not just about the token - it's about sendin"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOODGOLD>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOODGOLD>>(v4);
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

