module 0x4b284ca528902abc543364ea061e03eb05eef94699f2fcebf42214f9fba9fa8d::margin_math {
    public(friend) fun get_margin_left(arg0: 0x4b284ca528902abc543364ea061e03eb05eef94699f2fcebf42214f9fba9fa8d::position::UserPosition, arg1: u128, arg2: u128) : u128 {
        let v0 = 0x4b284ca528902abc543364ea061e03eb05eef94699f2fcebf42214f9fba9fa8d::position::oiOpen(arg0);
        let v1 = if (0x4b284ca528902abc543364ea061e03eb05eef94699f2fcebf42214f9fba9fa8d::position::isPosPositive(arg0)) {
            0x4b284ca528902abc543364ea061e03eb05eef94699f2fcebf42214f9fba9fa8d::library::sub(0x4b284ca528902abc543364ea061e03eb05eef94699f2fcebf42214f9fba9fa8d::position::margin(arg0) + v0 * arg1 / 0x4b284ca528902abc543364ea061e03eb05eef94699f2fcebf42214f9fba9fa8d::position::compute_average_entry_price(arg0), v0)
        } else {
            0x4b284ca528902abc543364ea061e03eb05eef94699f2fcebf42214f9fba9fa8d::library::sub(0x4b284ca528902abc543364ea061e03eb05eef94699f2fcebf42214f9fba9fa8d::position::margin(arg0) + v0, v0 * arg1 / 0x4b284ca528902abc543364ea061e03eb05eef94699f2fcebf42214f9fba9fa8d::position::compute_average_entry_price(arg0))
        };
        0x4b284ca528902abc543364ea061e03eb05eef94699f2fcebf42214f9fba9fa8d::library::min(v1, arg2)
    }

    public(friend) fun get_max_removeable_margin(arg0: 0x4b284ca528902abc543364ea061e03eb05eef94699f2fcebf42214f9fba9fa8d::position::UserPosition, arg1: u128) : u128 {
        let v0 = 0x4b284ca528902abc543364ea061e03eb05eef94699f2fcebf42214f9fba9fa8d::position::margin(arg0);
        if (0x4b284ca528902abc543364ea061e03eb05eef94699f2fcebf42214f9fba9fa8d::position::isPosPositive(arg0)) {
            0x4b284ca528902abc543364ea061e03eb05eef94699f2fcebf42214f9fba9fa8d::library::min(v0, 0x4b284ca528902abc543364ea061e03eb05eef94699f2fcebf42214f9fba9fa8d::signed_number::positive_value(0x4b284ca528902abc543364ea061e03eb05eef94699f2fcebf42214f9fba9fa8d::signed_number::add_uint(0x4b284ca528902abc543364ea061e03eb05eef94699f2fcebf42214f9fba9fa8d::signed_number::from_subtraction(v0, 0x4b284ca528902abc543364ea061e03eb05eef94699f2fcebf42214f9fba9fa8d::position::oiOpen(arg0)), 0x4b284ca528902abc543364ea061e03eb05eef94699f2fcebf42214f9fba9fa8d::library::base_mul(0x4b284ca528902abc543364ea061e03eb05eef94699f2fcebf42214f9fba9fa8d::library::base_mul(0x4b284ca528902abc543364ea061e03eb05eef94699f2fcebf42214f9fba9fa8d::position::qPos(arg0), arg1), 0x4b284ca528902abc543364ea061e03eb05eef94699f2fcebf42214f9fba9fa8d::library::base_uint() - 0x4b284ca528902abc543364ea061e03eb05eef94699f2fcebf42214f9fba9fa8d::position::mro(arg0)))))
        } else {
            0x4b284ca528902abc543364ea061e03eb05eef94699f2fcebf42214f9fba9fa8d::library::min(v0, 0x4b284ca528902abc543364ea061e03eb05eef94699f2fcebf42214f9fba9fa8d::library::sub(v0 + 0x4b284ca528902abc543364ea061e03eb05eef94699f2fcebf42214f9fba9fa8d::position::oiOpen(arg0), 0x4b284ca528902abc543364ea061e03eb05eef94699f2fcebf42214f9fba9fa8d::library::base_mul(0x4b284ca528902abc543364ea061e03eb05eef94699f2fcebf42214f9fba9fa8d::library::base_mul(0x4b284ca528902abc543364ea061e03eb05eef94699f2fcebf42214f9fba9fa8d::position::qPos(arg0), arg1), 0x4b284ca528902abc543364ea061e03eb05eef94699f2fcebf42214f9fba9fa8d::library::base_uint() + 0x4b284ca528902abc543364ea061e03eb05eef94699f2fcebf42214f9fba9fa8d::position::mro(arg0))))
        }
    }

    public(friend) fun get_target_margin(arg0: 0x4b284ca528902abc543364ea061e03eb05eef94699f2fcebf42214f9fba9fa8d::position::UserPosition, arg1: u128, arg2: u128) : u128 {
        let v0 = 0x4b284ca528902abc543364ea061e03eb05eef94699f2fcebf42214f9fba9fa8d::library::base_mul(0x4b284ca528902abc543364ea061e03eb05eef94699f2fcebf42214f9fba9fa8d::position::qPos(arg0), arg2);
        if (0x4b284ca528902abc543364ea061e03eb05eef94699f2fcebf42214f9fba9fa8d::position::isPosPositive(arg0)) {
            0x4b284ca528902abc543364ea061e03eb05eef94699f2fcebf42214f9fba9fa8d::library::sub(0x4b284ca528902abc543364ea061e03eb05eef94699f2fcebf42214f9fba9fa8d::library::base_div(v0, arg1) + 0x4b284ca528902abc543364ea061e03eb05eef94699f2fcebf42214f9fba9fa8d::position::oiOpen(arg0), v0)
        } else {
            0x4b284ca528902abc543364ea061e03eb05eef94699f2fcebf42214f9fba9fa8d::library::sub(0x4b284ca528902abc543364ea061e03eb05eef94699f2fcebf42214f9fba9fa8d::library::base_div(v0, arg1) + v0, 0x4b284ca528902abc543364ea061e03eb05eef94699f2fcebf42214f9fba9fa8d::position::oiOpen(arg0))
        }
    }

    // decompiled from Move bytecode v6
}

