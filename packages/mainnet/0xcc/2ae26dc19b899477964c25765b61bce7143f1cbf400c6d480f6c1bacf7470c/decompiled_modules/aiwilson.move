module 0xcc2ae26dc19b899477964c25765b61bce7143f1cbf400c6d480f6c1bacf7470c::aiwilson {
    struct AIWILSON has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIWILSON, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AIWILSON>(arg0, 6, b"AIWILSON", b"Wilson by SuiAI", b"Wilson meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/wilson_f11372e5b3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AIWILSON>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIWILSON>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

