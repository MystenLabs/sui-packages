module 0x1807998f3fab48d20dc0189547ab199ff02d522c484bf3650159689ad9cda045::heppo {
    struct HEPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEPPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEPPO>(arg0, 6, b"HEPPO", b"Heppo", b"Meet HEPPO, the adorably round creature with the most heartwarming smile in crypto! Not quite like anything you've seen before - HEPPO is uniquely charming and here to spread happiness across the Sui Network!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALL_E_2024_07_10_04_48_37_A_simple_cute_and_funny_animal_that_could_be_used_as_a_meme_token_The_animal_should_be_in_a_basic_cartoon_style_with_minimal_details_featuring_big_1_removebg_preview_1_1_e24606fc5a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEPPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HEPPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

