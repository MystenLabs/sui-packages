module 0xcb7473713386ae0a8d76bfe61c8a7f40361d7043476b6d87210b436c2f93aa7f::suiperdeng {
    struct SUIPERDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPERDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPERDENG>(arg0, 6, b"SUIPERDENG", b"SUIPER HIPPO", b"THE SUPER HIPPO, SUIPER DENG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_09_19_33_05_A_superhero_hippopotamus_with_a_muscular_physique_wearing_a_blue_and_red_spandex_suit_with_a_bold_cape_flying_in_the_wind_The_hippo_has_a_heroic_sta_e907d69eda.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPERDENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPERDENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

