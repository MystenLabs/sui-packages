module 0xbaed9996fb18581b377ec45b71f9f2f5919fd823b85fbabb627ef744d94cc55b::grin {
    struct GRIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<GRIN>(arg0, 6, b"GRIN", b"BEAMING FACE WITH SMILING EYES", b"SuiEmoji Beaming Face with Smiling Eyes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiemoji.fun/emojis/grin.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GRIN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRIN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

