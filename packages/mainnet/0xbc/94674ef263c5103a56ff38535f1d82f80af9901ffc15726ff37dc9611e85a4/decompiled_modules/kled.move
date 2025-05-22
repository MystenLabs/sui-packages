module 0xbc94674ef263c5103a56ff38535f1d82f80af9901ffc15726ff37dc9611e85a4::kled {
    struct KLED has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<KLED>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<KLED>>(0x2::coin::mint<KLED>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: KLED, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/1zJX5gRnjLgmTpq5sVwkq69mNDQkCemqoasyjaPW6jm.png?size=lg&key=8604a7                                                                                                                                                                                                             ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<KLED>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"KLED    ")))), trim_right(b"KLEDAI                          "), trim_right(b"AI companies are spending billions of dollars on data (video, text, sound, etc) to train their models.  Kled is the middleman. We partner with top film studios and production houses, label their video content, and sell it to AI companies like OpenAI to help train models like ChatGPT, Sora,  Midjourney and more.        "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KLED>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<KLED>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<KLED>>(0x2::coin::mint<KLED>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

