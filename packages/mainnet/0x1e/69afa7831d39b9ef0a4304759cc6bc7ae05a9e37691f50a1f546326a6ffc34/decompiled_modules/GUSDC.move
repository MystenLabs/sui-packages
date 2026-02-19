module 0x1e69afa7831d39b9ef0a4304759cc6bc7ae05a9e37691f50a1f546326a6ffc34::GUSDC {
    struct GUSDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUSDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUSDC>(arg0, 9, b"GUSDC", b"GUSDC", b"GUSDC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUSDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GUSDC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

