module 0xa829aeb45b7981b523d4047ba8348317724808c09804f778c4b996eb3091c1a0::pump_pump_ {
    struct PUMP_PUMP_ has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMP_PUMP_, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUMP_PUMP_>(arg0, 9, b"PUMP PUMP", b"SUI PUMP", b"PUMP THIS TO THE MOON!!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PUMP_PUMP_>(&mut v2, 3000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMP_PUMP_>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUMP_PUMP_>>(v1);
    }

    // decompiled from Move bytecode v6
}

