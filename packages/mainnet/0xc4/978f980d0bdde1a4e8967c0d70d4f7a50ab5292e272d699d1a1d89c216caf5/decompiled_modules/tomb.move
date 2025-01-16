module 0xc4978f980d0bdde1a4e8967c0d70d4f7a50ab5292e272d699d1a1d89c216caf5::tomb {
    struct TOMB has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOMB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOMB>(arg0, 6, b"TOMB", b"Tomb", b"Our advanced AI system analyzes countless variables to predict your final moment with unprecedented accuracy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_pump_84c8f3d099.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOMB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOMB>>(v1);
    }

    // decompiled from Move bytecode v6
}

