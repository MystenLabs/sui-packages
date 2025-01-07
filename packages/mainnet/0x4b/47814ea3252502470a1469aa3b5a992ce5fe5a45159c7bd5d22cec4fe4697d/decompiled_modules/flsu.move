module 0x4b47814ea3252502470a1469aa3b5a992ce5fe5a45159c7bd5d22cec4fe4697d::flsu {
    struct FLSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLSU>(arg0, 6, b"FLSU", b"FlySUI", b"Blast off to the Moon with SUI the symbol of rapid growth and limitless potential in the crypto world. Invest in a future that's already taking flight!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_11_15_34_47_A_colorful_cartoon_style_image_of_the_young_boy_exactly_like_the_one_in_the_previous_image_wearing_a_spacesuit_while_refueling_his_rocket_labeled_S_f73f4ffec5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLSU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLSU>>(v1);
    }

    // decompiled from Move bytecode v6
}

