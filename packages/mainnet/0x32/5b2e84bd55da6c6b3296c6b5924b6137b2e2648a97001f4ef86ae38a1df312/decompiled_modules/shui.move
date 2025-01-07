module 0x325b2e84bd55da6c6b3296c6b5924b6137b2e2648a97001f4ef86ae38a1df312::shui {
    struct SHUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHUI>(arg0, 6, b"SHUI", b"Shui on Sui", b"Shui  means water in Chinese. Shui represents calmness, cheerfulness, joy, and nature.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_26_01_46_22_27087285f9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

