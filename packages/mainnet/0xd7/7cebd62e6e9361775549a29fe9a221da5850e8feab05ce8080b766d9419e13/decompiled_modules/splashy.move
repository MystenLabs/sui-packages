module 0xd77cebd62e6e9361775549a29fe9a221da5850e8feab05ce8080b766d9419e13::splashy {
    struct SPLASHY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPLASHY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPLASHY>(arg0, 6, b"SPLASHY", b"Splashy The Ghost", b"Splashy the ghost roams around the Sui network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeicrjhx6x2rclmjk4ths6z5of6wk5bohjhhuvgpuzkew3ces2gjpxm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPLASHY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SPLASHY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

