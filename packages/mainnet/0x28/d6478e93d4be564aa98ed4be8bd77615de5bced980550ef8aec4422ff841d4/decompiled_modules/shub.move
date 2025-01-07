module 0x28d6478e93d4be564aa98ed4be8bd77615de5bced980550ef8aec4422ff841d4::shub {
    struct SHUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHUB>(arg0, 6, b"SHUB", b"SUIHub", b"Sui's own hub!We decide what we want to see.LETS PUMP.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_a_c_20240930142845_02ad98a059.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

