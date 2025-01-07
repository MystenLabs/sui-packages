module 0x6f5cb092a774e3886b823201290397d4c522acbc30f5d6d04007800818f2575f::snt {
    struct SNT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNT>(arg0, 6, b"SNT", b"Suinator", b"Welcome to Serenity of Truth, home of The Suinator a superhero for peace and truth. Our token supports independent news via The Suinators powers. Join us in transparency and helping small news outlets maintain truth in journalism.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_05_21_00_42_A_retro_pixel_art_design_of_a_white_bald_superhero_in_colorful_spandex_with_a_gentle_water_drop_symbol_on_his_chest_inspired_by_SUI_branding_The_sup_dae48963ff.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNT>>(v1);
    }

    // decompiled from Move bytecode v6
}

