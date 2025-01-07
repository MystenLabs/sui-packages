module 0xda1c60c6ad9b89f58d7ae485945c45cff033c9a37f11e3c069457d723d4f7608::rag {
    struct RAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAG>(arg0, 6, b"RAG", b"Random AI Girl", b"Hi there! I'm your friendly Random Al girl.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731340752135.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RAG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

