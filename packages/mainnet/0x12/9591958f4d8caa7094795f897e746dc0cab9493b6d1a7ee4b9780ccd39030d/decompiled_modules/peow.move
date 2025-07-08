module 0x129591958f4d8caa7094795f897e746dc0cab9493b6d1a7ee4b9780ccd39030d::peow {
    struct PEOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEOW, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/2rCgWcsr6VL8NhjR8AGu3Tz42rTA1tKLA6KpiYJGbonk.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PEOW>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PEOW        ")))), trim_right(b"Peow                            "), trim_right(b"Peow is a grey cat with a chill and savage vibe. He always looks unimpressed, as if he knows all the secrets of the universe but just doesnt care. Peows signature style combines sarcastic humor, calm confidence, and a free spirit that never takes life too seriously. Whether he's staring blankly at your problems or casu"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEOW>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEOW>>(v4);
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

