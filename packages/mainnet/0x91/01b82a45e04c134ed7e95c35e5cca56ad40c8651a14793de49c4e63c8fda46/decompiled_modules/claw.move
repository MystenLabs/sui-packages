module 0x9101b82a45e04c134ed7e95c35e5cca56ad40c8651a14793de49c4e63c8fda46::claw {
    struct CLAW has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLAW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLAW>(arg0, 6, b"CLAW", b"CLAWSSui", b"Claw is claw", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/file_7_O_Ubnfs_Uv199zd_H8q8p1tk_Yo_5c88de1f3e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLAW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLAW>>(v1);
    }

    // decompiled from Move bytecode v6
}

