module 0xc4fcfed7755df7e93897db08663f6ca813ca09a9f259e82651eb9b9ffee6e1dc::stroks {
    struct STROKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: STROKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STROKS>(arg0, 6, b"STROKS", b"SuiStroks", b"Knock your wings up for the winds of change", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241003_025532_08923e125c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STROKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STROKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

