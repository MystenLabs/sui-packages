module 0x724e7e617c14a28ff9bf695c085b97be96ffdc7102794987d017e650d98d091e::agent {
    struct AGENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGENT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AGENT>(arg0, 6, b"AGENT", b"Create New Agent by SuiAI", b"Create New Agent.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/DALL_E_2025_01_02_07_15_00_A_sleek_and_modern_logo_design_for_a_Telegram_channel_named_Solana_Frontier_Signals_with_a_focus_on_cryptocurrency_and_Solana_blockchain_8ad96faf60.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AGENT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGENT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

