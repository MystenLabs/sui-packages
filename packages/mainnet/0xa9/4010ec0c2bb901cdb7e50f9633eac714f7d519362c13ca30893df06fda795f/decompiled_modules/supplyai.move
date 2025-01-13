module 0xa94010ec0c2bb901cdb7e50f9633eac714f7d519362c13ca30893df06fda795f::supplyai {
    struct SUPPLYAI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUPPLYAI>, arg1: 0x2::coin::Coin<SUPPLYAI>) {
        0x2::coin::burn<SUPPLYAI>(arg0, arg1);
    }

    fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<SUPPLYAI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUPPLYAI>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: SUPPLYAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/BAkwW3TuZJvaNoqmcm5tsWDFticnB57yJVT1di2apump.png?size=lg&key=1a4123                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SUPPLYAI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SupplyAI  ")))), trim_right(b"SupplyVestAI                    "), trim_right(b"SupplyAI is the native governance token of SupplyVest , aligning incentives, funding development, and empowering community participation                                                                                                                                                                                        "), v2, arg1);
        let v5 = v3;
        let v6 = &mut v5;
        let v7 = 0x2::tx_context::sender(arg1);
        mint_and_transfer(v6, 1000000000000000000, v7, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUPPLYAI>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUPPLYAI>>(v5);
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

