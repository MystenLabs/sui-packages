module 0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::margin_math {
    public(friend) fun get_margin_left(arg0: 0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::position::UserPosition, arg1: u128, arg2: u128) : u128 {
        let v0 = 0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::position::oiOpen(arg0);
        let v1 = if (0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::position::isPosPositive(arg0)) {
            0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::library::sub(0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::position::margin(arg0) + v0 * arg1 / 0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::position::compute_average_entry_price(arg0), v0)
        } else {
            0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::library::sub(0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::position::margin(arg0) + v0, v0 * arg1 / 0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::position::compute_average_entry_price(arg0))
        };
        0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::library::min(v1, arg2)
    }

    public(friend) fun get_max_removeable_margin(arg0: 0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::position::UserPosition, arg1: u128) : u128 {
        let v0 = 0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::position::margin(arg0);
        if (0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::position::isPosPositive(arg0)) {
            0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::library::min(v0, 0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::signed_number::positive_value(0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::signed_number::add_uint(0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::signed_number::from_subtraction(v0, 0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::position::oiOpen(arg0)), 0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::library::base_mul(0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::library::base_mul(0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::position::qPos(arg0), arg1), 0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::library::base_uint() - 0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::position::mro(arg0)))))
        } else {
            0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::library::min(v0, 0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::library::sub(v0 + 0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::position::oiOpen(arg0), 0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::library::base_mul(0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::library::base_mul(0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::position::qPos(arg0), arg1), 0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::library::base_uint() + 0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::position::mro(arg0))))
        }
    }

    public(friend) fun get_target_margin(arg0: 0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::position::UserPosition, arg1: u128, arg2: u128) : u128 {
        let v0 = 0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::library::base_mul(0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::position::qPos(arg0), arg2);
        if (0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::position::isPosPositive(arg0)) {
            0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::library::sub(0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::library::base_div(v0, arg1) + 0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::position::oiOpen(arg0), v0)
        } else {
            0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::library::sub(0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::library::base_div(v0, arg1) + v0, 0xfba1917d0218b13dff7e786a9961295455f92153cad372554c9c30b30827bae6::position::oiOpen(arg0))
        }
    }

    // decompiled from Move bytecode v6
}

