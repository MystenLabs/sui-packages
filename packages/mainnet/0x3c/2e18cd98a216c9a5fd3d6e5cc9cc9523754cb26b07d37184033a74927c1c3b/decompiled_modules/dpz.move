module 0x3c2e18cd98a216c9a5fd3d6e5cc9cc9523754cb26b07d37184033a74927c1c3b::dpz {
    struct DPZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: DPZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DPZ>(arg0, 6, b"DPZ", b"BALLZ DEEP", b"How Deep are we?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/s_1126475742_gs_7_is_35_u_0_oi_1_m_bc8_alpha_nov_3_Two_blue_balls_in_a_crystal_pool_of_water_the_bottom_of_the_pool_has_an_intricate_details_that_are_0bd2678326.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DPZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DPZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

