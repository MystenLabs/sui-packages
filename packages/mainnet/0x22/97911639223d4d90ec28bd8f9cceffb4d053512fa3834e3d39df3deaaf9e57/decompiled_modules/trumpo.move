module 0x2297911639223d4d90ec28bd8f9cceffb4d053512fa3834e3d39df3deaaf9e57::trumpo {
    struct TRUMPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPO>(arg0, 6, b"TRUMPO", b"EL PAPI TRUMPO", x"53747261696768742066726f6d207468652048656172746f206f6620494c20475245415445535420505245534944454e544f20544841542045564552204c49564544200a4255594e4f57204f5220435259204c41544552200a54454c454752414d20414e442057454253495445204146544552203530306b0a464f5220434f4c4c41424f524154494f4e2053454e44204d455353414745204f4e205457495454455220", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731598218610.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

