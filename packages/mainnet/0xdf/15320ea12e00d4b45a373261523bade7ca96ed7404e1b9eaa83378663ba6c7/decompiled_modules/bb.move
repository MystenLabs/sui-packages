module 0xdf15320ea12e00d4b45a373261523bade7ca96ed7404e1b9eaa83378663ba6c7::bb {
    struct BB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BB>(arg0, 6, b"BB", b"bcdcxb", b"fgdasfadsf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreid4qx5s3tifu3us2r4mwii6kiehigvmumugwij6yvghjowz5n4knm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

