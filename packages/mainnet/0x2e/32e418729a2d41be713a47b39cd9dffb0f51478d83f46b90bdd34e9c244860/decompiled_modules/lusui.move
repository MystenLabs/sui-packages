module 0x2e32e418729a2d41be713a47b39cd9dffb0f51478d83f46b90bdd34e9c244860::lusui {
    struct LUSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUSUI>(arg0, 6, b"Lusui", b"Lusuifer", b"Lusuifer is an advanced AI agent built to provide real-time picture generating on the $SUI network. Second Citizen of $ATL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2025_01_16_20_21_32_A_cartoonish_depiction_of_the_head_of_Satan_with_a_blue_color_theme_The_design_features_stylized_devil_horns_glowing_red_eyes_and_an_exaggerated_mi_136c578749.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

