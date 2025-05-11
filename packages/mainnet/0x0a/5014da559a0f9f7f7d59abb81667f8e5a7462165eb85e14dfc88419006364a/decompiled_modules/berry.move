module 0xa5014da559a0f9f7f7d59abb81667f8e5a7462165eb85e14dfc88419006364a::berry {
    struct BERRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BERRY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/5XUEeFuEKsgd27HrQTqkEe157Wb366c9ApgE3YAypump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BERRY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BERRY       ")))), trim_right(b"Strawberry In Bloom             "), trim_right(b"  iconic frog, Pepe, took the internet by storm - originally a quirky male character that quickly went viral through countless hilarious memes. Years later, it inspired the creation of the $PEPE memecoin, which exploded in 2023, reaching a $10 billion market cap.                                                         "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BERRY>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BERRY>>(v4);
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

