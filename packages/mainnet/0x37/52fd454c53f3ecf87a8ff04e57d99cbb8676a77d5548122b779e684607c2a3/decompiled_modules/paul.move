module 0x3752fd454c53f3ecf87a8ff04e57d99cbb8676a77d5548122b779e684607c2a3::paul {
    struct PAUL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAUL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAUL>(arg0, 9, b"PAUL", b"Paul strategy", b"Micro Strategy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<PAUL>>(v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAUL>>(v1);
    }

    // decompiled from Move bytecode v6
}

