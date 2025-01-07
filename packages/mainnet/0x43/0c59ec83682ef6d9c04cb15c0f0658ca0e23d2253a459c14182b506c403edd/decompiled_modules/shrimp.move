module 0x430c59ec83682ef6d9c04cb15c0f0658ca0e23d2253a459c14182b506c403edd::shrimp {
    struct SHRIMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHRIMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHRIMP>(arg0, 6, b"SHRIMP", b"SuiShrimp", b"Sui Shrimp", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUISHRIMP_7bc5217761.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHRIMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHRIMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

