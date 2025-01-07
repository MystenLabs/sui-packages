module 0xcca4694c8890254f874138172093e1bb768824cad74b89a7933a51e199846754::tio {
    struct TIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TIO>(arg0, 6, b"TIO", b"TIODAO Fun by SuiAI", b"A new era of Community Driving ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_3093_8ee65a83c4.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TIO>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIO>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

