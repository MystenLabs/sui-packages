module 0x1c376962d49221e17118e3ca8e5cbd0f5473707070e56db8e1273af2cb8190cb::suistas {
    struct SUISTAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISTAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISTAS>(arg0, 6, b"SUISTAS", b"SUPERSTAS", b"SUISTAS is my personal meme token, YOU PEOPLE ARE TOO INVOLVED IN THIS SWAMP OF SOULLESS MEMES! After all, it is the person himself who gives joy and joy. Join me!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sticker_93e1d4e1f7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISTAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISTAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

