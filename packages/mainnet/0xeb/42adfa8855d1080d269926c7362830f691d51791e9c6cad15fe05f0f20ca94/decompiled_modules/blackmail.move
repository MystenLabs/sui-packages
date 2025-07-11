module 0xeb42adfa8855d1080d269926c7362830f691d51791e9c6cad15fe05f0f20ca94::blackmail {
    struct BLACKMAIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLACKMAIL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/Eb8ys3gjfDTGik4sxAhJMzZ8nGcGcq8LHY1i4JEZUodw.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BLACKMAIL>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Blackmail   ")))), trim_right(b"Epstein Files                   "), trim_right(x"546865792073616964207468652066696c6573207765726520676f6e652e0a0a5765207361793a20457665727920706f73742069732070726573737572652e2e0a0a282121203425205461783a202121290a20383825206675656c73206275792026206275726e20200a20383825206f66207768617473206c6566742067657473207061696420746f20686f6c6465727320696e20534f4c206576657279203620285349582920686f7572730a0a4e6f20696e7369646572732e204e6f206f66662d7377697463682e0a0a57657265206865726520666f722070726f6f662e0a416e6420776520776f6e742073746f702e0a4576657279206d656e74696f6e2c206576657279207472656e642c2065766572792077686973706572206f662024424c41434b4d41494c206b6565707320746865207072657373757265206f6e20"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLACKMAIL>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLACKMAIL>>(v4);
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

