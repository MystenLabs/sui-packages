module 0x130b744db97bf0e8ef34ce9c3e48349fb8060b75ed226817cae13cf3290aa889::spd {
    struct SPD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPD>(arg0, 6, b"SPD", b"Sui puddle", x"54686520677265617465737420707564646c65206f6e20247375690a6a756d7020696e20697420616e642067657420776574", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_13_11_31_30_A_detailed_image_of_a_water_puddle_shaped_like_a_perfect_water_drop_The_puddle_reflects_the_sky_and_surrounding_environment_with_small_ripples_gentl_bbb43d6288.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPD>>(v1);
    }

    // decompiled from Move bytecode v6
}

