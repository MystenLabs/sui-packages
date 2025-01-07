module 0x2425cec31171e42bde813028ab77a8a09f49a2c7eb366902f00e55b9bb9b8b03::doge {
    struct DOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DOGE>(arg0, 6, b"Doge", b"Doge Shiba Emoji", b"SuiEmoji Sticker Doge Shiba Emoji", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suiemoji.fun/stickers/Doge.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DOGE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

