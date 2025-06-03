module 0xc620ba80fce9769fd1bb79de5d0b52d1db34d4e32b90246a89e60c1e97417a43::bluzo {
    struct BLUZO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUZO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUZO>(arg0, 6, b"Bluzo", b"Bluzo On Sui", b"BLuzos", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiho54mmescd3oryxcf6qvmtlvrscr3orhepqnusm56gcb7xkb7wse")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUZO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLUZO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

