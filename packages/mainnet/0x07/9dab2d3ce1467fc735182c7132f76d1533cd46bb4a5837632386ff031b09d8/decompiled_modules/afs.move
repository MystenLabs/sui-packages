module 0x79dab2d3ce1467fc735182c7132f76d1533cd46bb4a5837632386ff031b09d8::afs {
    struct AFS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AFS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AFS>(arg0, 6, b"AFS", b"arf by SuiAI", b"tytt", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/ai_dd4c8de925.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AFS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AFS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

