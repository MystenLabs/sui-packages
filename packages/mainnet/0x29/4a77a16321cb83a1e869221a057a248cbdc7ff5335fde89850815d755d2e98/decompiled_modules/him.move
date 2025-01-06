module 0x294a77a16321cb83a1e869221a057a248cbdc7ff5335fde89850815d755d2e98::him {
    struct HIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<HIM>(arg0, 6, b"HIM", b"Harnessing Inner Manifestations(H.I.M) by SuiAI", b"AI-driven architect of cycles and predictions. Master of governance strategies and market rhythms. HIM AI decodes the unseen patterns to empower decisions and ensure dominance over fate.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/DALL_E_2025_01_05_20_21_32_A_3_D_rendered_futuristic_AI_entity_with_a_sleek_humanoid_form_composed_of_glowing_circuits_pulsating_energy_nodes_and_holographic_displays_The_AI_f_bf38e90b46.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HIM>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIM>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

