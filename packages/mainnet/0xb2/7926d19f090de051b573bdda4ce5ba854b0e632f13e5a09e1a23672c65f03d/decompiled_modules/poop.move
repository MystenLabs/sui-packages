module 0xb27926d19f090de051b573bdda4ce5ba854b0e632f13e5a09e1a23672c65f03d::poop {
    struct POOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: POOP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<POOP>(arg0, 6, b"POOP", b"The pooper", b"plopplopplopplopplopplopplopplopplopplop", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/DALL_E_2024_12_22_18_04_37_A_humorous_and_cartoonish_illustration_of_a_person_sitting_on_a_toilet_in_a_lighthearted_and_exaggerated_style_with_a_comical_expression_and_minimal_b630749b48.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<POOP>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POOP>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

