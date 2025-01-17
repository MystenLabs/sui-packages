module 0x4c1aac0bf12ce66326f3fad878036e685b359b7d7333bdabf89f1545bdf0e5f9::snipee {
    struct SNIPEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNIPEE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SNIPEE>(arg0, 6, b"SNIPEE", b"snipee by SuiAI", b"HEHE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/pepe_9fdb441949.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SNIPEE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNIPEE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

