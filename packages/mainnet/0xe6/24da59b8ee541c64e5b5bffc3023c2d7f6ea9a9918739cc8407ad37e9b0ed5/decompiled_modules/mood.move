module 0xe624da59b8ee541c64e5b5bffc3023c2d7f6ea9a9918739cc8407ad37e9b0ed5::mood {
    struct MOOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOOD>(arg0, 6, b"MOOD", b"MooDeep", b"Moodeep is the deepest Moo Deng", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_12_23_27_37_A_detailed_underwater_scene_featuring_a_large_hippo_swimming_gracefully_The_hippo_s_massive_body_is_partially_submerged_with_sunlight_filtering_thro_cc573f0932.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

