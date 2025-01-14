module 0x1c91e222b456684d830c60a84a730d4fc8de0e322e7a4225944ece31579b52a1::xgpt {
    struct XGPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: XGPT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<XGPT>(arg0, 6, b"XGPT", b"XGPT by SuiAI", x"41492d706f776572656420636f6e766572736174696f6e616c20696e7465726661636520666f7220616c6c2063727970746f207461736b7320f09f8c902054726164652c206578706c6f72652c202620616363657373206d61726b657420646174612077697468206561736520", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/RK_Hl7_VP_400x400_d9568ee548_fb1743c2f3_a0b3898efa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<XGPT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XGPT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

