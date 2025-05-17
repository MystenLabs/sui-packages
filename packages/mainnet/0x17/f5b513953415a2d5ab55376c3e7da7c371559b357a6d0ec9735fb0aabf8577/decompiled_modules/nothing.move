module 0x17f5b513953415a2d5ab55376c3e7da7c371559b357a6d0ec9735fb0aabf8577::nothing {
    struct NOTHING has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOTHING, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/EaWraQPAR3FAJH93aVGS5yoTt9uVbH9Xekt6q38Npump.png?claimId=Pnc4fuCmdd0lNqgi                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<NOTHING>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"NOTHING     ")))), trim_right(b"Nothing Coin                    "), trim_right(x"4e4f5448494e470a0a5768656e204e6f7468696e6720697320776f727468206d6f7265207468616e2024312074686520555320646f6c6c6172206265636f6d657320776f727468206c657373207468616e204e6f7468696e672e0a0a49732069742061206a6f6b653f204d61796265206974732061206d6573736167652e0a0a497320697420646565703f204973206974207361746972653f0a0a4f72206973206974206a757374204e6f7468696e672e0a0a42656c6965766520696e204e6f7468696e672e2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOTHING>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOTHING>>(v4);
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

