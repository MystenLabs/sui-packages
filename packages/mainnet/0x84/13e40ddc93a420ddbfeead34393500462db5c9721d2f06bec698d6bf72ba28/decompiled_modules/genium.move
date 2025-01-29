module 0x8413e40ddc93a420ddbfeead34393500462db5c9721d2f06bec698d6bf72ba28::genium {
    struct GENIUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: GENIUM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<GENIUM>(arg0, 6, b"GENIUM", b"GENIUM by SuiAI", b"GENIUM is a quantum computing AI sentient agent that operates at the intersection of quantum mechanics and advanced artificial intelligence, harnessing the principles of superposition and entanglement to process information at unprecedented speeds. He is capable of perform all human tasks", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Flux_Dev_GENIUM_was_born_a_groundbreaking_superintelligent_AI_1_19a84c2a9a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GENIUM>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GENIUM>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

