module 0x1191a2f0525d90e3d97b35f73c9d06addb390ad3a5d04108aec20955bf607a32::tokenfe {
    struct TOKENFE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKENFE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TOKENFE>(arg0, 6, b"TOKENFE", b"TOKENFE by SuiAI", b"TOKENFE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/suai_logo_9d93e9ed25.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TOKENFE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKENFE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

