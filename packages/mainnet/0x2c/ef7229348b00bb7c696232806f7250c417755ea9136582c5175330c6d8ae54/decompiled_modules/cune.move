module 0x2cef7229348b00bb7c696232806f7250c417755ea9136582c5175330c6d8ae54::cune {
    struct CUNE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUNE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUNE>(arg0, 6, b"CUNE", b"SuiCune", b"Plan on the bonded paid dexscanner ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004702_db98483be4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUNE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CUNE>>(v1);
    }

    // decompiled from Move bytecode v6
}

