module 0x2904f625d3ff3b7556b5801d2eb2cf988cd751eaa2866a16f5f86cd36376faba::ankha {
    struct ANKHA has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<ANKHA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ANKHA>>(0x2::coin::mint<ANKHA>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: ANKHA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/bsc/0x4a956fcb9e1f791190595fcafe2d6bdc32cc4444.png?size=lg&key=36d3f2                                                                                                                                                                                                                 ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ANKHA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ANKHA   ")))), trim_right(b"ANKHA                           "), trim_right(b"This is Ankhas world, a place filled with ancient Egyptian charm and mystery. Here, you will explore ancient civilizations and enjoy the luxurious lifestyle. Are you ready to embrace the challenges of fate?                                                                                                                  "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANKHA>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ANKHA>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<ANKHA>>(0x2::coin::mint<ANKHA>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

