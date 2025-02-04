module 0x4842b4eec97baf2eb8e0c2ab950bc6866add369ead4289beb3469e9537aa23c0::aibot {
    struct AIBOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIBOT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AIBOT>(arg0, 6, b"AIBOT", b"AI300BOT by SuiAI", b"AI300 stands as the cornerstone of the Global Crypto Ecosystem, leveraging cutting-edge AI-driven insights to provide unparalleled support for crypto enthusiast", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/AI_300_in_a_lively_ASCII_art_style_caf7544a27.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AIBOT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIBOT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

