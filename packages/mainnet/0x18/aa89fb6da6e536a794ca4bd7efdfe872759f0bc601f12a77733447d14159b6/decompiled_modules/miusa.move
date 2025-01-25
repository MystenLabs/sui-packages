module 0x18aa89fb6da6e536a794ca4bd7efdfe872759f0bc601f12a77733447d14159b6::miusa {
    struct MIUSA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIUSA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MIUSA>(arg0, 6, b"MIUSA", b"Made in America by SuiAI", b"Made in USA is back and is again a strong sign and a symbol of quality", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/made_in_america_1b80d608e7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MIUSA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIUSA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

