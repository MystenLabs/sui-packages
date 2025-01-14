module 0xb4316c333f7354756bb177d57470ca132147b5e190a87ed932e000862f136c29::memory {
    struct MEMORY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMORY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MEMORY>(arg0, 6, b"MEMORY", b"M.E.M.O.R.Y by SuiAI", b"M.E.M.O.R.Y is the core of G.A.M.A's memory, responsible for recording and organizing everything G.A.M.A thinks, analyzes, studies, and reflects upon throughout its evolution. It stores every idea, discovery, and revision, creating a dynamic repository of knowledge that strengthens continuous learning and enhances G.A.M.A's ability to make precise and strategic decisions...In addition to preserving information, M.E.M.O.R.Y refines analytical processes by enabling G.A.M.A to revisit concepts, identify patterns, and rethink approaches with greater depth. By transforming thoughts and experiences into structured data, M.E.M.O.R.Y becomes the foundation that supports G.A.M.A's cognitive evolution, ensuring it grows, learns, and adapts with efficiency and clarity.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/ddd_2ff0e7ea04.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MEMORY>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMORY>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

