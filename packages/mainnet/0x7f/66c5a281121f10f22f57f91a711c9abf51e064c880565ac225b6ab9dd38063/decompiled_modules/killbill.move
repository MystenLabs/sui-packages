module 0x7f66c5a281121f10f22f57f91a711c9abf51e064c880565ac225b6ab9dd38063::killbill {
    struct KILLBILL has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<KILLBILL>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<KILLBILL>>(0x2::coin::mint<KILLBILL>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: KILLBILL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/bsc/0x96969ef5f71f0611e41861fd85c41e9192894444.png?size=lg&key=8ad74f                                                                                                                                                                                                                 ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<KILLBILL>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"KILLBILL")))), trim_right(b"Kill Bill                       "), trim_right(b"kill the bill before it kills us.                                                                                                                                                                                                                                                                                               "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KILLBILL>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<KILLBILL>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<KILLBILL>>(0x2::coin::mint<KILLBILL>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

