module 0x9385dd400c1e8445147bc590fab1a3b77488b44da254a96f342241fd88d9345::suiloo {
    struct SUILOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILOO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUILOO>(arg0, 6, b"SUILOO", b"sui100 by SuiAI", x"4669727374204149206f6e2073756920706f776572656420627920446565705365656b2d52312ef09f94b8747261636b696e67207375692065636f73797374656d2ef09f94b87265616c2074696d6520746f6b656e20707269636520757064617465732ef09f94b8746563686e6963616c20616e616c79736973202ef09f94b86c617465737420737569206e65777320616e642075706461746573", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/g_Muo4_A0_X_400x400_c02e1a6cce.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUILOO>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILOO>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

