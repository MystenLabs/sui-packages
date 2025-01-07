module 0x743d5e058c2eb0194ae5d672f5a2d926ecabbf5ff90e5315d1f8d23d5eb4749f::manage_swaps {
    struct Swap has copy, drop {
        amount: u64,
        swap_input_amount: u64,
        token_fee_amount: u64,
        fixed_native_fee_amount: u64,
        swap_output_amount: u64,
        refunded_token_amount: u64,
        recipient: address,
    }

    public entry fun end_sui_swap(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: address, arg3: address, arg4: address, arg5: &0x743d5e058c2eb0194ae5d672f5a2d926ecabbf5ff90e5315d1f8d23d5eb4749f::fee::FeesStorage, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, _) = 0x743d5e058c2eb0194ae5d672f5a2d926ecabbf5ff90e5315d1f8d23d5eb4749f::fee::calc_token_fees(arg4, arg1, arg5, arg6, arg7);
        if (0x743d5e058c2eb0194ae5d672f5a2d926ecabbf5ff90e5315d1f8d23d5eb4749f::fee::fixed_native_fee_amount(arg4, arg5, arg6) > 0) {
            0x743d5e058c2eb0194ae5d672f5a2d926ecabbf5ff90e5315d1f8d23d5eb4749f::fee::accrue_fixed_native_fees(&mut arg0, arg4, arg5, arg6, arg7);
        };
        if (v0 > 0) {
            0x743d5e058c2eb0194ae5d672f5a2d926ecabbf5ff90e5315d1f8d23d5eb4749f::fee::accrue_token_fees<0x2::sui::SUI>(&mut arg0, arg4, arg1, arg5, arg6, arg7);
        };
        if (0x2::coin::value<0x2::sui::SUI>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, arg2);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg0);
        };
    }

    public entry fun end_token_swap<T0>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: address, arg4: address, arg5: address, arg6: &0x743d5e058c2eb0194ae5d672f5a2d926ecabbf5ff90e5315d1f8d23d5eb4749f::fee::FeesStorage, arg7: 0x1::string::String, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, _) = 0x743d5e058c2eb0194ae5d672f5a2d926ecabbf5ff90e5315d1f8d23d5eb4749f::fee::calc_token_fees(arg5, arg2, arg6, arg7, arg8);
        let v2 = 0x743d5e058c2eb0194ae5d672f5a2d926ecabbf5ff90e5315d1f8d23d5eb4749f::fee::fixed_native_fee_amount(arg5, arg6, arg7);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= v2, 0);
        if (v2 > 0) {
            0x743d5e058c2eb0194ae5d672f5a2d926ecabbf5ff90e5315d1f8d23d5eb4749f::fee::accrue_fixed_native_fees(&mut arg1, arg5, arg6, arg7, arg8);
        };
        if (v0 > 0) {
            0x743d5e058c2eb0194ae5d672f5a2d926ecabbf5ff90e5315d1f8d23d5eb4749f::fee::accrue_token_fees<T0>(&mut arg0, arg5, arg2, arg6, arg7, arg8);
        };
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg3);
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
        if (0x2::coin::value<0x2::sui::SUI>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg3);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
        };
    }

    public fun if_minimum_value<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::coin::value<T0>(&arg0) >= arg1, 2);
        arg0
    }

    public fun native_fee(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: address, arg3: address, arg4: address, arg5: &0x743d5e058c2eb0194ae5d672f5a2d926ecabbf5ff90e5315d1f8d23d5eb4749f::fee::FeesStorage, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let (v0, _) = 0x743d5e058c2eb0194ae5d672f5a2d926ecabbf5ff90e5315d1f8d23d5eb4749f::fee::calc_token_fees(arg4, arg1, arg5, arg6, arg7);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) >= arg1, 1);
        if (0x743d5e058c2eb0194ae5d672f5a2d926ecabbf5ff90e5315d1f8d23d5eb4749f::fee::fixed_native_fee_amount(arg4, arg5, arg6) > 0) {
            0x743d5e058c2eb0194ae5d672f5a2d926ecabbf5ff90e5315d1f8d23d5eb4749f::fee::accrue_fixed_native_fees(&mut arg0, arg4, arg5, arg6, arg7);
        };
        if (v0 > 0) {
            0x743d5e058c2eb0194ae5d672f5a2d926ecabbf5ff90e5315d1f8d23d5eb4749f::fee::accrue_token_fees<0x2::sui::SUI>(&mut arg0, arg4, arg1, arg5, arg6, arg7);
        };
        arg0
    }

    public fun split_in_perc<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>) {
        (arg0, 0x2::coin::split<T0>(&mut arg0, 0x743d5e058c2eb0194ae5d672f5a2d926ecabbf5ff90e5315d1f8d23d5eb4749f::math::divide_and_round_up(0x2::coin::value<T0>(&arg0) * arg1, 100), arg2))
    }

    public fun start_sui_swap(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: address, arg3: &0x743d5e058c2eb0194ae5d672f5a2d926ecabbf5ff90e5315d1f8d23d5eb4749f::fee::FeesStorage, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let (_, _) = 0x743d5e058c2eb0194ae5d672f5a2d926ecabbf5ff90e5315d1f8d23d5eb4749f::fee::calc_token_fees(arg2, arg1, arg3, arg4, arg5);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) >= arg1, 0);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg0) - arg1;
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0, v2, arg5), 0x2::tx_context::sender(arg5));
        };
        arg0
    }

    public fun start_token_swap<T0>(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: address, arg4: &0x743d5e058c2eb0194ae5d672f5a2d926ecabbf5ff90e5315d1f8d23d5eb4749f::fee::FeesStorage, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) : (u64, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<T0>) {
        let (v0, _) = 0x743d5e058c2eb0194ae5d672f5a2d926ecabbf5ff90e5315d1f8d23d5eb4749f::fee::calc_token_fees(arg3, arg2, arg4, arg5, arg6);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) >= 0x743d5e058c2eb0194ae5d672f5a2d926ecabbf5ff90e5315d1f8d23d5eb4749f::fee::fixed_native_fee_amount(arg3, arg4, arg5), 0);
        assert!(0x2::coin::value<T0>(&arg1) >= arg2, 1);
        (arg2 - v0, arg0, arg1)
    }

    public fun take_swap_fee_sui(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: address, arg3: address, arg4: &0x2::clock::Clock, arg5: address, arg6: &0x743d5e058c2eb0194ae5d672f5a2d926ecabbf5ff90e5315d1f8d23d5eb4749f::fee::FeesStorage, arg7: 0x1::string::String, arg8: &mut 0x2::tx_context::TxContext) : (u64, 0x2::coin::Coin<0x2::sui::SUI>) {
        let (v0, _) = 0x743d5e058c2eb0194ae5d672f5a2d926ecabbf5ff90e5315d1f8d23d5eb4749f::fee::calc_token_fees(arg5, arg1, arg6, arg7, arg8);
        let v2 = 0x743d5e058c2eb0194ae5d672f5a2d926ecabbf5ff90e5315d1f8d23d5eb4749f::fee::fixed_native_fee_amount(arg5, arg6, arg7);
        let v3 = v2 + v0;
        let v4 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v4 >= v3, 0);
        assert!(v4 >= arg1, 1);
        if (v4 > arg1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0, v4 - arg1, arg8), 0x2::tx_context::sender(arg8));
        };
        if (v2 > 0) {
            0x743d5e058c2eb0194ae5d672f5a2d926ecabbf5ff90e5315d1f8d23d5eb4749f::fee::accrue_fixed_native_fees(&mut arg0, arg5, arg6, arg7, arg8);
        };
        if (v0 > 0) {
            0x743d5e058c2eb0194ae5d672f5a2d926ecabbf5ff90e5315d1f8d23d5eb4749f::fee::accrue_token_fees<0x2::sui::SUI>(&mut arg0, arg5, arg1, arg6, arg7, arg8);
        };
        (arg1 - v3, arg0)
    }

    // decompiled from Move bytecode v6
}

