module 0xc536a421b2228d64ddcc89654bd98313ddbc09e57a4dd5d2ac1b51562aef4310::lagu {
    struct LAGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAGU>(arg0, 6, b"LAGU", b"LAGU SUI", b"Hello Im Lago sui meme dolphin. the next trend on sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/luga_head_3677cc09a3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAGU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LAGU>>(v1);
    }

    // decompiled from Move bytecode v6
}

