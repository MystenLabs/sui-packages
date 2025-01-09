module 0x8a954c0c5159f8d91a2b94cfa2d82536e099c4d13b3cbc01051faa2895c8b814::minke {
    struct MINKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINKE>(arg0, 6, b"MINKE", b"Minke", b"Minke Swap is a powerful trade aggregator designed to help users secure the best trading rates by seamlessly connecting to multiple decentralized exchanges within the Sui ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736386998750.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MINKE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINKE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

