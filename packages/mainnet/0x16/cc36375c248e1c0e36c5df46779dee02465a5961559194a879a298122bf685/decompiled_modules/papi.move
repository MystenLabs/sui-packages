module 0x16cc36375c248e1c0e36c5df46779dee02465a5961559194a879a298122bf685::papi {
    struct PAPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAPI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<PAPI>(arg0, 6, b"PAPI", b"Francisco Prado by SuiAI", b"everything bright and beautiful ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/63nm46_4c95fa2616.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PAPI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAPI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

