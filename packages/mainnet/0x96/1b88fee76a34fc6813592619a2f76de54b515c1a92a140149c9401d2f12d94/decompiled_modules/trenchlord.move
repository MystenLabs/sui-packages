module 0x961b88fee76a34fc6813592619a2f76de54b515c1a92a140149c9401d2f12d94::trenchlord {
    struct TRENCHLORD has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRENCHLORD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRENCHLORD>(arg0, 6, b"TRENCHLORD", b"Sui Trenchlord", b"Weak hands tremble, but TRENCHLORD stands unshaken, green candles light the path.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicxompe4hzpmtd7xexlbqramuujpvxln7mszedyh537rqjrsmnk7e")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRENCHLORD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TRENCHLORD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

