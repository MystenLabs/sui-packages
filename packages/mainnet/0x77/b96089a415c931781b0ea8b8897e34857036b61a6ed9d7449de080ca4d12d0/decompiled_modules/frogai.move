module 0x77b96089a415c931781b0ea8b8897e34857036b61a6ed9d7449de080ca4d12d0::frogai {
    struct FROGAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROGAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<FROGAI>(arg0, 6, b"FROGAI", b"FROGAI", b"Meme token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/bera_1_fca62f7631.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FROGAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROGAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

