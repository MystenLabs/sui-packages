module 0xf6e770d9a0b48eadbdd36ddcc6601b0b1fba64490b27bf7c57ded8dc3aa64ce2::suiglass {
    struct SUIGLASS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGLASS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGLASS>(arg0, 6, b"SuiGlass", b"$SuiGlass", b"Watche the full way to the moon with my glasses", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000107238_952edb66b0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGLASS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGLASS>>(v1);
    }

    // decompiled from Move bytecode v6
}

