module 0x27be82a21f29da71240e3ae984c3262aec151e23d912b422d85ffad39c31bee1::solplay {
    struct SOLPLAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOLPLAY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/34E6fraGjoppHhnc9bCCGKr4j7nf1S5CFGn2CTHKpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SOLPLAY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SOLPLAY     ")))), trim_right(b"SolPlay                         "), trim_right(x"536f6c506c6179206973207468652066697273742041492d706f776572656420706c6174666f726d2074686174207472616e73666f726d7320796f75722073637269707420616e6420637573746f6d206d656d652063686172616374657220696e746f2066756c6c7920616e696d6174656420766964656f73207769746820766f6963656f766572737065726665637420666f7220636f6e74656e742063726561746f72732c2063727970746f2070726f6a656374732c20616e64206469676974616c2073746f727974656c6c6572732e200a0a497420616c736f20666561747572657320706f77657266756c20746f6f6c7320666f722067656e65726174696e6720766972616c206d656d65732c20696c6c757374726174696f6e732c20616e64207472656e642d64726976656e206d6564696120696e207365636f6e6473"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOLPLAY>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOLPLAY>>(v4);
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

