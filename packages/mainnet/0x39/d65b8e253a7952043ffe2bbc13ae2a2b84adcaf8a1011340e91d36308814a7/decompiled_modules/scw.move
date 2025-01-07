module 0x39d65b8e253a7952043ffe2bbc13ae2a2b84adcaf8a1011340e91d36308814a7::scw {
    struct SCW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCW>(arg0, 6, b"SCW", b"SuiCowboyWorm", b"If this moons, 25% of dev profits will go in marketing (provable transactions) every month", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_11_12_09_29_37_A_close_up_image_of_a_fictional_blue_worm_named_Sui_Worm_on_a_solid_black_background_featuring_glowing_green_and_red_candles_along_its_body_to_repr_0712e4cbcd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCW>>(v1);
    }

    // decompiled from Move bytecode v6
}

