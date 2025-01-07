module 0x326868875d5580e3f66a7e202c26cccc410750e7c004e6a5e4aa7897c170b070::diddy {
    struct DIDDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIDDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIDDY>(arg0, 6, b"DIDDY", x"5365616e20e2809c4469646479e2809d", b"Nice Try, Diddy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730951020101.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DIDDY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIDDY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

