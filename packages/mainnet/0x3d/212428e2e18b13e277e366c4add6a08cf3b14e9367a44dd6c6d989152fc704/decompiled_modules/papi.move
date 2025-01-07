module 0x3d212428e2e18b13e277e366c4add6a08cf3b14e9367a44dd6c6d989152fc704::papi {
    struct PAPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAPI>(arg0, 6, b"PAPI", b"sui papi", b"The legend of sui papi started with a single drop. Created by visionary developers who wanted to infuse life, fiesta, and utility into the digital financial ecosystem. Aprovecha el da, que maana no sabemos si estaremos.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_03_23_13_57_A_fun_cartoonish_image_of_Sui_Papi_the_muscular_water_droplet_character_featuring_a_stylish_mustache_and_a_sombrero_Sui_Papi_has_a_playful_and_con_91a8e7a140.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAPI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

