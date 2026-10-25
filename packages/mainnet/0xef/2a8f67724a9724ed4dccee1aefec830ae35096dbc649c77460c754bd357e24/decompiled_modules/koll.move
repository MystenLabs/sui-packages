module 0xef2a8f67724a9724ed4dccee1aefec830ae35096dbc649c77460c754bd357e24::koll {
    struct KOLL has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOLL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<KOLL>(arg0, 9, 0x1::string::utf8(b"KOLL"), 0x1::string::utf8(b"kol"), 0x1::string::utf8(b"kol (KOLL)"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOLL>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<KOLL>>(0x2::coin_registry::finalize<KOLL>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

