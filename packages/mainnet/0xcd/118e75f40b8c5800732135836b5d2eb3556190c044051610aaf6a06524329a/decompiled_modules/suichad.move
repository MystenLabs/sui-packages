module 0xcd118e75f40b8c5800732135836b5d2eb3556190c044051610aaf6a06524329a::suichad {
    struct SUICHAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICHAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICHAD>(arg0, 6, b"SuiCHAD", b"Sui CHAD", b"SuiCHAD | Giga Chad of the #SUI network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_01_21_43_52_8abe5d0df4_89fc20ca62.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICHAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICHAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

