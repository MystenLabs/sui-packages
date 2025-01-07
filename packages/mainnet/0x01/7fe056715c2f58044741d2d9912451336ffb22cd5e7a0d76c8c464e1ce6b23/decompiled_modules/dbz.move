module 0x17fe056715c2f58044741d2d9912451336ffb22cd5e7a0d76c8c464e1ce6b23::dbz {
    struct DBZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: DBZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DBZ>(arg0, 6, b"DBZ", b"BALLZ DEEP", b"How deep are we?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/s_1134328420_gs_7_is_35_u_0_oi_1_m_bc8_alpha_nov_3_Two_dark_blue_balls_close_together_falling_from_the_surface_of_a_deep_pool_of_water_the_bottom_of_t_1ea1db9519.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DBZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DBZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

