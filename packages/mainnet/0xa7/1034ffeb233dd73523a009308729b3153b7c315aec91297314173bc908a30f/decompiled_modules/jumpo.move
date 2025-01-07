module 0xa71034ffeb233dd73523a009308729b3153b7c315aec91297314173bc908a30f::jumpo {
    struct JUMPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUMPO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/3EDU1zVQ2LswGeKpqjVQCLVfd4CJgiTFTRw2hHnpKRF5.png?size=lg&key=05287d                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<JUMPO>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"jumpo   ")))), trim_right(b"Jumpo                           "), trim_right(b"Are you ready for Jumpo's decisive jump? This cat is not just a meme, he is the force behind the new ATH and $10M MC! Jumpo rushes to the top of cryptocurrencies with the grace of a predator and the soul of a conqueror. It's not just a cat, it's a bold symbol of freedom that is ready to jump all boundaries.            "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUMPO>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JUMPO>>(v4);
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

