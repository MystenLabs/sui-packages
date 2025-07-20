module 0x8f20c247bf045db66a591f5309ac614883f7acfef42abc5878539d42eea480a5::coqn {
    struct COQN has drop {
        dummy_field: bool,
    }

    fun init(arg0: COQN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/Eax4THRMgNzZ7BNw627y14idhLTz2CJHBBFd266NNLic.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<COQN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"COQN        ")))), trim_right(b"Coq'n Balz                      "), trim_right(b"The nostalgic meme coin. Pay tribute to every illicit doodle, daydream escape from Mrs. Crabtree's 7th-grade math class, and all the \"artwork\" scribbled on bathroom stalls. We've mixed that deviant joy with '80s cartoons, retro games, and the questionable safety of '90s toys. This blast from the past is now wrapped in "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COQN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COQN>>(v4);
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

