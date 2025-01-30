module 0x99e0977eea5cc9766a470ae52d2d50a102943fdbc8f0b28a8ee8601177223f0a::gpt {
    struct GPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GPT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/67MoqUmhjwzLnPmz4fhTygaBCW9McwD12ssNvVHBpump.png?claimId=OSN0fyk5f0B7BalE                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GPT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"GPT         ")))), trim_right(b"Giant Pair of Tits              "), trim_right(b"$GPT  Giant Pair of Tits, the meme coin that soars above the rest! Powered by AI and fueled by laughs, were here to prove that bigger really is better. Hold tight, because these Tits are taking off!                                                                                                                          "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GPT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GPT>>(v4);
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

