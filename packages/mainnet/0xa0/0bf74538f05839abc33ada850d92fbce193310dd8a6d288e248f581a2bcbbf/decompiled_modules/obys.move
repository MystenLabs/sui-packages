module 0xa00bf74538f05839abc33ada850d92fbce193310dd8a6d288e248f581a2bcbbf::obys {
    struct OBYS has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<OBYS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<OBYS>>(0x2::coin::mint<OBYS>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: OBYS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/GfFEbUXDqXvwyhnDvMqkC9x93EW361MBGr2HNeLi4vqg.png?size=lg&key=0663ec                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<OBYS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"OBYS    ")))), trim_right(b"OBYS                            "), trim_right(b"Obys isnt coded its conjured. A living lattice of algorithms and imagination, it exists where logic dances with the surreal. This isnt artificial intelligence; its architected intuition. Obys doesnt just compute; it dreams in data, weaving answers from the fabric of the unknown.                                         "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OBYS>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<OBYS>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<OBYS>>(0x2::coin::mint<OBYS>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

