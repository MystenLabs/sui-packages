module 0x6a9dd36aa972b5d5a42988ab31423aa2669139a2f72e365855954b776214ba8f::water {
    struct WATER has drop {
        dummy_field: bool,
    }

    fun init(arg0: WATER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WATER>(arg0, 6, b"WATER", b"Blue Drink", b"Blue Drink is simply $WATER the most important thing you need for living!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_14_17_48_32_A_logo_for_a_meme_token_called_WATER_The_design_features_a_playful_and_fun_depiction_of_water_elements_such_as_waves_or_water_droplets_combined_52cbb4eed0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WATER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WATER>>(v1);
    }

    // decompiled from Move bytecode v6
}

