module 0x380f25a497f7e6764fd6d1369e54226a7ec994ae38cbc42162f1894d107a7b25::drunki {
    struct DRUNKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRUNKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRUNKI>(arg0, 6, b"DRUNKI", b"Drunki On SUI", b"Meet Drunki a drunk degen on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_4_e917dc8cec.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRUNKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRUNKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

