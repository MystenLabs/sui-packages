module 0x98858f27d3e1b6ff3c90afa8f26715573bd2773a086ec3a83b50e6269665f930::helaa {
    struct HELAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HELAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HELAA>(arg0, 9, b"HELAA", b"helgos911", b"helgos nft", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/748b3182c2037d81c5caf9f56278f6f1blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HELAA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HELAA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

