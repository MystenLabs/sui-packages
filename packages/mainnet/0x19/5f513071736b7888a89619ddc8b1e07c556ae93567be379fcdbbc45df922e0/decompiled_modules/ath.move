module 0x195f513071736b7888a89619ddc8b1e07c556ae93567be379fcdbbc45df922e0::ath {
    struct ATH has drop {
        dummy_field: bool,
    }

    fun init(arg0: ATH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ATH>(arg0, 6, b"ATH", b"SuiAIBackToATH", b"@SuiAIFun @suilaunchcoin @SuiNetwork @SuiFoundation @aixdg_agent @tokeninsight_io @suilaunchcoin $ATH + SuiAIBackToATH https://t.co/C6YUvi8Rt7", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/ath-q4ren9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ATH>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ATH>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

