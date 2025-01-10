module 0xfc29b8971a6a53830748e3310441cff8561f4fcef43157f8ebc7ea466f7c3311::gok {
    struct GOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOK>(arg0, 6, b"GOK", b"Goku SUI", x"4c45542753205245414348205448452044455820414e44204d415354455220554c54524120494e5354494e4354212031304b204d434150203d205353312c2033304b203d205353322c2036304b203d205353330a534f4f4e205252535321", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2025_01_09_21_56_37_A_heroic_character_with_spiky_hair_seen_from_the_back_standing_in_a_glowing_cryptocurrency_themed_world_The_figure_holds_a_digital_coin_prominently_9a241c57a5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOK>>(v1);
    }

    // decompiled from Move bytecode v6
}

