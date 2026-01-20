module 0xe6be8c2642a55b69322dbc1c23fc83177d96cdc2c97b4af5753a6cdc2f188285::leverage_swap_borrow {
    struct NewSwapBorrowEvent has copy, drop {
        leverage_owner_cap: 0x2::object::ID,
        operation: 0xe6be8c2642a55b69322dbc1c23fc83177d96cdc2c97b4af5753a6cdc2f188285::leverage_obligation::Operation,
        collateral: 0x1::type_name::TypeName,
        debt: 0x1::type_name::TypeName,
        initial_debt_amount: u64,
        collateral_price: 0x620f11cbcf6d9dd8b0e77a6a06d413bd15eb0682501e554959b804d0a3626b6e::float::Decimal,
    }

    public fun complete_leverage<T0, T1, T2>(arg0: &mut 0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::app::ProtocolApp, arg1: &mut 0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::market::Market<T0>, arg2: &mut 0xe6be8c2642a55b69322dbc1c23fc83177d96cdc2c97b4af5753a6cdc2f188285::leverage_market::LeverageMarket, arg3: &mut 0xe6be8c2642a55b69322dbc1c23fc83177d96cdc2c97b4af5753a6cdc2f188285::leverage_obligation::LeverageMarketOwnerCap, arg4: 0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::market::FlashLoan<T0, T2>, arg5: 0x2::coin::Coin<T1>, arg6: 0x1::option::Option<0x1::string::String>, arg7: &0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::coin_decimals_registry::CoinDecimalsRegistry, arg8: &0x819909b3d88417bb50cbb62bdd1d299caa80bcaa03d016e61c545b172cebfa4b::x_oracle::XOracle, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::deposit::deposit<T0, T1>(arg0, arg1, 0xe6be8c2642a55b69322dbc1c23fc83177d96cdc2c97b4af5753a6cdc2f188285::leverage_obligation::market_obligation(arg3), arg5, arg9, arg10);
        let v0 = 0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::market::fee<T0, T2>(&arg4) + 0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::market::loan_amount<T0, T2>(&arg4);
        let v1 = 0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::borrow::borrow<T0, T2>(0xe6be8c2642a55b69322dbc1c23fc83177d96cdc2c97b4af5753a6cdc2f188285::leverage_obligation::market_obligation(arg3), arg1, arg7, v0, arg8, arg9, arg10);
        assert!(0x2::coin::value<T2>(&v1) == v0, 13906834651084750847);
        0xe6be8c2642a55b69322dbc1c23fc83177d96cdc2c97b4af5753a6cdc2f188285::leverage_repay::complete_leverage<T0, T2>(arg0, arg1, arg2, arg3, arg4, arg6, v1, arg8, arg9, arg7, arg10)
    }

    public fun request_leverage<T0, T1, T2>(arg0: &mut 0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::app::ProtocolApp, arg1: &mut 0xe6be8c2642a55b69322dbc1c23fc83177d96cdc2c97b4af5753a6cdc2f188285::leverage_app::LeverageApp, arg2: &mut 0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::market::Market<T0>, arg3: &mut 0xe6be8c2642a55b69322dbc1c23fc83177d96cdc2c97b4af5753a6cdc2f188285::leverage_market::LeverageMarket, arg4: &mut 0xe6be8c2642a55b69322dbc1c23fc83177d96cdc2c97b4af5753a6cdc2f188285::leverage_obligation::LeverageMarketOwnerCap, arg5: 0x2::coin::Coin<T2>, arg6: u64, arg7: &0x819909b3d88417bb50cbb62bdd1d299caa80bcaa03d016e61c545b172cebfa4b::x_oracle::XOracle, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::market::FlashLoan<T0, T2>, 0x2::coin::Coin<T2>) {
        0xe6be8c2642a55b69322dbc1c23fc83177d96cdc2c97b4af5753a6cdc2f188285::leverage_market::ensure_no_leverage_on_going(arg3);
        0xe6be8c2642a55b69322dbc1c23fc83177d96cdc2c97b4af5753a6cdc2f188285::leverage_market::mark_leverage_ongoing(arg3);
        0xe6be8c2642a55b69322dbc1c23fc83177d96cdc2c97b4af5753a6cdc2f188285::leverage_obligation::ensure_same_market<T0>(arg4);
        0xe6be8c2642a55b69322dbc1c23fc83177d96cdc2c97b4af5753a6cdc2f188285::leverage_obligation::set_or_check_position<T1, T2>(arg4, 0xe6be8c2642a55b69322dbc1c23fc83177d96cdc2c97b4af5753a6cdc2f188285::leverage_obligation::swap_borrow());
        let v0 = NewSwapBorrowEvent{
            leverage_owner_cap  : 0xe6be8c2642a55b69322dbc1c23fc83177d96cdc2c97b4af5753a6cdc2f188285::leverage_obligation::id(arg4),
            operation           : 0xe6be8c2642a55b69322dbc1c23fc83177d96cdc2c97b4af5753a6cdc2f188285::leverage_obligation::swap_borrow(),
            collateral          : 0x1::type_name::get<T1>(),
            debt                : 0x1::type_name::get<T2>(),
            initial_debt_amount : 0x2::coin::value<T2>(&arg5),
            collateral_price    : 0xe6be8c2642a55b69322dbc1c23fc83177d96cdc2c97b4af5753a6cdc2f188285::leverage_obligation::get_collateral_price<T1, T2>(arg7, arg8),
        };
        0x2::event::emit<NewSwapBorrowEvent>(v0);
        let (v1, v2) = 0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::flash_loan::borrow_flash_loan<T0, T2>(arg0, 0xe6be8c2642a55b69322dbc1c23fc83177d96cdc2c97b4af5753a6cdc2f188285::leverage_app::borrow_protocol_caller_cap(arg1), arg2, 0xe6be8c2642a55b69322dbc1c23fc83177d96cdc2c97b4af5753a6cdc2f188285::leverage_market::emode_group(arg3), arg6 - 0x2::coin::value<T2>(&arg5), arg9);
        let v3 = v1;
        0x2::coin::join<T2>(&mut v3, arg5);
        assert!(0x2::coin::value<T2>(&v3) == arg6, 13906834509350830079);
        (v2, v3)
    }

    // decompiled from Move bytecode v6
}

