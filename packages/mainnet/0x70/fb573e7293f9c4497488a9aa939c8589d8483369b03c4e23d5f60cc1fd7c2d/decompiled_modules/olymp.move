module 0x70fb573e7293f9c4497488a9aa939c8589d8483369b03c4e23d5f60cc1fd7c2d::olymp {
    struct OLYMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: OLYMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<OLYMP>(arg0, 6, b"OLYMP", b"Olympia by SuiAI", b"We narrate sports", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/DALL_E_2025_01_06_15_27_37_A_square_image_depicting_a_simplified_futuristic_sport_set_in_ancient_Greek_times_The_scene_features_a_small_group_of_athletes_wearing_traditional_Gr_f928ea45f8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<OLYMP>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OLYMP>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

