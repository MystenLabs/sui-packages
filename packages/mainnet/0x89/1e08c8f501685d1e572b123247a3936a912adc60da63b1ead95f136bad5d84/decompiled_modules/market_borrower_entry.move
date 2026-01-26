module 0x891e08c8f501685d1e572b123247a3936a912adc60da63b1ead95f136bad5d84::market_borrower_entry {
    public entry fun borrow<T0, T1>(arg0: &mut 0x891e08c8f501685d1e572b123247a3936a912adc60da63b1ead95f136bad5d84::market::Hearn, arg1: u64, arg2: address, arg3: address, arg4: u128, arg5: u128, arg6: &0x2::clock::Clock, arg7: &0xb58f355d03ce22d89d6f8ef94808a7ecbc8c5464c3cf2e03797ff93c8edfba9e::pyth_oracle::Oracle, arg8: &0x891e08c8f501685d1e572b123247a3936a912adc60da63b1ead95f136bad5d84::farming_core::Farming, arg9: &mut 0x891e08c8f501685d1e572b123247a3936a912adc60da63b1ead95f136bad5d84::farming_core::Pool<T0>, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, _, v2) = 0x891e08c8f501685d1e572b123247a3936a912adc60da63b1ead95f136bad5d84::market::borrow<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, 0x1::option::none<address>(), arg10);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, arg3);
        0x891e08c8f501685d1e572b123247a3936a912adc60da63b1ead95f136bad5d84::farming_core::stake_adjust<T0>(arg8, arg9, arg0, arg1, arg2, v2, true, arg6, arg10);
    }

    public fun flash_loan<T0>(arg0: &mut 0x891e08c8f501685d1e572b123247a3936a912adc60da63b1ead95f136bad5d84::market::Hearn, arg1: u64, arg2: u64, arg3: u128, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x891e08c8f501685d1e572b123247a3936a912adc60da63b1ead95f136bad5d84::market::FlashLoanReceipt<T0>) {
        0x891e08c8f501685d1e572b123247a3936a912adc60da63b1ead95f136bad5d84::market::flash_loan<T0>(arg0, arg1, arg2, arg3, arg4)
    }

    public fun flash_loan_repay<T0>(arg0: &mut 0x891e08c8f501685d1e572b123247a3936a912adc60da63b1ead95f136bad5d84::market::Hearn, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: 0x891e08c8f501685d1e572b123247a3936a912adc60da63b1ead95f136bad5d84::market::FlashLoanReceipt<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0x891e08c8f501685d1e572b123247a3936a912adc60da63b1ead95f136bad5d84::market::flash_loan_repay<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun repay<T0, T1>(arg0: &mut 0x891e08c8f501685d1e572b123247a3936a912adc60da63b1ead95f136bad5d84::market::Hearn, arg1: u64, arg2: address, arg3: u128, arg4: u128, arg5: 0x2::coin::Coin<T0>, arg6: &0x2::clock::Clock, arg7: &0x891e08c8f501685d1e572b123247a3936a912adc60da63b1ead95f136bad5d84::farming_core::Farming, arg8: &mut 0x891e08c8f501685d1e572b123247a3936a912adc60da63b1ead95f136bad5d84::farming_core::Pool<T0>, arg9: &mut 0x2::tx_context::TxContext) {
        let (_, v1, v2) = 0x891e08c8f501685d1e572b123247a3936a912adc60da63b1ead95f136bad5d84::market::repay<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg9);
        let v3 = v2;
        if (0x2::coin::value<T0>(&v3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg9));
        } else {
            0x2::coin::destroy_zero<T0>(v3);
        };
        0x891e08c8f501685d1e572b123247a3936a912adc60da63b1ead95f136bad5d84::farming_core::stake_adjust<T0>(arg7, arg8, arg0, arg1, arg2, v1, false, arg6, arg9);
    }

    public entry fun supply_collateral<T0>(arg0: &mut 0x891e08c8f501685d1e572b123247a3936a912adc60da63b1ead95f136bad5d84::market::Hearn, arg1: u64, arg2: address, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        let (_, v1) = 0x891e08c8f501685d1e572b123247a3936a912adc60da63b1ead95f136bad5d84::market::supply_collateral<T0>(arg0, arg1, arg2, arg3, arg4);
        let v2 = v1;
        if (0x2::coin::value<T0>(&v2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg4));
        } else {
            0x2::coin::destroy_zero<T0>(v2);
        };
    }

    public entry fun withdraw_collateral<T0, T1>(arg0: &mut 0x891e08c8f501685d1e572b123247a3936a912adc60da63b1ead95f136bad5d84::market::Hearn, arg1: u64, arg2: address, arg3: address, arg4: u128, arg5: &0x2::clock::Clock, arg6: &0xb58f355d03ce22d89d6f8ef94808a7ecbc8c5464c3cf2e03797ff93c8edfba9e::pyth_oracle::Oracle, arg7: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x891e08c8f501685d1e572b123247a3936a912adc60da63b1ead95f136bad5d84::market::withdraw_collateral<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::tx_context::sender(arg7), arg6, arg7), arg3);
    }

    public fun borrow_with_coin<T0, T1>(arg0: &mut 0x891e08c8f501685d1e572b123247a3936a912adc60da63b1ead95f136bad5d84::market::Hearn, arg1: u64, arg2: address, arg3: address, arg4: u128, arg5: u128, arg6: &0x2::clock::Clock, arg7: &0xb58f355d03ce22d89d6f8ef94808a7ecbc8c5464c3cf2e03797ff93c8edfba9e::pyth_oracle::Oracle, arg8: &0x891e08c8f501685d1e572b123247a3936a912adc60da63b1ead95f136bad5d84::farming_core::Farming, arg9: &mut 0x891e08c8f501685d1e572b123247a3936a912adc60da63b1ead95f136bad5d84::farming_core::Pool<T0>, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u128, u128) {
        let (v0, v1, v2) = 0x891e08c8f501685d1e572b123247a3936a912adc60da63b1ead95f136bad5d84::market::borrow<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, 0x1::option::none<address>(), arg10);
        0x891e08c8f501685d1e572b123247a3936a912adc60da63b1ead95f136bad5d84::farming_core::stake_adjust<T0>(arg8, arg9, arg0, arg1, arg2, v2, true, arg6, arg10);
        (v0, v1, v2)
    }

    public fun withdraw_collateral_with_coin<T0, T1>(arg0: &mut 0x891e08c8f501685d1e572b123247a3936a912adc60da63b1ead95f136bad5d84::market::Hearn, arg1: u64, arg2: address, arg3: u128, arg4: &0x2::clock::Clock, arg5: &0xb58f355d03ce22d89d6f8ef94808a7ecbc8c5464c3cf2e03797ff93c8edfba9e::pyth_oracle::Oracle, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::tx_context::sender(arg6);
        0x891e08c8f501685d1e572b123247a3936a912adc60da63b1ead95f136bad5d84::market::withdraw_collateral<T0, T1>(arg0, arg1, arg2, v0, arg3, arg4, v0, arg5, arg6)
    }

    // decompiled from Move bytecode v6
}

