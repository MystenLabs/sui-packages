module 0x4207a967315cd8d8ff26fdd99596071fc27e258851d14a5d50ef31894d403701::suicapsul {
    struct SUICAPSUL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICAPSUL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICAPSUL>(arg0, 6, b"Suicapsul", b"SUI CAPSULE ", b"Buy more suicapsul to protect yourself from financial problem ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730975158545.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUICAPSUL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICAPSUL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

