module 0x27ef7aa84771904162eb86126b3ead179003f6f26bef7c751c36caae1589a993::leverage_swap_borrow {
    struct NewSwapBorrowEvent has copy, drop {
        leverage_owner_cap: 0x2::object::ID,
        operation: 0x27ef7aa84771904162eb86126b3ead179003f6f26bef7c751c36caae1589a993::leverage_obligation::Operation,
        collateral: 0x1::type_name::TypeName,
        debt: 0x1::type_name::TypeName,
        initial_debt_amount: u64,
        collateral_price: 0xa8238dcaf33f70aa16f605d4744ffa049607b2a58a6a7fc728beb2ab346ce2af::float::Decimal,
    }

    public fun complete_leverage<T0, T1, T2>(arg0: &mut 0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::app::ProtocolApp, arg1: &mut 0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::market::Market<T0>, arg2: &mut 0x27ef7aa84771904162eb86126b3ead179003f6f26bef7c751c36caae1589a993::leverage_market::LeverageMarket, arg3: &0x27ef7aa84771904162eb86126b3ead179003f6f26bef7c751c36caae1589a993::leverage_obligation::LeverageMarketOwnerCap, arg4: 0x27ef7aa84771904162eb86126b3ead179003f6f26bef7c751c36caae1589a993::leverage_repay::LeverageHotPotato<T0, T2>, arg5: 0x2::coin::Coin<T1>, arg6: 0x1::option::Option<0x1::string::String>, arg7: &0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::coin_decimals_registry::CoinDecimalsRegistry, arg8: &0xa82b15bccee2ba9604ee1906e484dc1313c5cc5bfec25c340dc23b9df9b2347a::x_oracle::XOracle, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x27ef7aa84771904162eb86126b3ead179003f6f26bef7c751c36caae1589a993::leverage_market::ensure_supporting_market<T0>(arg2, arg1);
        0x27ef7aa84771904162eb86126b3ead179003f6f26bef7c751c36caae1589a993::leverage_obligation::ensure_coins_match<T1, T2>(arg3);
        0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::deposit::deposit<T0, T1>(arg0, arg1, 0x27ef7aa84771904162eb86126b3ead179003f6f26bef7c751c36caae1589a993::leverage_obligation::market_obligation(arg3), arg5, arg9, arg10);
        0x27ef7aa84771904162eb86126b3ead179003f6f26bef7c751c36caae1589a993::leverage_repay::complete_leverage<T0, T2>(arg0, arg1, arg2, arg3, arg4, arg6, 0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::borrow::borrow<T0, T2>(arg0, 0x27ef7aa84771904162eb86126b3ead179003f6f26bef7c751c36caae1589a993::leverage_obligation::market_obligation(arg3), arg1, arg7, 0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::market::fee<T0, T2>(0x27ef7aa84771904162eb86126b3ead179003f6f26bef7c751c36caae1589a993::leverage_repay::flash_loan<T0, T2>(&arg4)) + 0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::market::loan_amount<T0, T2>(0x27ef7aa84771904162eb86126b3ead179003f6f26bef7c751c36caae1589a993::leverage_repay::flash_loan<T0, T2>(&arg4)), arg8, arg9, arg10), arg8, arg9, arg7, arg10)
    }

    public fun request_leverage<T0, T1, T2>(arg0: &0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::app::ProtocolApp, arg1: &0x27ef7aa84771904162eb86126b3ead179003f6f26bef7c751c36caae1589a993::leverage_app::LeverageApp, arg2: &mut 0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::market::Market<T0>, arg3: &mut 0x27ef7aa84771904162eb86126b3ead179003f6f26bef7c751c36caae1589a993::leverage_market::LeverageMarket, arg4: &mut 0x27ef7aa84771904162eb86126b3ead179003f6f26bef7c751c36caae1589a993::leverage_obligation::LeverageMarketOwnerCap, arg5: 0x2::coin::Coin<T2>, arg6: u64, arg7: &0xa82b15bccee2ba9604ee1906e484dc1313c5cc5bfec25c340dc23b9df9b2347a::x_oracle::XOracle, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x27ef7aa84771904162eb86126b3ead179003f6f26bef7c751c36caae1589a993::leverage_repay::LeverageHotPotato<T0, T2>, 0x2::coin::Coin<T2>) {
        0x27ef7aa84771904162eb86126b3ead179003f6f26bef7c751c36caae1589a993::leverage_app::ensure_version_matches(arg1);
        0x27ef7aa84771904162eb86126b3ead179003f6f26bef7c751c36caae1589a993::leverage_market::ensure_no_leverage_on_going(arg3);
        0x27ef7aa84771904162eb86126b3ead179003f6f26bef7c751c36caae1589a993::leverage_market::mark_leverage_ongoing(arg3);
        0x27ef7aa84771904162eb86126b3ead179003f6f26bef7c751c36caae1589a993::leverage_market::ensure_supporting_market<T0>(arg3, arg2);
        0x27ef7aa84771904162eb86126b3ead179003f6f26bef7c751c36caae1589a993::leverage_obligation::ensure_same_market<T0>(arg4);
        0x27ef7aa84771904162eb86126b3ead179003f6f26bef7c751c36caae1589a993::leverage_obligation::ensure_same_emode(arg4, 0x27ef7aa84771904162eb86126b3ead179003f6f26bef7c751c36caae1589a993::leverage_market::emode_group(arg3));
        0x27ef7aa84771904162eb86126b3ead179003f6f26bef7c751c36caae1589a993::leverage_obligation::set_or_check_position<T1, T2>(arg4, 0x27ef7aa84771904162eb86126b3ead179003f6f26bef7c751c36caae1589a993::leverage_obligation::swap_borrow());
        let v0 = NewSwapBorrowEvent{
            leverage_owner_cap  : 0x27ef7aa84771904162eb86126b3ead179003f6f26bef7c751c36caae1589a993::leverage_obligation::id(arg4),
            operation           : 0x27ef7aa84771904162eb86126b3ead179003f6f26bef7c751c36caae1589a993::leverage_obligation::swap_borrow(),
            collateral          : 0x1::type_name::with_defining_ids<T1>(),
            debt                : 0x1::type_name::with_defining_ids<T2>(),
            initial_debt_amount : 0x2::coin::value<T2>(&arg5),
            collateral_price    : 0x27ef7aa84771904162eb86126b3ead179003f6f26bef7c751c36caae1589a993::leverage_obligation::get_collateral_price<T1, T2>(arg7, arg8),
        };
        0x2::event::emit<NewSwapBorrowEvent>(v0);
        let (v1, v2) = 0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::flash_loan::borrow_flash_loan<T0, T2>(arg0, 0x27ef7aa84771904162eb86126b3ead179003f6f26bef7c751c36caae1589a993::leverage_app::borrow_protocol_caller_cap(arg1), arg2, 0x27ef7aa84771904162eb86126b3ead179003f6f26bef7c751c36caae1589a993::leverage_market::emode_group(arg3), arg6 - 0x2::coin::value<T2>(&arg5), arg9);
        let v3 = v1;
        0x2::coin::join<T2>(&mut v3, arg5);
        assert!(0x2::coin::value<T2>(&v3) == arg6, 0x27ef7aa84771904162eb86126b3ead179003f6f26bef7c751c36caae1589a993::leverage_error::inconsistent_total_leverage_value());
        (0x27ef7aa84771904162eb86126b3ead179003f6f26bef7c751c36caae1589a993::leverage_repay::new_leverage_hot_potato<T0, T2>(v2), v3)
    }

    // decompiled from Move bytecode v6
}

