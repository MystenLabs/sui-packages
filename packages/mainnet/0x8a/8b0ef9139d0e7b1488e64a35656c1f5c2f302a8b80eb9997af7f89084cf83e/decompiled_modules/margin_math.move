module 0x8a8b0ef9139d0e7b1488e64a35656c1f5c2f302a8b80eb9997af7f89084cf83e::margin_math {
    public(friend) fun get_margin_left(arg0: 0x8a8b0ef9139d0e7b1488e64a35656c1f5c2f302a8b80eb9997af7f89084cf83e::position::UserPosition, arg1: u128, arg2: u128) : u128 {
        let v0 = 0x8a8b0ef9139d0e7b1488e64a35656c1f5c2f302a8b80eb9997af7f89084cf83e::position::oiOpen(arg0);
        let v1 = if (0x8a8b0ef9139d0e7b1488e64a35656c1f5c2f302a8b80eb9997af7f89084cf83e::position::isPosPositive(arg0)) {
            0x8a8b0ef9139d0e7b1488e64a35656c1f5c2f302a8b80eb9997af7f89084cf83e::library::sub(0x8a8b0ef9139d0e7b1488e64a35656c1f5c2f302a8b80eb9997af7f89084cf83e::position::margin(arg0) + v0 * arg1 / 0x8a8b0ef9139d0e7b1488e64a35656c1f5c2f302a8b80eb9997af7f89084cf83e::position::compute_average_entry_price(arg0), v0)
        } else {
            0x8a8b0ef9139d0e7b1488e64a35656c1f5c2f302a8b80eb9997af7f89084cf83e::library::sub(0x8a8b0ef9139d0e7b1488e64a35656c1f5c2f302a8b80eb9997af7f89084cf83e::position::margin(arg0) + v0, v0 * arg1 / 0x8a8b0ef9139d0e7b1488e64a35656c1f5c2f302a8b80eb9997af7f89084cf83e::position::compute_average_entry_price(arg0))
        };
        0x8a8b0ef9139d0e7b1488e64a35656c1f5c2f302a8b80eb9997af7f89084cf83e::library::min(v1, arg2)
    }

    public(friend) fun get_max_removeable_margin(arg0: 0x8a8b0ef9139d0e7b1488e64a35656c1f5c2f302a8b80eb9997af7f89084cf83e::position::UserPosition, arg1: u128) : u128 {
        let v0 = 0x8a8b0ef9139d0e7b1488e64a35656c1f5c2f302a8b80eb9997af7f89084cf83e::position::margin(arg0);
        if (0x8a8b0ef9139d0e7b1488e64a35656c1f5c2f302a8b80eb9997af7f89084cf83e::position::isPosPositive(arg0)) {
            0x8a8b0ef9139d0e7b1488e64a35656c1f5c2f302a8b80eb9997af7f89084cf83e::library::min(v0, 0x8a8b0ef9139d0e7b1488e64a35656c1f5c2f302a8b80eb9997af7f89084cf83e::signed_number::positive_value(0x8a8b0ef9139d0e7b1488e64a35656c1f5c2f302a8b80eb9997af7f89084cf83e::signed_number::add_uint(0x8a8b0ef9139d0e7b1488e64a35656c1f5c2f302a8b80eb9997af7f89084cf83e::signed_number::from_subtraction(v0, 0x8a8b0ef9139d0e7b1488e64a35656c1f5c2f302a8b80eb9997af7f89084cf83e::position::oiOpen(arg0)), 0x8a8b0ef9139d0e7b1488e64a35656c1f5c2f302a8b80eb9997af7f89084cf83e::library::base_mul(0x8a8b0ef9139d0e7b1488e64a35656c1f5c2f302a8b80eb9997af7f89084cf83e::library::base_mul(0x8a8b0ef9139d0e7b1488e64a35656c1f5c2f302a8b80eb9997af7f89084cf83e::position::qPos(arg0), arg1), 0x8a8b0ef9139d0e7b1488e64a35656c1f5c2f302a8b80eb9997af7f89084cf83e::library::base_uint() - 0x8a8b0ef9139d0e7b1488e64a35656c1f5c2f302a8b80eb9997af7f89084cf83e::position::mro(arg0)))))
        } else {
            0x8a8b0ef9139d0e7b1488e64a35656c1f5c2f302a8b80eb9997af7f89084cf83e::library::min(v0, 0x8a8b0ef9139d0e7b1488e64a35656c1f5c2f302a8b80eb9997af7f89084cf83e::library::sub(v0 + 0x8a8b0ef9139d0e7b1488e64a35656c1f5c2f302a8b80eb9997af7f89084cf83e::position::oiOpen(arg0), 0x8a8b0ef9139d0e7b1488e64a35656c1f5c2f302a8b80eb9997af7f89084cf83e::library::base_mul(0x8a8b0ef9139d0e7b1488e64a35656c1f5c2f302a8b80eb9997af7f89084cf83e::library::base_mul(0x8a8b0ef9139d0e7b1488e64a35656c1f5c2f302a8b80eb9997af7f89084cf83e::position::qPos(arg0), arg1), 0x8a8b0ef9139d0e7b1488e64a35656c1f5c2f302a8b80eb9997af7f89084cf83e::library::base_uint() + 0x8a8b0ef9139d0e7b1488e64a35656c1f5c2f302a8b80eb9997af7f89084cf83e::position::mro(arg0))))
        }
    }

    public(friend) fun get_target_margin(arg0: 0x8a8b0ef9139d0e7b1488e64a35656c1f5c2f302a8b80eb9997af7f89084cf83e::position::UserPosition, arg1: u128, arg2: u128) : u128 {
        let v0 = 0x8a8b0ef9139d0e7b1488e64a35656c1f5c2f302a8b80eb9997af7f89084cf83e::library::base_mul(0x8a8b0ef9139d0e7b1488e64a35656c1f5c2f302a8b80eb9997af7f89084cf83e::position::qPos(arg0), arg2);
        if (0x8a8b0ef9139d0e7b1488e64a35656c1f5c2f302a8b80eb9997af7f89084cf83e::position::isPosPositive(arg0)) {
            0x8a8b0ef9139d0e7b1488e64a35656c1f5c2f302a8b80eb9997af7f89084cf83e::library::sub(0x8a8b0ef9139d0e7b1488e64a35656c1f5c2f302a8b80eb9997af7f89084cf83e::library::base_div(v0, arg1) + 0x8a8b0ef9139d0e7b1488e64a35656c1f5c2f302a8b80eb9997af7f89084cf83e::position::oiOpen(arg0), v0)
        } else {
            0x8a8b0ef9139d0e7b1488e64a35656c1f5c2f302a8b80eb9997af7f89084cf83e::library::sub(0x8a8b0ef9139d0e7b1488e64a35656c1f5c2f302a8b80eb9997af7f89084cf83e::library::base_div(v0, arg1) + v0, 0x8a8b0ef9139d0e7b1488e64a35656c1f5c2f302a8b80eb9997af7f89084cf83e::position::oiOpen(arg0))
        }
    }

    // decompiled from Move bytecode v6
}

