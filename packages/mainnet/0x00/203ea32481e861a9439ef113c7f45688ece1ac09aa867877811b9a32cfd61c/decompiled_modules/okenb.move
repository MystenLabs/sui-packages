module 0x203ea32481e861a9439ef113c7f45688ece1ac09aa867877811b9a32cfd61c::okenb {
    struct OKENB has drop {
        dummy_field: bool,
    }

    fun init(arg0: OKENB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<OKENB>(arg0, 6, b"OKENB", b"New Agent TOKENB by SuiAI", b"New Agent", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/DALL_E_2025_01_02_07_15_00_A_sleek_and_modern_logo_design_for_a_Telegram_channel_named_Solana_Frontier_Signals_with_a_focus_on_cryptocurrency_and_Solana_blockchain_aa5494a278.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<OKENB>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OKENB>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

