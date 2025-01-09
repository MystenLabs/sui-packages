module 0x9a0789a267233cfab6c6c68f431da2c5cfd586dc917ff4fd91c4f9d9b61481e::suai {
    struct SUAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUAI>(arg0, 6, b"TEST", b"TEST", b"TEST", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/suai_logo.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUAI>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUAI>>(v0);
    }

    // decompiled from Move bytecode v6
}

