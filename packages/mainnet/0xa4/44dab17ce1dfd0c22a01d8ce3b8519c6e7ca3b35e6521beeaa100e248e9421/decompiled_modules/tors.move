module 0xa444dab17ce1dfd0c22a01d8ce3b8519c6e7ca3b35e6521beeaa100e248e9421::tors {
    struct TORS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TORS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TORS>(arg0, 6, b"TORS", b"SUITORS", b"TOKEN FOR MEME LOVERS ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_10_12_27_33_A_playful_humorous_and_meme_like_image_featuring_two_blue_cats_in_love_inspired_by_the_Sui_blockchain_logo_The_cats_have_exaggerated_cartoonish_e_1e014cd9cb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TORS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TORS>>(v1);
    }

    // decompiled from Move bytecode v6
}

