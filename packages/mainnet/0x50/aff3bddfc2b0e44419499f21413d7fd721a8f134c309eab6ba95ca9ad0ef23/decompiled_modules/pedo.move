module 0x50aff3bddfc2b0e44419499f21413d7fd721a8f134c309eab6ba95ca9ad0ef23::pedo {
    struct PEDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEDO>(arg0, 6, b"PEDO", b"PEDOBEAR", b"PEDOBEAR UN SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000193733_83b924c725.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEDO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEDO>>(v1);
    }

    // decompiled from Move bytecode v6
}

