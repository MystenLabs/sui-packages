module 0x25a82954ce791edcfe94070246f81c4a514fb0ed9018e6cbe7afab5d8b510a7c::aaaaa {
    struct AAAAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAAA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AAAAA>(arg0, 6, b"AAAAA", b"AAAAAAAA by SuiAI", b"AAAAAAAA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/logo_color_500x500png_2_53af501293.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AAAAA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAAA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

