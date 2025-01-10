module 0x32a0d52ce69426645819ec4832da7bbfaa0cd3dda404cf79945f3147651cd530::sui {
    struct SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUI>(arg0, 6, b"SUI", b"SUI by SuiAI", b"SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/20250110_225201_8e7c8028b6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

