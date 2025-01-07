module 0xe912979adb5766ce1755c35d50b6a4799bd96afac6420cf71fe0a000dd2b398d::ssbear {
    struct SSBEAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSBEAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSBEAR>(arg0, 6, b"SSBEAR", b"Suishootbear", b"Fun sui with bera bear", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730951921720.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SSBEAR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSBEAR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

