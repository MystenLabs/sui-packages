module 0x9e812d852b389a2e14bf7731ff046a8263d0029162010fa1d5ed7dfc76de36b2::saviour {
    struct SAVIOUR has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SAVIOUR>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SAVIOUR>>(0x2::coin::mint<SAVIOUR>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SAVIOUR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/6q6tqND6J8fPpAf2VNbFYLuXKVgbPC7BUbPjQTyrbonk.png?size=lg&key=871c92                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SAVIOUR>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SAVIOUR ")))), trim_right(b"Bonk Level Saviour              "), trim_right(b"someone PLEASE save my bags I can't fkn do this anymore. everyday I wake up and my coins are DOWN. they don't even bond anymore. PLEASE PLEASE someone do something. where are the influenzas when we need them??? we need a BONK-level SAVIOUR to turn this market around                                                      "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAVIOUR>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SAVIOUR>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<SAVIOUR>>(0x2::coin::mint<SAVIOUR>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

