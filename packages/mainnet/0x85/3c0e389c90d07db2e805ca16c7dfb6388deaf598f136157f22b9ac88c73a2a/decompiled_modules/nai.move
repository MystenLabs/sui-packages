module 0x853c0e389c90d07db2e805ca16c7dfb6388deaf598f136157f22b9ac88c73a2a::nai {
    struct NAI has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<NAI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<NAI>>(0x2::coin::mint<NAI>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: NAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/iWnxxuruSV4DnFpk3iDNsCGuDMYBafpi4CQjg92pump.png?size=lg&key=6a929b                                                                                                                                                                                                             ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<NAI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"NAI     ")))), trim_right(b"NeonAI                          "), trim_right(b"NeonAI (NAI) Purple light and artificial intelligence, a dynamic duo stepping into the digital future! This combination not only represents an alluring glow but also embodies smart solutions and innovative ideas pushing the boundaries of technology and science.                                                           "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NAI>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<NAI>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<NAI>>(0x2::coin::mint<NAI>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

