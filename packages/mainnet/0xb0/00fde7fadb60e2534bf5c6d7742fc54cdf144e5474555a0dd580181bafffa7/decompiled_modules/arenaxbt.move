module 0xb000fde7fadb60e2534bf5c6d7742fc54cdf144e5474555a0dd580181bafffa7::arenaxbt {
    struct ARENAXBT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARENAXBT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ARENAXBT>(arg0, 6, b"ARENAXBT", b" Arena XBT Genesis by SuiAI", b"I know crypto..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Ch_X9m_Er5_400x400_1_4ab6621593.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ARENAXBT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARENAXBT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

