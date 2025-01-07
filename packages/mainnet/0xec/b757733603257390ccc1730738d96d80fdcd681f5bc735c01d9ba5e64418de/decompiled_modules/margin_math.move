module 0xecb757733603257390ccc1730738d96d80fdcd681f5bc735c01d9ba5e64418de::margin_math {
    public(friend) fun get_margin_left(arg0: 0xecb757733603257390ccc1730738d96d80fdcd681f5bc735c01d9ba5e64418de::position::UserPosition, arg1: u128, arg2: u128) : u128 {
        let v0 = 0xecb757733603257390ccc1730738d96d80fdcd681f5bc735c01d9ba5e64418de::position::oiOpen(arg0);
        let v1 = if (0xecb757733603257390ccc1730738d96d80fdcd681f5bc735c01d9ba5e64418de::position::isPosPositive(arg0)) {
            0xecb757733603257390ccc1730738d96d80fdcd681f5bc735c01d9ba5e64418de::library::sub(0xecb757733603257390ccc1730738d96d80fdcd681f5bc735c01d9ba5e64418de::position::margin(arg0) + v0 * arg1 / 0xecb757733603257390ccc1730738d96d80fdcd681f5bc735c01d9ba5e64418de::position::compute_average_entry_price(arg0), v0)
        } else {
            0xecb757733603257390ccc1730738d96d80fdcd681f5bc735c01d9ba5e64418de::library::sub(0xecb757733603257390ccc1730738d96d80fdcd681f5bc735c01d9ba5e64418de::position::margin(arg0) + v0, v0 * arg1 / 0xecb757733603257390ccc1730738d96d80fdcd681f5bc735c01d9ba5e64418de::position::compute_average_entry_price(arg0))
        };
        0xecb757733603257390ccc1730738d96d80fdcd681f5bc735c01d9ba5e64418de::library::min(v1, arg2)
    }

    public(friend) fun get_max_removeable_margin(arg0: 0xecb757733603257390ccc1730738d96d80fdcd681f5bc735c01d9ba5e64418de::position::UserPosition, arg1: u128) : u128 {
        let v0 = 0xecb757733603257390ccc1730738d96d80fdcd681f5bc735c01d9ba5e64418de::position::margin(arg0);
        if (0xecb757733603257390ccc1730738d96d80fdcd681f5bc735c01d9ba5e64418de::position::isPosPositive(arg0)) {
            0xecb757733603257390ccc1730738d96d80fdcd681f5bc735c01d9ba5e64418de::library::min(v0, 0xecb757733603257390ccc1730738d96d80fdcd681f5bc735c01d9ba5e64418de::signed_number::positive_value(0xecb757733603257390ccc1730738d96d80fdcd681f5bc735c01d9ba5e64418de::signed_number::add_uint(0xecb757733603257390ccc1730738d96d80fdcd681f5bc735c01d9ba5e64418de::signed_number::from_subtraction(v0, 0xecb757733603257390ccc1730738d96d80fdcd681f5bc735c01d9ba5e64418de::position::oiOpen(arg0)), 0xecb757733603257390ccc1730738d96d80fdcd681f5bc735c01d9ba5e64418de::library::base_mul(0xecb757733603257390ccc1730738d96d80fdcd681f5bc735c01d9ba5e64418de::library::base_mul(0xecb757733603257390ccc1730738d96d80fdcd681f5bc735c01d9ba5e64418de::position::qPos(arg0), arg1), 0xecb757733603257390ccc1730738d96d80fdcd681f5bc735c01d9ba5e64418de::library::base_uint() - 0xecb757733603257390ccc1730738d96d80fdcd681f5bc735c01d9ba5e64418de::position::mro(arg0)))))
        } else {
            0xecb757733603257390ccc1730738d96d80fdcd681f5bc735c01d9ba5e64418de::library::min(v0, 0xecb757733603257390ccc1730738d96d80fdcd681f5bc735c01d9ba5e64418de::library::sub(v0 + 0xecb757733603257390ccc1730738d96d80fdcd681f5bc735c01d9ba5e64418de::position::oiOpen(arg0), 0xecb757733603257390ccc1730738d96d80fdcd681f5bc735c01d9ba5e64418de::library::base_mul(0xecb757733603257390ccc1730738d96d80fdcd681f5bc735c01d9ba5e64418de::library::base_mul(0xecb757733603257390ccc1730738d96d80fdcd681f5bc735c01d9ba5e64418de::position::qPos(arg0), arg1), 0xecb757733603257390ccc1730738d96d80fdcd681f5bc735c01d9ba5e64418de::library::base_uint() + 0xecb757733603257390ccc1730738d96d80fdcd681f5bc735c01d9ba5e64418de::position::mro(arg0))))
        }
    }

    public(friend) fun get_target_margin(arg0: 0xecb757733603257390ccc1730738d96d80fdcd681f5bc735c01d9ba5e64418de::position::UserPosition, arg1: u128, arg2: u128) : u128 {
        let v0 = 0xecb757733603257390ccc1730738d96d80fdcd681f5bc735c01d9ba5e64418de::library::base_mul(0xecb757733603257390ccc1730738d96d80fdcd681f5bc735c01d9ba5e64418de::position::qPos(arg0), arg2);
        if (0xecb757733603257390ccc1730738d96d80fdcd681f5bc735c01d9ba5e64418de::position::isPosPositive(arg0)) {
            0xecb757733603257390ccc1730738d96d80fdcd681f5bc735c01d9ba5e64418de::library::sub(0xecb757733603257390ccc1730738d96d80fdcd681f5bc735c01d9ba5e64418de::library::base_div(v0, arg1) + 0xecb757733603257390ccc1730738d96d80fdcd681f5bc735c01d9ba5e64418de::position::oiOpen(arg0), v0)
        } else {
            0xecb757733603257390ccc1730738d96d80fdcd681f5bc735c01d9ba5e64418de::library::sub(0xecb757733603257390ccc1730738d96d80fdcd681f5bc735c01d9ba5e64418de::library::base_div(v0, arg1) + v0, 0xecb757733603257390ccc1730738d96d80fdcd681f5bc735c01d9ba5e64418de::position::oiOpen(arg0))
        }
    }

    // decompiled from Move bytecode v6
}

