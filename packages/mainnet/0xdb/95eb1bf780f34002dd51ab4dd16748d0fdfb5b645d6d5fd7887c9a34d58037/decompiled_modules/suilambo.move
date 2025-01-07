module 0xdb95eb1bf780f34002dd51ab4dd16748d0fdfb5b645d6d5fd7887c9a34d58037::suilambo {
    struct SUILAMBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILAMBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILAMBO>(arg0, 6, b"SuiLambo", b"SUILAMBO", b"sd ssddsdf fdgfnj", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_07_23_20_40_A_cartoon_style_Lamborghini_sports_car_in_light_blue_The_car_should_have_exaggerated_smooth_curves_and_a_playful_whimsical_appearance_as_if_drawn_1c44ff39d7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILAMBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILAMBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

