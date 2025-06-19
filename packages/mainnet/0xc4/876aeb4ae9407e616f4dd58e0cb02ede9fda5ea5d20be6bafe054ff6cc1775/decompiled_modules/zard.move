module 0xc4876aeb4ae9407e616f4dd58e0cb02ede9fda5ea5d20be6bafe054ff6cc1775::zard {
    struct ZARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZARD>(arg0, 6, b"ZARD", b"charizard", b"If this bonds i will update all and send it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihmpju26fsiy4ew4gk57fajdxhhulkk7zo4djyj6y7x3fzr5oyjny")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ZARD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

