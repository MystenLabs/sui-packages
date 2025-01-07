module 0xa52c006263b2f4c9ed7b7038553e3f4ce6c3c3717d7946966a5b6d3e6c0fcf6b::pumbaa {
    struct PUMBAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMBAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUMBAA>(arg0, 6, b"PUMBAA", b"PumbaaSui", b"Pumbaa - Pump the fun on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241004_105654_ce886e720c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMBAA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUMBAA>>(v1);
    }

    // decompiled from Move bytecode v6
}

