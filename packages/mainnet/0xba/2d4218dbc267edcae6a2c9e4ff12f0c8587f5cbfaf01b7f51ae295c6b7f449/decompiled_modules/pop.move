module 0xba2d4218dbc267edcae6a2c9e4ff12f0c8587f5cbfaf01b7f51ae295c6b7f449::pop {
    struct POP has drop {
        dummy_field: bool,
    }

    fun init(arg0: POP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POP>(arg0, 6, b"POP", b"PEPOpop", b"NON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1763629030044.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

