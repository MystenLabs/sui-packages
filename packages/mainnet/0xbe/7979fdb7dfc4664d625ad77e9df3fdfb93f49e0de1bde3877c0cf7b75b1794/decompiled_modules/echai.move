module 0xbe7979fdb7dfc4664d625ad77e9df3fdfb93f49e0de1bde3877c0cf7b75b1794::echai {
    struct ECHAI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<ECHAI>, arg1: 0x2::coin::Coin<ECHAI>) {
        0x2::coin::burn<ECHAI>(arg0, arg1);
    }

    fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<ECHAI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ECHAI>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: ECHAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/8nQBuF666JEuSGR6FLitmXDCvH2QJrnvwvVrK6oepump.png?size=lg&key=27d4c7                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ECHAI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ECHAI     ")))), trim_right(b"Echelon AI                      "), trim_right(x"456368656c6f6e204149207c2054686520496e74656c6c6967656e7420457965206f662043727970746f2020414920666f7220536f6c616e61206d656d65636f696e733a20696e7369676874732c2074726164696e672c20616e6420656e676167656d656e742e20506f7765726564206279200a40616931367a64616f0a20456c697a612e20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        let v5 = v3;
        let v6 = &mut v5;
        let v7 = 0x2::tx_context::sender(arg1);
        mint_and_transfer(v6, 1000000000000000000, v7, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ECHAI>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ECHAI>>(v5);
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

