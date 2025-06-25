module 0xe3c1279ca2ac3c20f4a52c0afa5a61ce3368548a4a19f2464f40e98cbad10d7a::drive {
    struct DRIVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRIVE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/CQ1dYW7YF38kmPyUX1zYZCYUpJ8UcjqzR4kVYm3Qsd1W.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<DRIVE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Drive       ")))), trim_right(b"Trench Racer                    "), trim_right(b"Trench Racer is an adrenaline-fueled Web3 arcade racing game where precision and risk-taking are the keys to victory. Navigate high-speed traffic, weaving through lanes to rack up points for daring close calls. The closer you get without crashing, the bigger the reward. With blockchain integration, players can earn tok"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRIVE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRIVE>>(v4);
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

