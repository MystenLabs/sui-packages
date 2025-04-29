module 0xcfa987cd76a0a8f85cf3035e1da74d083139f4ddde566043090eb5a03ac66abd::dish {
    struct DISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: DISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DISH>(arg0, 6, b"DISH", b"Dick Fish", b"This is how deep she meant", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2025_04_28_115552_8eb12e4c58.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

