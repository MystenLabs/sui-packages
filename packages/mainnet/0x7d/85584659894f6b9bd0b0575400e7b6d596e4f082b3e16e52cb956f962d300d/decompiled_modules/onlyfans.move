module 0x7d85584659894f6b9bd0b0575400e7b6d596e4f082b3e16e52cb956f962d300d::onlyfans {
    struct ONLYFANS has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<ONLYFANS>, arg1: 0x2::coin::Coin<ONLYFANS>) {
        0x2::coin::burn<ONLYFANS>(arg0, arg1);
    }

    fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<ONLYFANS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ONLYFANS>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: ONLYFANS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/2e66JiGrwDyvDAA6zTpSe7kVEyFeGHSh9HyasVBcpump.png?size=lg&key=8aee98                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ONLYFANS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"OnlyFans  ")))), trim_right(b"OnlyFans                        "), trim_right(b"Come join us in only fans Metaverse where the community colides with the OF girls and parties, with diddy and his friends have provided plenty of baby oil, where you can line up to be the 150th guy for Lily Philips and much much more                                                                                       "), v2, arg1);
        let v5 = v3;
        let v6 = &mut v5;
        let v7 = 0x2::tx_context::sender(arg1);
        mint_and_transfer(v6, 1000000000000000000, v7, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ONLYFANS>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ONLYFANS>>(v5);
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

