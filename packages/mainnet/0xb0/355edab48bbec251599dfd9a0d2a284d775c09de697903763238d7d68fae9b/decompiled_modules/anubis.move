module 0xb0355edab48bbec251599dfd9a0d2a284d775c09de697903763238d7d68fae9b::anubis {
    struct ANUBIS has drop {
        dummy_field: bool,
    }

    public fun deposit(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<ANUBIS>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<ANUBIS>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: ANUBIS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/HAo43caXejw6VPFaR4hRKeecbN6b6WeyCQkEoz6DokLD.png?size=lg&key=1d206c                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4, v5) = 0x2::coin::create_regulated_currency_v2<ANUBIS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ANUBIS  ")))), trim_right(b"Anubis                          "), trim_right(b"At the top of the pyramid stands a proud, fierce black dogthe very embodiment of the ancient Egyptian god Anubis. Unlike those market-friendly, cute little dogs or that goofy green frog Pepe, he doesn't wag his tail or croak for attention.                                                                                 "), v2, false, arg1);
        let v6 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANUBIS>>(v5);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ANUBIS>>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<ANUBIS>>(0x2::coin::mint<ANUBIS>(&mut v6, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<ANUBIS>>(v4, 0x2::tx_context::sender(arg1));
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

