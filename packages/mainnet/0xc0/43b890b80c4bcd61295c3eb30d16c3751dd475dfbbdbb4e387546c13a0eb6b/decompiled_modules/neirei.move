module 0xc043b890b80c4bcd61295c3eb30d16c3751dd475dfbbdbb4e387546c13a0eb6b::neirei {
    struct NEIREI has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<NEIREI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<NEIREI>>(0x2::coin::mint<NEIREI>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: NEIREI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0x1d4fb9bfa1967be6ca74819e28b98c2aa5ae8b59.png?size=lg&key=f6c92b                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<NEIREI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"NEIREI  ")))), trim_right(b"Neirei                          "), trim_right(b"NeiRei is the Chinese twist on Neiro. Team is full of chads, ready to hustle harder than a street vendor selling dumplings at rush hour!                                                                                                                                                                                        "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEIREI>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<NEIREI>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<NEIREI>>(0x2::coin::mint<NEIREI>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

