module 0x36b629fde99c8d5824d1b053dada192014cf78ee88323a79f95b6074dfc886a9::dis {
    struct DIS has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<DIS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DIS>>(0x2::coin::mint<DIS>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: DIS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/2AEU9yWk3dEGnVwRaKv4div5TarC4dn7axFLyz6zG4Pf.png?size=lg&key=ab7f42                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<DIS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"DIS     ")))), trim_right(b"Distribute.ai                   "), trim_right(b"Distribute.AI turns tens-of-thousands of idle GPUs into a single, always-on distributed supercomputer, delivering lightning-fast, low-cost inference through OpenAI-compatible endpoints.                                                                                                                                       "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DIS>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DIS>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<DIS>>(0x2::coin::mint<DIS>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

