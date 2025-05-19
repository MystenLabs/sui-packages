module 0xa427d4d0712048d7b8f200cb303eb2e0ddfa2390ef9739ef92a0e64e33ba3569::inx {
    struct INX has drop {
        dummy_field: bool,
    }

    fun init(arg0: INX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INX>(arg0, 6, b"INX", b"INX AI", b"With growing interest in AI integration within blockchain technology, INX AI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiequclhvtq5pgcwo5zklqxhsy6hgzqoxib7wcrlek42iscxnc2cly")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<INX>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

