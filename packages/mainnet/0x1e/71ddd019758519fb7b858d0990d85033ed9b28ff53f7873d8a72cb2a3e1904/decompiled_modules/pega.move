module 0x1e71ddd019758519fb7b858d0990d85033ed9b28ff53f7873d8a72cb2a3e1904::pega {
    struct PEGA has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<PEGA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PEGA>>(0x2::coin::mint<PEGA>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: PEGA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0x658d49ee75eaad697ed6d6dd063c9a364165b419.png?size=lg&key=f0b1b7                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PEGA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PEGA    ")))), trim_right(b"PEGA                            "), trim_right(b"PEGA, a comic created by Matt Suric that follows the adventures of his character, along with his friends Landwolf and Andy. PEGA captures the essence of Matt Suric creative vision and showcases the lovable charm of the PEGA and his pals in a series of delightful and entertaining vignettes.                              "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEGA>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PEGA>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<PEGA>>(0x2::coin::mint<PEGA>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

