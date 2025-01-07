module 0x5942e57a39f8b66dd7f5a4c8c1be0058b7f70d44e92dcf8a277922bcf8a32f6::suilambo {
    struct SUILAMBO has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUILAMBO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUILAMBO>>(0x2::coin::mint<SUILAMBO>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SUILAMBO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/FhAdp55ngkaRCC3TGAMsJdDCUHQDPTMcxQDJ4HCfnxMf.png?size=lg&key=429a99                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SUILAMBO>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SUILAMBO")))), trim_right(b"Sui-Lambo                       "), trim_right(b"Are you ready to soar high with an incredible crypto adventure? Sui-Lambo is a meme token inspired by the famous Pixar animated film Up. With Sui-Lambo, you won't just join a captivating crypto journey, but also get the chance to embrace the spirit of adventure and happiness.                                            "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUILAMBO>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUILAMBO>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUILAMBO>>(0x2::coin::mint<SUILAMBO>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

