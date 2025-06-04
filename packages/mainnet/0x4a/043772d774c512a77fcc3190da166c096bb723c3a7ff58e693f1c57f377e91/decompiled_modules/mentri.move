module 0x4a043772d774c512a77fcc3190da166c096bb723c3a7ff58e693f1c57f377e91::mentri {
    struct MENTRI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MENTRI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MENTRI>(arg0, 6, b"MENTRI", b"Sui mentri", b"Smen", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiafy2fmzzjw7hk6lk467t2zgfvrttrxc3k32qee7ygeivstgyjmrm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MENTRI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MENTRI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

