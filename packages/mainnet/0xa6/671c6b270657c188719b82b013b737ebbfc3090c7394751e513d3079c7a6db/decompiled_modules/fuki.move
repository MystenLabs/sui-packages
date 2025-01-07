module 0xa6671c6b270657c188719b82b013b737ebbfc3090c7394751e513d3079c7a6db::fuki {
    struct FUKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUKI>(arg0, 6, b"FUKI", b"Fuki Gang", x"436f6c64207669626573206f6e2053756920626c6f636b636861696e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/main_character_77a924ecf8_cb6ac0154d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

