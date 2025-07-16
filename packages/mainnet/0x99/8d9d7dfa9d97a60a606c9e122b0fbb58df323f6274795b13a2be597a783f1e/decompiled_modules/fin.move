module 0x998d9d7dfa9d97a60a606c9e122b0fbb58df323f6274795b13a2be597a783f1e::fin {
    struct FIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIN>(arg0, 6, b"FIN", b"FIN GURU", b"Fin guru Agent Provide the latest updates and insights on financial news, trends, and market analysis.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeieo3uxdo7f7wsgmja3rkq73a4kkt76uuvmlwyrbbu7z3j3evyalau")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

