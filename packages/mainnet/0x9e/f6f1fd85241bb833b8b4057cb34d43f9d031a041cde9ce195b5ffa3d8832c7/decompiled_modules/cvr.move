module 0x9ef6f1fd85241bb833b8b4057cb34d43f9d031a041cde9ce195b5ffa3d8832c7::cvr {
    struct CVR has drop {
        dummy_field: bool,
    }

    fun init(arg0: CVR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CVR>(arg0, 6, b"CVR", b"Caviar on SUI", b"Caviar for a million suis!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_19_11_40_06_A_cute_cartoon_style_fish_egg_with_big_expressive_eyes_The_egg_should_be_round_with_a_glossy_translucent_shell_and_a_soft_pinkish_hue_The_eyes_a_48f61c103c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CVR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CVR>>(v1);
    }

    // decompiled from Move bytecode v6
}

