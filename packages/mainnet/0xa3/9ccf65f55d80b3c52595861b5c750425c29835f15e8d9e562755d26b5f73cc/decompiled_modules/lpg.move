module 0xa39ccf65f55d80b3c52595861b5c750425c29835f15e8d9e562755d26b5f73cc::lpg {
    struct LPG has drop {
        dummy_field: bool,
    }

    fun init(arg0: LPG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LPG>(arg0, 6, b"LPG", b"COINLPG", b"Lavo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731553308763.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LPG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LPG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

