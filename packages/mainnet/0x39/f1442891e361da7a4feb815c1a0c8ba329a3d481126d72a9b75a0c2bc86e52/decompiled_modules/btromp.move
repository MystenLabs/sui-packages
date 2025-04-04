module 0x39f1442891e361da7a4feb815c1a0c8ba329a3d481126d72a9b75a0c2bc86e52::btromp {
    struct BTROMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTROMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/AhMyrvkpMPzYhv6XvkSa8yvBwkxZfF7aUtmvY8tipump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BTROMP>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BTROMP      ")))), trim_right(b"BOOK OF TROMP                   "), trim_right(b"Book of Tromp ($BTROMP) - reborn through the power of its community. After facing challenges, the true believers sparked a community takeover to steer $BTROMP back to glory, with a bold mission to MAKE MEME COINS GREAT AGAIN! Fueled by resilience, humor, and a passion for decentralized chaos, this isnt just a tokenits "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTROMP>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTROMP>>(v4);
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

