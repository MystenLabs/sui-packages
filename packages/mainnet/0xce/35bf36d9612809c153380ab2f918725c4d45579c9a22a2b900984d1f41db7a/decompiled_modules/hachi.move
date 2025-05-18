module 0xce35bf36d9612809c153380ab2f918725c4d45579c9a22a2b900984d1f41db7a::hachi {
    struct HACHI has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<HACHI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<HACHI>>(0x2::coin::mint<HACHI>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: HACHI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0x78b9065d325aaecd8df4735dcc69f371162f94c7.png?size=lg&key=12f5a5                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<HACHI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Hachi   ")))), trim_right(b"Hachiko                         "), trim_right(b"Hachiko was an Akita dog known for his incredible loyalty. After his owner, Professor Ueno, passed away in 1925, Hachiko continued waiting for him at Shibuya Station every day for nearly 10 years until his own death in 1935.                                                                                                "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HACHI>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<HACHI>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<HACHI>>(0x2::coin::mint<HACHI>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

