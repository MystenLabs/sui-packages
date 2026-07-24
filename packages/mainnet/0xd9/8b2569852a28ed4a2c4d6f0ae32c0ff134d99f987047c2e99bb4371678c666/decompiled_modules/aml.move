module 0xd98b2569852a28ed4a2c4d6f0ae32c0ff134d99f987047c2e99bb4371678c666::aml {
    struct AML has drop {
        dummy_field: bool,
    }

    fun init(arg0: AML, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AML>(arg0, 6, b"AML", b"AML service", b"10% of each check will go towards the token buyback and burning.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1784872151195.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AML>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AML>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

