module 0xa1167c5b8287730a3cf5d94270683eb31b9ac6492b068bef2a3f6d1252e11db6::testsymbol {
    struct TESTSYMBOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTSYMBOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTSYMBOL>(arg0, 6, b"Testsymbol", b"NC", b"This is test token..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1748521779365.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TESTSYMBOL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTSYMBOL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

