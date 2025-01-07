module 0x845f8b92d39cd077415d591ecbeef1647f52490a7b94cf74b61099eeac381678::margin_math {
    public(friend) fun get_margin_left(arg0: 0x845f8b92d39cd077415d591ecbeef1647f52490a7b94cf74b61099eeac381678::position::UserPosition, arg1: u128, arg2: u128) : u128 {
        let v0 = 0x845f8b92d39cd077415d591ecbeef1647f52490a7b94cf74b61099eeac381678::position::oiOpen(arg0);
        let v1 = if (0x845f8b92d39cd077415d591ecbeef1647f52490a7b94cf74b61099eeac381678::position::isPosPositive(arg0)) {
            0x845f8b92d39cd077415d591ecbeef1647f52490a7b94cf74b61099eeac381678::library::sub(0x845f8b92d39cd077415d591ecbeef1647f52490a7b94cf74b61099eeac381678::position::margin(arg0) + v0 * arg1 / 0x845f8b92d39cd077415d591ecbeef1647f52490a7b94cf74b61099eeac381678::position::compute_average_entry_price(arg0), v0)
        } else {
            0x845f8b92d39cd077415d591ecbeef1647f52490a7b94cf74b61099eeac381678::library::sub(0x845f8b92d39cd077415d591ecbeef1647f52490a7b94cf74b61099eeac381678::position::margin(arg0) + v0, v0 * arg1 / 0x845f8b92d39cd077415d591ecbeef1647f52490a7b94cf74b61099eeac381678::position::compute_average_entry_price(arg0))
        };
        0x845f8b92d39cd077415d591ecbeef1647f52490a7b94cf74b61099eeac381678::library::min(v1, arg2)
    }

    public(friend) fun get_max_removeable_margin(arg0: 0x845f8b92d39cd077415d591ecbeef1647f52490a7b94cf74b61099eeac381678::position::UserPosition, arg1: u128) : u128 {
        let v0 = 0x845f8b92d39cd077415d591ecbeef1647f52490a7b94cf74b61099eeac381678::position::margin(arg0);
        if (0x845f8b92d39cd077415d591ecbeef1647f52490a7b94cf74b61099eeac381678::position::isPosPositive(arg0)) {
            0x845f8b92d39cd077415d591ecbeef1647f52490a7b94cf74b61099eeac381678::library::min(v0, 0x845f8b92d39cd077415d591ecbeef1647f52490a7b94cf74b61099eeac381678::signed_number::positive_value(0x845f8b92d39cd077415d591ecbeef1647f52490a7b94cf74b61099eeac381678::signed_number::add_uint(0x845f8b92d39cd077415d591ecbeef1647f52490a7b94cf74b61099eeac381678::signed_number::from_subtraction(v0, 0x845f8b92d39cd077415d591ecbeef1647f52490a7b94cf74b61099eeac381678::position::oiOpen(arg0)), 0x845f8b92d39cd077415d591ecbeef1647f52490a7b94cf74b61099eeac381678::library::base_mul(0x845f8b92d39cd077415d591ecbeef1647f52490a7b94cf74b61099eeac381678::library::base_mul(0x845f8b92d39cd077415d591ecbeef1647f52490a7b94cf74b61099eeac381678::position::qPos(arg0), arg1), 0x845f8b92d39cd077415d591ecbeef1647f52490a7b94cf74b61099eeac381678::library::base_uint() - 0x845f8b92d39cd077415d591ecbeef1647f52490a7b94cf74b61099eeac381678::position::mro(arg0)))))
        } else {
            0x845f8b92d39cd077415d591ecbeef1647f52490a7b94cf74b61099eeac381678::library::min(v0, 0x845f8b92d39cd077415d591ecbeef1647f52490a7b94cf74b61099eeac381678::library::sub(v0 + 0x845f8b92d39cd077415d591ecbeef1647f52490a7b94cf74b61099eeac381678::position::oiOpen(arg0), 0x845f8b92d39cd077415d591ecbeef1647f52490a7b94cf74b61099eeac381678::library::base_mul(0x845f8b92d39cd077415d591ecbeef1647f52490a7b94cf74b61099eeac381678::library::base_mul(0x845f8b92d39cd077415d591ecbeef1647f52490a7b94cf74b61099eeac381678::position::qPos(arg0), arg1), 0x845f8b92d39cd077415d591ecbeef1647f52490a7b94cf74b61099eeac381678::library::base_uint() + 0x845f8b92d39cd077415d591ecbeef1647f52490a7b94cf74b61099eeac381678::position::mro(arg0))))
        }
    }

    public(friend) fun get_target_margin(arg0: 0x845f8b92d39cd077415d591ecbeef1647f52490a7b94cf74b61099eeac381678::position::UserPosition, arg1: u128, arg2: u128) : u128 {
        let v0 = 0x845f8b92d39cd077415d591ecbeef1647f52490a7b94cf74b61099eeac381678::library::base_mul(0x845f8b92d39cd077415d591ecbeef1647f52490a7b94cf74b61099eeac381678::position::qPos(arg0), arg2);
        if (0x845f8b92d39cd077415d591ecbeef1647f52490a7b94cf74b61099eeac381678::position::isPosPositive(arg0)) {
            0x845f8b92d39cd077415d591ecbeef1647f52490a7b94cf74b61099eeac381678::library::sub(0x845f8b92d39cd077415d591ecbeef1647f52490a7b94cf74b61099eeac381678::library::base_div(v0, arg1) + 0x845f8b92d39cd077415d591ecbeef1647f52490a7b94cf74b61099eeac381678::position::oiOpen(arg0), v0)
        } else {
            0x845f8b92d39cd077415d591ecbeef1647f52490a7b94cf74b61099eeac381678::library::sub(0x845f8b92d39cd077415d591ecbeef1647f52490a7b94cf74b61099eeac381678::library::base_div(v0, arg1) + v0, 0x845f8b92d39cd077415d591ecbeef1647f52490a7b94cf74b61099eeac381678::position::oiOpen(arg0))
        }
    }

    // decompiled from Move bytecode v6
}

