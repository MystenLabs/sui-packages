module 0x485001d594deee1d18e1d0d18d6e2169cb82d25508dc2f9c41cf709565a77526::fuddie {
    struct FUDDIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUDDIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUDDIE>(arg0, 6, b"Fuddie", b"Fuddies", b"Extra special owls means an extra special community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3a89ff90adc8d50ccbdeac61ac4a2223_bbe5c739aa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUDDIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUDDIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

