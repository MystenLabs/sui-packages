module 0x5d6b0c6f79950d007ac12e1c4083abed132298607326e5d115a294a64f6fd0a::wurk {
    struct WURK has drop {
        dummy_field: bool,
    }

    fun init(arg0: WURK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"e78b6f28f0b17d98b33e89d0f9e89116c96aef1ddb35a840850105cd29b634c4                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<WURK>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"WURK        ")))), trim_right(b"WURK                            "), trim_right(b"WURK.FUN is a crypto-native microtask platform on Solana where projects can easily create promotion jobs (starting with reposts on X/Twitter). Users complete simple tasks, verify them on chain, and get instant rewards. A vault model distributes part of the platform revenue back to token holders and referrers, making th"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WURK>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WURK>>(v4);
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

