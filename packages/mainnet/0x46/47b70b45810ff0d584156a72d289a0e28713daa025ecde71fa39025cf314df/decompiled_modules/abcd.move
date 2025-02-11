module 0x4647b70b45810ff0d584156a72d289a0e28713daa025ecde71fa39025cf314df::abcd {
    struct ABCD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABCD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ABCD>(arg0, 6, b"ABCD", b"ABCD by SuiAI", b"ABCD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/your_paragraph_text_18162522681_8405c9fc29.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ABCD>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABCD>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

