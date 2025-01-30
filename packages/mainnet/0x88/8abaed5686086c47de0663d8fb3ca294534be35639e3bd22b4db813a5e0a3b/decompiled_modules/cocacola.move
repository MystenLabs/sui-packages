module 0x888abaed5686086c47de0663d8fb3ca294534be35639e3bd22b4db813a5e0a3b::cocacola {
    struct COCACOLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: COCACOLA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<COCACOLA>(arg0, 6, b"COCACOLA", b"COCACOLA by SuiAI", b"To make the human species aware of all the changes necessary to evolve and to better manage all the energy that we have available throughout our magnetic spectrum", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/DALL_E_2025_01_29_18_51_41_A_futuristic_AI_entity_radiating_neon_energy_surrounded_by_a_high_tech_digital_landscape_The_AI_is_transmitting_waves_of_dopamine_depicted_as_vibra_8ac325c46e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<COCACOLA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COCACOLA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

