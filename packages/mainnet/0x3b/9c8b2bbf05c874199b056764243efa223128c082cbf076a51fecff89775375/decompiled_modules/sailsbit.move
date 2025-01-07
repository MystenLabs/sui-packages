module 0x3b9c8b2bbf05c874199b056764243efa223128c082cbf076a51fecff89775375::sailsbit {
    struct SAILSBIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAILSBIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAILSBIT>(arg0, 6, b"SailsBit", b"Sui Sails Bit", b"Sail through the Sui ecosystem ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_02_00_03_30_A_retro_8_bit_style_sailing_boat_with_its_sails_fully_opened_cruising_over_a_pixelated_coral_reef_in_the_ocean_The_water_is_depicted_with_pixelated_91dcb83683.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAILSBIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAILSBIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

