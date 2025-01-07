module 0x44ccf095682a7c0ea6ea2e4688f2eb7ceee07409a5030e6437b904b42898cc4d::skop {
    struct SKOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKOP>(arg0, 6, b"SKOP", b"FIRST SKULL OF PEPE", b"FIRST SKULL OF PEPE: https://www.skopsui.pro", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_2_fcc56e5ea3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

