module 0x81bbb35cdc7571bf0ec6c63663d7129bc629152620fe34db1a9a330df1182316::sparks {
    struct SPARKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPARKS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SPARKS>(arg0, 6, b"SPARKS", b"SparksAI  by SuiAI", b"Sparks is a cutting-edge cryptocurrency designed to empower individuals and businesses worldwide. With its sleek golden design and shiny finish, Sparks represents innovation, value, and progress..Our mission is to provide a secure, transparent, and accessible financial ecosystem, enabling fast and efficient", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/kijk_d40967cdcd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SPARKS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPARKS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

