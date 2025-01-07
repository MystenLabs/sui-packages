module 0xd8fe849e1c4dc882ca67fc1f2861fbcc4f3b0c2e35c584ff9cfd87185aebaabe::margin_math {
    public(friend) fun get_margin_left(arg0: 0xd8fe849e1c4dc882ca67fc1f2861fbcc4f3b0c2e35c584ff9cfd87185aebaabe::position::UserPosition, arg1: u128, arg2: u128) : u128 {
        let v0 = 0xd8fe849e1c4dc882ca67fc1f2861fbcc4f3b0c2e35c584ff9cfd87185aebaabe::position::oiOpen(arg0);
        let v1 = if (0xd8fe849e1c4dc882ca67fc1f2861fbcc4f3b0c2e35c584ff9cfd87185aebaabe::position::isPosPositive(arg0)) {
            0xd8fe849e1c4dc882ca67fc1f2861fbcc4f3b0c2e35c584ff9cfd87185aebaabe::library::sub(0xd8fe849e1c4dc882ca67fc1f2861fbcc4f3b0c2e35c584ff9cfd87185aebaabe::position::margin(arg0) + v0 * arg1 / 0xd8fe849e1c4dc882ca67fc1f2861fbcc4f3b0c2e35c584ff9cfd87185aebaabe::position::compute_average_entry_price(arg0), v0)
        } else {
            0xd8fe849e1c4dc882ca67fc1f2861fbcc4f3b0c2e35c584ff9cfd87185aebaabe::library::sub(0xd8fe849e1c4dc882ca67fc1f2861fbcc4f3b0c2e35c584ff9cfd87185aebaabe::position::margin(arg0) + v0, v0 * arg1 / 0xd8fe849e1c4dc882ca67fc1f2861fbcc4f3b0c2e35c584ff9cfd87185aebaabe::position::compute_average_entry_price(arg0))
        };
        0xd8fe849e1c4dc882ca67fc1f2861fbcc4f3b0c2e35c584ff9cfd87185aebaabe::library::min(v1, arg2)
    }

    public(friend) fun get_max_removeable_margin(arg0: 0xd8fe849e1c4dc882ca67fc1f2861fbcc4f3b0c2e35c584ff9cfd87185aebaabe::position::UserPosition, arg1: u128) : u128 {
        let v0 = 0xd8fe849e1c4dc882ca67fc1f2861fbcc4f3b0c2e35c584ff9cfd87185aebaabe::position::margin(arg0);
        if (0xd8fe849e1c4dc882ca67fc1f2861fbcc4f3b0c2e35c584ff9cfd87185aebaabe::position::isPosPositive(arg0)) {
            0xd8fe849e1c4dc882ca67fc1f2861fbcc4f3b0c2e35c584ff9cfd87185aebaabe::library::min(v0, 0xd8fe849e1c4dc882ca67fc1f2861fbcc4f3b0c2e35c584ff9cfd87185aebaabe::signed_number::positive_value(0xd8fe849e1c4dc882ca67fc1f2861fbcc4f3b0c2e35c584ff9cfd87185aebaabe::signed_number::add_uint(0xd8fe849e1c4dc882ca67fc1f2861fbcc4f3b0c2e35c584ff9cfd87185aebaabe::signed_number::from_subtraction(v0, 0xd8fe849e1c4dc882ca67fc1f2861fbcc4f3b0c2e35c584ff9cfd87185aebaabe::position::oiOpen(arg0)), 0xd8fe849e1c4dc882ca67fc1f2861fbcc4f3b0c2e35c584ff9cfd87185aebaabe::library::base_mul(0xd8fe849e1c4dc882ca67fc1f2861fbcc4f3b0c2e35c584ff9cfd87185aebaabe::library::base_mul(0xd8fe849e1c4dc882ca67fc1f2861fbcc4f3b0c2e35c584ff9cfd87185aebaabe::position::qPos(arg0), arg1), 0xd8fe849e1c4dc882ca67fc1f2861fbcc4f3b0c2e35c584ff9cfd87185aebaabe::library::base_uint() - 0xd8fe849e1c4dc882ca67fc1f2861fbcc4f3b0c2e35c584ff9cfd87185aebaabe::position::mro(arg0)))))
        } else {
            0xd8fe849e1c4dc882ca67fc1f2861fbcc4f3b0c2e35c584ff9cfd87185aebaabe::library::min(v0, 0xd8fe849e1c4dc882ca67fc1f2861fbcc4f3b0c2e35c584ff9cfd87185aebaabe::library::sub(v0 + 0xd8fe849e1c4dc882ca67fc1f2861fbcc4f3b0c2e35c584ff9cfd87185aebaabe::position::oiOpen(arg0), 0xd8fe849e1c4dc882ca67fc1f2861fbcc4f3b0c2e35c584ff9cfd87185aebaabe::library::base_mul(0xd8fe849e1c4dc882ca67fc1f2861fbcc4f3b0c2e35c584ff9cfd87185aebaabe::library::base_mul(0xd8fe849e1c4dc882ca67fc1f2861fbcc4f3b0c2e35c584ff9cfd87185aebaabe::position::qPos(arg0), arg1), 0xd8fe849e1c4dc882ca67fc1f2861fbcc4f3b0c2e35c584ff9cfd87185aebaabe::library::base_uint() + 0xd8fe849e1c4dc882ca67fc1f2861fbcc4f3b0c2e35c584ff9cfd87185aebaabe::position::mro(arg0))))
        }
    }

    public(friend) fun get_target_margin(arg0: 0xd8fe849e1c4dc882ca67fc1f2861fbcc4f3b0c2e35c584ff9cfd87185aebaabe::position::UserPosition, arg1: u128, arg2: u128) : u128 {
        let v0 = 0xd8fe849e1c4dc882ca67fc1f2861fbcc4f3b0c2e35c584ff9cfd87185aebaabe::library::base_mul(0xd8fe849e1c4dc882ca67fc1f2861fbcc4f3b0c2e35c584ff9cfd87185aebaabe::position::qPos(arg0), arg2);
        if (0xd8fe849e1c4dc882ca67fc1f2861fbcc4f3b0c2e35c584ff9cfd87185aebaabe::position::isPosPositive(arg0)) {
            0xd8fe849e1c4dc882ca67fc1f2861fbcc4f3b0c2e35c584ff9cfd87185aebaabe::library::sub(0xd8fe849e1c4dc882ca67fc1f2861fbcc4f3b0c2e35c584ff9cfd87185aebaabe::library::base_div(v0, arg1) + 0xd8fe849e1c4dc882ca67fc1f2861fbcc4f3b0c2e35c584ff9cfd87185aebaabe::position::oiOpen(arg0), v0)
        } else {
            0xd8fe849e1c4dc882ca67fc1f2861fbcc4f3b0c2e35c584ff9cfd87185aebaabe::library::sub(0xd8fe849e1c4dc882ca67fc1f2861fbcc4f3b0c2e35c584ff9cfd87185aebaabe::library::base_div(v0, arg1) + v0, 0xd8fe849e1c4dc882ca67fc1f2861fbcc4f3b0c2e35c584ff9cfd87185aebaabe::position::oiOpen(arg0))
        }
    }

    // decompiled from Move bytecode v6
}

