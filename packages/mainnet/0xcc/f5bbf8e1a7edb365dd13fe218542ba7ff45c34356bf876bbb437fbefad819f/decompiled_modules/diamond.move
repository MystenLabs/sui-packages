module 0xccf5bbf8e1a7edb365dd13fe218542ba7ff45c34356bf876bbb437fbefad819f::diamond {
    struct DIAMOND has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<DIAMOND>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DIAMOND>>(0x2::coin::mint<DIAMOND>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: DIAMOND, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/TowR6PGvw3uPihCkRCfoQXXB4wz8xcCaqoBAenypump.png?size=lg&key=c9c43c                                                                                                                                                                                                             ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<DIAMOND>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"DIAMOND ")))), trim_right(b"Diamond Hands Guy               "), trim_right(b"Deep in the solana trenches but its okay bc im just a diamond hands guy                                                                                                                                                                                                                                                         "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DIAMOND>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DIAMOND>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<DIAMOND>>(0x2::coin::mint<DIAMOND>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

