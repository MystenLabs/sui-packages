module 0x985da73c6779c68077f1c06f5396717cae5a871859790bacaeb0fdb25950dab::melo {
    struct MELO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MELO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MELO>(arg0, 6, b"Melo", b"MELO FISH SUI", b"It's Melo fish ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4f54eaa7ccf90383c608eba6c78c9a2f_cff4fdf4f3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MELO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MELO>>(v1);
    }

    // decompiled from Move bytecode v6
}

