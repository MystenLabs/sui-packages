module 0x355a656d163883e472da3ed6c4137ddf043c8e5f11ab49a5d7e9ca0cf1023d9e::leverage_swap_borrow {
    struct NewSwapBorrowEvent has copy, drop {
        leverage_owner_cap: 0x2::object::ID,
        operation: 0x355a656d163883e472da3ed6c4137ddf043c8e5f11ab49a5d7e9ca0cf1023d9e::leverage_obligation::Operation,
        collateral: 0x1::type_name::TypeName,
        debt: 0x1::type_name::TypeName,
        initial_debt_amount: u64,
        collateral_price: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal,
    }

    public fun complete_leverage<T0, T1, T2>(arg0: &mut 0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::app::ProtocolApp, arg1: &mut 0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::market::Market<T0>, arg2: &mut 0x355a656d163883e472da3ed6c4137ddf043c8e5f11ab49a5d7e9ca0cf1023d9e::leverage_market::LeverageMarket, arg3: &0x355a656d163883e472da3ed6c4137ddf043c8e5f11ab49a5d7e9ca0cf1023d9e::leverage_obligation::LeverageMarketOwnerCap, arg4: 0x355a656d163883e472da3ed6c4137ddf043c8e5f11ab49a5d7e9ca0cf1023d9e::leverage_repay::LeverageHotPotato<T0, T2>, arg5: 0x2::coin::Coin<T1>, arg6: 0x1::option::Option<0x1::string::String>, arg7: &0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::coin_decimals_registry::CoinDecimalsRegistry, arg8: &0xf4b6a35a90a54d9758c06cf304ef93534fc37746ab0eff62bcae6bf272e50e83::x_oracle::XOracle, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x355a656d163883e472da3ed6c4137ddf043c8e5f11ab49a5d7e9ca0cf1023d9e::leverage_market::ensure_supporting_market<T0>(arg2, arg1);
        0x355a656d163883e472da3ed6c4137ddf043c8e5f11ab49a5d7e9ca0cf1023d9e::leverage_obligation::ensure_coins_match<T1, T2>(arg3);
        0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::deposit::deposit<T0, T1>(arg0, arg1, 0x355a656d163883e472da3ed6c4137ddf043c8e5f11ab49a5d7e9ca0cf1023d9e::leverage_obligation::market_obligation(arg3), arg5, arg9, arg10);
        0x355a656d163883e472da3ed6c4137ddf043c8e5f11ab49a5d7e9ca0cf1023d9e::leverage_repay::complete_leverage<T0, T2>(arg0, arg1, arg2, arg3, arg4, arg6, 0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::borrow::borrow<T0, T2>(arg0, 0x355a656d163883e472da3ed6c4137ddf043c8e5f11ab49a5d7e9ca0cf1023d9e::leverage_obligation::market_obligation(arg3), arg1, arg7, 0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::market::fee<T0, T2>(0x355a656d163883e472da3ed6c4137ddf043c8e5f11ab49a5d7e9ca0cf1023d9e::leverage_repay::flash_loan<T0, T2>(&arg4)) + 0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::market::loan_amount<T0, T2>(0x355a656d163883e472da3ed6c4137ddf043c8e5f11ab49a5d7e9ca0cf1023d9e::leverage_repay::flash_loan<T0, T2>(&arg4)), arg8, arg9, arg10), arg8, arg9, arg7, arg10)
    }

    public fun request_leverage<T0, T1, T2>(arg0: &0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::app::ProtocolApp, arg1: &0x355a656d163883e472da3ed6c4137ddf043c8e5f11ab49a5d7e9ca0cf1023d9e::leverage_app::LeverageApp, arg2: &mut 0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::market::Market<T0>, arg3: &mut 0x355a656d163883e472da3ed6c4137ddf043c8e5f11ab49a5d7e9ca0cf1023d9e::leverage_market::LeverageMarket, arg4: &mut 0x355a656d163883e472da3ed6c4137ddf043c8e5f11ab49a5d7e9ca0cf1023d9e::leverage_obligation::LeverageMarketOwnerCap, arg5: 0x2::coin::Coin<T2>, arg6: u64, arg7: &0xf4b6a35a90a54d9758c06cf304ef93534fc37746ab0eff62bcae6bf272e50e83::x_oracle::XOracle, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x355a656d163883e472da3ed6c4137ddf043c8e5f11ab49a5d7e9ca0cf1023d9e::leverage_repay::LeverageHotPotato<T0, T2>, 0x2::coin::Coin<T2>) {
        0x355a656d163883e472da3ed6c4137ddf043c8e5f11ab49a5d7e9ca0cf1023d9e::leverage_app::ensure_version_matches(arg1);
        0x355a656d163883e472da3ed6c4137ddf043c8e5f11ab49a5d7e9ca0cf1023d9e::leverage_market::ensure_no_leverage_on_going(arg3);
        0x355a656d163883e472da3ed6c4137ddf043c8e5f11ab49a5d7e9ca0cf1023d9e::leverage_market::mark_leverage_ongoing(arg3);
        0x355a656d163883e472da3ed6c4137ddf043c8e5f11ab49a5d7e9ca0cf1023d9e::leverage_market::ensure_supporting_market<T0>(arg3, arg2);
        0x355a656d163883e472da3ed6c4137ddf043c8e5f11ab49a5d7e9ca0cf1023d9e::leverage_obligation::ensure_same_market<T0>(arg4);
        0x355a656d163883e472da3ed6c4137ddf043c8e5f11ab49a5d7e9ca0cf1023d9e::leverage_obligation::set_or_check_position<T1, T2>(arg4, 0x355a656d163883e472da3ed6c4137ddf043c8e5f11ab49a5d7e9ca0cf1023d9e::leverage_obligation::swap_borrow());
        let v0 = NewSwapBorrowEvent{
            leverage_owner_cap  : 0x355a656d163883e472da3ed6c4137ddf043c8e5f11ab49a5d7e9ca0cf1023d9e::leverage_obligation::id(arg4),
            operation           : 0x355a656d163883e472da3ed6c4137ddf043c8e5f11ab49a5d7e9ca0cf1023d9e::leverage_obligation::swap_borrow(),
            collateral          : 0x1::type_name::with_defining_ids<T1>(),
            debt                : 0x1::type_name::with_defining_ids<T2>(),
            initial_debt_amount : 0x2::coin::value<T2>(&arg5),
            collateral_price    : 0x355a656d163883e472da3ed6c4137ddf043c8e5f11ab49a5d7e9ca0cf1023d9e::leverage_obligation::get_collateral_price<T1, T2>(arg7, arg8),
        };
        0x2::event::emit<NewSwapBorrowEvent>(v0);
        let (v1, v2) = 0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::flash_loan::borrow_flash_loan<T0, T2>(arg0, 0x355a656d163883e472da3ed6c4137ddf043c8e5f11ab49a5d7e9ca0cf1023d9e::leverage_app::borrow_protocol_caller_cap(arg1), arg2, 0x355a656d163883e472da3ed6c4137ddf043c8e5f11ab49a5d7e9ca0cf1023d9e::leverage_market::emode_group(arg3), arg6 - 0x2::coin::value<T2>(&arg5), arg9);
        let v3 = v1;
        0x2::coin::join<T2>(&mut v3, arg5);
        assert!(0x2::coin::value<T2>(&v3) == arg6, 0x355a656d163883e472da3ed6c4137ddf043c8e5f11ab49a5d7e9ca0cf1023d9e::leverage_error::inconsistent_total_leverage_value());
        (0x355a656d163883e472da3ed6c4137ddf043c8e5f11ab49a5d7e9ca0cf1023d9e::leverage_repay::new_leverage_hot_potato<T0, T2>(v2), v3)
    }

    // decompiled from Move bytecode v6
}

