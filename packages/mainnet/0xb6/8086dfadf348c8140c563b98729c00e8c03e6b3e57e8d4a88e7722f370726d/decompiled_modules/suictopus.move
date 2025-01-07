module 0xb68086dfadf348c8140c563b98729c00e8c03e6b3e57e8d4a88e7722f370726d::suictopus {
    struct SUICTOPUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICTOPUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICTOPUS>(arg0, 6, b"SUICTOPUS", b"Suictopus", b"Suictopus  | The friendly octopus of the Sui blockchain  | Spreading good vibes, decentralization, and tentacle-powered innovation!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_12_26_23_07_04_A_friendly_and_welcoming_ocean_animal_resembling_a_colorful_cartoon_style_octopus_with_a_big_smile_and_playful_expressive_eyes_The_octopus_has_vibr_866d097062.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICTOPUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICTOPUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

