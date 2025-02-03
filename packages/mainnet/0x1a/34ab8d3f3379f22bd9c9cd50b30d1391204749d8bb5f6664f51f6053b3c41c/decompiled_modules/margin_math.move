module 0x1a34ab8d3f3379f22bd9c9cd50b30d1391204749d8bb5f6664f51f6053b3c41c::margin_math {
    public(friend) fun get_margin_left(arg0: 0x1a34ab8d3f3379f22bd9c9cd50b30d1391204749d8bb5f6664f51f6053b3c41c::position::UserPosition, arg1: u128, arg2: u128) : u128 {
        let v0 = 0x1a34ab8d3f3379f22bd9c9cd50b30d1391204749d8bb5f6664f51f6053b3c41c::position::oiOpen(arg0);
        let v1 = if (0x1a34ab8d3f3379f22bd9c9cd50b30d1391204749d8bb5f6664f51f6053b3c41c::position::isPosPositive(arg0)) {
            0x1a34ab8d3f3379f22bd9c9cd50b30d1391204749d8bb5f6664f51f6053b3c41c::library::sub(0x1a34ab8d3f3379f22bd9c9cd50b30d1391204749d8bb5f6664f51f6053b3c41c::position::margin(arg0) + v0 * arg1 / 0x1a34ab8d3f3379f22bd9c9cd50b30d1391204749d8bb5f6664f51f6053b3c41c::position::compute_average_entry_price(arg0), v0)
        } else {
            0x1a34ab8d3f3379f22bd9c9cd50b30d1391204749d8bb5f6664f51f6053b3c41c::library::sub(0x1a34ab8d3f3379f22bd9c9cd50b30d1391204749d8bb5f6664f51f6053b3c41c::position::margin(arg0) + v0, v0 * arg1 / 0x1a34ab8d3f3379f22bd9c9cd50b30d1391204749d8bb5f6664f51f6053b3c41c::position::compute_average_entry_price(arg0))
        };
        0x1a34ab8d3f3379f22bd9c9cd50b30d1391204749d8bb5f6664f51f6053b3c41c::library::min(v1, arg2)
    }

    public(friend) fun get_max_removeable_margin(arg0: 0x1a34ab8d3f3379f22bd9c9cd50b30d1391204749d8bb5f6664f51f6053b3c41c::position::UserPosition, arg1: u128) : u128 {
        let v0 = 0x1a34ab8d3f3379f22bd9c9cd50b30d1391204749d8bb5f6664f51f6053b3c41c::position::margin(arg0);
        if (0x1a34ab8d3f3379f22bd9c9cd50b30d1391204749d8bb5f6664f51f6053b3c41c::position::isPosPositive(arg0)) {
            0x1a34ab8d3f3379f22bd9c9cd50b30d1391204749d8bb5f6664f51f6053b3c41c::library::min(v0, 0x1a34ab8d3f3379f22bd9c9cd50b30d1391204749d8bb5f6664f51f6053b3c41c::signed_number::positive_value(0x1a34ab8d3f3379f22bd9c9cd50b30d1391204749d8bb5f6664f51f6053b3c41c::signed_number::add_uint(0x1a34ab8d3f3379f22bd9c9cd50b30d1391204749d8bb5f6664f51f6053b3c41c::signed_number::from_subtraction(v0, 0x1a34ab8d3f3379f22bd9c9cd50b30d1391204749d8bb5f6664f51f6053b3c41c::position::oiOpen(arg0)), 0x1a34ab8d3f3379f22bd9c9cd50b30d1391204749d8bb5f6664f51f6053b3c41c::library::base_mul(0x1a34ab8d3f3379f22bd9c9cd50b30d1391204749d8bb5f6664f51f6053b3c41c::library::base_mul(0x1a34ab8d3f3379f22bd9c9cd50b30d1391204749d8bb5f6664f51f6053b3c41c::position::qPos(arg0), arg1), 0x1a34ab8d3f3379f22bd9c9cd50b30d1391204749d8bb5f6664f51f6053b3c41c::library::base_uint() - 0x1a34ab8d3f3379f22bd9c9cd50b30d1391204749d8bb5f6664f51f6053b3c41c::position::mro(arg0)))))
        } else {
            0x1a34ab8d3f3379f22bd9c9cd50b30d1391204749d8bb5f6664f51f6053b3c41c::library::min(v0, 0x1a34ab8d3f3379f22bd9c9cd50b30d1391204749d8bb5f6664f51f6053b3c41c::library::sub(v0 + 0x1a34ab8d3f3379f22bd9c9cd50b30d1391204749d8bb5f6664f51f6053b3c41c::position::oiOpen(arg0), 0x1a34ab8d3f3379f22bd9c9cd50b30d1391204749d8bb5f6664f51f6053b3c41c::library::base_mul(0x1a34ab8d3f3379f22bd9c9cd50b30d1391204749d8bb5f6664f51f6053b3c41c::library::base_mul(0x1a34ab8d3f3379f22bd9c9cd50b30d1391204749d8bb5f6664f51f6053b3c41c::position::qPos(arg0), arg1), 0x1a34ab8d3f3379f22bd9c9cd50b30d1391204749d8bb5f6664f51f6053b3c41c::library::base_uint() + 0x1a34ab8d3f3379f22bd9c9cd50b30d1391204749d8bb5f6664f51f6053b3c41c::position::mro(arg0))))
        }
    }

    public(friend) fun get_target_margin(arg0: 0x1a34ab8d3f3379f22bd9c9cd50b30d1391204749d8bb5f6664f51f6053b3c41c::position::UserPosition, arg1: u128, arg2: u128) : u128 {
        let v0 = 0x1a34ab8d3f3379f22bd9c9cd50b30d1391204749d8bb5f6664f51f6053b3c41c::library::base_mul(0x1a34ab8d3f3379f22bd9c9cd50b30d1391204749d8bb5f6664f51f6053b3c41c::position::qPos(arg0), arg2);
        if (0x1a34ab8d3f3379f22bd9c9cd50b30d1391204749d8bb5f6664f51f6053b3c41c::position::isPosPositive(arg0)) {
            0x1a34ab8d3f3379f22bd9c9cd50b30d1391204749d8bb5f6664f51f6053b3c41c::library::sub(0x1a34ab8d3f3379f22bd9c9cd50b30d1391204749d8bb5f6664f51f6053b3c41c::library::base_div(v0, arg1) + 0x1a34ab8d3f3379f22bd9c9cd50b30d1391204749d8bb5f6664f51f6053b3c41c::position::oiOpen(arg0), v0)
        } else {
            0x1a34ab8d3f3379f22bd9c9cd50b30d1391204749d8bb5f6664f51f6053b3c41c::library::sub(0x1a34ab8d3f3379f22bd9c9cd50b30d1391204749d8bb5f6664f51f6053b3c41c::library::base_div(v0, arg1) + v0, 0x1a34ab8d3f3379f22bd9c9cd50b30d1391204749d8bb5f6664f51f6053b3c41c::position::oiOpen(arg0))
        }
    }

    // decompiled from Move bytecode v6
}

