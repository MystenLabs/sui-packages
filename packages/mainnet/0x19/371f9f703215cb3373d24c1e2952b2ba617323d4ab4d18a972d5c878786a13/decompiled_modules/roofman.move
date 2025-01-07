module 0x19371f9f703215cb3373d24c1e2952b2ba617323d4ab4d18a972d5c878786a13::roofman {
    struct ROOFMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROOFMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROOFMAN>(arg0, 6, b"Roofman", b"ManOnRoof", b"Random man on roof. No strings. Risky. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732207418092.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROOFMAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROOFMAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

