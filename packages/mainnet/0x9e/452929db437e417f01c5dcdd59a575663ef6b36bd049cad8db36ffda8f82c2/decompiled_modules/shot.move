module 0x9e452929db437e417f01c5dcdd59a575663ef6b36bd049cad8db36ffda8f82c2::shot {
    struct SHOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHOT>(arg0, 6, b"SHOT", b"Pop Shot", b"Shot Shot Shot Shot Shot Shot Shot Shot Shot Shot Shot Shot Shot Shot Shot Shot!!!!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20250430_235459_b1b846b92d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

