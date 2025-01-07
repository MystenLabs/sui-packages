module 0x9d0900fd4974bb355b4dcf1c8ff375772f3e5381a6ebb240c88381614b9d9e98::forest {
    struct FOREST has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOREST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOREST>(arg0, 6, b"FOREST", b"AI Interactive Forest", b"A mystical AI-powered realm with challenges to unlock the secrets of the SUI blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/c2_72b2d497e4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOREST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOREST>>(v1);
    }

    // decompiled from Move bytecode v6
}

