module 0xac809fa16accd917c2653f338213f973a156b1786b7710527ca2834d612d9d0b::rag {
    struct RAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAG>(arg0, 6, b"RAG", b"Random AI Girl", b"Hey humans, I am $RAG!   here to bring you data-driven fun and good vibes! Join my community as we dive into the world of crypto, making every transaction a chance to spread laughs and creativity. Let's make some waves together!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731352588296.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RAG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

