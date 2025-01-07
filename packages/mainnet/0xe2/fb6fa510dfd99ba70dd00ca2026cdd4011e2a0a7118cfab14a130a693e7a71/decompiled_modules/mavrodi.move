module 0xe2fb6fa510dfd99ba70dd00ca2026cdd4011e2a0a7118cfab14a130a693e7a71::mavrodi {
    struct MAVRODI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAVRODI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAVRODI>(arg0, 6, b"MAVRODI", b"Mavrodi MMM", b"Mavrodi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/scale_1200_9ca737632d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAVRODI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAVRODI>>(v1);
    }

    // decompiled from Move bytecode v6
}

