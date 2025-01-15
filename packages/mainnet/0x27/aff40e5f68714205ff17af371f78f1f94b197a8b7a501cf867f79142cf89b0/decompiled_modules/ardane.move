module 0x27aff40e5f68714205ff17af371f78f1f94b197a8b7a501cf867f79142cf89b0::ardane {
    struct ARDANE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARDANE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ARDANE>(arg0, 6, b"ARDANE", b"Ardane AI asistant by SuiAI", b"Ardane is a visionary AI assistant, blending advanced intelligence with seamless digital integration.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/waf_a98d7bff02.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ARDANE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARDANE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

