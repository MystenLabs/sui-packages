module 0x7236f4de0504e3f20411d7d2d027a33f01cc53713d118bf0afbdadb59b99f7c9::aaamoodeng {
    struct AAAMOODENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAMOODENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAMOODENG>(arg0, 6, b"aaaMOODENG", b"The first Moodeng", b"This is MOODENG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6_c300faef81_62984c62d6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAMOODENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAMOODENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

