module 0xe69f12ddcfa71f18e5c991013692889994c3e052899eb789554664d85eb3de5d::voiceai {
    struct VOICEAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: VOICEAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/3PeRqZY6KcaCTTZrjfmQufkTjPvXZ2LDenrfXTSadQUo.png?size=lg&key=d62f46                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<VOICEAI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"VOICEAI ")))), trim_right(b"VoiceAI                         "), trim_right(b"VoiceAI is revolutionizing the way the world interacts with audio, combining cutting-edge AI-powered speech-to-text technology with blockchain innovation. Our mission is to deliver seamless, multilingual transcription solutions that empower individuals and businesses globally.                                           "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VOICEAI>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VOICEAI>>(v4);
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

