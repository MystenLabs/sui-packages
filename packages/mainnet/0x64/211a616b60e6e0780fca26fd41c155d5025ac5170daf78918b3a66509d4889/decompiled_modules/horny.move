module 0x64211a616b60e6e0780fca26fd41c155d5025ac5170daf78918b3a66509d4889::horny {
    struct HORNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HORNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HORNY>(arg0, 6, b"Horny", b"Suigasm", b"Im horny as sui breaking ATH, time to get horny together", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/kirbycum_fa4677d6fa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HORNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HORNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

