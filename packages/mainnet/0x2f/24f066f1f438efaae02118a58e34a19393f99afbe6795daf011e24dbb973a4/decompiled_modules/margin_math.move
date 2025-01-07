module 0x2f24f066f1f438efaae02118a58e34a19393f99afbe6795daf011e24dbb973a4::margin_math {
    public(friend) fun get_margin_left(arg0: 0x2f24f066f1f438efaae02118a58e34a19393f99afbe6795daf011e24dbb973a4::position::UserPosition, arg1: u128, arg2: u128) : u128 {
        let v0 = 0x2f24f066f1f438efaae02118a58e34a19393f99afbe6795daf011e24dbb973a4::position::oiOpen(arg0);
        let v1 = if (0x2f24f066f1f438efaae02118a58e34a19393f99afbe6795daf011e24dbb973a4::position::isPosPositive(arg0)) {
            0x2f24f066f1f438efaae02118a58e34a19393f99afbe6795daf011e24dbb973a4::library::sub(0x2f24f066f1f438efaae02118a58e34a19393f99afbe6795daf011e24dbb973a4::position::margin(arg0) + v0 * arg1 / 0x2f24f066f1f438efaae02118a58e34a19393f99afbe6795daf011e24dbb973a4::position::compute_average_entry_price(arg0), v0)
        } else {
            0x2f24f066f1f438efaae02118a58e34a19393f99afbe6795daf011e24dbb973a4::library::sub(0x2f24f066f1f438efaae02118a58e34a19393f99afbe6795daf011e24dbb973a4::position::margin(arg0) + v0, v0 * arg1 / 0x2f24f066f1f438efaae02118a58e34a19393f99afbe6795daf011e24dbb973a4::position::compute_average_entry_price(arg0))
        };
        0x2f24f066f1f438efaae02118a58e34a19393f99afbe6795daf011e24dbb973a4::library::min(v1, arg2)
    }

    public(friend) fun get_max_removeable_margin(arg0: 0x2f24f066f1f438efaae02118a58e34a19393f99afbe6795daf011e24dbb973a4::position::UserPosition, arg1: u128) : u128 {
        let v0 = 0x2f24f066f1f438efaae02118a58e34a19393f99afbe6795daf011e24dbb973a4::position::margin(arg0);
        if (0x2f24f066f1f438efaae02118a58e34a19393f99afbe6795daf011e24dbb973a4::position::isPosPositive(arg0)) {
            0x2f24f066f1f438efaae02118a58e34a19393f99afbe6795daf011e24dbb973a4::library::min(v0, 0x2f24f066f1f438efaae02118a58e34a19393f99afbe6795daf011e24dbb973a4::signed_number::positive_value(0x2f24f066f1f438efaae02118a58e34a19393f99afbe6795daf011e24dbb973a4::signed_number::add_uint(0x2f24f066f1f438efaae02118a58e34a19393f99afbe6795daf011e24dbb973a4::signed_number::from_subtraction(v0, 0x2f24f066f1f438efaae02118a58e34a19393f99afbe6795daf011e24dbb973a4::position::oiOpen(arg0)), 0x2f24f066f1f438efaae02118a58e34a19393f99afbe6795daf011e24dbb973a4::library::base_mul(0x2f24f066f1f438efaae02118a58e34a19393f99afbe6795daf011e24dbb973a4::library::base_mul(0x2f24f066f1f438efaae02118a58e34a19393f99afbe6795daf011e24dbb973a4::position::qPos(arg0), arg1), 0x2f24f066f1f438efaae02118a58e34a19393f99afbe6795daf011e24dbb973a4::library::base_uint() - 0x2f24f066f1f438efaae02118a58e34a19393f99afbe6795daf011e24dbb973a4::position::mro(arg0)))))
        } else {
            0x2f24f066f1f438efaae02118a58e34a19393f99afbe6795daf011e24dbb973a4::library::min(v0, 0x2f24f066f1f438efaae02118a58e34a19393f99afbe6795daf011e24dbb973a4::library::sub(v0 + 0x2f24f066f1f438efaae02118a58e34a19393f99afbe6795daf011e24dbb973a4::position::oiOpen(arg0), 0x2f24f066f1f438efaae02118a58e34a19393f99afbe6795daf011e24dbb973a4::library::base_mul(0x2f24f066f1f438efaae02118a58e34a19393f99afbe6795daf011e24dbb973a4::library::base_mul(0x2f24f066f1f438efaae02118a58e34a19393f99afbe6795daf011e24dbb973a4::position::qPos(arg0), arg1), 0x2f24f066f1f438efaae02118a58e34a19393f99afbe6795daf011e24dbb973a4::library::base_uint() + 0x2f24f066f1f438efaae02118a58e34a19393f99afbe6795daf011e24dbb973a4::position::mro(arg0))))
        }
    }

    public(friend) fun get_target_margin(arg0: 0x2f24f066f1f438efaae02118a58e34a19393f99afbe6795daf011e24dbb973a4::position::UserPosition, arg1: u128, arg2: u128) : u128 {
        let v0 = 0x2f24f066f1f438efaae02118a58e34a19393f99afbe6795daf011e24dbb973a4::library::base_mul(0x2f24f066f1f438efaae02118a58e34a19393f99afbe6795daf011e24dbb973a4::position::qPos(arg0), arg2);
        if (0x2f24f066f1f438efaae02118a58e34a19393f99afbe6795daf011e24dbb973a4::position::isPosPositive(arg0)) {
            0x2f24f066f1f438efaae02118a58e34a19393f99afbe6795daf011e24dbb973a4::library::sub(0x2f24f066f1f438efaae02118a58e34a19393f99afbe6795daf011e24dbb973a4::library::base_div(v0, arg1) + 0x2f24f066f1f438efaae02118a58e34a19393f99afbe6795daf011e24dbb973a4::position::oiOpen(arg0), v0)
        } else {
            0x2f24f066f1f438efaae02118a58e34a19393f99afbe6795daf011e24dbb973a4::library::sub(0x2f24f066f1f438efaae02118a58e34a19393f99afbe6795daf011e24dbb973a4::library::base_div(v0, arg1) + v0, 0x2f24f066f1f438efaae02118a58e34a19393f99afbe6795daf011e24dbb973a4::position::oiOpen(arg0))
        }
    }

    // decompiled from Move bytecode v6
}

