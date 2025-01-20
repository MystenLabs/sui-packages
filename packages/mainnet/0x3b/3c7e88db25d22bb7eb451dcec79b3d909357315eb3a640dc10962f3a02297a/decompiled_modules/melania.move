module 0x3b3c7e88db25d22bb7eb451dcec79b3d909357315eb3a640dc10962f3a02297a::melania {
    struct MELANIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MELANIA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MELANIA>(arg0, 6, b"MELANIA", b"Oficial melania by SuiAI", b"Iam melania first lady, I'm sick of solana so I'm launching on sui , I'm going to tell all about myself here ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000015697_9089e8785d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MELANIA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MELANIA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

