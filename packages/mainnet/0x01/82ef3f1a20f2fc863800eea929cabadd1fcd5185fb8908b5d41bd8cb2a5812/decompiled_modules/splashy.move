module 0x182ef3f1a20f2fc863800eea929cabadd1fcd5185fb8908b5d41bd8cb2a5812::splashy {
    struct SPLASHY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPLASHY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPLASHY>(arg0, 6, b"SPLASHY", b"Splash The Ghost", b"Splashy the ghost roams around the Sui network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeicrjhx6x2rclmjk4ths6z5of6wk5bohjhhuvgpuzkew3ces2gjpxm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPLASHY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SPLASHY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

