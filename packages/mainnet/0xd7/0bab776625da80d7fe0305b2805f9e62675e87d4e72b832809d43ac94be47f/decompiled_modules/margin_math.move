module 0xd70bab776625da80d7fe0305b2805f9e62675e87d4e72b832809d43ac94be47f::margin_math {
    public(friend) fun get_margin_left(arg0: 0xd70bab776625da80d7fe0305b2805f9e62675e87d4e72b832809d43ac94be47f::position::UserPosition, arg1: u128, arg2: u128) : u128 {
        let v0 = 0xd70bab776625da80d7fe0305b2805f9e62675e87d4e72b832809d43ac94be47f::position::oiOpen(arg0);
        let v1 = if (0xd70bab776625da80d7fe0305b2805f9e62675e87d4e72b832809d43ac94be47f::position::isPosPositive(arg0)) {
            0xd70bab776625da80d7fe0305b2805f9e62675e87d4e72b832809d43ac94be47f::library::sub(0xd70bab776625da80d7fe0305b2805f9e62675e87d4e72b832809d43ac94be47f::position::margin(arg0) + v0 * arg1 / 0xd70bab776625da80d7fe0305b2805f9e62675e87d4e72b832809d43ac94be47f::position::compute_average_entry_price(arg0), v0)
        } else {
            0xd70bab776625da80d7fe0305b2805f9e62675e87d4e72b832809d43ac94be47f::library::sub(0xd70bab776625da80d7fe0305b2805f9e62675e87d4e72b832809d43ac94be47f::position::margin(arg0) + v0, v0 * arg1 / 0xd70bab776625da80d7fe0305b2805f9e62675e87d4e72b832809d43ac94be47f::position::compute_average_entry_price(arg0))
        };
        0xd70bab776625da80d7fe0305b2805f9e62675e87d4e72b832809d43ac94be47f::library::min(v1, arg2)
    }

    public(friend) fun get_max_removeable_margin(arg0: 0xd70bab776625da80d7fe0305b2805f9e62675e87d4e72b832809d43ac94be47f::position::UserPosition, arg1: u128) : u128 {
        let v0 = 0xd70bab776625da80d7fe0305b2805f9e62675e87d4e72b832809d43ac94be47f::position::margin(arg0);
        if (0xd70bab776625da80d7fe0305b2805f9e62675e87d4e72b832809d43ac94be47f::position::isPosPositive(arg0)) {
            0xd70bab776625da80d7fe0305b2805f9e62675e87d4e72b832809d43ac94be47f::library::min(v0, 0xd70bab776625da80d7fe0305b2805f9e62675e87d4e72b832809d43ac94be47f::signed_number::positive_value(0xd70bab776625da80d7fe0305b2805f9e62675e87d4e72b832809d43ac94be47f::signed_number::add_uint(0xd70bab776625da80d7fe0305b2805f9e62675e87d4e72b832809d43ac94be47f::signed_number::from_subtraction(v0, 0xd70bab776625da80d7fe0305b2805f9e62675e87d4e72b832809d43ac94be47f::position::oiOpen(arg0)), 0xd70bab776625da80d7fe0305b2805f9e62675e87d4e72b832809d43ac94be47f::library::base_mul(0xd70bab776625da80d7fe0305b2805f9e62675e87d4e72b832809d43ac94be47f::library::base_mul(0xd70bab776625da80d7fe0305b2805f9e62675e87d4e72b832809d43ac94be47f::position::qPos(arg0), arg1), 0xd70bab776625da80d7fe0305b2805f9e62675e87d4e72b832809d43ac94be47f::library::base_uint() - 0xd70bab776625da80d7fe0305b2805f9e62675e87d4e72b832809d43ac94be47f::position::mro(arg0)))))
        } else {
            0xd70bab776625da80d7fe0305b2805f9e62675e87d4e72b832809d43ac94be47f::library::min(v0, 0xd70bab776625da80d7fe0305b2805f9e62675e87d4e72b832809d43ac94be47f::library::sub(v0 + 0xd70bab776625da80d7fe0305b2805f9e62675e87d4e72b832809d43ac94be47f::position::oiOpen(arg0), 0xd70bab776625da80d7fe0305b2805f9e62675e87d4e72b832809d43ac94be47f::library::base_mul(0xd70bab776625da80d7fe0305b2805f9e62675e87d4e72b832809d43ac94be47f::library::base_mul(0xd70bab776625da80d7fe0305b2805f9e62675e87d4e72b832809d43ac94be47f::position::qPos(arg0), arg1), 0xd70bab776625da80d7fe0305b2805f9e62675e87d4e72b832809d43ac94be47f::library::base_uint() + 0xd70bab776625da80d7fe0305b2805f9e62675e87d4e72b832809d43ac94be47f::position::mro(arg0))))
        }
    }

    public(friend) fun get_target_margin(arg0: 0xd70bab776625da80d7fe0305b2805f9e62675e87d4e72b832809d43ac94be47f::position::UserPosition, arg1: u128, arg2: u128) : u128 {
        let v0 = 0xd70bab776625da80d7fe0305b2805f9e62675e87d4e72b832809d43ac94be47f::library::base_mul(0xd70bab776625da80d7fe0305b2805f9e62675e87d4e72b832809d43ac94be47f::position::qPos(arg0), arg2);
        if (0xd70bab776625da80d7fe0305b2805f9e62675e87d4e72b832809d43ac94be47f::position::isPosPositive(arg0)) {
            0xd70bab776625da80d7fe0305b2805f9e62675e87d4e72b832809d43ac94be47f::library::sub(0xd70bab776625da80d7fe0305b2805f9e62675e87d4e72b832809d43ac94be47f::library::base_div(v0, arg1) + 0xd70bab776625da80d7fe0305b2805f9e62675e87d4e72b832809d43ac94be47f::position::oiOpen(arg0), v0)
        } else {
            0xd70bab776625da80d7fe0305b2805f9e62675e87d4e72b832809d43ac94be47f::library::sub(0xd70bab776625da80d7fe0305b2805f9e62675e87d4e72b832809d43ac94be47f::library::base_div(v0, arg1) + v0, 0xd70bab776625da80d7fe0305b2805f9e62675e87d4e72b832809d43ac94be47f::position::oiOpen(arg0))
        }
    }

    // decompiled from Move bytecode v6
}

