module 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::margin_math {
    public(friend) fun get_margin_left(arg0: 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::position::UserPosition, arg1: u128, arg2: u128) : u128 {
        let v0 = 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::position::oiOpen(arg0);
        let v1 = if (0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::position::isPosPositive(arg0)) {
            0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::library::sub(0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::position::margin(arg0) + v0 * arg1 / 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::position::compute_average_entry_price(arg0), v0)
        } else {
            0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::library::sub(0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::position::margin(arg0) + v0, v0 * arg1 / 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::position::compute_average_entry_price(arg0))
        };
        0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::library::min(v1, arg2)
    }

    public(friend) fun get_max_removeable_margin(arg0: 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::position::UserPosition, arg1: u128) : u128 {
        let v0 = 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::position::margin(arg0);
        if (0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::position::isPosPositive(arg0)) {
            0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::library::min(v0, 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::signed_number::positive_value(0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::signed_number::add_uint(0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::signed_number::from_subtraction(v0, 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::position::oiOpen(arg0)), 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::library::base_mul(0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::library::base_mul(0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::position::qPos(arg0), arg1), 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::library::base_uint() - 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::position::mro(arg0)))))
        } else {
            0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::library::min(v0, 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::library::sub(v0 + 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::position::oiOpen(arg0), 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::library::base_mul(0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::library::base_mul(0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::position::qPos(arg0), arg1), 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::library::base_uint() + 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::position::mro(arg0))))
        }
    }

    public(friend) fun get_target_margin(arg0: 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::position::UserPosition, arg1: u128, arg2: u128) : u128 {
        let v0 = 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::library::base_mul(0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::position::qPos(arg0), arg2);
        if (0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::position::isPosPositive(arg0)) {
            0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::library::sub(0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::library::base_div(v0, arg1) + 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::position::oiOpen(arg0), v0)
        } else {
            0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::library::sub(0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::library::base_div(v0, arg1) + v0, 0xb0a58adb97bb44ad607bd83204f985fd1a21bb6b6764a5602154068c6e88dbcf::position::oiOpen(arg0))
        }
    }

    // decompiled from Move bytecode v6
}

