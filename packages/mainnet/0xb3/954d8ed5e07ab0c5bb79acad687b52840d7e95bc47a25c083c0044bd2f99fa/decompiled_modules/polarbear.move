module 0xb3954d8ed5e07ab0c5bb79acad687b52840d7e95bc47a25c083c0044bd2f99fa::polarbear {
    struct POLARBEAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: POLARBEAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POLARBEAR>(arg0, 6, b"Polarbear", b"polar bear", b"polar bear.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_09_17_24_24_35e1a5b60c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POLARBEAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POLARBEAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

