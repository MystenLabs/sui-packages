module 0x42affae39bc7a033e0e3f40038d90e0b2238e1f4ab130b5c70aadfb70f1f97b1::graph {
    struct GRAPH has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<GRAPH>, arg1: 0x2::coin::Coin<GRAPH>) {
        0x2::coin::burn<GRAPH>(arg0, arg1);
    }

    fun init(arg0: GRAPH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRAPH>(arg0, 4, b"GRAPH", b"GRAPH", b"SUI GRAPH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/9uXvdyPLknsSHnx6csn5wTLjxYXhPbe9Q7Ewzys7buNx.png")), arg1);
        let v2 = v0;
        let v3 = &mut v2;
        mint(v3, 10000000000000000000, @0xfc66d8f0d18c8887fe9bc699c12283f8494a16332aa624c374e88904d8d67c63, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRAPH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRAPH>>(v2, @0xfc66d8f0d18c8887fe9bc699c12283f8494a16332aa624c374e88904d8d67c63);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<GRAPH>, arg1: u128, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<GRAPH>(arg0, (arg1 as u64), arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

