module 0x5ccbc590a850c0d0a24750ce5abbcd165986f0d19da03948abe560016ca995d6::akkid {
    struct AKKID has drop {
        dummy_field: bool,
    }

    fun init(arg0: AKKID, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AKKID>(arg0, 6, b"AKKID", b"AKIA by SuiAI", b"AKSKSK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Root_0e0ef914ba.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AKKID>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AKKID>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

