module 0x6bb22de1bb6b81851988fca4b09efe5146aba5089e8623ab09954565c0ff5e6a::dest {
    struct DEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEST>(arg0, 9, b"DESTING", b"dest", b"just a dest", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://localhost:9900/kappa/coins/3a1ac58d-c2a2-43d5-bc9f-fa58c682c368.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEST>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

