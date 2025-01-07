module 0x7c925326ad32688affce82e0bf4b5d3f692fc40394ac714d043726289c9be6e1::bald {
    struct BALD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BALD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BALD>(arg0, 6, b"BALD", b"BALD COIN", b"Meme coin for bald people.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_09_26_09_10_08_A_cartoon_style_illustration_of_a_bald_white_man_with_dollar_signs_in_his_eyes_The_man_should_have_a_simple_friendly_expression_wearing_a_basic_shi_726b6e55c3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BALD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BALD>>(v1);
    }

    // decompiled from Move bytecode v6
}

