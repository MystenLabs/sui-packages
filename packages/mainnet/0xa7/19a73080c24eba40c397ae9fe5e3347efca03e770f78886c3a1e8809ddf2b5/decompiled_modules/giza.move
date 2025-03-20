module 0xa719a73080c24eba40c397ae9fe5e3347efca03e770f78886c3a1e8809ddf2b5::giza {
    struct GIZA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIZA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/FmFnRZWRLnZMcRDQGDCoHSdgLUFMZ7bAtD2qk75Vpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GIZA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Giza        ")))), trim_right(b"Pyramids                        "), trim_right(b"The Greatest Archeological Find in HISTORY was Just Discovered! Using Powerful Ground-Penetrating Radar, Scientists Have Mapped a Structure More Than Twice the Height of the Tallest Building on Earth Under the Khafre Pyramid in the Giza Complex. Speculation is that they are going to be used for nuclear warfare using th"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIZA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GIZA>>(v4);
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

