module 0x9718dad9a9c6f1762b33c9b7b588aeb66679e1adc497e205066bb025ce959033::wally {
    struct WALLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WALLY>(arg0, 6, b"WALLY", b"Emotional Support Alligator", b"Wally, the famous Emotional Support Alligator, first captured headlines when he was rescued from an alligator-infested pond at Disney World, and later became recognized as the worlds first registered Emotional Support alligator.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x4f7d2d728ce137dd01ec63ef7b225805c7b54575_7ffd5d882d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WALLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WALLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

