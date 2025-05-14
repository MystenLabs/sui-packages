module 0x66ebac85ff7a2233b5397aa6ae1adcf9a755a5890c01261a53573801e0c0b320::bam {
    struct BAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/CWY3XDTbN91sSmg4XR3ZgxAVgrhiFv4Ue8gUwwJLbonk.png?claimId=lVrB3IKlQGr-X6Nm                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BAM>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BAM         ")))), trim_right(b"BAM by Scotty                   "), trim_right(b"$BAM is a CTO reclaimed by the community + artist Scotty Russell after the original token launched with stolen art. Instead of letting it die, Scotty and the family rallied, aligning it with his mission to empower artists on Solana. As Head of Artist Development through BONK Art Masters, he backs $BAM as an independent"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAM>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAM>>(v4);
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

