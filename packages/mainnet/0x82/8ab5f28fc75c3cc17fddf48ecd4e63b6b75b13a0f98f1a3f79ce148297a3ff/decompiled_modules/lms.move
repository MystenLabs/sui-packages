module 0x828ab5f28fc75c3cc17fddf48ecd4e63b6b75b13a0f98f1a3f79ce148297a3ff::lms {
    struct LMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LMS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<LMS>(arg0, 6, b"LMS", b"Lamas", b"MIo token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/BOYV_5759_34dbd0dea7.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LMS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LMS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

