module 0x30a8cdcea2d40226c8e63c7e67bf7ae10f80b8f42f909d9a994ab0f01584f8b2::angl {
    struct ANGL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANGL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANGL>(arg0, 6, b"ANGL", b"ANGEL", b"Fallen Angel", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/augustus_frogustus_fantasy_Character_Elegant_Minimal_female_cre_f9e2b89f_8d65_4e7d_b13a_ccc8180a16b9_cropped_7dccb89174.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANGL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANGL>>(v1);
    }

    // decompiled from Move bytecode v6
}

