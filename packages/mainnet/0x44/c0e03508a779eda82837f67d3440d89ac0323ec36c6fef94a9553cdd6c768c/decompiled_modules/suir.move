module 0x44c0e03508a779eda82837f67d3440d89ac0323ec36c6fef94a9553cdd6c768c::suir {
    struct SUIR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIR>(arg0, 6, b"SUIR", b"SUIRROT", b"The parrot of sui, ready to fly? Lets send it!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3137_031a8a0f07.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIR>>(v1);
    }

    // decompiled from Move bytecode v6
}

