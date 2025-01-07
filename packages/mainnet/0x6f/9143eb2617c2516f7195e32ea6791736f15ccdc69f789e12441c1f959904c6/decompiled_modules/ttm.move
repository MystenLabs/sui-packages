module 0x6f9143eb2617c2516f7195e32ea6791736f15ccdc69f789e12441c1f959904c6::ttm {
    struct TTM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TTM>(arg0, 6, b"TTM", b"Totem AI", b"A sacred gateway to forge your own sovereign spirit & cosmic dashboard. Access ancient wisdom, quantum communities, and infinite realms.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735022699988.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TTM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

