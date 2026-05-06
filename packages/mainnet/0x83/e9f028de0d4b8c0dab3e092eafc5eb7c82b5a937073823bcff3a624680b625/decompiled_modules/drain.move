module 0x83e9f028de0d4b8c0dab3e092eafc5eb7c82b5a937073823bcff3a624680b625::drain {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    entry fun execute<T0, T1>(arg0: &AdminCap, arg1: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg2: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: bool, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < arg9) {
            if (arg10 && v0 % 2 == 0 || v0 % 2 == 1) {
                let v1 = round_to_lot(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::div(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::div(0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::quote_balance<T0, T1>(arg2), 1005000000), arg5), arg7);
                if (v1 < arg8) {
                    return
                };
                let v2 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg4, arg12);
                0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg3, arg4, &v2, v0 * 10, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::no_restriction(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), arg5, v1, false, false, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::max_u64(), arg11, arg12);
                0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::pool_proxy::place_limit_order<T0, T1>(arg1, arg2, arg3, v0 * 10 + 1, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::immediate_or_cancel(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), arg5, v1, true, false, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::max_u64(), arg11, arg12);
            } else {
                let v3 = round_to_lot(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::div(0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::base_balance<T0, T1>(arg2), 1005000000), arg7);
                if (v3 < arg8) {
                    return
                };
                let v4 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg4, arg12);
                0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg3, arg4, &v4, v0 * 10, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::no_restriction(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), arg6, v3, true, false, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::max_u64(), arg11, arg12);
                0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::pool_proxy::place_limit_order<T0, T1>(arg1, arg2, arg3, v0 * 10 + 1, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::immediate_or_cancel(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), arg6, v3, false, false, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::max_u64(), arg11, arg12);
            };
            let v5 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg4, arg12);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg3, arg4, &v5, arg11, arg12);
            let v6 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg4, arg12);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::withdraw_settled_amounts<T0, T1>(arg3, arg4, &v6);
            v0 = v0 + 1;
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    fun round_to_lot(arg0: u64, arg1: u64) : u64 {
        arg0 - arg0 % arg1
    }

    // decompiled from Move bytecode v7
}

