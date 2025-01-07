module 0xbf0dd8c7250e85b8333bcbd7e36b82af7465a8bb80ba88217920f9db8e60e79::rickroll {
    struct RICKROLL has drop {
        dummy_field: bool,
    }

    fun init(arg0: RICKROLL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<RICKROLL>(arg0, 6, b"RICKROLL", b"Rickroll", b"You got rickrolled mint it now ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/rick_4f2fdfe93c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RICKROLL>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RICKROLL>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

