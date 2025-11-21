module 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::swap_borrow {
    struct NewSwapBorrowEvent has copy, drop {
        leverage_owner_cap: 0x2::object::ID,
        operation: 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::leverage_obligation::Operation,
        collateral: 0x1::type_name::TypeName,
        debt: 0x1::type_name::TypeName,
        deposit: u64,
        deposit_usd: 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::Decimal,
    }

    struct SwapBorrowPotato<phantom T0, phantom T1> {
        flash_loan: 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::reserve::FlashLoan<T0, T1>,
        maybe_leverage: 0x1::option::Option<0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::Decimal>,
    }

    public fun complete_leverage<T0, T1, T2>(arg0: &mut 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::market::Market<T0>, arg1: &mut 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::leverage_market::LeverageMarket, arg2: &mut 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::leverage_obligation::LeverageMarketOwnerCap, arg3: SwapBorrowPotato<T0, T2>, arg4: 0x2::coin::Coin<T1>, arg5: &0x4abb202e193c18f6d5b418ef03418fd5e77f40d57a19355fececf8079fa1db98::coin_decimals_registry::CoinDecimalsRegistry, arg6: &0x5060fa94bc49945536eae3d46583d1d85dd3b1c549e5b83b48b0dfe9833ff404::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let SwapBorrowPotato {
            flash_loan     : v0,
            maybe_leverage : v1,
        } = arg3;
        let v2 = v1;
        let v3 = v0;
        let v4 = if (0x1::option::is_some<0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::Decimal>(&v2)) {
            let v5 = 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::floor(0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::div(0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::from(0x2::coin::value<T1>(&arg4)), *0x1::option::borrow<0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::Decimal>(&v2)));
            0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::leverage_obligation::increase_collateral(arg2, v5, 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::leverage_obligation::get_collateral_price<T1, T2>(arg6, arg7));
            v5
        } else {
            0
        };
        0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::deposit::deposit<T0, T1>(0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::leverage_obligation::market_obligation(arg2), arg0, arg4, arg7, arg8);
        let v6 = 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::reserve::fee<T0, T2>(&v3) + 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::reserve::loan_amount<T0, T2>(&v3);
        let v7 = 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::borrow::borrow<T0, T2>(0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::leverage_obligation::market_obligation(arg2), arg0, arg5, v6, arg6, arg7, arg8);
        assert!(0x2::coin::value<T2>(&v7) == v6, 13906834621019979775);
        let v8 = NewSwapBorrowEvent{
            leverage_owner_cap : 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::leverage_obligation::id(arg2),
            operation          : 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::leverage_obligation::swap_borrow(),
            collateral         : 0x1::type_name::get<T1>(),
            debt               : 0x1::type_name::get<T2>(),
            deposit            : v4,
            deposit_usd        : 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::leverage_obligation::get_usd_value<T1>(arg6, arg7, v4, arg5),
        };
        0x2::event::emit<NewSwapBorrowEvent>(v8);
        0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::leverage_repay::complete_leverage<T0, T2>(arg0, arg1, arg2, v3, v7, arg6, arg7, arg5, arg8)
    }

    public fun request_leverage<T0, T1, T2>(arg0: &mut 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::market::Market<T0>, arg1: &mut 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::leverage_market::LeverageMarket, arg2: &mut 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::leverage_obligation::LeverageMarketOwnerCap, arg3: 0x2::coin::Coin<T2>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (SwapBorrowPotato<T0, T2>, 0x2::coin::Coin<T2>) {
        assert!(!0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::leverage_market::is_leverate_on_going(arg1), 13906834384796778495);
        0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::leverage_market::mark_leverage_ongoing(arg1);
        0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::leverage_obligation::set_or_check_position<T0, T1, T2>(arg2, arg0, 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::leverage_obligation::swap_borrow());
        let v0 = if (0x2::coin::value<T2>(&arg3) == 0) {
            0x1::option::none<0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::Decimal>()
        } else {
            0x1::option::some<0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::Decimal>(0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::from_quotient(arg4, 0x2::coin::value<T2>(&arg3)))
        };
        let (v1, v2) = 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::flash_loan::borrow_flash_loan_inner<T0, T2>(arg0, arg4 - 0x2::coin::value<T2>(&arg3), 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::leverage_market::emode_group(arg1), arg5);
        let v3 = v1;
        0x2::coin::join<T2>(&mut v3, arg3);
        assert!(0x2::coin::value<T2>(&v3) == arg4, 13906834470696124415);
        let v4 = SwapBorrowPotato<T0, T2>{
            flash_loan     : v2,
            maybe_leverage : v0,
        };
        (v4, v3)
    }

    // decompiled from Move bytecode v6
}

