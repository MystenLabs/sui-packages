module 0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::margin_math {
    public(friend) fun get_margin_left(arg0: 0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::position::UserPosition, arg1: u128, arg2: u128) : u128 {
        let v0 = 0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::position::oiOpen(arg0);
        let v1 = if (0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::position::isPosPositive(arg0)) {
            0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::library::sub(0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::position::margin(arg0) + v0 * arg1 / 0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::position::compute_average_entry_price(arg0), v0)
        } else {
            0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::library::sub(0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::position::margin(arg0) + v0, v0 * arg1 / 0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::position::compute_average_entry_price(arg0))
        };
        0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::library::min(v1, arg2)
    }

    public(friend) fun get_max_removeable_margin(arg0: 0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::position::UserPosition, arg1: u128) : u128 {
        let v0 = 0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::position::margin(arg0);
        if (0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::position::isPosPositive(arg0)) {
            0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::library::min(v0, 0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::signed_number::positive_value(0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::signed_number::add_uint(0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::signed_number::from_subtraction(v0, 0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::position::oiOpen(arg0)), 0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::library::base_mul(0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::library::base_mul(0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::position::qPos(arg0), arg1), 0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::library::base_uint() - 0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::position::mro(arg0)))))
        } else {
            0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::library::min(v0, 0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::library::sub(v0 + 0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::position::oiOpen(arg0), 0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::library::base_mul(0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::library::base_mul(0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::position::qPos(arg0), arg1), 0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::library::base_uint() + 0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::position::mro(arg0))))
        }
    }

    public(friend) fun get_target_margin(arg0: 0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::position::UserPosition, arg1: u128, arg2: u128) : u128 {
        let v0 = 0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::library::base_mul(0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::position::qPos(arg0), arg2);
        if (0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::position::isPosPositive(arg0)) {
            0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::library::sub(0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::library::base_div(v0, arg1) + 0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::position::oiOpen(arg0), v0)
        } else {
            0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::library::sub(0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::library::base_div(v0, arg1) + v0, 0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::position::oiOpen(arg0))
        }
    }

    // decompiled from Move bytecode v6
}

