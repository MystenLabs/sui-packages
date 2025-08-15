module 0xc146a5fc37c12d646a1ff34fc6f868af894b55dc432bc17d656fa950a317cbdc::hwm {
    struct HWM has drop {
        dummy_field: bool,
    }

    fun init(arg0: HWM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/93Uym8h3HE5XEo48z7PevVxp8sH5zKCfAFpHh4Dqvm8U.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<HWM>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"HWM         ")))), trim_right(b"Here with me                    "), trim_right(b"Here With Me Coin ($HWM) is a community-driven meme coin inspired by D4VDs iconic song Here With Me. Its more than just a tokenits a vibe. Built for music lovers, meme traders, and anyone chasing that late-night nostalgia, $HWM blends emotional connection with crypto culture. With locked liquidity, no dev dumps, and a "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HWM>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HWM>>(v4);
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

