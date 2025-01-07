module 0x1c111bf588eb438b238a2dece0a2a0ae1659d8918b119db32d0779ff41e22305::stassui {
    struct STASSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STASSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STASSUI>(arg0, 6, b"STASSUI", b"SUISTAS", b"SUISTAS is my personal meme token, YOU PEOPLE ARE TOO INVOLVED IN THIS SWAMP OF SOULLESS MEMES! After all, it is the person himself who gives joy and joy. Join me!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sticker_2b9eb81b2d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STASSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STASSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

