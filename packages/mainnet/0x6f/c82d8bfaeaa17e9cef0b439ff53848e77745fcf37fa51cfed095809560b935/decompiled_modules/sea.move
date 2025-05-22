module 0x6fc82d8bfaeaa17e9cef0b439ff53848e77745fcf37fa51cfed095809560b935::sea {
    struct SEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEA>(arg0, 6, b"SEA", b"SuiFaring World", b"Save the Sea, save our World", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifw5yf2mgnoal5icwvrkpt2zrgzabgpcisgfyxczbdr7opsepyc5e")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SEA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

