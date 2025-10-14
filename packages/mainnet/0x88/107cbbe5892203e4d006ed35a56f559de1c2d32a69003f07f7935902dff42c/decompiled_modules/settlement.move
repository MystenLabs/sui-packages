module 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::settlement {
    public(friend) fun get_margin_left(arg0: &0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::position::Position, arg1: u128, arg2: u128) : u128 {
        let v0 = 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::position::oi_open(arg0);
        let v1 = if (0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::position::is_long(arg0)) {
            0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::library::sub(0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::position::margin(arg0) + v0 * arg1 / 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::position::compute_average_entry_price(arg0), v0)
        } else {
            0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::library::sub(0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::position::margin(arg0) + v0, v0 * arg1 / 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::position::compute_average_entry_price(arg0))
        };
        0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::library::min(v1, arg2)
    }

    public(friend) fun get_max_removeable_margin(arg0: 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::position::Position, arg1: u128) : u128 {
        let v0 = 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::position::margin(&arg0);
        if (0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::position::is_long(&arg0)) {
            0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::library::min(v0, 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::s128::positive_value(0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::s128::add_u128(0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::s128::from_subtraction(v0, 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::position::oi_open(&arg0)), 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::library::base_mul(0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::library::base_mul(0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::position::size(&arg0), arg1), 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::library::base_uint() - 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::position::mro(&arg0)))))
        } else {
            0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::library::min(v0, 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::library::sub(v0 + 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::position::oi_open(&arg0), 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::library::base_mul(0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::library::base_mul(0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::position::size(&arg0), arg1), 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::library::base_uint() + 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::position::mro(&arg0))))
        }
    }

    public(friend) fun get_target_margin(arg0: &0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::position::Position, arg1: u128, arg2: u128) : u128 {
        let v0 = 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::library::base_mul(0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::position::size(arg0), arg2);
        if (0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::position::is_long(arg0)) {
            0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::library::sub(0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::library::base_div(v0, arg1) + 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::position::oi_open(arg0), v0)
        } else {
            0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::library::sub(0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::library::base_div(v0, arg1) + v0, 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::position::oi_open(arg0))
        }
    }

    public(friend) fun trade_margin_settlement<T0>(arg0: &mut 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::bank::Bank<T0>, arg1: address, arg2: address, arg3: address, arg4: 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::s128::S128, arg5: 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::s128::S128, arg6: u128) {
        assert!(0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::bank::exists_account<T0>(arg0, arg2), 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::error::not_enough_balance_in_bank(0));
        assert!(0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::bank::exists_account<T0>(arg0, arg3), 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::error::not_enough_balance_in_bank(1));
        if (0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::s128::gte_u128(arg4, 0)) {
            transfer_based_on_fundsflow<T0>(arg0, arg1, arg2, arg4, 0, arg6);
            transfer_based_on_fundsflow<T0>(arg0, arg1, arg3, arg5, 1, arg6);
        } else {
            transfer_based_on_fundsflow<T0>(arg0, arg1, arg3, arg5, 1, arg6);
            transfer_based_on_fundsflow<T0>(arg0, arg1, arg2, arg4, 0, arg6);
        };
    }

    fun transfer_based_on_fundsflow<T0>(arg0: &mut 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::bank::Bank<T0>, arg1: address, arg2: address, arg3: 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::s128::S128, arg4: u64, arg5: u128) {
        if (0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::s128::value(arg3) == 0) {
            return
        };
        let (v0, v1, v2) = if (0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::s128::gt_u128(arg3, 0)) {
            (arg1, arg4, arg2)
        } else {
            (arg2, 2, arg1)
        };
        0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::bank::transfer<T0>(arg0, v2, v0, 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::s128::value(arg3), v1, arg5);
    }

    // decompiled from Move bytecode v6
}

