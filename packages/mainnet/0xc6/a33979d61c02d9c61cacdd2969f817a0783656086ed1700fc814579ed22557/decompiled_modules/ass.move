module 0xc6a33979d61c02d9c61cacdd2969f817a0783656086ed1700fc814579ed22557::ass {
    struct ASS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/C2WZb4PgkzhAB28HgMamEXpGrsWcLHvDEyXSr7aapump.png?claimId=_ISMGtag3t3PoCaY                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ASS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ass         ")))), trim_right(b"another stupid shitcoin         "), trim_right(b"Ass coin  is a cute meme that runs on Solana blockchain. The meme is inspired by its famous meme brother Titi coin and now come in different version to make meme enthusiasts and crypto community united. The nmeme nwas original created by its n developer, however the original ndeveloper rugged it on community by selling"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASS>>(v4);
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

