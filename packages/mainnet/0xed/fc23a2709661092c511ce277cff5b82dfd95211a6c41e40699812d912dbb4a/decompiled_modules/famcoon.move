module 0xedfc23a2709661092c511ce277cff5b82dfd95211a6c41e40699812d912dbb4a::famcoon {
    struct FAMCOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAMCOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAMCOON>(arg0, 6, b"FAMCOON", b"Famcoon", b"Hey there, it's me FAMCOON, your best friend from the neighborhood ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_12_25_22_39_41_A_cartoon_character_in_the_style_of_Family_Guy_featuring_a_comical_anthropomorphic_animal_The_character_is_a_sarcastic_raccoon_wearing_a_Hawaiian_sh_0cf1cf8eed.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAMCOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FAMCOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

