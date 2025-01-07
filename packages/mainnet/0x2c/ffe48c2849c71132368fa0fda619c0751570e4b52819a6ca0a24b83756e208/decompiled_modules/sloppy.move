module 0x2cffe48c2849c71132368fa0fda619c0751570e4b52819a6ca0a24b83756e208::sloppy {
    struct SLOPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLOPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLOPPY>(arg0, 6, b"Sloppy", b"$Sloppy", b"Sloppy just landed on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5985_B7_B2_28_E1_49_E6_A55_A_28593_A9_EDCE_9_cb90fd9ff4.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLOPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLOPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

