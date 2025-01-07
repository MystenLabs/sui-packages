module 0x5ce8288bdee5f9141b58b8cf6d787bbae0f09749c4b70da42e020de28b7e6bde::bloby {
    struct BLOBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOBY>(arg0, 6, b"BLOBY", b"bloby", b"hi am bloby", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_09_13_19_51_25_A_background_image_suitable_for_a_meme_coin_website_featuring_the_SUI_chu_theme_The_design_includes_an_abstract_blue_electric_themed_background_wit_a5a0c72693.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLOBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

