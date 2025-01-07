module 0x8b73e3852a0761b858f4a5ca1abfe87249e07ec7b528f6d2b3f7232cb7f69d2f::lily {
    struct LILY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LILY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LILY>(arg0, 6, b"Lily", b"Lily the cat", b"Lily is a blue eye, light brown and white ragdoll cat owned by Lisa, Blackpink", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aasd_b33a8ffd91.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LILY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LILY>>(v1);
    }

    // decompiled from Move bytecode v6
}

