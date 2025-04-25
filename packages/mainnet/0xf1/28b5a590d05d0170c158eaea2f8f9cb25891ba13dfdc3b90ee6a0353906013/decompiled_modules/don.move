module 0xf128b5a590d05d0170c158eaea2f8f9cb25891ba13dfdc3b90ee6a0353906013::don {
    struct DON has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<DON>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DON>>(0x2::coin::mint<DON>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: DON, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/bsc/0x42fe1937e1db4f11509e9f7fdd97048bd8d04444.png?size=lg&key=bad331                                                                                                                                                                                                                 ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<DON>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"DON     ")))), trim_right(b"Salamanca                       "), trim_right(b"Inspired by the Salamanca cartel from Breaking Bad, this token isnt just for laughs  its here to dominate the meme coin space on Sui.                                                                                                                                                                                           "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DON>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DON>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<DON>>(0x2::coin::mint<DON>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

