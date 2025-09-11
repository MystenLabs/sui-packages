module 0xd467074b7952b188f681d8fecaede92b18b154a78298d0276c115026f02f02fe::gfnd {
    struct GFND has drop {
        dummy_field: bool,
    }

    fun init(arg0: GFND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GFND>(arg0, 6, b"GFND", b"GeForceNowDown", b"We're currently investigating an issue due to a spike in demand that impacts the GeForce NOW app and game launches. We will provide an update when available.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8z9ze_DIT_200x200_6fd530dd23.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GFND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GFND>>(v1);
    }

    // decompiled from Move bytecode v6
}

