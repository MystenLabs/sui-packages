module 0xa82d97fc1f1740033c3b87b33598dec46a14965002d97cd4bd053e7dc3246177::loopy {
    struct LOOPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOOPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOOPY>(arg0, 6, b"LOOPY", b"Loopy", x"546865206d6f73742061646f7261626c652063756c7420746f206576657220696e76616465205355490a0a57652063616e20646f206974206265636175736520776520617265206375746521200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Bm_Fm_Ovo5_400x400_54da809f18.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOOPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOOPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

