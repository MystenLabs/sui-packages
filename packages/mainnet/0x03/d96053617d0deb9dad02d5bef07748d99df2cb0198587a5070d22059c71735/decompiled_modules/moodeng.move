module 0x3d96053617d0deb9dad02d5bef07748d99df2cb0198587a5070d22059c71735::moodeng {
    struct MOODENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOODENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOODENG>(arg0, 6, b"MOODENG", b"Moo Deng", b"Moo Deng Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_cf34ee3a06.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOODENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOODENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

