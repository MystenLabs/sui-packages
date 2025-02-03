module 0x7613dc282c09fd8bb0440a2062281570dcd2a2c7f25a224e5f445370d3e8d08d::coinai {
    struct COINAI has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<COINAI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<COINAI>>(0x2::coin::mint<COINAI>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: COINAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/7VQUjvzdiNQEigzhTozJaT49GkJu1scypUTDmDUp13as.png?size=lg&key=b59fb4                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<COINAI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"COINAI  ")))), trim_right(b"Coinbase AI Agent               "), trim_right(b"Coinbase AI Agent is an innovative project launched by Coinbase, designed to integrate artificial intelligence into the cryptocurrency trading platform to help users make smarter investment decisions.                                                                                                                        "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COINAI>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<COINAI>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<COINAI>>(0x2::coin::mint<COINAI>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

