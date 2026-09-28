module 0x11e045f3a3374208e1b5224127b0bbf7de7b3caa06cb1352a2c0db20b96b6ee::deepbook {
    public fun borrow<T0>(arg0: &mut 0xad5c08c267ab84c0651a82385d77ee8fa5c0e2fcad24bc9b2d97dacbca40149a::session::Session, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T0>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x2::sui::SUI>, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan) {
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_base<0x2::sui::SUI, T0>(arg1, 0xad5c08c267ab84c0651a82385d77ee8fa5c0e2fcad24bc9b2d97dacbca40149a::session::open_loan(arg0), arg2);
        (0x2::coin::into_balance<0x2::sui::SUI>(v0), v1)
    }

    public fun buy_base<T0, T1>(arg0: &mut 0xad5c08c267ab84c0651a82385d77ee8fa5c0e2fcad24bc9b2d97dacbca40149a::session::Session, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg1, 0x2::coin::from_balance<T1>(arg2, arg4), 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg4), 1, arg3, arg4);
        let v3 = v0;
        settle_deep(v2);
        0xad5c08c267ab84c0651a82385d77ee8fa5c0e2fcad24bc9b2d97dacbca40149a::session::record_leg(arg0, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1), false, 0x2::coin::value<T0>(&v3));
        (0x2::coin::into_balance<T0>(v3), 0x2::coin::into_balance<T1>(v1))
    }

    fun estimate<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: bool, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) : (u64, u64) {
        if (arg1 == 0) {
            return (0, 0)
        };
        let v0 = 0xad5c08c267ab84c0651a82385d77ee8fa5c0e2fcad24bc9b2d97dacbca40149a::search::floor_mul_div(arg1, 1000000000 + 0xad5c08c267ab84c0651a82385d77ee8fa5c0e2fcad24bc9b2d97dacbca40149a::search::floor_mul_div(arg3, 5, 4), 1000000000 + 0xad5c08c267ab84c0651a82385d77ee8fa5c0e2fcad24bc9b2d97dacbca40149a::search::ceil_mul_div(arg4, 5, 4));
        if (v0 == 0) {
            return (0, 0)
        };
        let (v1, v2) = if (arg2) {
            let (v3, v4, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out_input_fee<T0, T1>(arg0, v0, arg5);
            (v3, v4)
        } else {
            let (v6, v7, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out_input_fee<T0, T1>(arg0, v0, arg5);
            (v6, v7)
        };
        if (arg2) {
            (v2, v1)
        } else {
            (v1, v2)
        }
    }

    public fun quote<T0, T1>(arg0: &mut 0xad5c08c267ab84c0651a82385d77ee8fa5c0e2fcad24bc9b2d97dacbca40149a::session::Session, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: bool, arg3: u64, arg4: &0x2::clock::Clock) {
        assert!(arg3 <= 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::max_additional_taker_fee(), 1);
        let (v0, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params<T0, T1>(arg1);
        let (v3, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params_next<T0, T1>(arg1);
        let v6 = arg2 && 0x1::type_name::with_defining_ids<T0>() == 0x1::type_name::with_defining_ids<0x2::sui::SUI>() || 0x1::type_name::with_defining_ids<T1>() == 0x1::type_name::with_defining_ids<0x2::sui::SUI>();
        let v7 = vector[];
        let v8 = vector[];
        let v9 = 0xad5c08c267ab84c0651a82385d77ee8fa5c0e2fcad24bc9b2d97dacbca40149a::session::quote_inputs(arg0);
        0x1::vector::reverse<u64>(&mut v9);
        let v10 = 0;
        while (v10 < 0x1::vector::length<u64>(&v9)) {
            let (v11, v12) = estimate<T0, T1>(arg1, 0x1::vector::pop_back<u64>(&mut v9), arg2, v0, 0xad5c08c267ab84c0651a82385d77ee8fa5c0e2fcad24bc9b2d97dacbca40149a::search::checked_sum(0x1::u64::max(v0, v3), arg3), arg4);
            0x1::vector::push_back<u64>(&mut v7, v11);
            if (v6) {
                0x1::vector::push_back<u64>(&mut v8, v12);
            };
            v10 = v10 + 1;
        };
        0x1::vector::destroy_empty<u64>(v9);
        0xad5c08c267ab84c0651a82385d77ee8fa5c0e2fcad24bc9b2d97dacbca40149a::session::record_quote(arg0, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1), arg2, v7, vector[], v8);
    }

    public fun repay<T0>(arg0: &mut 0xad5c08c267ab84c0651a82385d77ee8fa5c0e2fcad24bc9b2d97dacbca40149a::session::Session, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T0>, arg2: 0x2::balance::Balance<0x2::sui::SUI>, arg3: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_base<0x2::sui::SUI, T0>(arg1, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg2, 0xad5c08c267ab84c0651a82385d77ee8fa5c0e2fcad24bc9b2d97dacbca40149a::session::close_loan(arg0, &mut arg2)), arg4), arg3);
        arg2
    }

    public fun sell_base<T0, T1>(arg0: &mut 0xad5c08c267ab84c0651a82385d77ee8fa5c0e2fcad24bc9b2d97dacbca40149a::session::Session, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>) {
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T0, T1>(arg1, 0x2::coin::from_balance<T0>(arg2, arg4), 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg4), 1, arg3, arg4);
        let v3 = v1;
        settle_deep(v2);
        0xad5c08c267ab84c0651a82385d77ee8fa5c0e2fcad24bc9b2d97dacbca40149a::session::record_leg(arg0, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1), true, 0x2::coin::value<T1>(&v3));
        (0x2::coin::into_balance<T1>(v3), 0x2::coin::into_balance<T0>(v0))
    }

    fun settle_deep(arg0: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg0);
    }

    // decompiled from Move bytecode v7
}

