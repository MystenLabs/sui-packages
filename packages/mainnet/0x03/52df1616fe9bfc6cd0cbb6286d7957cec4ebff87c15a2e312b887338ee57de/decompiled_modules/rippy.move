module 0x352df1616fe9bfc6cd0cbb6286d7957cec4ebff87c15a2e312b887338ee57de::rippy {
    struct RIPPY has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<RIPPY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<RIPPY>>(0x2::coin::mint<RIPPY>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: RIPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/8nbrvdhc5NGzXWVaEa6Gv1tN3q368oKv4pecaWcxpump.png?size=lg&key=f6f1bb                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<RIPPY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"RIPPY   ")))), trim_right(b"Rippy Raccoon                   "), trim_right(x"58525020676f696e2077696c6420357820696e20746865206c617374206d6f6e7468212057686f73206d616b696e2069742068617070656e3f204e6f6e65206f74686572207468616e20746865206c6567656e642c202452495050592c20746865206f6666696369616c20585250206d6173636f742e00202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RIPPY>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<RIPPY>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<RIPPY>>(0x2::coin::mint<RIPPY>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

