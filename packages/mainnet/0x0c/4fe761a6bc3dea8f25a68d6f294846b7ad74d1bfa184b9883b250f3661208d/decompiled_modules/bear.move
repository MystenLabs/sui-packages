module 0xc4fe761a6bc3dea8f25a68d6f294846b7ad74d1bfa184b9883b250f3661208d::bear {
    struct BEAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEAR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BEAR>(arg0, 6, b"BEAR", b"BEAR", b"SuiEmoji Bear", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.suiemoji.fun/emojis/bear.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BEAR>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEAR>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

