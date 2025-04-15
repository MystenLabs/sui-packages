module 0x19a2313bc0ce86714d8030b7e685be40cc6224b6b4a4d0cd42e25df26762a8e1::revi {
    struct REVI has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<REVI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<REVI>>(0x2::coin::mint<REVI>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: REVI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/A7V6na55WqcXEX4ExyiJ2E9UHRtAcw3iyXh2FXwPpump.png?size=lg&key=91262a                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<REVI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"REVI    ")))), trim_right(b"Retard Vitalik                  "), trim_right(b"A cheeky nod to Vitaliks brilliance wrapped in meme madness! This tokens for degens who vibe with cryptos wild side. Join the retard family and let's make history together!                                                                                                                                                    "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REVI>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<REVI>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<REVI>>(0x2::coin::mint<REVI>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

