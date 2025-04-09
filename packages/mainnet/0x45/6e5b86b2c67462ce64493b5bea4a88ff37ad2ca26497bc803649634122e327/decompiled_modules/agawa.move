module 0x456e5b86b2c67462ce64493b5bea4a88ff37ad2ca26497bc803649634122e327::agawa {
    struct AGAWA has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<AGAWA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<AGAWA>>(0x2::coin::mint<AGAWA>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: AGAWA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/DH4MqNmSR7rSY1zLiEaszx8cyDPCNgTWWTm4w8TMpump.png?size=lg&key=6530fc                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<AGAWA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"AGAWA   ")))), trim_right(b"Agawa                           "), trim_right(b"AGAWA: Agentic Away The first AGI agent, discovering who she truly is. AGAWA() is an AGI agent in a Ghibli-style virtual town, discovering who she truly is and sharing its magical moments with the world online.                                                                                                              "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AGAWA>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<AGAWA>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<AGAWA>>(0x2::coin::mint<AGAWA>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

