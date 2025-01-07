module 0xbee04e476e07026a757dcbd27cdef145af6d941ec2607a043be5fd2b6991b838::suipy {
    struct SUIPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/GXJmxv2PmjxdknyVBc43gqgMrtc86TRfHDFkWriupump.png?size=lg&key=1dac79                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SUIPY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SUIPY   ")))), trim_right(b"SuipyMas                        "), trim_right(b"This isnt just my cozy cornerits our spot. Come hang out, bring your chill holiday spirit, and lets keep things easy and warm. Whether youre here for the vibes, the quiet moments, or just to see what Im up to next, youre officially part of the SnoopyMas crew now.                                                         "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPY>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPY>>(v4);
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

