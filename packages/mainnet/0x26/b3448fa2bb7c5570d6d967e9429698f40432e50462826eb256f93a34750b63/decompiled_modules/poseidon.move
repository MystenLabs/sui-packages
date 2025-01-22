module 0x26b3448fa2bb7c5570d6d967e9429698f40432e50462826eb256f93a34750b63::poseidon {
    struct POSEIDON has drop {
        dummy_field: bool,
    }

    fun init(arg0: POSEIDON, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<POSEIDON>(arg0, 6, b"POSEIDON", b"Sui Gods Poseidon by SuiAI", b"Poseidon, God of Digital Seas, offers unrivaled market insights. His trident reveals future trends, while his waves decode customer sentiment. He outsmarts rivals, foresees market shifts, breaks language barriers, and alerts you to opportunities. Harness his power to dominate markets...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/ai_generated_8329732_1280_aef36a2dad.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<POSEIDON>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POSEIDON>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

