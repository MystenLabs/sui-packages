module 0xbab1900fa275fdcd028d8345b8d7bef3c427a4947d82c3f971bd4f34c4f6ee75::ayla {
    struct AYLA has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<AYLA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<AYLA>>(0x2::coin::mint<AYLA>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: AYLA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/base/0x0bfc8d7dca71586f4c4e23643268f26de46915f6.png?size=lg&key=5a4e55                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<AYLA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"AYLA    ")))), trim_right(b"DogWithFlower                   "), trim_right(b"Ayla, finally tokenized by someone who truly knows her story.                                                                                                                                                                                                                                                                   "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AYLA>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<AYLA>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<AYLA>>(0x2::coin::mint<AYLA>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

