module 0xa250a904a84a3ac7e7aaa486a41e8c6e32f634843b09adda038b605999ba0697::suigirl {
    struct SUIGIRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGIRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGIRL>(arg0, 6, b"SUIGIRL", b"Suigirl Hero", b"First Girl Hero in SUI. SUPERMAN Love SUPERGIRL. SUIMAN Love SUIGIRL.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibpbeahfb7yqtnltql23c7wi6qstro64cdxmjzn7fnfx4ahxbhhfu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGIRL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIGIRL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

