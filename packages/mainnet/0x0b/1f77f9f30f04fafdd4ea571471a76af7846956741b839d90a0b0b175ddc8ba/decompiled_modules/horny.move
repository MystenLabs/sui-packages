module 0xb1f77f9f30f04fafdd4ea571471a76af7846956741b839d90a0b0b175ddc8ba::horny {
    struct HORNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HORNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HORNY>(arg0, 6, b"Horny", b"Suigasm", b"Im horny as sui almost broke ATH, time to get horny together", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/kirbycum_a9a7825d00.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HORNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HORNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

