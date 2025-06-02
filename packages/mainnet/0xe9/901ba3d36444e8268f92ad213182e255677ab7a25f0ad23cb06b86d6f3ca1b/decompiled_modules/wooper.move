module 0xe9901ba3d36444e8268f92ad213182e255677ab7a25f0ad23cb06b86d6f3ca1b::wooper {
    struct WOOPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOOPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOOPER>(arg0, 6, b"WOOPER", b"Wooper Sui", b"Hop in with the WOOPER and let's grow together", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigkdvbqzwdbfcimumy7h4l2wfhaonj45n4hchiqtrp55ohsvypbxm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOOPER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WOOPER>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

