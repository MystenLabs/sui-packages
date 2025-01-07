module 0xde0b9c063224eaca2f6796229cd5e666db0f54efd3fc77369df17f3c5d3ce131::suindinger {
    struct SUINDINGER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINDINGER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINDINGER>(arg0, 6, b"SUINDINGER", b"Schrodinger's Cat", b"SUINDINGER will probably be the future; Schrodinger's formula redefined how we see the universe: a place where infinite possibilities exist until we choose to act. Blockchain bring this to life, transforming uncertainty into opportunity. The power to collapse that uncertainty into truth doesnt belong to corporations or governments, it belongs to us.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Schr_A_dingers_cat_as_the_central_figure_peering_out_of_a_box_on_the_edge_of_a_black_hole_with_a_simple_animation_of_the_cat_and_a_more_realistic_animation_of_the_black_hole_and_the_box_2d84c5e57e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINDINGER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINDINGER>>(v1);
    }

    // decompiled from Move bytecode v6
}

