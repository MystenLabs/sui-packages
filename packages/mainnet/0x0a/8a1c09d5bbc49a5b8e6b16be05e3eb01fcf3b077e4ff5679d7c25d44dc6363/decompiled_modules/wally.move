module 0xa8a1c09d5bbc49a5b8e6b16be05e3eb01fcf3b077e4ff5679d7c25d44dc6363::wally {
    struct WALLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALLY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/CsPXJHDfRCXzktAosR2mpVZUuPpowAsyLaR4w7aaKGag.png?size=lg&key=030cc6                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<WALLY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"WALLY   ")))), trim_right(b"Emotional Support Alligator     "), trim_right(b"Wally, the famous Emotional Support Alligator, first captured headlines when he was rescued from an alligator-infested pond at Disney World                                                                                                                                                                                     "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WALLY>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WALLY>>(v4);
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

