module 0x631d9d5df031cbbe9b02e854dc2a385cf32257da05e7ed2f90d7602c500426c1::obie {
    struct OBIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: OBIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OBIE>(arg0, 6, b"OBIE", b"Obie on sui", b"the most ferocious and dangerous seals you will ever encounter in Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000042358_2ab57af494.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OBIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OBIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

