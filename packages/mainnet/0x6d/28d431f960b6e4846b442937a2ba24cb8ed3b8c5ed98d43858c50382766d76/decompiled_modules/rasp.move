module 0x6d28d431f960b6e4846b442937a2ba24cb8ed3b8c5ed98d43858c50382766d76::rasp {
    struct RASP has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<RASP>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<RASP>>(0x2::coin::mint<RASP>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: RASP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://cdn.dexscreener.com/cms/images/EXy9iruZk0Y0bFe_?width=150&height=150&fit=crop&quality=95&format=auto                                                                                                                                                                                                                    ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<RASP>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Rasp    ")))), trim_right(b"Raspberry                       "), trim_right(b"he cutest meme coin of all time. Based off the Mini Groodle pet of the same name, shes adorable cute and going to the Moon! Watch her journey and her growing. A lot of fun, and a way to be connected to the Mini Golden Doodle Raspberry                                                                                      "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RASP>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<RASP>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<RASP>>(0x2::coin::mint<RASP>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

