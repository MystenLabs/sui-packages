module 0xd5318a264f1404edc8c9ce5d8c02cad18f13620f6e5eebfbde69e498a7598c56::trumpo {
    struct TRUMPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPO>(arg0, 6, b"TRUMPO", b"EL PRESIDENTO TRUMPO", x"53747261696768742066726f6d207468652048656172746f206f6620494c20475245415445535420505245534944454e544f20544841542045564552204c495645440a49542753204d4520454c2050415049205452554d504f0a425559204e4f57204f5220435259204c41544552200a494e5354414752414d2c2054454c454752414d20592057454253495445204146544552203530304b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731598647167.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

