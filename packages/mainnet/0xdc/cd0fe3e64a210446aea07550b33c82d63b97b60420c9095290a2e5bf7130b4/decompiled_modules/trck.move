module 0xdccd0fe3e64a210446aea07550b33c82d63b97b60420c9095290a2e5bf7130b4::trck {
    struct TRCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRCK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TRCK>(arg0, 6, b"TRCK", b"TRUMP TRACKER by SuiAI", b"Trump Tracker..An advanced AI agent designed to monitor and analyze cryptocurrency wallet activities linked to Donald Trump. It provides real-time updates, detailed transaction insights, and market impact analysis, ensuring comprehensive blockchain transparency.  ..With features like custom alerts, data visualization, and 24/7 monitoring, Trump Tracker is the ultimate tool for tracking crypto activity with precision and clarity.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Captura_de_tela_2025_01_19_160251_9f89c1c34f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TRCK>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRCK>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

