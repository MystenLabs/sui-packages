module 0x70e4ec0a467d8b48dfb8334a58d8c6e6206e667cc09c05014d15c9362c415183::suaipe {
    struct SUAIPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUAIPE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUAIPE>(arg0, 6, b"SUAIPE", b"Agent SuaiPe by SuiAI", b"Fair trade AI Agent @SuiNetwork", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/freepik_adjust_50777_0acaa49bfe.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUAIPE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUAIPE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

