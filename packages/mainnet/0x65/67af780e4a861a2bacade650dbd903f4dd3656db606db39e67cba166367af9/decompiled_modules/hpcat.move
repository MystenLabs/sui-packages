module 0x6567af780e4a861a2bacade650dbd903f4dd3656db606db39e67cba166367af9::hpcat {
    struct HPCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HPCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HPCAT>(arg0, 6, b"HPCAT", b"Happy Cat", b"I Am a Happy Cat in SUI inviting You into my World.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_08_17_11_45_15_A_meme_cat_with_a_mischievous_expression_laughing_The_cat_is_wearing_a_bright_red_cap_tilted_slightly_to_one_side_The_background_is_simple_and_brig_991a403094.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HPCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HPCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

