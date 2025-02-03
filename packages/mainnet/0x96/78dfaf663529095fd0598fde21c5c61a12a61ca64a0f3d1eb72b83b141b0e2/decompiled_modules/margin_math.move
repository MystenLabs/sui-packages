module 0x9678dfaf663529095fd0598fde21c5c61a12a61ca64a0f3d1eb72b83b141b0e2::margin_math {
    public(friend) fun get_margin_left(arg0: 0x9678dfaf663529095fd0598fde21c5c61a12a61ca64a0f3d1eb72b83b141b0e2::position::UserPosition, arg1: u128, arg2: u128) : u128 {
        let v0 = 0x9678dfaf663529095fd0598fde21c5c61a12a61ca64a0f3d1eb72b83b141b0e2::position::oiOpen(arg0);
        let v1 = if (0x9678dfaf663529095fd0598fde21c5c61a12a61ca64a0f3d1eb72b83b141b0e2::position::isPosPositive(arg0)) {
            0x9678dfaf663529095fd0598fde21c5c61a12a61ca64a0f3d1eb72b83b141b0e2::library::sub(0x9678dfaf663529095fd0598fde21c5c61a12a61ca64a0f3d1eb72b83b141b0e2::position::margin(arg0) + v0 * arg1 / 0x9678dfaf663529095fd0598fde21c5c61a12a61ca64a0f3d1eb72b83b141b0e2::position::compute_average_entry_price(arg0), v0)
        } else {
            0x9678dfaf663529095fd0598fde21c5c61a12a61ca64a0f3d1eb72b83b141b0e2::library::sub(0x9678dfaf663529095fd0598fde21c5c61a12a61ca64a0f3d1eb72b83b141b0e2::position::margin(arg0) + v0, v0 * arg1 / 0x9678dfaf663529095fd0598fde21c5c61a12a61ca64a0f3d1eb72b83b141b0e2::position::compute_average_entry_price(arg0))
        };
        0x9678dfaf663529095fd0598fde21c5c61a12a61ca64a0f3d1eb72b83b141b0e2::library::min(v1, arg2)
    }

    public(friend) fun get_max_removeable_margin(arg0: 0x9678dfaf663529095fd0598fde21c5c61a12a61ca64a0f3d1eb72b83b141b0e2::position::UserPosition, arg1: u128) : u128 {
        let v0 = 0x9678dfaf663529095fd0598fde21c5c61a12a61ca64a0f3d1eb72b83b141b0e2::position::margin(arg0);
        if (0x9678dfaf663529095fd0598fde21c5c61a12a61ca64a0f3d1eb72b83b141b0e2::position::isPosPositive(arg0)) {
            0x9678dfaf663529095fd0598fde21c5c61a12a61ca64a0f3d1eb72b83b141b0e2::library::min(v0, 0x9678dfaf663529095fd0598fde21c5c61a12a61ca64a0f3d1eb72b83b141b0e2::signed_number::positive_value(0x9678dfaf663529095fd0598fde21c5c61a12a61ca64a0f3d1eb72b83b141b0e2::signed_number::add_uint(0x9678dfaf663529095fd0598fde21c5c61a12a61ca64a0f3d1eb72b83b141b0e2::signed_number::from_subtraction(v0, 0x9678dfaf663529095fd0598fde21c5c61a12a61ca64a0f3d1eb72b83b141b0e2::position::oiOpen(arg0)), 0x9678dfaf663529095fd0598fde21c5c61a12a61ca64a0f3d1eb72b83b141b0e2::library::base_mul(0x9678dfaf663529095fd0598fde21c5c61a12a61ca64a0f3d1eb72b83b141b0e2::library::base_mul(0x9678dfaf663529095fd0598fde21c5c61a12a61ca64a0f3d1eb72b83b141b0e2::position::qPos(arg0), arg1), 0x9678dfaf663529095fd0598fde21c5c61a12a61ca64a0f3d1eb72b83b141b0e2::library::base_uint() - 0x9678dfaf663529095fd0598fde21c5c61a12a61ca64a0f3d1eb72b83b141b0e2::position::mro(arg0)))))
        } else {
            0x9678dfaf663529095fd0598fde21c5c61a12a61ca64a0f3d1eb72b83b141b0e2::library::min(v0, 0x9678dfaf663529095fd0598fde21c5c61a12a61ca64a0f3d1eb72b83b141b0e2::library::sub(v0 + 0x9678dfaf663529095fd0598fde21c5c61a12a61ca64a0f3d1eb72b83b141b0e2::position::oiOpen(arg0), 0x9678dfaf663529095fd0598fde21c5c61a12a61ca64a0f3d1eb72b83b141b0e2::library::base_mul(0x9678dfaf663529095fd0598fde21c5c61a12a61ca64a0f3d1eb72b83b141b0e2::library::base_mul(0x9678dfaf663529095fd0598fde21c5c61a12a61ca64a0f3d1eb72b83b141b0e2::position::qPos(arg0), arg1), 0x9678dfaf663529095fd0598fde21c5c61a12a61ca64a0f3d1eb72b83b141b0e2::library::base_uint() + 0x9678dfaf663529095fd0598fde21c5c61a12a61ca64a0f3d1eb72b83b141b0e2::position::mro(arg0))))
        }
    }

    public(friend) fun get_target_margin(arg0: 0x9678dfaf663529095fd0598fde21c5c61a12a61ca64a0f3d1eb72b83b141b0e2::position::UserPosition, arg1: u128, arg2: u128) : u128 {
        let v0 = 0x9678dfaf663529095fd0598fde21c5c61a12a61ca64a0f3d1eb72b83b141b0e2::library::base_mul(0x9678dfaf663529095fd0598fde21c5c61a12a61ca64a0f3d1eb72b83b141b0e2::position::qPos(arg0), arg2);
        if (0x9678dfaf663529095fd0598fde21c5c61a12a61ca64a0f3d1eb72b83b141b0e2::position::isPosPositive(arg0)) {
            0x9678dfaf663529095fd0598fde21c5c61a12a61ca64a0f3d1eb72b83b141b0e2::library::sub(0x9678dfaf663529095fd0598fde21c5c61a12a61ca64a0f3d1eb72b83b141b0e2::library::base_div(v0, arg1) + 0x9678dfaf663529095fd0598fde21c5c61a12a61ca64a0f3d1eb72b83b141b0e2::position::oiOpen(arg0), v0)
        } else {
            0x9678dfaf663529095fd0598fde21c5c61a12a61ca64a0f3d1eb72b83b141b0e2::library::sub(0x9678dfaf663529095fd0598fde21c5c61a12a61ca64a0f3d1eb72b83b141b0e2::library::base_div(v0, arg1) + v0, 0x9678dfaf663529095fd0598fde21c5c61a12a61ca64a0f3d1eb72b83b141b0e2::position::oiOpen(arg0))
        }
    }

    // decompiled from Move bytecode v6
}

