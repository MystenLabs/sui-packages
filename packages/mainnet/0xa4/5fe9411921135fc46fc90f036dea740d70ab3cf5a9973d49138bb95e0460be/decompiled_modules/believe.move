module 0xa45fe9411921135fc46fc90f036dea740d70ab3cf5a9973d49138bb95e0460be::believe {
    struct BELIEVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BELIEVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BELIEVE>(arg0, 6, b"Believe", b"Believe in something", b"Believe in sui, Believe in commuinty, Believed in something.  A project by Likeable_Dev", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000182206_2edc02471d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BELIEVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BELIEVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

