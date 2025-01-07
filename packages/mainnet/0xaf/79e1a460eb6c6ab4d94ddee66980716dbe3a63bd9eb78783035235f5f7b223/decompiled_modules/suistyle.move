module 0xaf79e1a460eb6c6ab4d94ddee66980716dbe3a63bd9eb78783035235f5f7b223::suistyle {
    struct SUISTYLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISTYLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISTYLE>(arg0, 6, b"SUISTYLE", b"SUI - STYLE", b"The SUI-STYLE...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUISTYLE_51903a6dba.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISTYLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISTYLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

