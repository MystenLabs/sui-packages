module 0xafb14fe1dbc692fc2e32897053f199b0ae301cbdc7e7f1a48e2f6088928d6b7e::suichad {
    struct SUICHAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICHAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICHAD>(arg0, 6, b"SUICHAD", b"SUICHAD CTO", b"SUICHAD Community Take Over", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_05_14_10_13_421876616c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICHAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICHAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

