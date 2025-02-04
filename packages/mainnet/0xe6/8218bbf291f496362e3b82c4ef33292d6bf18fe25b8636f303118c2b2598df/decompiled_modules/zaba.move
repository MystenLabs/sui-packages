module 0xe68218bbf291f496362e3b82c4ef33292d6bf18fe25b8636f303118c2b2598df::zaba {
    struct ZABA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZABA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/fMvxACX7pssw93vxEtvg1dyJWsDiPFgVjTmuCZEpump.png                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ZABA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ZABA        ")))), trim_right(b"ZABA                            "), trim_right(b"Meet ba, the latest and greatest crypto meme token hopping into the spotlight! This isnt your average frogba is the future of decentralized fun, blending the charm of original, hand-crafted artwork with the cutting-edge power of AI and NFT technology. Whether youre a meme lover, NFT collector, or a blockchain enthusias"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZABA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZABA>>(v4);
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

