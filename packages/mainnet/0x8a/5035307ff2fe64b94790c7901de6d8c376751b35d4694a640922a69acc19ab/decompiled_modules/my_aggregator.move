module 0x8a5035307ff2fe64b94790c7901de6d8c376751b35d4694a640922a69acc19ab::my_aggregator {
    public fun take_swap_fee_coin<T0>(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: address, arg4: address, arg5: &0x2::clock::Clock, arg6: address, arg7: &0x8a5035307ff2fe64b94790c7901de6d8c376751b35d4694a640922a69acc19ab::fee::FeesStorage, arg8: 0x1::string::String, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, _) = 0x8a5035307ff2fe64b94790c7901de6d8c376751b35d4694a640922a69acc19ab::fee::calc_token_fees(arg6, arg2, arg7, arg8, arg9);
        let v2 = 0x8a5035307ff2fe64b94790c7901de6d8c376751b35d4694a640922a69acc19ab::fee::fixed_native_fee_amount(arg6, arg7, arg8);
        let v3 = 0x2::coin::value<T0>(&arg1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) >= v2, 0);
        assert!(v3 >= arg2, 1);
        if (v3 > arg2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, v3 - arg2, arg9), 0x2::tx_context::sender(arg9));
        };
        if (v2 > 0) {
            0x8a5035307ff2fe64b94790c7901de6d8c376751b35d4694a640922a69acc19ab::fee::accrue_fixed_native_fees(&mut arg0, arg6, arg7, arg8, arg9);
        };
        if (v0 > 0) {
            0x8a5035307ff2fe64b94790c7901de6d8c376751b35d4694a640922a69acc19ab::fee::accrue_token_fees<T0>(&mut arg1, arg6, arg2, arg7, arg8, arg9);
        };
        if (0x2::coin::value<0x2::sui::SUI>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg9));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg0);
        };
        arg1
    }

    public fun take_swap_fee_sui(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: address, arg3: address, arg4: &0x2::clock::Clock, arg5: address, arg6: &0x8a5035307ff2fe64b94790c7901de6d8c376751b35d4694a640922a69acc19ab::fee::FeesStorage, arg7: 0x1::string::String, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let (v0, _) = 0x8a5035307ff2fe64b94790c7901de6d8c376751b35d4694a640922a69acc19ab::fee::calc_token_fees(arg5, arg1, arg6, arg7, arg8);
        let v2 = 0x8a5035307ff2fe64b94790c7901de6d8c376751b35d4694a640922a69acc19ab::fee::fixed_native_fee_amount(arg5, arg6, arg7);
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v3 >= v2 + v0, 0);
        assert!(v3 >= arg1, 1);
        if (v3 > arg1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0, v3 - arg1, arg8), 0x2::tx_context::sender(arg8));
        };
        if (v2 > 0) {
            0x8a5035307ff2fe64b94790c7901de6d8c376751b35d4694a640922a69acc19ab::fee::accrue_fixed_native_fees(&mut arg0, arg5, arg6, arg7, arg8);
        };
        if (v0 > 0) {
            0x8a5035307ff2fe64b94790c7901de6d8c376751b35d4694a640922a69acc19ab::fee::accrue_token_fees<0x2::sui::SUI>(&mut arg0, arg5, arg1, arg6, arg7, arg8);
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

