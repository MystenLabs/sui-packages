module 0x3253280ff696a70219ebdee3708595db42609c56249f5413859fcfc3ab4354fa::toony {
    struct TOONY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOONY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOONY>(arg0, 6, b"TOONY", b"TOONY STARS", b"TOONY STARS is your gateway to a vibrant and whimsical world of cryptocurrency. So, strap in, hold tight, and get ready to explore the dazzling world of TOONY STARSwhere every coin is a star, and every star tells a story!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_3291653b21.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOONY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOONY>>(v1);
    }

    // decompiled from Move bytecode v6
}

