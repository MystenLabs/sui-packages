module 0x4e57cf0fd73647d44d2191fbb3028176893c07388d9472df07124fe7f72c0a66::sail_token {
    struct SAIL_TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAIL_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAIL_TOKEN>(arg0, 6, b"SAIL", b"FullSail", b"FullSail Governance Token with ve(4,4) capabilities", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAIL_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAIL_TOKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

