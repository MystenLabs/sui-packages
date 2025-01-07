module 0xbbd5859c9574916c63ee3ba1fe5697f6e0b2dde08c9193a9e649c1a64a55904c::dps {
    struct DPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DPS>(arg0, 6, b"DPS", b"BALLSDEEP", b"Wea are so DEEP.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/s_771231965_gs_7_is_35_u_0_oi_0_m_bc8_alpha_nov_3_Two_dark_blue_balls_close_together_falling_from_the_surface_of_a_deep_pool_of_water_the_bottom_of_t_358be8a453.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

