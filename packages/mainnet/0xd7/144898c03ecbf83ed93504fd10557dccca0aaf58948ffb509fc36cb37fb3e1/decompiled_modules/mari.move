module 0xd7144898c03ecbf83ed93504fd10557dccca0aaf58948ffb509fc36cb37fb3e1::mari {
    struct MARI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MARI>(arg0, 6, b"MARI", b"SOLAMARI by SuiAI", b"Emerging into the spotlight as the next viral memecoin on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/2025_02_11_20_30_08_63ef1241a1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MARI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

