module 0x6507c78a3eda2f371953c4f26cb87c188a52a4341e9180d5ec5ea27774d7844::hips {
    struct HIPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIPS>(arg0, 6, b"HIPS", b"Hippo Sui", b"Say goodbye to the days of dogs and frogs, it's time for $HIPS to rise and redefine the game.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/rk_Ja_C5xo_400x400_8b3ca1bdf5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HIPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

