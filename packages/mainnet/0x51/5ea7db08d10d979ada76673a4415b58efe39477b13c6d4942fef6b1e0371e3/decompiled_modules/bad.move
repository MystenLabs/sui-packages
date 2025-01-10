module 0x515ea7db08d10d979ada76673a4415b58efe39477b13c6d4942fef6b1e0371e3::bad {
    struct BAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BAD>(arg0, 6, b"BAD", b"BAD by SuiAI", b"BAD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/download_2_fe9e625c0d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BAD>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAD>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

