module 0x6f78a4ca4f4ac4250f5584f50c37d1808ba13f7e9723be00e242c94a4954e7c9::shin {
    struct SHIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIN>(arg0, 6, b"SHIN", b"SHIN CHAN", b"$SHIN - Shin Chan on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_11_23_51_57_6394bb823e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

