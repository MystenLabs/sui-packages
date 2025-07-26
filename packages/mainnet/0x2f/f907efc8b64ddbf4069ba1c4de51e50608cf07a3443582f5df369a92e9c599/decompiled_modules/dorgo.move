module 0x2ff907efc8b64ddbf4069ba1c4de51e50608cf07a3443582f5df369a92e9c599::dorgo {
    struct DORGO has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<DORGO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DORGO>>(0x2::coin::mint<DORGO>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: DORGO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/base/0x2f0ea0144fbde60514cfdb9f444c02e95f359af8.png?size=lg&key=b53fc9                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<DORGO>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"DORGO   ")))), trim_right(b"Dorgo                           "), trim_right(b"Deep within the ruins of the Roman Colosseum, where gladiators once fought for glory, a mystical doge emerged. This was no ordinary caninethis was DORGO, blessed by the ancient gods of memes and crowned by the spirits of legendary emperors.                                                                                "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DORGO>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DORGO>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<DORGO>>(0x2::coin::mint<DORGO>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

