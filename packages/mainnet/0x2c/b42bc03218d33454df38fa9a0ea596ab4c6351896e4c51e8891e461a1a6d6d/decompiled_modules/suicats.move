module 0x2cb42bc03218d33454df38fa9a0ea596ab4c6351896e4c51e8891e461a1a6d6d::suicats {
    struct SUICATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICATS>(arg0, 6, b"SUICATS", b"SUICATSCOIN", b"Running wild on SUI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cat_0238bba522.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICATS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICATS>>(v1);
    }

    // decompiled from Move bytecode v6
}

