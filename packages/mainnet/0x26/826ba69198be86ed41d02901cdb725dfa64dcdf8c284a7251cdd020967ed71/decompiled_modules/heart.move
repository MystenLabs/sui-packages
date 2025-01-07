module 0x26826ba69198be86ed41d02901cdb725dfa64dcdf8c284a7251cdd020967ed71::heart {
    struct HEART has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEART, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<HEART>(arg0, 6, b"HEART", b"RED HEART", b"SuiEmoji Red Heart", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.suiemoji.fun/emojis/heart.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HEART>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEART>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

