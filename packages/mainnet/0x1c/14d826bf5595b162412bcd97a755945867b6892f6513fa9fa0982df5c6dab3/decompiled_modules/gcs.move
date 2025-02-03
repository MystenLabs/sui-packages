module 0x1c14d826bf5595b162412bcd97a755945867b6892f6513fa9fa0982df5c6dab3::gcs {
    struct GCS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GCS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GCS>(arg0, 6, b"GCS", b"GrumpyCat on sui", b"Welcome to the world of Grumpy Cat!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_01_31_17_06_56_dacde3882e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GCS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GCS>>(v1);
    }

    // decompiled from Move bytecode v6
}

