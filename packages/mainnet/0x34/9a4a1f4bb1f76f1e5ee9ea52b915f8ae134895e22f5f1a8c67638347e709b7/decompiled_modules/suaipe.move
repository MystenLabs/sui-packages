module 0x349a4a1f4bb1f76f1e5ee9ea52b915f8ae134895e22f5f1a8c67638347e709b7::suaipe {
    struct SUAIPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUAIPE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUAIPE>(arg0, 6, b"SUAIPE", b"Agent SuaiPe by SuiAI", b"Fair Trade AI Agent @SuiNetwork", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Suai_Pe2_c8a5efb81e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUAIPE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUAIPE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

