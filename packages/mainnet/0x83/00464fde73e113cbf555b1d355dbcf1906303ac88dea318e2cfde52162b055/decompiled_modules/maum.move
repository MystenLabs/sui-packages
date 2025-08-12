module 0x8300464fde73e113cbf555b1d355dbcf1906303ac88dea318e2cfde52162b055::maum {
    struct MAUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAUM, arg1: &mut 0x2::tx_context::TxContext) {
        0x5be3b953994a26e01d28a9bcb6b943f102222ca0a9e265d21e4946915c335d8e::mtoken::create_coin<MAUM>(arg0, 9, b"MAUM", b"MAUM", b"MAUM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://app.matrixdock.com/images/xaum/xaum-64x64-icon.png")), true, 0, arg1);
    }

    // decompiled from Move bytecode v6
}

