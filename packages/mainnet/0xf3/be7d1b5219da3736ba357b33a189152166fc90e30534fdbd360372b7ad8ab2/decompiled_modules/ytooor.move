module 0xf3be7d1b5219da3736ba357b33a189152166fc90e30534fdbd360372b7ad8ab2::ytooor {
    struct YTOOOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: YTOOOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YTOOOR>(arg0, 6, b"Ytooor", b"YTRRR", b"dafdsafas", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MOODENG_f76d1f354f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YTOOOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YTOOOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

