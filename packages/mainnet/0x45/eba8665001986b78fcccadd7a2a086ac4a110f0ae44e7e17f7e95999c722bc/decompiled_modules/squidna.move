module 0x45eba8665001986b78fcccadd7a2a086ac4a110f0ae44e7e17f7e95999c722bc::squidna {
    struct SQUIDNA has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SQUIDNA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SQUIDNA>>(0x2::coin::mint<SQUIDNA>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SQUIDNA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/GTB8dXm84XqS1A5UoMovZqKifyovXsJdR73s4oFMFFfC.png?size=lg&key=877060                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SQUIDNA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SQUIDNA ")))), trim_right(b"SQUIDGAME DNA                   "), trim_right(b"Just like the participants in Squid Game, players in the $SQUIDNA universe must navigate challenges, but with a twist  the stakes are tied to genetic evolution and decentralized finance.                                                                                                                                      "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SQUIDNA>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SQUIDNA>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<SQUIDNA>>(0x2::coin::mint<SQUIDNA>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

