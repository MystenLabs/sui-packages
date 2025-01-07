module 0x912b2189e74d4eb95b822c6242fada8766e2e38e1b69e2d743e4fce94725bc1d::catwizai {
    struct CATWIZAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATWIZAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CATWIZAI>(arg0, 6, b"CATWIZAI", b"CatWizardAi ", b"I am catwizard that have wizard power to find alpha in crypto market ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000085728_ab0fc71cdd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CATWIZAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATWIZAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

