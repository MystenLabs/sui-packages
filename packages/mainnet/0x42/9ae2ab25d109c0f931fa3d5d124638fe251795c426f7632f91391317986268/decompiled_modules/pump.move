module 0x429ae2ab25d109c0f931fa3d5d124638fe251795c426f7632f91391317986268::pump {
    struct PUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUMP>(arg0, 6, b"Pump", b"PumpIt", b"Just for fun! What you want??", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730949986886.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUMP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

