module 0x8347a8818bb2a5e5f7b94110000f42455313c235c25f4cbb620ed7790ad4ff0d::pepsons {
    struct PEPSONS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPSONS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPSONS>(arg0, 6, b"PEPSONS", b"The Pepsons Sui", x"5468652024504550534f4e53204d656d65696e67206f6e205355490a0a0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_14_23_37_17_3011c1957a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPSONS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPSONS>>(v1);
    }

    // decompiled from Move bytecode v6
}

