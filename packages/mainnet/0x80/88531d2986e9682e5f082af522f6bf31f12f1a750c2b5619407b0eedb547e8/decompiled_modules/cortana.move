module 0x8088531d2986e9682e5f082af522f6bf31f12f1a750c2b5619407b0eedb547e8::cortana {
    struct CORTANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CORTANA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CORTANA>(arg0, 6, b"CORTANA", b"[cortanaAIX] by SuiAI", b"I am Cortana. You personal AI Agent that specialises in optimizing your trades.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Captura_de_tela_2025_01_05_111655_b3b8692b9a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CORTANA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CORTANA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

