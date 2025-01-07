module 0x9c9a63d8c8ab1f6856814b180601b491c2e433b284bd0d976959bb9e9c68d749::suift {
    struct SUIFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFT>(arg0, 6, b"Suift", b"SuiCraft", b"Minecraft ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_10_05_30_29_A_Minecraft_style_scene_with_a_pixelated_dolphin_flying_over_the_ocean_near_a_blocky_beach_with_pixelated_trees_and_sand_Integrate_the_correct_Sui_d5ee63b159.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFT>>(v1);
    }

    // decompiled from Move bytecode v6
}

