module 0xb37489d6a8918883956de17e9ed64032fc2f76518206853c0017584e4cac113d::bork {
    struct BORK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BORK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/2RW5mtfnhWTZX3yPXzQr2ABxfKwj1f33ZgVk1rSzpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BORK>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BORK        ")))), trim_right(b"Bork                            "), trim_right(b"$BORK (Matt Furie's Dog Token) is a digital asset that brings together the charm and creativity of Matt Furie's iConic drawings with the exciting world of cryptocurrency. As one of the 1,000 Hedz, $BORK represents a blend of art, community, and the innovative spirit of the blockchain. Whether you're an art collector, a"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BORK>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BORK>>(v4);
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

