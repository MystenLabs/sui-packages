module 0xd7302e2484996fad72b2385ba74838cf527e3a5fa0198b795ca14185c6e91981::suirf {
    struct SUIRF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRF>(arg0, 6, b"SUIRF", b"Sui Surfer", b"Riding the Sui-Wave ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_c2f0116876.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRF>>(v1);
    }

    // decompiled from Move bytecode v6
}

