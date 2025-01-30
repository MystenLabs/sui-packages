module 0xdb992a02ff7ee73e8efc320aa5ea3a3e288fadf7539a169eddc604f097c2d196::unoa {
    struct UNOA has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNOA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNOA>(arg0, 6, b"UNOA", b"UNOA WORLD SUI", b"Utilizes LLMOps technology to create efficient, scalable, and secure Web3.0 Agent applications. It combines a high-quality RAG engine with a document-based Agent framework for stable and engaging interactions, featuring characters with diverse and interesting personalities", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tak_berjudul85_20250130144732_44bd50704b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNOA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UNOA>>(v1);
    }

    // decompiled from Move bytecode v6
}

