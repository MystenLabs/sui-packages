module 0xc52d14e163489594089e1e48a5364b5dec3fda6f17aef34e28f0782a6b5a791c::suaipe {
    struct SUAIPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUAIPE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUAIPE>(arg0, 6, b"SUAIPE", b"Agent SuaiPe by SuiAI", b"Fair Trade AI Agent", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Suai_Pe2_8525cff7c5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUAIPE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUAIPE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

