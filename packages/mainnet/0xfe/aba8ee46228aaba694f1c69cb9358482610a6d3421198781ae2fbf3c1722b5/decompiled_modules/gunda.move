module 0xfeaba8ee46228aaba694f1c69cb9358482610a6d3421198781ae2fbf3c1722b5::gunda {
    struct GUNDA has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<GUNDA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<GUNDA>>(0x2::coin::mint<GUNDA>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: GUNDA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://cdn.dexscreener.com/cms/images/8f96335399affee4b18d031639ce3812bfe3ffcaa2ee57fa85bf60d86a6922a5?width=128&height=128&fit=crop&quality=95&format=auto                                                                                                                                                                    ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GUNDA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"GUNDA   ")))), trim_right(b"GUNDA                           "), trim_right(b"The guqin-playing panda of Sui. Gunda brings peace and harmony to the wild memecoin world with a long-term, carefully prepared project.                                                                                                                                                                                         "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GUNDA>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GUNDA>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<GUNDA>>(0x2::coin::mint<GUNDA>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

