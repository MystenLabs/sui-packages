module 0xb13d09f46e58aba9fc7cb07fca301eada050e165174330dd8936b7ed44633593::muradsdogs {
    struct MURADSDOGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MURADSDOGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MURADSDOGS>(arg0, 6, b"MURADSDOGS", b"TEDDY", b"Murad's real dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Snipaste_2024_10_13_01_46_33_f37f6ac396.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MURADSDOGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MURADSDOGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

