module 0x13e5c2cb0b81b3abd9378593b99d172c680cf358c06a4c1b7bfcb0226671e893::cpp {
    struct CPP has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<CPP>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CPP>>(0x2::coin::mint<CPP>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: CPP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/CXyquSinxK3s5SPN2TfAE9rF43s3nS6qWsGQp4REK22Z.png?size=lg&key=d5fc18                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CPP>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"CPP     ")))), trim_right(b"Crazy Purple Penguins           "), trim_right(b"In a certain world called Sui, there are angry purple penguins living in the purple pole, and believe me, you don't want to bother them. These penguins are ambitious, smart, and always know how to make a good return, and they are called \"crazy purple penguins\".                                                           "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CPP>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CPP>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<CPP>>(0x2::coin::mint<CPP>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

