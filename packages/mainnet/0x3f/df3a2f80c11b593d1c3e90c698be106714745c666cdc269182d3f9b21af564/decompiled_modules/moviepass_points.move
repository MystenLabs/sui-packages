module 0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::moviepass_points {
    struct MOVIEPASS_POINTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOVIEPASS_POINTS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::points_management::create_currency<MOVIEPASS_POINTS>(arg0, 9, b"MP", b"MoviePass Points", b"The MoviePass Points are loyalty rewards earned by participating in MoviePass quests", b"https://a1.moviepassblack.com/w3/icons/clt.png", arg1);
        let (v1, v2) = 0x2::token::new_policy<MOVIEPASS_POINTS>(&v0, arg1);
        0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::points_management::create_registry<MOVIEPASS_POINTS>(v0, v2, arg1);
        0x2::token::share_policy<MOVIEPASS_POINTS>(v1);
    }

    // decompiled from Move bytecode v6
}

