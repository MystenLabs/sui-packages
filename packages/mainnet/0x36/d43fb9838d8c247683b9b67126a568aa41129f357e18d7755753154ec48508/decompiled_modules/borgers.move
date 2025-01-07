module 0x36d43fb9838d8c247683b9b67126a568aa41129f357e18d7755753154ec48508::borgers {
    struct BORGERS has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<BORGERS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BORGERS>>(0x2::coin::mint<BORGERS>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: BORGERS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/5tqxHk9gaHgFmUqMrZ9EYghBiBmqtn7hDeRJQ8QSgiNA.png?size=lg&key=8324a6                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BORGERS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BORGERS ")))), trim_right(b"Bob's Burgers                   "), trim_right(b"Straight out of our favorite animated burger joint, Bob Belcher taught us one thing: a good burger isnt just food  its an experience. Inspired by the charm, wit, and endless hustle of Bobs Burgers, were here to channel that same energy into every bite.                                                                    "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BORGERS>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BORGERS>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<BORGERS>>(0x2::coin::mint<BORGERS>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

