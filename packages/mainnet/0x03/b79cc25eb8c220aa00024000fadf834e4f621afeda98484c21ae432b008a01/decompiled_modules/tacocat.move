module 0x3b79cc25eb8c220aa00024000fadf834e4f621afeda98484c21ae432b008a01::tacocat {
    struct TACOCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TACOCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TACOCAT>(arg0, 6, b"TACOCAT", b"TacocaT", b"Tacocat is TacocaT, new meta, OG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000043503_3a7173532a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TACOCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TACOCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

