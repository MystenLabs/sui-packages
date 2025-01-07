module 0xf82c6bcad05fc01e03e062afbce23fc09a68a30042afea0afdad99d1f3cb80fd::wolfnun {
    struct WOLFNUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOLFNUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOLFNUN>(arg0, 6, b"WOLFNUN", b"WolfNun", b"Wolf nun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4033_5f2d8ea7af.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOLFNUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOLFNUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

