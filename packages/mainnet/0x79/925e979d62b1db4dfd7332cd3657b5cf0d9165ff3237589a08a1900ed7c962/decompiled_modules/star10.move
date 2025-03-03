module 0x79925e979d62b1db4dfd7332cd3657b5cf0d9165ff3237589a08a1900ed7c962::star10 {
    struct STAR10 has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<STAR10>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<STAR10>>(0x2::coin::mint<STAR10>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: STAR10, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/bsc/0x8b9abdd229ec0c4a28e01b91aacdc5daafc25c2b.png?size=lg&key=d0f34f                                                                                                                                                                                                                 ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<STAR10>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"STAR10  ")))), trim_right(b"Ronaldinho Coin                 "), trim_right(b"Own a piece of Ronaldinhos legacy. Be a part of the $STAR10 movementwhere holders play, win, and unlock exclusive rewards.                                                                                                                                                                                                      "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STAR10>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<STAR10>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<STAR10>>(0x2::coin::mint<STAR10>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

