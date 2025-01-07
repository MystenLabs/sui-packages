module 0xbc8f9072df2e7b6d64f3052c0ae5dea8b3ebca0e45e275eff473c6f53259cfcc::ltr {
    struct LTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: LTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LTR>(arg0, 6, b"LTR", b"Louie the Raccoon", b"Louie the Raccoon was the last of the Davinci trilogy to be launched on sui. You faded when he told you to buy bitcoin at $1. Will you fade $LTR too?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000052962_a948139470.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LTR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LTR>>(v1);
    }

    // decompiled from Move bytecode v6
}

