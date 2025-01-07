module 0x4d54623067461175e28a93c2b1f25b61642bfa26f04b5aa46d4fe02d6bac9ef7::suille {
    struct SUILLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILLE>(arg0, 6, b"Suille", b"it's a suille", b"#neuille", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/gender_reveal_fille_canon_jpg_7c3c0504c2.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

