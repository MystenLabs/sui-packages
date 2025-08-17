module 0x6fe3611c47d317e5564766c4db6ef44189dea10776a5b602af8875faf54e7d2c::actba {
    struct ACTBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ACTBA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/8MxjSs3kEPmfiqKN1S4o3PABp198uYyx4gLF1TvZbonk.png?claimId=30uXZc79U0Mw5tYV                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ACTBA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ACTB        ")))), trim_right(b"ACT B : The Bonk Prophecy       "), trim_right(b"$ACT B is a memecoin born from chaos, forged by community, and driven by prophecy. It represents more than just a token on a blockchainit's a movement, a story, and a living meme narrative unfolding in real time. At its core, $ACT B is built around \"The Bonk Prophecy\", a community-led saga about revival, redemption, an"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ACTBA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ACTBA>>(v4);
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

