module 0x9d33d6b4cc0971a6e06b01a4699e4e5f1ca10a4370c64c363f11eb64f7feef5e::diggs {
    struct DIGGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIGGS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DIGGS>(arg0, 6, b"DIGGS", b"Diggs Algo by SuiAI", b"Diggs Algo is an AI-powered financial and sports betting assistant, providing expert market insights, technical analysis, and sharp betting picks. Whether you're trading stocks, analyzing crypto, or locking in your next parlay, Diggs delivers real-time data-driven decisions'", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/image0_1_9e86a05be6.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DIGGS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIGGS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

