module 0xfb32f2fda49fe01878093534f65a9e44bb7f8067f1e3aeb4393ba3d9aaa83cd1::suichad {
    struct SUICHAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICHAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICHAD>(arg0, 6, b"SUICHAD", b"GigaChad on Sui", b"Legendary aura of GigaChad on Sui. SUICHAD is a symbol of power, confidence, charisma of the Sui community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_23_16_24_28_73765ae52e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICHAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICHAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

