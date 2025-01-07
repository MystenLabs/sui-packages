module 0xcecb8684406a867329579aa90929b25df8a5bc8d7e8e865e31a0ad604500b08a::rizzbiz {
    struct RIZZBIZ has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<RIZZBIZ>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<RIZZBIZ>>(0x2::coin::mint<RIZZBIZ>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: RIZZBIZ, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://cdn.dexscreener.com/cms/images/5dDUKWNKI2Bh5B_B?width=150&height=150&fit=crop&quality=95&format=auto                                                                                                                                                                                                                    ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<RIZZBIZ>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"RIZZBIZ ")))), trim_right(b"RIZZBIZ - Santa's got a New Gig "), trim_right(b"Santas got a new gig and its not just delivering presents. This time, hes taking the banks... but only to spread the crypto cheer! RizzBiz is the meme coin thats all about holiday mischiefbecause who says you cant have a little fun this Christmas?                                                                         "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RIZZBIZ>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<RIZZBIZ>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<RIZZBIZ>>(0x2::coin::mint<RIZZBIZ>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

