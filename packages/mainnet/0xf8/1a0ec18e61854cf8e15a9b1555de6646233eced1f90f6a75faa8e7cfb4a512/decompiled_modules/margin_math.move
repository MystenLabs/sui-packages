module 0xf81a0ec18e61854cf8e15a9b1555de6646233eced1f90f6a75faa8e7cfb4a512::margin_math {
    public(friend) fun get_margin_left(arg0: 0xf81a0ec18e61854cf8e15a9b1555de6646233eced1f90f6a75faa8e7cfb4a512::position::UserPosition, arg1: u128, arg2: u128) : u128 {
        let v0 = 0xf81a0ec18e61854cf8e15a9b1555de6646233eced1f90f6a75faa8e7cfb4a512::position::oiOpen(arg0);
        let v1 = if (0xf81a0ec18e61854cf8e15a9b1555de6646233eced1f90f6a75faa8e7cfb4a512::position::isPosPositive(arg0)) {
            0xf81a0ec18e61854cf8e15a9b1555de6646233eced1f90f6a75faa8e7cfb4a512::library::sub(0xf81a0ec18e61854cf8e15a9b1555de6646233eced1f90f6a75faa8e7cfb4a512::position::margin(arg0) + v0 * arg1 / 0xf81a0ec18e61854cf8e15a9b1555de6646233eced1f90f6a75faa8e7cfb4a512::position::compute_average_entry_price(arg0), v0)
        } else {
            0xf81a0ec18e61854cf8e15a9b1555de6646233eced1f90f6a75faa8e7cfb4a512::library::sub(0xf81a0ec18e61854cf8e15a9b1555de6646233eced1f90f6a75faa8e7cfb4a512::position::margin(arg0) + v0, v0 * arg1 / 0xf81a0ec18e61854cf8e15a9b1555de6646233eced1f90f6a75faa8e7cfb4a512::position::compute_average_entry_price(arg0))
        };
        0xf81a0ec18e61854cf8e15a9b1555de6646233eced1f90f6a75faa8e7cfb4a512::library::min(v1, arg2)
    }

    public(friend) fun get_max_removeable_margin(arg0: 0xf81a0ec18e61854cf8e15a9b1555de6646233eced1f90f6a75faa8e7cfb4a512::position::UserPosition, arg1: u128) : u128 {
        let v0 = 0xf81a0ec18e61854cf8e15a9b1555de6646233eced1f90f6a75faa8e7cfb4a512::position::margin(arg0);
        if (0xf81a0ec18e61854cf8e15a9b1555de6646233eced1f90f6a75faa8e7cfb4a512::position::isPosPositive(arg0)) {
            0xf81a0ec18e61854cf8e15a9b1555de6646233eced1f90f6a75faa8e7cfb4a512::library::min(v0, 0xf81a0ec18e61854cf8e15a9b1555de6646233eced1f90f6a75faa8e7cfb4a512::signed_number::positive_value(0xf81a0ec18e61854cf8e15a9b1555de6646233eced1f90f6a75faa8e7cfb4a512::signed_number::add_uint(0xf81a0ec18e61854cf8e15a9b1555de6646233eced1f90f6a75faa8e7cfb4a512::signed_number::from_subtraction(v0, 0xf81a0ec18e61854cf8e15a9b1555de6646233eced1f90f6a75faa8e7cfb4a512::position::oiOpen(arg0)), 0xf81a0ec18e61854cf8e15a9b1555de6646233eced1f90f6a75faa8e7cfb4a512::library::base_mul(0xf81a0ec18e61854cf8e15a9b1555de6646233eced1f90f6a75faa8e7cfb4a512::library::base_mul(0xf81a0ec18e61854cf8e15a9b1555de6646233eced1f90f6a75faa8e7cfb4a512::position::qPos(arg0), arg1), 0xf81a0ec18e61854cf8e15a9b1555de6646233eced1f90f6a75faa8e7cfb4a512::library::base_uint() - 0xf81a0ec18e61854cf8e15a9b1555de6646233eced1f90f6a75faa8e7cfb4a512::position::mro(arg0)))))
        } else {
            0xf81a0ec18e61854cf8e15a9b1555de6646233eced1f90f6a75faa8e7cfb4a512::library::min(v0, 0xf81a0ec18e61854cf8e15a9b1555de6646233eced1f90f6a75faa8e7cfb4a512::library::sub(v0 + 0xf81a0ec18e61854cf8e15a9b1555de6646233eced1f90f6a75faa8e7cfb4a512::position::oiOpen(arg0), 0xf81a0ec18e61854cf8e15a9b1555de6646233eced1f90f6a75faa8e7cfb4a512::library::base_mul(0xf81a0ec18e61854cf8e15a9b1555de6646233eced1f90f6a75faa8e7cfb4a512::library::base_mul(0xf81a0ec18e61854cf8e15a9b1555de6646233eced1f90f6a75faa8e7cfb4a512::position::qPos(arg0), arg1), 0xf81a0ec18e61854cf8e15a9b1555de6646233eced1f90f6a75faa8e7cfb4a512::library::base_uint() + 0xf81a0ec18e61854cf8e15a9b1555de6646233eced1f90f6a75faa8e7cfb4a512::position::mro(arg0))))
        }
    }

    public(friend) fun get_target_margin(arg0: 0xf81a0ec18e61854cf8e15a9b1555de6646233eced1f90f6a75faa8e7cfb4a512::position::UserPosition, arg1: u128, arg2: u128) : u128 {
        let v0 = 0xf81a0ec18e61854cf8e15a9b1555de6646233eced1f90f6a75faa8e7cfb4a512::library::base_mul(0xf81a0ec18e61854cf8e15a9b1555de6646233eced1f90f6a75faa8e7cfb4a512::position::qPos(arg0), arg2);
        if (0xf81a0ec18e61854cf8e15a9b1555de6646233eced1f90f6a75faa8e7cfb4a512::position::isPosPositive(arg0)) {
            0xf81a0ec18e61854cf8e15a9b1555de6646233eced1f90f6a75faa8e7cfb4a512::library::sub(0xf81a0ec18e61854cf8e15a9b1555de6646233eced1f90f6a75faa8e7cfb4a512::library::base_div(v0, arg1) + 0xf81a0ec18e61854cf8e15a9b1555de6646233eced1f90f6a75faa8e7cfb4a512::position::oiOpen(arg0), v0)
        } else {
            0xf81a0ec18e61854cf8e15a9b1555de6646233eced1f90f6a75faa8e7cfb4a512::library::sub(0xf81a0ec18e61854cf8e15a9b1555de6646233eced1f90f6a75faa8e7cfb4a512::library::base_div(v0, arg1) + v0, 0xf81a0ec18e61854cf8e15a9b1555de6646233eced1f90f6a75faa8e7cfb4a512::position::oiOpen(arg0))
        }
    }

    // decompiled from Move bytecode v6
}

