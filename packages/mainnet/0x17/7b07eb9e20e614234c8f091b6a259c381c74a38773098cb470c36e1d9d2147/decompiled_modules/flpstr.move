module 0x177b07eb9e20e614234c8f091b6a259c381c74a38773098cb470c36e1d9d2147::flpstr {
    struct FLPSTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLPSTR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<FLPSTR>(arg0, 6, b"FLPSTR", b"FLPSTR by SuiAI", b"FLPSTR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Screenshot_20250111_005941_73fc5f9362.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FLPSTR>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLPSTR>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

