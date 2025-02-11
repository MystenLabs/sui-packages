module 0x6fa0eebc80be039c7cea9451ecd1e5c8fa2f852a893e9ce7196bdf5c8c8e03f5::pop {
    struct POP has drop {
        dummy_field: bool,
    }

    fun init(arg0: POP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<POP>(arg0, 6, b"POP", b"POP by SuiAI", b"POP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/download_1cb5519bea.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<POP>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POP>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

