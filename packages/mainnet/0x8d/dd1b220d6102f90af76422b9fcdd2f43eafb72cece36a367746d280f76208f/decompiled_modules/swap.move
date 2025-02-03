module 0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::swap {
    struct SwapHotPotato<phantom T0, phantom T1> {
        amount_in: u64,
        min_amount_out: u64,
        amount_in_type: 0x1::type_name::TypeName,
        amount_out_type: 0x1::type_name::TypeName,
    }

    fun assert_coin_in_type<T0, T1>(arg0: &SwapHotPotato<T0, T1>) {
        assert!(0x1::type_name::get<T0>() == arg0.amount_in_type, 2);
    }

    fun assert_coin_out_type<T0, T1>(arg0: &SwapHotPotato<T0, T1>) {
        assert!(0x1::type_name::get<T1>() == arg0.amount_out_type, 3);
    }

    fun assert_min_amount_out<T0, T1>(arg0: &SwapHotPotato<T0, T1>, arg1: u64) {
        assert!(arg1 >= arg0.min_amount_out, 1);
    }

    public fun start_swap<T0, T1>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64) : SwapHotPotato<T0, T1> {
        SwapHotPotato<T0, T1>{
            amount_in       : 0x2::coin::value<T0>(arg0),
            min_amount_out  : arg1,
            amount_in_type  : 0x1::type_name::get<T0>(),
            amount_out_type : 0x1::type_name::get<T1>(),
        }
    }

    public fun swap_exact_in_for_exact_out<T0, T1>(arg0: &0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::config::FeeConfig, arg1: SwapHotPotato<T0, T1>, arg2: &mut 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_coin_in_type<T0, T1>(&arg1);
        assert_coin_out_type<T0, T1>(&arg1);
        assert_min_amount_out<T0, T1>(&arg1, 0x2::coin::value<T1>(arg2));
        0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::fee::pay_fee_1<T1, 0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::events_swap::SwapEvent>(arg0, arg2, 0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::constant::swap_fee_type(), arg3);
        0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::events_swap::emit_swap_event(0x2::tx_context::sender(arg3), arg1.amount_in_type, arg1.amount_out_type, arg1.amount_in, 0x2::coin::value<T1>(arg2));
        let SwapHotPotato {
            amount_in       : _,
            min_amount_out  : _,
            amount_in_type  : _,
            amount_out_type : _,
        } = arg1;
    }

    // decompiled from Move bytecode v6
}

