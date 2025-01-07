module 0xa2d49e2df9d8a5e718e6560a6ca4e101a106f8bd4685aaf2107b1100ad6293dc::sneke {
    struct SNEKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNEKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNEKE>(arg0, 6, b"Sneke", b"Seneke", b"SLITHER INTO 2025 WITH PEPE! BUY $PEPESNAKE NOW!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_12_27_at_10_07_57a_PM_435c875268.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNEKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNEKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

