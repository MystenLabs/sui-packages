module 0xd2fe428ecdf95586ed98ffb1fb9055237bfb3ad1cccfab71074fd1b391caf69a::suirf {
    struct SUIRF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRF>(arg0, 6, b"SUIRF", b"Suirf", b"Oh Fuck", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Suirf_15e70510b0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRF>>(v1);
    }

    // decompiled from Move bytecode v6
}

