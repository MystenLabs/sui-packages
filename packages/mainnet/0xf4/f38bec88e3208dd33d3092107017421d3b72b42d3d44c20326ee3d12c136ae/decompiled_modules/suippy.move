module 0xf4f38bec88e3208dd33d3092107017421d3b72b42d3d44c20326ee3d12c136ae::suippy {
    struct SUIPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPPY>(arg0, 6, b"SUIPPY", b"Suippy", b"Welcome to the $SUIPPY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CORAL_SUI_6ebb73537f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

