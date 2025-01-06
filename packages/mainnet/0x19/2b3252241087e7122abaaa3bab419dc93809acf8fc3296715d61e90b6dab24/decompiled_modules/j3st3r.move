module 0x192b3252241087e7122abaaa3bab419dc93809acf8fc3296715d61e90b6dab24::j3st3r {
    struct J3ST3R has drop {
        dummy_field: bool,
    }

    fun init(arg0: J3ST3R, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<J3ST3R>(arg0, 6, b"J3ST3R", b"jester", b"\"Laugh Loud, Think Deep, Rebel Brightly.\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736188994771.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<J3ST3R>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<J3ST3R>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

