module 0x379d92ca41a3b163e0d4642ce35a0ea012c0ce94e6f7e7cc002f04a20d58d807::swoop {
    struct SWOOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWOOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWOOP>(arg0, 6, b"SWOOP", b"SwoopOnSui", b"Swoop is coming to @SuiNetwork and launching NOW!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/swoop_80cd8d8b9c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWOOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWOOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

