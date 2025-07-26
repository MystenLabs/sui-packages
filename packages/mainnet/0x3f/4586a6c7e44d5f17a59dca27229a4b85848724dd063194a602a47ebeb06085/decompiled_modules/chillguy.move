module 0x3f4586a6c7e44d5f17a59dca27229a4b85848724dd063194a602a47ebeb06085::chillguy {
    struct CHILLGUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLGUY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/cyMRy2qBFbv6r6epi5TFiWuwANP46bH56iY42zdbonk.png                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CHILLGUY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ChillGuy    ")))), trim_right(b"Just a Chill Guy                "), trim_right(b"I know Im supposed to be a chill guy and low-key not really care about anything but Im tired of trying to be someone that Im not I want you to think of something right now that makes you happy that thing you see the thing that lights you up, Chase that all of your soul chase that because its easy to brush off lifes pot"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLGUY>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHILLGUY>>(v4);
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

