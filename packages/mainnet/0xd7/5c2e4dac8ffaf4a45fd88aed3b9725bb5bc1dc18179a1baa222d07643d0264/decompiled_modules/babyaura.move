module 0xd75c2e4dac8ffaf4a45fd88aed3b9725bb5bc1dc18179a1baa222d07643d0264::babyaura {
    struct BABYAURA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYAURA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/HzC1RLQhbV5hpFLw2EYhi9iWNWoN365xDvtYHv9vpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BABYAURA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BABYAURA    ")))), trim_right(b"Baby Aura                       "), trim_right(x"4261627920417572612069736e74206c6f75642e20497420646f65736e7420727573682e204974206a75737420657869737473676c6f77696e672c20706561636566756c2c20616e6420737472616e67656c7920706f77657266756c2e2046726f6d20746865206d6f6d656e742069742061707065617265642c207468696e67732066656c7420646966666572656e742e2043616c6d65722e20536f667465722e2041206c6974746c65206d6f7265206d61676963616c2e0a0a49747320736d616c6c2c20796573627574206974732070726573656e636520697320687567652e2057686572657665722042616279204175726120676f65732c2074686520776f726c6420736c6f777320646f776e20616e642073746172747320746f206272656174686520616761696e2e0a0a244241425941555241202d20506f77657265"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYAURA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYAURA>>(v4);
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

