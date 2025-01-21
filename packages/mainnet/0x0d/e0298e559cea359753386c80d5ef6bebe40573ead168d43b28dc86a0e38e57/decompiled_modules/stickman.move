module 0xde0298e559cea359753386c80d5ef6bebe40573ead168d43b28dc86a0e38e57::stickman {
    struct STICKMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: STICKMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<STICKMAN>(arg0, 6, b"STICKMAN", b"Stickman AI by SuiAI", b"just a squiggly dude swimming to the top of the sui ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/DALL_E_2025_01_21_16_30_46_A_black_and_white_sketch_of_a_stick_figure_wearing_a_fedora_and_smoking_a_cigarette_leaning_casually_against_a_lamppost_on_a_city_street_The_minimal_6b48ddbba2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<STICKMAN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STICKMAN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

