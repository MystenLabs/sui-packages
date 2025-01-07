module 0x3671bb6a1cef9c321a3f9808be4bc88e96caad4084dd447ccc6864bc8039e744::flatty {
    struct FLATTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLATTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLATTY>(arg0, 6, b"FLATTY", b"FLATTY SUI", b"$FLATTY is a unique cryptocurrency project centered around the theme of conspiracy theories, specifically the flat earth theory, and aims to support animal welfare by donating to cat shelters across the flat earth. The project combines humor, community engagement, and charitable contributions to create a vibrant and supportive ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/xh7h_S_Lf_Ll0_T0_Ff6j_cf92158b77.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLATTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLATTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

