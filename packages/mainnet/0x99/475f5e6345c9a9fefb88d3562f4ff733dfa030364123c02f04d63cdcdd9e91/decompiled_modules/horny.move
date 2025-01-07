module 0x99475f5e6345c9a9fefb88d3562f4ff733dfa030364123c02f04d63cdcdd9e91::horny {
    struct HORNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HORNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HORNY>(arg0, 6, b"HORNY", b"Still Horny", b"Still Horny Degen?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1595_bb04e1c585.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HORNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HORNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

