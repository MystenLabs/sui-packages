module 0xfa325fac9c1f032442d77d886dad5471fac11526193213f1be807294f1c68b8c::blacksonicething {
    struct BLACKSONICETHING has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLACKSONICETHING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLACKSONICETHING>(arg0, 6, b"BLACKSONICEThing", b"blacksonicETH", b"blacksnonic", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiaxvqfbxdc6vxtxggokczgnehoutav5udnika3weqe53ai2qng5da")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLACKSONICETHING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLACKSONICETHING>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

