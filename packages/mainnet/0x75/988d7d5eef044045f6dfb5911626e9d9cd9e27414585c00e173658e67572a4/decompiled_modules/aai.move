module 0x75988d7d5eef044045f6dfb5911626e9d9cd9e27414585c00e173658e67572a4::aai {
    struct AAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAI>(arg0, 6, b"AAi", b"Alonix Ai ", b"\"My project focuses on designing and deploying AI-driven web games utilizing machine learning algorithms, natural language processing and computer vision to create immersive, adaptive and interactive gaming experiences.\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733833591355.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

