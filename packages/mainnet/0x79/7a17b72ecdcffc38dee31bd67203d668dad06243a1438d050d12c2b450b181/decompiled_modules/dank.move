module 0x797a17b72ecdcffc38dee31bd67203d668dad06243a1438d050d12c2b450b181::dank {
    struct DANK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DANK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/GPwwihLa1w9Qsz27SmNrj7aLVnE7pr2cAvHe6aVVpump.png?claimId=rt-AD74MXjvPmPcC                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<DANK>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"DANK        ")))), trim_right(b"Dank Memes                      "), trim_right(b"The $dank meme era was the first online internet era where humans began willingly creating and making memes, crossing lines and mixing ideas from new online communities that had formed during the #y2k era and real life experiences this era birthed the gem of the $mlg culture, dank memes were once called shit posts and "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DANK>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DANK>>(v4);
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

