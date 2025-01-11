module 0xa8f905b281a3fb0d0a519b23974af12a77259b36e5c08be52336aa05ac47ef47::sdoctor {
    struct SDOCTOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDOCTOR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/5vb8AXytbQenTds4xKinp1FEoWAK7xoiNZw6hCh4pump.png?size=lg&key=93e3dc                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SDOCTOR>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SDOCTOR ")))), trim_right(b"SUI Doctor AI                   "), trim_right(b"$DOCTOR AI is an advanced AI-powered medical diagnostic system specializing in the analysis of medical imaging, including X-rays, MRI, CT scans, and ultrasounds                                                                                                                                                                "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDOCTOR>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDOCTOR>>(v4);
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

