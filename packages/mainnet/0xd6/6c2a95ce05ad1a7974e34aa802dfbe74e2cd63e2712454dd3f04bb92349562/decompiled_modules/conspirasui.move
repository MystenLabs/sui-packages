module 0xd66c2a95ce05ad1a7974e34aa802dfbe74e2cd63e2712454dd3f04bb92349562::conspirasui {
    struct CONSPIRASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CONSPIRASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CONSPIRASUI>(arg0, 6, b"Conspirasui", b"ConspiraSUI", b"THEY ARE WATCHING US", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_movepump_2aa47c3b84.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CONSPIRASUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CONSPIRASUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

