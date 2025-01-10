module 0xc73c926bd6380666babaf3d8d49b45a06ebf9e7047afb9262e0f8eb05b43e07d::eeefee {
    struct EEEFEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: EEEFEE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<EEEFEE>(arg0, 6, b"EEEFEE", b"EEEFEE by SuiAI", b"EEEFEE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/suai_logo_e6238a53b5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EEEFEE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EEEFEE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

