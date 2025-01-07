module 0xf04befa1856b5e7ccfdde2ca40ddf7024538d4caec748f796744bf6e88f1675c::stasui {
    struct STASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STASUI>(arg0, 6, b"STASUI", b"SUISTAS", b"SUISTAS is my personal meme token, YOU PEOPLE ARE TOO INVOLVED IN THIS SWAMP OF SOULLESS MEMES! After all, it is the person himself who gives joy and joy. Join me!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sticker_108345d007.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STASUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STASUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

