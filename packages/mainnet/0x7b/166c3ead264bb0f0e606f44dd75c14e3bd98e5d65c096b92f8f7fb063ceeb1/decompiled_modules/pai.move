module 0x7b166c3ead264bb0f0e606f44dd75c14e3bd98e5d65c096b92f8f7fb063ceeb1::pai {
    struct PAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<PAI>(arg0, 6, b"PAI", b"PERFORMANCE AI by SuiAI", b"PAI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/20250110_233340_e1f8bd1751.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

