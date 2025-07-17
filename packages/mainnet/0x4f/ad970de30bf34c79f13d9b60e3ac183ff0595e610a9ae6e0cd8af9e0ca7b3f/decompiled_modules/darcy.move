module 0x4fad970de30bf34c79f13d9b60e3ac183ff0595e610a9ae6e0cd8af9e0ca7b3f::darcy {
    struct DARCY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DARCY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/Ha2niru9scE6XUpdoTyDEFRf8xhbz5rhoFUUTZzdcrDw.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<DARCY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"DARCY       ")))), trim_right(b"Darcy grok companion            "), trim_right(x"4c4153542044617263792047726f6b20436f6d70616e696f6e20454c4f4e4d55534b204f6666696369616c20436f6e6669726d6174696f6e202e0a546869732024444152435920776173206d6164652031206d696e757465206265666f726520746865206f74686572202444415243592e205468697320697320746865206f726967696e616c2066697273742044415243592e204f746865722044415243597320617265206f6e6c792068616c66204c5020616e64206f7572204441524359206973204845415659204c502e200a4d4144452054696d653a0a4a756c792031362c20323032352031393a31303a3034202b5554430a57454253495445204c414e434820534f4f4e205457495454455220434f4d4d554e495459204c4155434820534f4f4e20202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DARCY>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DARCY>>(v4);
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

