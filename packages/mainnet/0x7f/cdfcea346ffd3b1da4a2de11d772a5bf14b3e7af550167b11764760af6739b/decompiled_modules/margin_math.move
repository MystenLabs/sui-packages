module 0x7fcdfcea346ffd3b1da4a2de11d772a5bf14b3e7af550167b11764760af6739b::margin_math {
    public(friend) fun get_margin_left(arg0: 0x7fcdfcea346ffd3b1da4a2de11d772a5bf14b3e7af550167b11764760af6739b::position::UserPosition, arg1: u128, arg2: u128) : u128 {
        let v0 = 0x7fcdfcea346ffd3b1da4a2de11d772a5bf14b3e7af550167b11764760af6739b::position::oiOpen(arg0);
        let v1 = if (0x7fcdfcea346ffd3b1da4a2de11d772a5bf14b3e7af550167b11764760af6739b::position::isPosPositive(arg0)) {
            0x7fcdfcea346ffd3b1da4a2de11d772a5bf14b3e7af550167b11764760af6739b::library::sub(0x7fcdfcea346ffd3b1da4a2de11d772a5bf14b3e7af550167b11764760af6739b::position::margin(arg0) + v0 * arg1 / 0x7fcdfcea346ffd3b1da4a2de11d772a5bf14b3e7af550167b11764760af6739b::position::compute_average_entry_price(arg0), v0)
        } else {
            0x7fcdfcea346ffd3b1da4a2de11d772a5bf14b3e7af550167b11764760af6739b::library::sub(0x7fcdfcea346ffd3b1da4a2de11d772a5bf14b3e7af550167b11764760af6739b::position::margin(arg0) + v0, v0 * arg1 / 0x7fcdfcea346ffd3b1da4a2de11d772a5bf14b3e7af550167b11764760af6739b::position::compute_average_entry_price(arg0))
        };
        0x7fcdfcea346ffd3b1da4a2de11d772a5bf14b3e7af550167b11764760af6739b::library::min(v1, arg2)
    }

    public(friend) fun get_max_removeable_margin(arg0: 0x7fcdfcea346ffd3b1da4a2de11d772a5bf14b3e7af550167b11764760af6739b::position::UserPosition, arg1: u128) : u128 {
        let v0 = 0x7fcdfcea346ffd3b1da4a2de11d772a5bf14b3e7af550167b11764760af6739b::position::margin(arg0);
        if (0x7fcdfcea346ffd3b1da4a2de11d772a5bf14b3e7af550167b11764760af6739b::position::isPosPositive(arg0)) {
            0x7fcdfcea346ffd3b1da4a2de11d772a5bf14b3e7af550167b11764760af6739b::library::min(v0, 0x7fcdfcea346ffd3b1da4a2de11d772a5bf14b3e7af550167b11764760af6739b::signed_number::positive_value(0x7fcdfcea346ffd3b1da4a2de11d772a5bf14b3e7af550167b11764760af6739b::signed_number::add_uint(0x7fcdfcea346ffd3b1da4a2de11d772a5bf14b3e7af550167b11764760af6739b::signed_number::from_subtraction(v0, 0x7fcdfcea346ffd3b1da4a2de11d772a5bf14b3e7af550167b11764760af6739b::position::oiOpen(arg0)), 0x7fcdfcea346ffd3b1da4a2de11d772a5bf14b3e7af550167b11764760af6739b::library::base_mul(0x7fcdfcea346ffd3b1da4a2de11d772a5bf14b3e7af550167b11764760af6739b::library::base_mul(0x7fcdfcea346ffd3b1da4a2de11d772a5bf14b3e7af550167b11764760af6739b::position::qPos(arg0), arg1), 0x7fcdfcea346ffd3b1da4a2de11d772a5bf14b3e7af550167b11764760af6739b::library::base_uint() - 0x7fcdfcea346ffd3b1da4a2de11d772a5bf14b3e7af550167b11764760af6739b::position::mro(arg0)))))
        } else {
            0x7fcdfcea346ffd3b1da4a2de11d772a5bf14b3e7af550167b11764760af6739b::library::min(v0, 0x7fcdfcea346ffd3b1da4a2de11d772a5bf14b3e7af550167b11764760af6739b::library::sub(v0 + 0x7fcdfcea346ffd3b1da4a2de11d772a5bf14b3e7af550167b11764760af6739b::position::oiOpen(arg0), 0x7fcdfcea346ffd3b1da4a2de11d772a5bf14b3e7af550167b11764760af6739b::library::base_mul(0x7fcdfcea346ffd3b1da4a2de11d772a5bf14b3e7af550167b11764760af6739b::library::base_mul(0x7fcdfcea346ffd3b1da4a2de11d772a5bf14b3e7af550167b11764760af6739b::position::qPos(arg0), arg1), 0x7fcdfcea346ffd3b1da4a2de11d772a5bf14b3e7af550167b11764760af6739b::library::base_uint() + 0x7fcdfcea346ffd3b1da4a2de11d772a5bf14b3e7af550167b11764760af6739b::position::mro(arg0))))
        }
    }

    public(friend) fun get_target_margin(arg0: 0x7fcdfcea346ffd3b1da4a2de11d772a5bf14b3e7af550167b11764760af6739b::position::UserPosition, arg1: u128, arg2: u128) : u128 {
        let v0 = 0x7fcdfcea346ffd3b1da4a2de11d772a5bf14b3e7af550167b11764760af6739b::library::base_mul(0x7fcdfcea346ffd3b1da4a2de11d772a5bf14b3e7af550167b11764760af6739b::position::qPos(arg0), arg2);
        if (0x7fcdfcea346ffd3b1da4a2de11d772a5bf14b3e7af550167b11764760af6739b::position::isPosPositive(arg0)) {
            0x7fcdfcea346ffd3b1da4a2de11d772a5bf14b3e7af550167b11764760af6739b::library::sub(0x7fcdfcea346ffd3b1da4a2de11d772a5bf14b3e7af550167b11764760af6739b::library::base_div(v0, arg1) + 0x7fcdfcea346ffd3b1da4a2de11d772a5bf14b3e7af550167b11764760af6739b::position::oiOpen(arg0), v0)
        } else {
            0x7fcdfcea346ffd3b1da4a2de11d772a5bf14b3e7af550167b11764760af6739b::library::sub(0x7fcdfcea346ffd3b1da4a2de11d772a5bf14b3e7af550167b11764760af6739b::library::base_div(v0, arg1) + v0, 0x7fcdfcea346ffd3b1da4a2de11d772a5bf14b3e7af550167b11764760af6739b::position::oiOpen(arg0))
        }
    }

    // decompiled from Move bytecode v6
}

