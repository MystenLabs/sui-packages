module 0x1ecadd50b478d5da425759a37ca1541acc7352b4b1ee7dd05eaa43e47349a314::mira {
    struct MIRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIRA>(arg0, 6, b"MIRA", b"Mira", b"if you could press a button that cures your child's brain tumor in exchange for ending your life immediately, every parent would hesitate for zero seconds before fighting to be the first to press it the cruelest thing is that no such button exists.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735191328534.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIRA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIRA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

