module 0x9b8a0b6367c4243e52d39acdf4c4f90d358809e19940fdb1a41e0e10909b0d25::mord {
    struct MORD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MORD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MORD>(arg0, 6, b"MORD", b"Mordulec by SuiAI", b"Web3 MAX", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000025280_92d2f61971.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MORD>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MORD>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

