module 0x6318bdc5533d423a55a422c88e95afeefc04f793041a30ab4940b26fbfc57198::gasg5 {
    struct GASG5 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GASG5, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GASG5>(arg0, 6, b"Gasg5", b"gasg", b"agf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/R_cfb8b9f963.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GASG5>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GASG5>>(v1);
    }

    // decompiled from Move bytecode v6
}

