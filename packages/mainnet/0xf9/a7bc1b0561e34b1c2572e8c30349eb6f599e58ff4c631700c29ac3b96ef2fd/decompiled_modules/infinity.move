module 0xf9a7bc1b0561e34b1c2572e8c30349eb6f599e58ff4c631700c29ac3b96ef2fd::infinity {
    struct INFINITY has drop {
        dummy_field: bool,
    }

    fun init(arg0: INFINITY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<INFINITY>(arg0, 6, b"INFINITY", b"INFINITY", b"SuiEmoji Infinity", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.suiemoji.fun/emojis/infinity.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<INFINITY>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INFINITY>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

