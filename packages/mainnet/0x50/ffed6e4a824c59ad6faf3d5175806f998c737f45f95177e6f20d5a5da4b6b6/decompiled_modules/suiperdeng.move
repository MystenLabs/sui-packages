module 0x50ffed6e4a824c59ad6faf3d5175806f998c737f45f95177e6f20d5a5da4b6b6::suiperdeng {
    struct SUIPERDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPERDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPERDENG>(arg0, 6, b"SUIPERDENG", b"SUIPER HIPPO", b"SUIPER HIPPO, SUIPER DENG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_09_19_33_05_A_superhero_hippopotamus_with_a_muscular_physique_wearing_a_blue_and_red_spandex_suit_with_a_bold_cape_flying_in_the_wind_The_hippo_has_a_heroic_sta_e766978d52.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPERDENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPERDENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

