module 0x5692f9c251b05ad71cfdb32f47b36ac5580049b1916f5ba46c4024483dfbf130::chillgirl {
    struct CHILLGIRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLGIRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLGIRL>(arg0, 6, b"CHILLGIRL", b"Just a chill girl", b"A chillgirl finds inspiration in her chillguy 's achievements.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733410513771.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHILLGIRL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLGIRL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

