module 0x7002bbd10ab3daffea1fc84f3672ffe920414ab5be421ca5340302d344c71865::spem {
    struct SPEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPEM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPEM>(arg0, 6, b"SPEM", b"SuiSushi Pepemoto", b"SuiSushi Pepemoto  Next x1000 gems!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_09_21_46_38_A_blueish_frog_character_inspired_by_the_style_of_Pepe_the_Frog_fused_with_a_nigiri_sushi_The_frog_character_has_a_cute_round_face_with_a_slightly_4c90872929.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPEM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPEM>>(v1);
    }

    // decompiled from Move bytecode v6
}

