module 0x7d80aacc6d1e347830189a895ed406b33512e296982212147e7a885c4d180067::optyca {
    struct OPTYCA has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<OPTYCA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<OPTYCA>>(0x2::coin::mint<OPTYCA>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: OPTYCA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/MTrDTs2rKiV7gT83q3HUWPjoEmkU2F8nJntxtZkCTfN.png?size=lg&key=3774fa                                                                                                                                                                                                             ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<OPTYCA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"OPTYCA  ")))), trim_right(b"OPTYCA AI                       "), trim_right(b"Breaking the Boundaries of Creativity At Optyca, we are paving the way for a new era of creativity by turning text into breathtaking images. Our goal is to empower creators worldwide with advanced AI tools, enabling them to explore endless possibilities in modern design.                                                 "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OPTYCA>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<OPTYCA>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<OPTYCA>>(0x2::coin::mint<OPTYCA>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

