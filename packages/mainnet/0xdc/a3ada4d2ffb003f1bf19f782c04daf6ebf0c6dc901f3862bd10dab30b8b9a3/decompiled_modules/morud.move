module 0xdca3ada4d2ffb003f1bf19f782c04daf6ebf0c6dc901f3862bd10dab30b8b9a3::morud {
    struct MORUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MORUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MORUD>(arg0, 6, b"MORUD", b"MORUD ON SUI", x"474d200a244d4f525544206f6e20235355492e200a4c657473206765742069742067656e67", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000018352_3a0e623716.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MORUD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MORUD>>(v1);
    }

    // decompiled from Move bytecode v6
}

