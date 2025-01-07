module 0x6daf6e084de79fde6ff50856b0470c2003552570a92b35cffed3dbe82744ffe4::margin_math {
    public(friend) fun get_margin_left(arg0: 0x6daf6e084de79fde6ff50856b0470c2003552570a92b35cffed3dbe82744ffe4::position::UserPosition, arg1: u128, arg2: u128) : u128 {
        let v0 = 0x6daf6e084de79fde6ff50856b0470c2003552570a92b35cffed3dbe82744ffe4::position::oiOpen(arg0);
        let v1 = if (0x6daf6e084de79fde6ff50856b0470c2003552570a92b35cffed3dbe82744ffe4::position::isPosPositive(arg0)) {
            0x6daf6e084de79fde6ff50856b0470c2003552570a92b35cffed3dbe82744ffe4::library::sub(0x6daf6e084de79fde6ff50856b0470c2003552570a92b35cffed3dbe82744ffe4::position::margin(arg0) + v0 * arg1 / 0x6daf6e084de79fde6ff50856b0470c2003552570a92b35cffed3dbe82744ffe4::position::compute_average_entry_price(arg0), v0)
        } else {
            0x6daf6e084de79fde6ff50856b0470c2003552570a92b35cffed3dbe82744ffe4::library::sub(0x6daf6e084de79fde6ff50856b0470c2003552570a92b35cffed3dbe82744ffe4::position::margin(arg0) + v0, v0 * arg1 / 0x6daf6e084de79fde6ff50856b0470c2003552570a92b35cffed3dbe82744ffe4::position::compute_average_entry_price(arg0))
        };
        0x6daf6e084de79fde6ff50856b0470c2003552570a92b35cffed3dbe82744ffe4::library::min(v1, arg2)
    }

    public(friend) fun get_max_removeable_margin(arg0: 0x6daf6e084de79fde6ff50856b0470c2003552570a92b35cffed3dbe82744ffe4::position::UserPosition, arg1: u128) : u128 {
        let v0 = 0x6daf6e084de79fde6ff50856b0470c2003552570a92b35cffed3dbe82744ffe4::position::margin(arg0);
        if (0x6daf6e084de79fde6ff50856b0470c2003552570a92b35cffed3dbe82744ffe4::position::isPosPositive(arg0)) {
            0x6daf6e084de79fde6ff50856b0470c2003552570a92b35cffed3dbe82744ffe4::library::min(v0, 0x6daf6e084de79fde6ff50856b0470c2003552570a92b35cffed3dbe82744ffe4::signed_number::positive_value(0x6daf6e084de79fde6ff50856b0470c2003552570a92b35cffed3dbe82744ffe4::signed_number::add_uint(0x6daf6e084de79fde6ff50856b0470c2003552570a92b35cffed3dbe82744ffe4::signed_number::from_subtraction(v0, 0x6daf6e084de79fde6ff50856b0470c2003552570a92b35cffed3dbe82744ffe4::position::oiOpen(arg0)), 0x6daf6e084de79fde6ff50856b0470c2003552570a92b35cffed3dbe82744ffe4::library::base_mul(0x6daf6e084de79fde6ff50856b0470c2003552570a92b35cffed3dbe82744ffe4::library::base_mul(0x6daf6e084de79fde6ff50856b0470c2003552570a92b35cffed3dbe82744ffe4::position::qPos(arg0), arg1), 0x6daf6e084de79fde6ff50856b0470c2003552570a92b35cffed3dbe82744ffe4::library::base_uint() - 0x6daf6e084de79fde6ff50856b0470c2003552570a92b35cffed3dbe82744ffe4::position::mro(arg0)))))
        } else {
            0x6daf6e084de79fde6ff50856b0470c2003552570a92b35cffed3dbe82744ffe4::library::min(v0, 0x6daf6e084de79fde6ff50856b0470c2003552570a92b35cffed3dbe82744ffe4::library::sub(v0 + 0x6daf6e084de79fde6ff50856b0470c2003552570a92b35cffed3dbe82744ffe4::position::oiOpen(arg0), 0x6daf6e084de79fde6ff50856b0470c2003552570a92b35cffed3dbe82744ffe4::library::base_mul(0x6daf6e084de79fde6ff50856b0470c2003552570a92b35cffed3dbe82744ffe4::library::base_mul(0x6daf6e084de79fde6ff50856b0470c2003552570a92b35cffed3dbe82744ffe4::position::qPos(arg0), arg1), 0x6daf6e084de79fde6ff50856b0470c2003552570a92b35cffed3dbe82744ffe4::library::base_uint() + 0x6daf6e084de79fde6ff50856b0470c2003552570a92b35cffed3dbe82744ffe4::position::mro(arg0))))
        }
    }

    public(friend) fun get_target_margin(arg0: 0x6daf6e084de79fde6ff50856b0470c2003552570a92b35cffed3dbe82744ffe4::position::UserPosition, arg1: u128, arg2: u128) : u128 {
        let v0 = 0x6daf6e084de79fde6ff50856b0470c2003552570a92b35cffed3dbe82744ffe4::library::base_mul(0x6daf6e084de79fde6ff50856b0470c2003552570a92b35cffed3dbe82744ffe4::position::qPos(arg0), arg2);
        if (0x6daf6e084de79fde6ff50856b0470c2003552570a92b35cffed3dbe82744ffe4::position::isPosPositive(arg0)) {
            0x6daf6e084de79fde6ff50856b0470c2003552570a92b35cffed3dbe82744ffe4::library::sub(0x6daf6e084de79fde6ff50856b0470c2003552570a92b35cffed3dbe82744ffe4::library::base_div(v0, arg1) + 0x6daf6e084de79fde6ff50856b0470c2003552570a92b35cffed3dbe82744ffe4::position::oiOpen(arg0), v0)
        } else {
            0x6daf6e084de79fde6ff50856b0470c2003552570a92b35cffed3dbe82744ffe4::library::sub(0x6daf6e084de79fde6ff50856b0470c2003552570a92b35cffed3dbe82744ffe4::library::base_div(v0, arg1) + v0, 0x6daf6e084de79fde6ff50856b0470c2003552570a92b35cffed3dbe82744ffe4::position::oiOpen(arg0))
        }
    }

    // decompiled from Move bytecode v6
}

