module 0x71b1d6e716459a28aedcce6823694ac71746a8e614740caa8b8e79bb44b424ab::bluiey {
    struct BLUIEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUIEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUIEY>(arg0, 6, b"BlUIEY", b"Bluiey", b"Forget Joe Bluiey is the blue M&M mascot of the Sui chain, sweetening up everyones PnL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_14_21_25_05_cfc3f9ddcf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUIEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUIEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

