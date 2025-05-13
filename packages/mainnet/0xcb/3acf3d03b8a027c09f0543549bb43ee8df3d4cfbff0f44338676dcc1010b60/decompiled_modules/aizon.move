module 0xcb3acf3d03b8a027c09f0543549bb43ee8df3d4cfbff0f44338676dcc1010b60::aizon {
    struct AIZON has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIZON, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/DC5QWcTS4bkQ43ggvgr8QMnsDM6mb49s6HuEtv4Bpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<AIZON>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"AIZON       ")))), trim_right(b"AI Crypto PlayZone              "), trim_right(x"41492043727970746f20506c61795a6f6e65202841495a4f4e290a596f757220616c6c2d696e2d6f6e652063727970746f2065636f73797374656d20207c20506c61792c206561726e2c20616e6420646973636f76657220776974682041492d706f776572656420746f6f6c7320207c204f6e6520746f6b656e2c20656e646c657373206f70706f7274756e6974696573200a2854686973206973206f7572206f6666696369616c20746f6b656e2920202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIZON>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIZON>>(v4);
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

