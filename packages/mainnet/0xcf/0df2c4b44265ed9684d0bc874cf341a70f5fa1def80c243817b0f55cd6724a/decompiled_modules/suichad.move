module 0xcf0df2c4b44265ed9684d0bc874cf341a70f5fa1def80c243817b0f55cd6724a::suichad {
    struct SUICHAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICHAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICHAD>(arg0, 6, b"SuiCHAD", b"Sui CHAD", b"SuiCHAD | Giga Chad of the #SUI network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_01_21_43_52_8abe5d0df4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICHAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICHAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

