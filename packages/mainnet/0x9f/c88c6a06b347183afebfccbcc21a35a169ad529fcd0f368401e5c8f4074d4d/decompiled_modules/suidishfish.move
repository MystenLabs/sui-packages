module 0x9fc88c6a06b347183afebfccbcc21a35a169ad529fcd0f368401e5c8f4074d4d::suidishfish {
    struct SUIDISHFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDISHFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDISHFISH>(arg0, 6, b"SUIDISHFISH", b"SUI.DISH.FISH", b"The SuiDishFish Official Page. The SUI version of Matt Furies inspirations for our school, featuring Queen LaSuifa! More characters to come, all in one home.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/FF_2_A00_F0_1354_4_FFB_AE_77_050_EE_9_AE_3_ED_9_87983e2a08.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDISHFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDISHFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

