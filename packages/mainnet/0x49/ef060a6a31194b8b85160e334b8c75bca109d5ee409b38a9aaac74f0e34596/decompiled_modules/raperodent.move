module 0x49ef060a6a31194b8b85160e334b8c75bca109d5ee409b38a9aaac74f0e34596::raperodent {
    struct RAPERODENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAPERODENT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/FqrGu7Askk6UcGMvFBB4rPEFSp3X4SrahrbxUFNDbonk.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<RAPERODENT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"RAPERODENT  ")))), trim_right(b"Origin of Troll Face            "), trim_right(b"ape Rodent (often stylized as raperodent in some discussions) is considered the original troll meme and predecessor to the iconic Trollface. It was created in 2008 by artist Carlos Ramirez (known online as Whynne) as an early attempt to capture a mischievous, trolling expression, inspired by the 1930s cartoon character"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAPERODENT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAPERODENT>>(v4);
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

