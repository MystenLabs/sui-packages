module 0xab2e9d932b9802530a353489c7f10fd820868d1c761fe28a3a93380600bb1db1::cblai {
    struct CBLAI has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<CBLAI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CBLAI>>(0x2::coin::mint<CBLAI>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: CBLAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/8AiofvntQrqVpk7rg9d5kTkfREUKM7aqRJcoUG6qbUKy.png?size=lg&key=7c7292                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CBLAI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"CBLAI   ")))), trim_right(b"CABAL AI                        "), trim_right(b"NO description necessary. This it degens dream world that we all live in. Come join us and live the underworld billionaires fantasy life. WEN LAMBO!                                                                                                                                                                            "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CBLAI>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CBLAI>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<CBLAI>>(0x2::coin::mint<CBLAI>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

