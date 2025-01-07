module 0x57a2b06a1d7fdae43b08f3a3276e52baf4ab732c6898821e5cd2804bc1479cda::job {
    struct JOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOB>(arg0, 6, b"Job", b"Im really tired", b"This token only for people who work 10hrs a day", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5843_f427c54af0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

