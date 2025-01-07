module 0xa8c34aa53023f5267237282022306f25bf2e486e9784854e61699d0458faa52e::suimars {
    struct SUIMARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMARS>(arg0, 6, b"SuiMARS", b"MARS", b"Falcon 9 in Terminus City, MARS.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1727003973921_51c3a008a3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMARS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMARS>>(v1);
    }

    // decompiled from Move bytecode v6
}

