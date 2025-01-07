module 0x4e865e633d9737526029fda385dc780ce3d319dc45fbad755f7ce1d1ac32a890::suidog {
    struct SUIDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDOG>(arg0, 6, b"SUIDOG", b"THE SUIDOG", b"SUIDOG ZONE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_b88766a8a6_2c86449a6f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

