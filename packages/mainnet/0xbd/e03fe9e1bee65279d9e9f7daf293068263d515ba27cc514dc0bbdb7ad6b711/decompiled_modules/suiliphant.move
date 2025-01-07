module 0xbde03fe9e1bee65279d9e9f7daf293068263d515ba27cc514dc0bbdb7ad6b711::suiliphant {
    struct SUILIPHANT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILIPHANT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILIPHANT>(arg0, 6, b"SUILIPHANT", b"Elephant on SUI", b"The BLUEST elephant on the planet SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_12_08_14_14_26_A_cartoonish_blue_elephant_in_the_art_style_of_Family_Guy_standing_on_two_legs_with_a_playful_and_exaggerated_expression_The_elephant_is_wearing_cas_3266ac04ac.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILIPHANT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILIPHANT>>(v1);
    }

    // decompiled from Move bytecode v6
}

