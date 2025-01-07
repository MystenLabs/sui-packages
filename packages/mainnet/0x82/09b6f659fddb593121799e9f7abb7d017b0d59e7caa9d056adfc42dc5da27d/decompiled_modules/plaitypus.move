module 0x8209b6f659fddb593121799e9f7abb7d017b0d59e7caa9d056adfc42dc5da27d::plaitypus {
    struct PLAITYPUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLAITYPUS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<PLAITYPUS>(arg0, 6, b"PLAITYPUS", b"Plaitypus", b".", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000016477_7edf24b197.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PLAITYPUS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLAITYPUS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

