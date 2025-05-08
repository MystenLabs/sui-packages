module 0x38bc7cbb7d2f478427fbc495408910ee733a4e3b8050936aec75acb9b8f42dfc::sola {
    struct SOLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOLA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SOLA>(arg0, 6, b"SOLA", b"Sola by SuiAI", x"534f4c4120697320746865206e6578742d67656e20636f696e206f6e205375692c20706f776572696e6720612032342f37207669727475616c2069646f6c206c69766573747265616d696e67206f6e20596f755475626520e28094207768657265204149206d65657473206e6f6e2d73746f7020656e7465727461696e6d656e7420696e20746865206865617274206f662057656233", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/sola_3ecbf3b5dc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SOLA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOLA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

