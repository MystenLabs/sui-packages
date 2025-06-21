module 0x7cd0094ec027c76cb0fdd6b19c2090a617d90b5dea6b4b609ee2637e75ad953b::gemai {
    struct GEMAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GEMAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/GXdehwcW58uLEaSqc5V2AKDoDjSkTa2FzaUwZGEeEgem.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GEMAI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"GEMAI       ")))), trim_right(b"GemDetector.ai                  "), trim_right(b"GemDetectorAI uses advanced multi-agent AI to scan the Solana blockchain for hidden token gems before they gain traction. $GEMAI powers the entire ecosystem, unlocking premium access to advanced research, real-time trading analytics, sentiment analysis, and early alpha insights into high-potential tokens. Join the AI-p"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GEMAI>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GEMAI>>(v4);
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

