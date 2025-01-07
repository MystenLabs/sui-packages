module 0x7fb934f1bb2bfe9e1d54e8d005db8bf615a2e679822489685d6713554038b20::pepsui {
    struct PEPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPSUI>(arg0, 6, b"Pepsui", b"pepsui", b"Fuel your crypto journey with pepsui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/R_Qb_Ws_K7_P_400x400_143d2b744e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

