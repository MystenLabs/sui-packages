module 0x3baafd1bee6ceb4de3c951314eab4a98b1a6c1ea8ed9f526b2503e52fdaff921::aiera {
    struct AIERA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIERA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AIERA>(arg0, 6, b"AIERA", b"Ai ERA", b"Anon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000015576_74d8d73d05.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AIERA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIERA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

