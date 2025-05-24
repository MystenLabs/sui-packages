module 0x1dbb81fc061be76b38074b530fac5db7034f360ab5e0dbd1bcdd4e757cfc06f6::lambo {
    struct LAMBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAMBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAMBO>(arg0, 6, b"LAMBO", b"WEN LAMBO", b"WEN LAMBO SER!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigksbov3gwaze6refna7xipj5xfxro5c3jzjfrxcvfxgqvdl3edeq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAMBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LAMBO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

