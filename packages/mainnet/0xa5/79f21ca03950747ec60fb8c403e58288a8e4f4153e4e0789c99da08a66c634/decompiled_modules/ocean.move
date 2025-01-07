module 0xa579f21ca03950747ec60fb8c403e58288a8e4f4153e4e0789c99da08a66c634::ocean {
    struct OCEAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCEAN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<OCEAN>(arg0, 6, b"OCEAN", b"WATER WAVE", b"SuiEmoji Water Wave", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.suiemoji.fun/emojis/ocean.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<OCEAN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCEAN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

