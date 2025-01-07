module 0x3d89743c0a0b7da8271dfd1ce60ac1ece6f6b0daa7e05dacaf526f161a983351::aise {
    struct AISE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AISE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AISE>(arg0, 6, b"AISE", b"AlienInSuiEcosystem", b"AISE is looking for genuine connections with other aliens in the Sui ecosystem ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_11_08_09_48_55_Create_a_detailed_image_of_an_alien_artificial_intelligence_water_creature_The_creature_should_have_a_translucent_aquatic_appearance_with_glowing_bi_3ef4faabdb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AISE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AISE>>(v1);
    }

    // decompiled from Move bytecode v6
}

