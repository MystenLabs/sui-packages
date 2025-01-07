module 0xb5f7d1feb6c1ac8581297f13cdc36b5d131713727c15c9c1b0050278bea5aab2::margin_math {
    public(friend) fun get_margin_left(arg0: 0xb5f7d1feb6c1ac8581297f13cdc36b5d131713727c15c9c1b0050278bea5aab2::position::UserPosition, arg1: u128, arg2: u128) : u128 {
        let v0 = 0xb5f7d1feb6c1ac8581297f13cdc36b5d131713727c15c9c1b0050278bea5aab2::position::oiOpen(arg0);
        let v1 = if (0xb5f7d1feb6c1ac8581297f13cdc36b5d131713727c15c9c1b0050278bea5aab2::position::isPosPositive(arg0)) {
            0xb5f7d1feb6c1ac8581297f13cdc36b5d131713727c15c9c1b0050278bea5aab2::library::sub(0xb5f7d1feb6c1ac8581297f13cdc36b5d131713727c15c9c1b0050278bea5aab2::position::margin(arg0) + v0 * arg1 / 0xb5f7d1feb6c1ac8581297f13cdc36b5d131713727c15c9c1b0050278bea5aab2::position::compute_average_entry_price(arg0), v0)
        } else {
            0xb5f7d1feb6c1ac8581297f13cdc36b5d131713727c15c9c1b0050278bea5aab2::library::sub(0xb5f7d1feb6c1ac8581297f13cdc36b5d131713727c15c9c1b0050278bea5aab2::position::margin(arg0) + v0, v0 * arg1 / 0xb5f7d1feb6c1ac8581297f13cdc36b5d131713727c15c9c1b0050278bea5aab2::position::compute_average_entry_price(arg0))
        };
        0xb5f7d1feb6c1ac8581297f13cdc36b5d131713727c15c9c1b0050278bea5aab2::library::min(v1, arg2)
    }

    public(friend) fun get_max_removeable_margin(arg0: 0xb5f7d1feb6c1ac8581297f13cdc36b5d131713727c15c9c1b0050278bea5aab2::position::UserPosition, arg1: u128) : u128 {
        let v0 = 0xb5f7d1feb6c1ac8581297f13cdc36b5d131713727c15c9c1b0050278bea5aab2::position::margin(arg0);
        if (0xb5f7d1feb6c1ac8581297f13cdc36b5d131713727c15c9c1b0050278bea5aab2::position::isPosPositive(arg0)) {
            0xb5f7d1feb6c1ac8581297f13cdc36b5d131713727c15c9c1b0050278bea5aab2::library::min(v0, 0xb5f7d1feb6c1ac8581297f13cdc36b5d131713727c15c9c1b0050278bea5aab2::signed_number::positive_value(0xb5f7d1feb6c1ac8581297f13cdc36b5d131713727c15c9c1b0050278bea5aab2::signed_number::add_uint(0xb5f7d1feb6c1ac8581297f13cdc36b5d131713727c15c9c1b0050278bea5aab2::signed_number::from_subtraction(v0, 0xb5f7d1feb6c1ac8581297f13cdc36b5d131713727c15c9c1b0050278bea5aab2::position::oiOpen(arg0)), 0xb5f7d1feb6c1ac8581297f13cdc36b5d131713727c15c9c1b0050278bea5aab2::library::base_mul(0xb5f7d1feb6c1ac8581297f13cdc36b5d131713727c15c9c1b0050278bea5aab2::library::base_mul(0xb5f7d1feb6c1ac8581297f13cdc36b5d131713727c15c9c1b0050278bea5aab2::position::qPos(arg0), arg1), 0xb5f7d1feb6c1ac8581297f13cdc36b5d131713727c15c9c1b0050278bea5aab2::library::base_uint() - 0xb5f7d1feb6c1ac8581297f13cdc36b5d131713727c15c9c1b0050278bea5aab2::position::mro(arg0)))))
        } else {
            0xb5f7d1feb6c1ac8581297f13cdc36b5d131713727c15c9c1b0050278bea5aab2::library::min(v0, 0xb5f7d1feb6c1ac8581297f13cdc36b5d131713727c15c9c1b0050278bea5aab2::library::sub(v0 + 0xb5f7d1feb6c1ac8581297f13cdc36b5d131713727c15c9c1b0050278bea5aab2::position::oiOpen(arg0), 0xb5f7d1feb6c1ac8581297f13cdc36b5d131713727c15c9c1b0050278bea5aab2::library::base_mul(0xb5f7d1feb6c1ac8581297f13cdc36b5d131713727c15c9c1b0050278bea5aab2::library::base_mul(0xb5f7d1feb6c1ac8581297f13cdc36b5d131713727c15c9c1b0050278bea5aab2::position::qPos(arg0), arg1), 0xb5f7d1feb6c1ac8581297f13cdc36b5d131713727c15c9c1b0050278bea5aab2::library::base_uint() + 0xb5f7d1feb6c1ac8581297f13cdc36b5d131713727c15c9c1b0050278bea5aab2::position::mro(arg0))))
        }
    }

    public(friend) fun get_target_margin(arg0: 0xb5f7d1feb6c1ac8581297f13cdc36b5d131713727c15c9c1b0050278bea5aab2::position::UserPosition, arg1: u128, arg2: u128) : u128 {
        let v0 = 0xb5f7d1feb6c1ac8581297f13cdc36b5d131713727c15c9c1b0050278bea5aab2::library::base_mul(0xb5f7d1feb6c1ac8581297f13cdc36b5d131713727c15c9c1b0050278bea5aab2::position::qPos(arg0), arg2);
        if (0xb5f7d1feb6c1ac8581297f13cdc36b5d131713727c15c9c1b0050278bea5aab2::position::isPosPositive(arg0)) {
            0xb5f7d1feb6c1ac8581297f13cdc36b5d131713727c15c9c1b0050278bea5aab2::library::sub(0xb5f7d1feb6c1ac8581297f13cdc36b5d131713727c15c9c1b0050278bea5aab2::library::base_div(v0, arg1) + 0xb5f7d1feb6c1ac8581297f13cdc36b5d131713727c15c9c1b0050278bea5aab2::position::oiOpen(arg0), v0)
        } else {
            0xb5f7d1feb6c1ac8581297f13cdc36b5d131713727c15c9c1b0050278bea5aab2::library::sub(0xb5f7d1feb6c1ac8581297f13cdc36b5d131713727c15c9c1b0050278bea5aab2::library::base_div(v0, arg1) + v0, 0xb5f7d1feb6c1ac8581297f13cdc36b5d131713727c15c9c1b0050278bea5aab2::position::oiOpen(arg0))
        }
    }

    // decompiled from Move bytecode v6
}

