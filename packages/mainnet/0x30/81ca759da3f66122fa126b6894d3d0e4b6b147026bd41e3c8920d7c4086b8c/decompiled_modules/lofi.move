module 0x3081ca759da3f66122fa126b6894d3d0e4b6b147026bd41e3c8920d7c4086b8c::lofi {
    struct LOFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOFI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<LOFI>(arg0, 6, b"LOFI", b"LOFI ", b"Lofi In Suai", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_7348_7e5f4a72b5.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LOFI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOFI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

