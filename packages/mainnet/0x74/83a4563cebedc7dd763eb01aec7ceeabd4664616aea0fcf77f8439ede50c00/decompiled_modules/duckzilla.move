module 0x7483a4563cebedc7dd763eb01aec7ceeabd4664616aea0fcf77f8439ede50c00::duckzilla {
    struct DUCKZILLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCKZILLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCKZILLA>(arg0, 6, b"Duckzilla", b"Duckzilla on SUI", b"Real DuckzillaSui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GY_7_J4_ZTXIAE_7r9_c3816b9911.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCKZILLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUCKZILLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

