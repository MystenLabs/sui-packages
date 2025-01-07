module 0x400b1444cd3e663e508703237e4cf96cc82e03f1cffd7e0cb2b836f49db29e4e::dolly {
    struct DOLLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLLY>(arg0, 6, b"DOLLY", b"DOLLY FAN ON SUI", b"DOLLY FAN The cutest dog in SUI, also a friend of Moodengs.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_dolly_b35f4392ec.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOLLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

