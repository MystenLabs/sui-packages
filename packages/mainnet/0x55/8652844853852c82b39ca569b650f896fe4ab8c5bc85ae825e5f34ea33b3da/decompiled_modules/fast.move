module 0x558652844853852c82b39ca569b650f896fe4ab8c5bc85ae825e5f34ea33b3da::fast {
    struct FAST has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAST>(arg0, 6, b"FAST", b"Fas", b"Meet Fas on Sui! He blazes through the blockchain at lightning speed! Sui the fastest and most powerful force, driving the best network in crypto!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_09_22_16_00_23_A_cartoon_style_speedster_superhero_character_wearing_a_sleek_light_blue_suit_with_a_futuristic_design_The_character_is_running_fast_with_a_dynamic_p_90901f1358.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FAST>>(v1);
    }

    // decompiled from Move bytecode v6
}

