module 0x6a619d17501f111bd324cb9f27003f0c368f286cb03d02ffb1933ca51ad4c963::theory {
    struct THEORY has drop {
        dummy_field: bool,
    }

    fun init(arg0: THEORY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THEORY>(arg0, 6, b"Theory", b"Albert Einstein", b"Theory of relativity", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/e47b4026c252b73a262b72b7ca211a8e_7d7160f769.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THEORY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<THEORY>>(v1);
    }

    // decompiled from Move bytecode v6
}

