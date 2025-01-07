module 0xc58f92657d848e85cad1a12a92f875423a79e2b734b39631574add721e585c95::suiwif {
    struct SUIWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWIF>(arg0, 6, b"SUIWIF", b"SUIWIFHAT", b"Crazy WIF and crazy SUI create a crazy future", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_04_02_05_51_A_Shiba_Inu_dog_wearing_a_knitted_pink_hat_in_the_center_with_the_background_of_the_entire_image_featuring_fluid_wavy_lines_in_shades_of_blue_like_246dac8031.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

