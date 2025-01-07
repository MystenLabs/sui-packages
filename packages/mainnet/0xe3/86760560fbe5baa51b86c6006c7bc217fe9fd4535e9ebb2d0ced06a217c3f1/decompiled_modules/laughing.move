module 0xe386760560fbe5baa51b86c6006c7bc217fe9fd4535e9ebb2d0ced06a217c3f1::laughing {
    struct LAUGHING has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAUGHING, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<LAUGHING>(arg0, 6, b"LAUGHING", b"GRINNING SQUINTING FACE", b"SuiEmoji Grinning Squinting Face", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiemoji.fun/emojis/laughing.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LAUGHING>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAUGHING>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

