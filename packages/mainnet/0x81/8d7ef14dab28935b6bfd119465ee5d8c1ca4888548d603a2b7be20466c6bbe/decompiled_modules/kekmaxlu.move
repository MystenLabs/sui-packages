module 0x818d7ef14dab28935b6bfd119465ee5d8c1ca4888548d603a2b7be20466c6bbe::kekmaxlu {
    struct KEKMAXLU has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<KEKMAXLU>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<KEKMAXLU>>(0x2::coin::mint<KEKMAXLU>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: KEKMAXLU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://cdn.dexscreener.com/cms/images/T5RTlkbBAyDt1whM?width=150&height=150&fit=crop&quality=95&format=auto                                                                                                                                                                                                                    ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<KEKMAXLU>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"KEKMAXLU")))), trim_right(b"Kekius Maximus: Leveling Up     "), trim_right(b"Inspired by Elon Musk's tweet on X.com, posted on December 31, 2024, \"Kekius Maximus will soon reach level 80 in hardcore PoE,\" this crypto token on the Solana blockchain, featuring artwork by SurR.Ai and minted as an NFT on the Ethereum blockchain, celebrates perseverance and strategic triumph.                        "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KEKMAXLU>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<KEKMAXLU>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<KEKMAXLU>>(0x2::coin::mint<KEKMAXLU>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

