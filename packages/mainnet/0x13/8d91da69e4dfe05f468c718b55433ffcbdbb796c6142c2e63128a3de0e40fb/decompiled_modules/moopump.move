module 0x138d91da69e4dfe05f468c718b55433ffcbdbb796c6142c2e63128a3de0e40fb::moopump {
    struct MOOPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOOPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOOPUMP>(arg0, 6, b"MOOPUMP", b"MooPump", b"Thicc bottom, skinny legs, zero sense. The token that \"moos\" like no other.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_11_28_12_52_28_A_hyper_realistic_photo_of_a_cow_with_exaggerated_and_distorted_proportions_featuring_an_overly_wide_and_thick_lower_body_tapering_sharply_to_a_dispr_9d22898907.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOOPUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOOPUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

