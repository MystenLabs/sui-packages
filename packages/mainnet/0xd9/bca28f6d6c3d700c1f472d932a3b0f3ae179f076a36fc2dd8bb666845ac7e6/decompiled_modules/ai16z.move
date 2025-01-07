module 0xd9bca28f6d6c3d700c1f472d932a3b0f3ae179f076a36fc2dd8bb666845ac7e6::ai16z {
    struct AI16Z has drop {
        dummy_field: bool,
    }

    fun init(arg0: AI16Z, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AI16Z>(arg0, 6, b"AI16Z", b"Ai16zAgent", b"AI token from A16Z community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pub-efea87dea3f94e8084e073588c980c50.r2.dev/logo/01JBTVBW2PNR6DR2C0PJ8K8R0C/01JBTZAXRK4VCJPGBK01FT4QWW")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AI16Z>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AI16Z>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

