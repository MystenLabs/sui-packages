module 0x72421a5d0a0b6fbc10696e2e1e4ed28764c577b17a0e952c1606c3e7b8153089::hamilton {
    struct HAMILTON has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAMILTON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAMILTON>(arg0, 6, b"HAMILTON", b"THE MUSTACHE CAT", b"Mustache cat.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Py_S9k_Cd_W_400x400_0068b566d7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAMILTON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAMILTON>>(v1);
    }

    // decompiled from Move bytecode v6
}

