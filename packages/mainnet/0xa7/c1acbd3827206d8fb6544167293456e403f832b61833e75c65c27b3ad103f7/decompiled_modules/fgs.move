module 0xa7c1acbd3827206d8fb6544167293456e403f832b61833e75c65c27b3ad103f7::fgs {
    struct FGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FGS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/8JEYBUvCeksf1ehRW2qsD6T9RZo3aGxN5yhnswEfpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<FGS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"FGS         ")))), trim_right(b"farting goat smoke              "), trim_right(b"My daughter and I found this token and got rugged by dev so now we CTO                                                                                                                                                                                                                                                          "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FGS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FGS>>(v4);
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

