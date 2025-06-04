module 0x278ddc838ca2f68233d0a7e667ccd9f6d80b5ab970c0b94bd1ebfb1fd4e7dffd::snowparty {
    struct SNOWPARTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNOWPARTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNOWPARTY>(arg0, 6, b"SNOWPARTY", b"Snow Party", b"Snow", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigt3yzsid7aql7a57btj6al2m5y2kcuf4jvfrholkoalggm7ehoau")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNOWPARTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SNOWPARTY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

