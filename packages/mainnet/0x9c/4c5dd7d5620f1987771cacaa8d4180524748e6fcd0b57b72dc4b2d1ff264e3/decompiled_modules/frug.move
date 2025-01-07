module 0x9c4c5dd7d5620f1987771cacaa8d4180524748e6fcd0b57b72dc4b2d1ff264e3::frug {
    struct FRUG has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<FRUG>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FRUG>>(0x2::coin::mint<FRUG>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: FRUG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/8htHcawt8xCnSBupCm1kKUS9otEQh3XmXu9tU8qNpump.png?size=lg&key=5801d9                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<FRUG>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"FRUG    ")))), trim_right(b"Origins of Fwog                 "), trim_right(b"Julia Roblin, a Canadian artist with over 1.4 million TikTok followers, is known for her vibrant creativity and frog-inspired artwork. Her designs have sparked cultural influence, including inspiring the successful cryptocurrency $FRUG, blending art and technology in a unique way.                                       "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FRUG>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<FRUG>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<FRUG>>(0x2::coin::mint<FRUG>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

