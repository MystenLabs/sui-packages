module 0x5a930d547ebbb0a6a41a0a985249c2f841cf04b27a3f51b736f7492952ac530b::slepe {
    struct SLEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLEPE>(arg0, 6, b"SLEPE", b"BOOK OF SLEPE", b"The Book of Slepe, as it is written, tells the tale and shapes our future.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/v_LM_i6_C3_400x400_9ff68fc188.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

