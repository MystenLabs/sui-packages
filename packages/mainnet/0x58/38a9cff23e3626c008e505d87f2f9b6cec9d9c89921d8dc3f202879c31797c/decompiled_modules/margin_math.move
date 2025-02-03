module 0x5838a9cff23e3626c008e505d87f2f9b6cec9d9c89921d8dc3f202879c31797c::margin_math {
    public(friend) fun get_margin_left(arg0: 0x5838a9cff23e3626c008e505d87f2f9b6cec9d9c89921d8dc3f202879c31797c::position::UserPosition, arg1: u128, arg2: u128) : u128 {
        let v0 = 0x5838a9cff23e3626c008e505d87f2f9b6cec9d9c89921d8dc3f202879c31797c::position::oiOpen(arg0);
        let v1 = if (0x5838a9cff23e3626c008e505d87f2f9b6cec9d9c89921d8dc3f202879c31797c::position::isPosPositive(arg0)) {
            0x5838a9cff23e3626c008e505d87f2f9b6cec9d9c89921d8dc3f202879c31797c::library::sub(0x5838a9cff23e3626c008e505d87f2f9b6cec9d9c89921d8dc3f202879c31797c::position::margin(arg0) + v0 * arg1 / 0x5838a9cff23e3626c008e505d87f2f9b6cec9d9c89921d8dc3f202879c31797c::position::compute_average_entry_price(arg0), v0)
        } else {
            0x5838a9cff23e3626c008e505d87f2f9b6cec9d9c89921d8dc3f202879c31797c::library::sub(0x5838a9cff23e3626c008e505d87f2f9b6cec9d9c89921d8dc3f202879c31797c::position::margin(arg0) + v0, v0 * arg1 / 0x5838a9cff23e3626c008e505d87f2f9b6cec9d9c89921d8dc3f202879c31797c::position::compute_average_entry_price(arg0))
        };
        0x5838a9cff23e3626c008e505d87f2f9b6cec9d9c89921d8dc3f202879c31797c::library::min(v1, arg2)
    }

    public(friend) fun get_max_removeable_margin(arg0: 0x5838a9cff23e3626c008e505d87f2f9b6cec9d9c89921d8dc3f202879c31797c::position::UserPosition, arg1: u128) : u128 {
        let v0 = 0x5838a9cff23e3626c008e505d87f2f9b6cec9d9c89921d8dc3f202879c31797c::position::margin(arg0);
        if (0x5838a9cff23e3626c008e505d87f2f9b6cec9d9c89921d8dc3f202879c31797c::position::isPosPositive(arg0)) {
            0x5838a9cff23e3626c008e505d87f2f9b6cec9d9c89921d8dc3f202879c31797c::library::min(v0, 0x5838a9cff23e3626c008e505d87f2f9b6cec9d9c89921d8dc3f202879c31797c::signed_number::positive_value(0x5838a9cff23e3626c008e505d87f2f9b6cec9d9c89921d8dc3f202879c31797c::signed_number::add_uint(0x5838a9cff23e3626c008e505d87f2f9b6cec9d9c89921d8dc3f202879c31797c::signed_number::from_subtraction(v0, 0x5838a9cff23e3626c008e505d87f2f9b6cec9d9c89921d8dc3f202879c31797c::position::oiOpen(arg0)), 0x5838a9cff23e3626c008e505d87f2f9b6cec9d9c89921d8dc3f202879c31797c::library::base_mul(0x5838a9cff23e3626c008e505d87f2f9b6cec9d9c89921d8dc3f202879c31797c::library::base_mul(0x5838a9cff23e3626c008e505d87f2f9b6cec9d9c89921d8dc3f202879c31797c::position::qPos(arg0), arg1), 0x5838a9cff23e3626c008e505d87f2f9b6cec9d9c89921d8dc3f202879c31797c::library::base_uint() - 0x5838a9cff23e3626c008e505d87f2f9b6cec9d9c89921d8dc3f202879c31797c::position::mro(arg0)))))
        } else {
            0x5838a9cff23e3626c008e505d87f2f9b6cec9d9c89921d8dc3f202879c31797c::library::min(v0, 0x5838a9cff23e3626c008e505d87f2f9b6cec9d9c89921d8dc3f202879c31797c::library::sub(v0 + 0x5838a9cff23e3626c008e505d87f2f9b6cec9d9c89921d8dc3f202879c31797c::position::oiOpen(arg0), 0x5838a9cff23e3626c008e505d87f2f9b6cec9d9c89921d8dc3f202879c31797c::library::base_mul(0x5838a9cff23e3626c008e505d87f2f9b6cec9d9c89921d8dc3f202879c31797c::library::base_mul(0x5838a9cff23e3626c008e505d87f2f9b6cec9d9c89921d8dc3f202879c31797c::position::qPos(arg0), arg1), 0x5838a9cff23e3626c008e505d87f2f9b6cec9d9c89921d8dc3f202879c31797c::library::base_uint() + 0x5838a9cff23e3626c008e505d87f2f9b6cec9d9c89921d8dc3f202879c31797c::position::mro(arg0))))
        }
    }

    public(friend) fun get_target_margin(arg0: 0x5838a9cff23e3626c008e505d87f2f9b6cec9d9c89921d8dc3f202879c31797c::position::UserPosition, arg1: u128, arg2: u128) : u128 {
        let v0 = 0x5838a9cff23e3626c008e505d87f2f9b6cec9d9c89921d8dc3f202879c31797c::library::base_mul(0x5838a9cff23e3626c008e505d87f2f9b6cec9d9c89921d8dc3f202879c31797c::position::qPos(arg0), arg2);
        if (0x5838a9cff23e3626c008e505d87f2f9b6cec9d9c89921d8dc3f202879c31797c::position::isPosPositive(arg0)) {
            0x5838a9cff23e3626c008e505d87f2f9b6cec9d9c89921d8dc3f202879c31797c::library::sub(0x5838a9cff23e3626c008e505d87f2f9b6cec9d9c89921d8dc3f202879c31797c::library::base_div(v0, arg1) + 0x5838a9cff23e3626c008e505d87f2f9b6cec9d9c89921d8dc3f202879c31797c::position::oiOpen(arg0), v0)
        } else {
            0x5838a9cff23e3626c008e505d87f2f9b6cec9d9c89921d8dc3f202879c31797c::library::sub(0x5838a9cff23e3626c008e505d87f2f9b6cec9d9c89921d8dc3f202879c31797c::library::base_div(v0, arg1) + v0, 0x5838a9cff23e3626c008e505d87f2f9b6cec9d9c89921d8dc3f202879c31797c::position::oiOpen(arg0))
        }
    }

    // decompiled from Move bytecode v6
}

