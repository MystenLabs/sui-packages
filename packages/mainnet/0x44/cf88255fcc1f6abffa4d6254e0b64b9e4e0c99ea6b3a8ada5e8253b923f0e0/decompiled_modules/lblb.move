module 0x44cf88255fcc1f6abffa4d6254e0b64b9e4e0c99ea6b3a8ada5e8253b923f0e0::lblb {
    struct LBLB has drop {
        dummy_field: bool,
    }

    fun init(arg0: LBLB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LBLB>(arg0, 6, b"LBLB", b"LABLUBLU", x"4c61426c75426c75206973207468652066616d6f757320626c7565206d6173636f74206f66207468652053554920426c6f636b636861696e2c0a5765206275696c6420612076696272616e7420756e697665727365206f6620636f6d69637320616e6420726172652c206f726967696e616c204e4654732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibofk573e7u44zacchn6phxyqsntotvhqonnxhqbrytoescg6zaca")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LBLB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LBLB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

