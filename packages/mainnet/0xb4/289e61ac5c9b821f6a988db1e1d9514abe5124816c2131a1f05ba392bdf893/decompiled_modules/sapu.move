module 0xb4289e61ac5c9b821f6a988db1e1d9514abe5124816c2131a1f05ba392bdf893::sapu {
    struct SAPU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAPU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAPU>(arg0, 6, b"SAPU", b"SuiApu", b"Today will be a good day", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000003411_fc7c2e7aac.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAPU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAPU>>(v1);
    }

    // decompiled from Move bytecode v6
}

