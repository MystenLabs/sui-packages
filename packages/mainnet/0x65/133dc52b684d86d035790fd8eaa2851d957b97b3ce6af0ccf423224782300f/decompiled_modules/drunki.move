module 0x65133dc52b684d86d035790fd8eaa2851d957b97b3ce6af0ccf423224782300f::drunki {
    struct DRUNKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRUNKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRUNKI>(arg0, 6, b"DRUNKI", b"Drunki On SUI", b"Meet Drunki a drunk degen on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_4_c7d6203e47.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRUNKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRUNKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

