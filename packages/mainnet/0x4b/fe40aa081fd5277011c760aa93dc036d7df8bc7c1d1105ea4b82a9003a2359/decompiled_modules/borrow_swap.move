module 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::borrow_swap {
    struct NewBorrowSwapEvent has copy, drop {
        leverage_owner_cap: 0x2::object::ID,
        operation: 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::leverage_obligation::Operation,
        collateral: 0x1::type_name::TypeName,
        debt: 0x1::type_name::TypeName,
        deposit_amount: u64,
        deposit_usd: 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::Decimal,
    }

    public fun request_leverage<T0, T1, T2>(arg0: &mut 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::market::Market<T0>, arg1: &mut 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::leverage_market::LeverageMarket, arg2: &mut 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::leverage_obligation::LeverageMarketOwnerCap, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: &0x4abb202e193c18f6d5b418ef03418fd5e77f40d57a19355fececf8079fa1db98::coin_decimals_registry::CoinDecimalsRegistry, arg7: &0x2::clock::Clock, arg8: &0x5060fa94bc49945536eae3d46583d1d85dd3b1c549e5b83b48b0dfe9833ff404::x_oracle::XOracle, arg9: &mut 0x2::tx_context::TxContext) : (0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::reserve::FlashLoan<T0, T1>, 0x2::coin::Coin<T2>) {
        assert!(!0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::leverage_market::is_leverate_on_going(arg1), 13906834384796778495);
        0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::leverage_market::mark_leverage_ongoing(arg1);
        let v0 = NewBorrowSwapEvent{
            leverage_owner_cap : 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::leverage_obligation::id(arg2),
            operation          : 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::leverage_obligation::borrow_swap(),
            collateral         : 0x1::type_name::get<T1>(),
            debt               : 0x1::type_name::get<T2>(),
            deposit_amount     : 0x2::coin::value<T1>(&arg3),
            deposit_usd        : 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::leverage_obligation::get_usd_value<T1>(arg8, arg7, 0x2::coin::value<T1>(&arg3), arg6),
        };
        0x2::event::emit<NewBorrowSwapEvent>(v0);
        0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::leverage_obligation::set_or_check_position<T0, T1, T2>(arg2, arg0, 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::leverage_obligation::borrow_swap());
        let (v1, v2) = 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::flash_loan::borrow_flash_loan_inner<T0, T1>(arg0, arg4 - 0x2::coin::value<T1>(&arg3), 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::leverage_market::emode_group(arg1), arg9);
        let v3 = v1;
        0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::leverage_obligation::increase_collateral(arg2, 0x2::coin::value<T1>(&arg3), 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::leverage_obligation::get_collateral_price<T1, T2>(arg8, arg7));
        0x2::coin::join<T1>(&mut v3, arg3);
        assert!(0x2::coin::value<T1>(&v3) == arg4, 13906834505055862783);
        0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::deposit::deposit<T0, T1>(0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::leverage_obligation::market_obligation(arg2), arg0, v3, arg7, arg9);
        (v2, 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::borrow::borrow<T0, T2>(0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::leverage_obligation::market_obligation(arg2), arg0, arg6, arg5, arg8, arg7, arg9))
    }

    // decompiled from Move bytecode v6
}

