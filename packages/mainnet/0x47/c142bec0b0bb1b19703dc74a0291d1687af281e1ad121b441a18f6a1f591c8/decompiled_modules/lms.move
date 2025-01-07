module 0x47c142bec0b0bb1b19703dc74a0291d1687af281e1ad121b441a18f6a1f591c8::lms {
    struct LMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LMS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<LMS>(arg0, 6, b"LMS", b"lamas", b"mio", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/BOYV_5759_5925507b45.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LMS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LMS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

