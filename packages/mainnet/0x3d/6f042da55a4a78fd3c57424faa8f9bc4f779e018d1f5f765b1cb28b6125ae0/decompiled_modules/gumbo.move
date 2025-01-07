module 0x3d6f042da55a4a78fd3c57424faa8f9bc4f779e018d1f5f765b1cb28b6125ae0::gumbo {
    struct GUMBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUMBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUMBO>(arg0, 6, b"GUMBO", b"GUMBO SUI", b"$GUMBO - Exclusive Edition from Zogz Collection from Matt Furie", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/gumbo_profile_pic_1_9c30105a7c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUMBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GUMBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

