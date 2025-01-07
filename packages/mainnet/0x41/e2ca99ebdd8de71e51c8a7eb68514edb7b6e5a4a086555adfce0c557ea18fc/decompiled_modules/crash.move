module 0x41e2ca99ebdd8de71e51c8a7eb68514edb7b6e5a4a086555adfce0c557ea18fc::crash {
    struct CRASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRASH>(arg0, 6, b"CRASH", b"CRASHOUT", b"RUGS GOT ME CRASHING OUTTT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7089_d433960493.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRASH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRASH>>(v1);
    }

    // decompiled from Move bytecode v6
}

