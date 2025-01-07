module 0xdf03b7b7b1f2e995aaf170fb5abeedec0f74039f94da8482e417e7e82c34468c::messiah {
    struct MESSIAH has drop {
        dummy_field: bool,
    }

    fun init(arg0: MESSIAH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MESSIAH>(arg0, 6, b"Messiah", b"Sui Messiah", b"Sui Messiah embodies giga wisdom and sui serenity, guiding all to redemption.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_07_22_53_55_A_detailed_illustration_of_a_joyful_laughing_figure_resembling_the_one_in_the_provided_image_with_flowing_hair_and_a_radiant_halo_behind_the_head_T_2_31061ea7a6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MESSIAH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MESSIAH>>(v1);
    }

    // decompiled from Move bytecode v6
}

