module 0xff9bc3fe1a126c4b540712bf1558c192c8f1a38b74f2649334fb6df312700b31::fltai {
    struct FLTAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLTAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<FLTAI>(arg0, 6, b"FLTAI", b"FLTAI by SuiAI", b"FLTAI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Screenshot_20250111_005941_a00934f8b2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FLTAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLTAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

