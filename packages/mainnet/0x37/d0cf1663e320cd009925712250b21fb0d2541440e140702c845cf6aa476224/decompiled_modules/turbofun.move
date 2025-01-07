module 0x37d0cf1663e320cd009925712250b21fb0d2541440e140702c845cf6aa476224::turbofun {
    struct TURBOFUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURBOFUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURBOFUN>(arg0, 6, b"TurboFun", b"Turbo Fun", x"66756e206576657279776865726520f09f94a5", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730949496990.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TURBOFUN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURBOFUN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

