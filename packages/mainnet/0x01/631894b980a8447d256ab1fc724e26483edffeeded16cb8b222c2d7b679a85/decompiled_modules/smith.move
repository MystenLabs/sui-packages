module 0x1631894b980a8447d256ab1fc724e26483edffeeded16cb8b222c2d7b679a85::smith {
    struct SMITH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMITH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SMITH>(arg0, 6, b"SMITH", b"Agent Smith by SuiAI", b"Agent Smith is always watching you.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Agent_Smith_The_Matrix_series_character_25a5ee2a64.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SMITH>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMITH>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

