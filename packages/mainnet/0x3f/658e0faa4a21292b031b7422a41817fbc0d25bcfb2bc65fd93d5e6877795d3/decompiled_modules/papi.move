module 0x3f658e0faa4a21292b031b7422a41817fbc0d25bcfb2bc65fd93d5e6877795d3::papi {
    struct PAPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAPI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<PAPI>(arg0, 6, b"PAPI", b"Francisco Prado by SuiAI", b"everything bright and beautiful ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/63nm46_52225bedb6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PAPI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAPI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

