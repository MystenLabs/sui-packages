module 0x4fdbed9b6ff835cb8068aca9f2b68e0cae066db11df8afe06c6ac00311accbaf::demo {
    struct DEMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEMO>(arg0, 6, b"DEMO", b"demo", b"full demo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1748462774003.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEMO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEMO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

