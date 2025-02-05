module 0x7776b36d26eb19c2db48e3ee2d0d9c45c34b2051ff3b1b8266277e61ec777d0c::theorist {
    struct THEORIST has drop {
        dummy_field: bool,
    }

    fun init(arg0: THEORIST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/DPPuaMMYn2CJF7uepBUc6p76EAaFJoKWcAnooqjPpump.png?claimId=F_FD8hU5BxJMu82c                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<THEORIST>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"THEORIST    ")))), trim_right(b"The Logic Theorist              "), trim_right(b"The Logic Theorist is the first AI computer program written in 1956 by Allen Newell, Herbert A. Simon, and Cliff Shaw. It was the first program deliberately engineered to perform automated reasoning, and has been described as \"the first artificial intelligence program\".                                                  "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THEORIST>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<THEORIST>>(v4);
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

