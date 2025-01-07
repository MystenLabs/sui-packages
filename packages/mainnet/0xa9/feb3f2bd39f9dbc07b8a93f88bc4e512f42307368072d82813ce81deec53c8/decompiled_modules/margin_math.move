module 0xa9feb3f2bd39f9dbc07b8a93f88bc4e512f42307368072d82813ce81deec53c8::margin_math {
    public(friend) fun get_margin_left(arg0: 0xa9feb3f2bd39f9dbc07b8a93f88bc4e512f42307368072d82813ce81deec53c8::position::UserPosition, arg1: u128, arg2: u128) : u128 {
        let v0 = 0xa9feb3f2bd39f9dbc07b8a93f88bc4e512f42307368072d82813ce81deec53c8::position::oiOpen(arg0);
        let v1 = if (0xa9feb3f2bd39f9dbc07b8a93f88bc4e512f42307368072d82813ce81deec53c8::position::isPosPositive(arg0)) {
            0xa9feb3f2bd39f9dbc07b8a93f88bc4e512f42307368072d82813ce81deec53c8::library::sub(0xa9feb3f2bd39f9dbc07b8a93f88bc4e512f42307368072d82813ce81deec53c8::position::margin(arg0) + v0 * arg1 / 0xa9feb3f2bd39f9dbc07b8a93f88bc4e512f42307368072d82813ce81deec53c8::position::compute_average_entry_price(arg0), v0)
        } else {
            0xa9feb3f2bd39f9dbc07b8a93f88bc4e512f42307368072d82813ce81deec53c8::library::sub(0xa9feb3f2bd39f9dbc07b8a93f88bc4e512f42307368072d82813ce81deec53c8::position::margin(arg0) + v0, v0 * arg1 / 0xa9feb3f2bd39f9dbc07b8a93f88bc4e512f42307368072d82813ce81deec53c8::position::compute_average_entry_price(arg0))
        };
        0xa9feb3f2bd39f9dbc07b8a93f88bc4e512f42307368072d82813ce81deec53c8::library::min(v1, arg2)
    }

    public(friend) fun get_max_removeable_margin(arg0: 0xa9feb3f2bd39f9dbc07b8a93f88bc4e512f42307368072d82813ce81deec53c8::position::UserPosition, arg1: u128) : u128 {
        let v0 = 0xa9feb3f2bd39f9dbc07b8a93f88bc4e512f42307368072d82813ce81deec53c8::position::margin(arg0);
        if (0xa9feb3f2bd39f9dbc07b8a93f88bc4e512f42307368072d82813ce81deec53c8::position::isPosPositive(arg0)) {
            0xa9feb3f2bd39f9dbc07b8a93f88bc4e512f42307368072d82813ce81deec53c8::library::min(v0, 0xa9feb3f2bd39f9dbc07b8a93f88bc4e512f42307368072d82813ce81deec53c8::signed_number::positive_value(0xa9feb3f2bd39f9dbc07b8a93f88bc4e512f42307368072d82813ce81deec53c8::signed_number::add_uint(0xa9feb3f2bd39f9dbc07b8a93f88bc4e512f42307368072d82813ce81deec53c8::signed_number::from_subtraction(v0, 0xa9feb3f2bd39f9dbc07b8a93f88bc4e512f42307368072d82813ce81deec53c8::position::oiOpen(arg0)), 0xa9feb3f2bd39f9dbc07b8a93f88bc4e512f42307368072d82813ce81deec53c8::library::base_mul(0xa9feb3f2bd39f9dbc07b8a93f88bc4e512f42307368072d82813ce81deec53c8::library::base_mul(0xa9feb3f2bd39f9dbc07b8a93f88bc4e512f42307368072d82813ce81deec53c8::position::qPos(arg0), arg1), 0xa9feb3f2bd39f9dbc07b8a93f88bc4e512f42307368072d82813ce81deec53c8::library::base_uint() - 0xa9feb3f2bd39f9dbc07b8a93f88bc4e512f42307368072d82813ce81deec53c8::position::mro(arg0)))))
        } else {
            0xa9feb3f2bd39f9dbc07b8a93f88bc4e512f42307368072d82813ce81deec53c8::library::min(v0, 0xa9feb3f2bd39f9dbc07b8a93f88bc4e512f42307368072d82813ce81deec53c8::library::sub(v0 + 0xa9feb3f2bd39f9dbc07b8a93f88bc4e512f42307368072d82813ce81deec53c8::position::oiOpen(arg0), 0xa9feb3f2bd39f9dbc07b8a93f88bc4e512f42307368072d82813ce81deec53c8::library::base_mul(0xa9feb3f2bd39f9dbc07b8a93f88bc4e512f42307368072d82813ce81deec53c8::library::base_mul(0xa9feb3f2bd39f9dbc07b8a93f88bc4e512f42307368072d82813ce81deec53c8::position::qPos(arg0), arg1), 0xa9feb3f2bd39f9dbc07b8a93f88bc4e512f42307368072d82813ce81deec53c8::library::base_uint() + 0xa9feb3f2bd39f9dbc07b8a93f88bc4e512f42307368072d82813ce81deec53c8::position::mro(arg0))))
        }
    }

    public(friend) fun get_target_margin(arg0: 0xa9feb3f2bd39f9dbc07b8a93f88bc4e512f42307368072d82813ce81deec53c8::position::UserPosition, arg1: u128, arg2: u128) : u128 {
        let v0 = 0xa9feb3f2bd39f9dbc07b8a93f88bc4e512f42307368072d82813ce81deec53c8::library::base_mul(0xa9feb3f2bd39f9dbc07b8a93f88bc4e512f42307368072d82813ce81deec53c8::position::qPos(arg0), arg2);
        if (0xa9feb3f2bd39f9dbc07b8a93f88bc4e512f42307368072d82813ce81deec53c8::position::isPosPositive(arg0)) {
            0xa9feb3f2bd39f9dbc07b8a93f88bc4e512f42307368072d82813ce81deec53c8::library::sub(0xa9feb3f2bd39f9dbc07b8a93f88bc4e512f42307368072d82813ce81deec53c8::library::base_div(v0, arg1) + 0xa9feb3f2bd39f9dbc07b8a93f88bc4e512f42307368072d82813ce81deec53c8::position::oiOpen(arg0), v0)
        } else {
            0xa9feb3f2bd39f9dbc07b8a93f88bc4e512f42307368072d82813ce81deec53c8::library::sub(0xa9feb3f2bd39f9dbc07b8a93f88bc4e512f42307368072d82813ce81deec53c8::library::base_div(v0, arg1) + v0, 0xa9feb3f2bd39f9dbc07b8a93f88bc4e512f42307368072d82813ce81deec53c8::position::oiOpen(arg0))
        }
    }

    // decompiled from Move bytecode v6
}

