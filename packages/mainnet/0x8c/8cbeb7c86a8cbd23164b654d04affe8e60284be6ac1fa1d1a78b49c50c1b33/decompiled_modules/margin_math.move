module 0x8c8cbeb7c86a8cbd23164b654d04affe8e60284be6ac1fa1d1a78b49c50c1b33::margin_math {
    public(friend) fun get_margin_left(arg0: 0x8c8cbeb7c86a8cbd23164b654d04affe8e60284be6ac1fa1d1a78b49c50c1b33::position::UserPosition, arg1: u128, arg2: u128) : u128 {
        let v0 = 0x8c8cbeb7c86a8cbd23164b654d04affe8e60284be6ac1fa1d1a78b49c50c1b33::position::oiOpen(arg0);
        let v1 = if (0x8c8cbeb7c86a8cbd23164b654d04affe8e60284be6ac1fa1d1a78b49c50c1b33::position::isPosPositive(arg0)) {
            0x8c8cbeb7c86a8cbd23164b654d04affe8e60284be6ac1fa1d1a78b49c50c1b33::library::sub(0x8c8cbeb7c86a8cbd23164b654d04affe8e60284be6ac1fa1d1a78b49c50c1b33::position::margin(arg0) + v0 * arg1 / 0x8c8cbeb7c86a8cbd23164b654d04affe8e60284be6ac1fa1d1a78b49c50c1b33::position::compute_average_entry_price(arg0), v0)
        } else {
            0x8c8cbeb7c86a8cbd23164b654d04affe8e60284be6ac1fa1d1a78b49c50c1b33::library::sub(0x8c8cbeb7c86a8cbd23164b654d04affe8e60284be6ac1fa1d1a78b49c50c1b33::position::margin(arg0) + v0, v0 * arg1 / 0x8c8cbeb7c86a8cbd23164b654d04affe8e60284be6ac1fa1d1a78b49c50c1b33::position::compute_average_entry_price(arg0))
        };
        0x8c8cbeb7c86a8cbd23164b654d04affe8e60284be6ac1fa1d1a78b49c50c1b33::library::min(v1, arg2)
    }

    public(friend) fun get_max_removeable_margin(arg0: 0x8c8cbeb7c86a8cbd23164b654d04affe8e60284be6ac1fa1d1a78b49c50c1b33::position::UserPosition, arg1: u128) : u128 {
        let v0 = 0x8c8cbeb7c86a8cbd23164b654d04affe8e60284be6ac1fa1d1a78b49c50c1b33::position::margin(arg0);
        if (0x8c8cbeb7c86a8cbd23164b654d04affe8e60284be6ac1fa1d1a78b49c50c1b33::position::isPosPositive(arg0)) {
            0x8c8cbeb7c86a8cbd23164b654d04affe8e60284be6ac1fa1d1a78b49c50c1b33::library::min(v0, 0x8c8cbeb7c86a8cbd23164b654d04affe8e60284be6ac1fa1d1a78b49c50c1b33::signed_number::positive_value(0x8c8cbeb7c86a8cbd23164b654d04affe8e60284be6ac1fa1d1a78b49c50c1b33::signed_number::add_uint(0x8c8cbeb7c86a8cbd23164b654d04affe8e60284be6ac1fa1d1a78b49c50c1b33::signed_number::from_subtraction(v0, 0x8c8cbeb7c86a8cbd23164b654d04affe8e60284be6ac1fa1d1a78b49c50c1b33::position::oiOpen(arg0)), 0x8c8cbeb7c86a8cbd23164b654d04affe8e60284be6ac1fa1d1a78b49c50c1b33::library::base_mul(0x8c8cbeb7c86a8cbd23164b654d04affe8e60284be6ac1fa1d1a78b49c50c1b33::library::base_mul(0x8c8cbeb7c86a8cbd23164b654d04affe8e60284be6ac1fa1d1a78b49c50c1b33::position::qPos(arg0), arg1), 0x8c8cbeb7c86a8cbd23164b654d04affe8e60284be6ac1fa1d1a78b49c50c1b33::library::base_uint() - 0x8c8cbeb7c86a8cbd23164b654d04affe8e60284be6ac1fa1d1a78b49c50c1b33::position::mro(arg0)))))
        } else {
            0x8c8cbeb7c86a8cbd23164b654d04affe8e60284be6ac1fa1d1a78b49c50c1b33::library::min(v0, 0x8c8cbeb7c86a8cbd23164b654d04affe8e60284be6ac1fa1d1a78b49c50c1b33::library::sub(v0 + 0x8c8cbeb7c86a8cbd23164b654d04affe8e60284be6ac1fa1d1a78b49c50c1b33::position::oiOpen(arg0), 0x8c8cbeb7c86a8cbd23164b654d04affe8e60284be6ac1fa1d1a78b49c50c1b33::library::base_mul(0x8c8cbeb7c86a8cbd23164b654d04affe8e60284be6ac1fa1d1a78b49c50c1b33::library::base_mul(0x8c8cbeb7c86a8cbd23164b654d04affe8e60284be6ac1fa1d1a78b49c50c1b33::position::qPos(arg0), arg1), 0x8c8cbeb7c86a8cbd23164b654d04affe8e60284be6ac1fa1d1a78b49c50c1b33::library::base_uint() + 0x8c8cbeb7c86a8cbd23164b654d04affe8e60284be6ac1fa1d1a78b49c50c1b33::position::mro(arg0))))
        }
    }

    public(friend) fun get_target_margin(arg0: 0x8c8cbeb7c86a8cbd23164b654d04affe8e60284be6ac1fa1d1a78b49c50c1b33::position::UserPosition, arg1: u128, arg2: u128) : u128 {
        let v0 = 0x8c8cbeb7c86a8cbd23164b654d04affe8e60284be6ac1fa1d1a78b49c50c1b33::library::base_mul(0x8c8cbeb7c86a8cbd23164b654d04affe8e60284be6ac1fa1d1a78b49c50c1b33::position::qPos(arg0), arg2);
        if (0x8c8cbeb7c86a8cbd23164b654d04affe8e60284be6ac1fa1d1a78b49c50c1b33::position::isPosPositive(arg0)) {
            0x8c8cbeb7c86a8cbd23164b654d04affe8e60284be6ac1fa1d1a78b49c50c1b33::library::sub(0x8c8cbeb7c86a8cbd23164b654d04affe8e60284be6ac1fa1d1a78b49c50c1b33::library::base_div(v0, arg1) + 0x8c8cbeb7c86a8cbd23164b654d04affe8e60284be6ac1fa1d1a78b49c50c1b33::position::oiOpen(arg0), v0)
        } else {
            0x8c8cbeb7c86a8cbd23164b654d04affe8e60284be6ac1fa1d1a78b49c50c1b33::library::sub(0x8c8cbeb7c86a8cbd23164b654d04affe8e60284be6ac1fa1d1a78b49c50c1b33::library::base_div(v0, arg1) + v0, 0x8c8cbeb7c86a8cbd23164b654d04affe8e60284be6ac1fa1d1a78b49c50c1b33::position::oiOpen(arg0))
        }
    }

    // decompiled from Move bytecode v6
}

