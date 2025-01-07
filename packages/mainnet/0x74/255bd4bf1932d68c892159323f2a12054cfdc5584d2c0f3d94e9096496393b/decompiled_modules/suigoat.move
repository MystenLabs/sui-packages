module 0x74255bd4bf1932d68c892159323f2a12054cfdc5584d2c0f3d94e9096496393b::suigoat {
    struct SUIGOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGOAT>(arg0, 6, b"SUIGOAT", b"Sui The GOAT", b"SUI>SOL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_08_alle_02_09_48_7c4fe51639.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGOAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGOAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

