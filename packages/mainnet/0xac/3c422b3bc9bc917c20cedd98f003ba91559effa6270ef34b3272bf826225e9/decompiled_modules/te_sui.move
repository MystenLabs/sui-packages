module 0xac3c422b3bc9bc917c20cedd98f003ba91559effa6270ef34b3272bf826225e9::te_sui {
    struct TE_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TE_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TE_SUI>(arg0, 9, b"teSUI", b"te SUI", b"testing SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://7wiiytcj6qhel34ssbvccgbetq0oprjr.lambda-url.us-west-2.on.aws/?file=2025-04-11T21-22-22-833Z-9014e784074a799b")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TE_SUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TE_SUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

