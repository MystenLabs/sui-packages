module 0xc375ce0a656d5ba9c7c85890d8c9609b6c52afba164dccf7980b1d3a9ab1d621::btcath {
    struct BTCATH has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<BTCATH>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BTCATH>>(0x2::coin::mint<BTCATH>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: BTCATH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/BQzsmcuETFrqEnPadiKNQJzQou1oFJ9KUogjjTWepump.png?size=lg&key=c44f82                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BTCATH>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BTCATH  ")))), trim_right(b"BTCNEWATH                       "), trim_right(b"BTC New ATH celebrates Bitcoin's historic achievement of reaching an all-time high of $100.000+. This token embodies the unstoppable momentum of BTC's rise, rallying the crypto                                                                                                                                                "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BTCATH>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BTCATH>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<BTCATH>>(0x2::coin::mint<BTCATH>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

