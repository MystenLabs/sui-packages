module 0xc7c4314eb7c803d6a885c978cfc45dca5a7183499d31db646146025488aa5db6::leverage_borrow_swap {
    struct NewBorrowSwapEvent has copy, drop {
        leverage_owner_cap: 0x2::object::ID,
        operation: 0xc7c4314eb7c803d6a885c978cfc45dca5a7183499d31db646146025488aa5db6::leverage_obligation::Operation,
        collateral: 0x1::type_name::TypeName,
        debt: 0x1::type_name::TypeName,
        collateral_amount: u64,
        collateral_price: 0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::Decimal,
    }

    public fun request_leverage<T0, T1, T2>(arg0: &0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::ProtocolApp, arg1: &0xc7c4314eb7c803d6a885c978cfc45dca5a7183499d31db646146025488aa5db6::leverage_app::LeverageApp, arg2: &mut 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::market::Market<T0>, arg3: &mut 0xc7c4314eb7c803d6a885c978cfc45dca5a7183499d31db646146025488aa5db6::leverage_market::LeverageMarket, arg4: &mut 0xc7c4314eb7c803d6a885c978cfc45dca5a7183499d31db646146025488aa5db6::leverage_obligation::LeverageMarketOwnerCap, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: &0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::coin_decimals_registry::CoinDecimalsRegistry, arg9: &0x2::clock::Clock, arg10: &0xb2122b399c78f3f0f9874bdd34fbdda90d3867ebf8972bda97f85218bf0de67::x_oracle::XOracle, arg11: &mut 0x2::tx_context::TxContext) : (0xc7c4314eb7c803d6a885c978cfc45dca5a7183499d31db646146025488aa5db6::leverage_repay::LeverageHotPotato<T0, T1>, 0x2::coin::Coin<T2>) {
        0xc7c4314eb7c803d6a885c978cfc45dca5a7183499d31db646146025488aa5db6::leverage_app::ensure_version_matches(arg1);
        0xc7c4314eb7c803d6a885c978cfc45dca5a7183499d31db646146025488aa5db6::leverage_market::ensure_no_leverage_on_going(arg3);
        0xc7c4314eb7c803d6a885c978cfc45dca5a7183499d31db646146025488aa5db6::leverage_market::mark_leverage_ongoing(arg3);
        0xc7c4314eb7c803d6a885c978cfc45dca5a7183499d31db646146025488aa5db6::leverage_market::ensure_supporting_market<T0>(arg3, arg2);
        0xc7c4314eb7c803d6a885c978cfc45dca5a7183499d31db646146025488aa5db6::leverage_obligation::ensure_same_market<T0>(arg4);
        0xc7c4314eb7c803d6a885c978cfc45dca5a7183499d31db646146025488aa5db6::leverage_obligation::ensure_same_emode(arg4, 0xc7c4314eb7c803d6a885c978cfc45dca5a7183499d31db646146025488aa5db6::leverage_market::emode_group(arg3));
        0xc7c4314eb7c803d6a885c978cfc45dca5a7183499d31db646146025488aa5db6::leverage_obligation::set_or_check_position<T1, T2>(arg4, 0xc7c4314eb7c803d6a885c978cfc45dca5a7183499d31db646146025488aa5db6::leverage_obligation::borrow_swap());
        let v0 = NewBorrowSwapEvent{
            leverage_owner_cap : 0xc7c4314eb7c803d6a885c978cfc45dca5a7183499d31db646146025488aa5db6::leverage_obligation::id(arg4),
            operation          : 0xc7c4314eb7c803d6a885c978cfc45dca5a7183499d31db646146025488aa5db6::leverage_obligation::borrow_swap(),
            collateral         : 0x1::type_name::with_defining_ids<T1>(),
            debt               : 0x1::type_name::with_defining_ids<T2>(),
            collateral_amount  : 0x2::coin::value<T1>(&arg5),
            collateral_price   : 0xc7c4314eb7c803d6a885c978cfc45dca5a7183499d31db646146025488aa5db6::leverage_obligation::get_collateral_price<T1, T2>(arg10, arg9),
        };
        0x2::event::emit<NewBorrowSwapEvent>(v0);
        let (v1, v2) = 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::flash_loan::borrow_flash_loan<T0, T1>(arg0, 0xc7c4314eb7c803d6a885c978cfc45dca5a7183499d31db646146025488aa5db6::leverage_app::borrow_protocol_caller_cap(arg1), arg2, 0xc7c4314eb7c803d6a885c978cfc45dca5a7183499d31db646146025488aa5db6::leverage_market::emode_group(arg3), arg6 - 0x2::coin::value<T1>(&arg5), arg11);
        let v3 = v1;
        0x2::coin::join<T1>(&mut v3, arg5);
        assert!(0x2::coin::value<T1>(&v3) == arg6, 0xc7c4314eb7c803d6a885c978cfc45dca5a7183499d31db646146025488aa5db6::leverage_error::token_amount_not_expected_value());
        0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::deposit::deposit<T0, T1>(arg0, arg2, 0xc7c4314eb7c803d6a885c978cfc45dca5a7183499d31db646146025488aa5db6::leverage_obligation::market_obligation(arg4), v3, arg9, arg11);
        (0xc7c4314eb7c803d6a885c978cfc45dca5a7183499d31db646146025488aa5db6::leverage_repay::new_leverage_hot_potato<T0, T1>(v2), 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::borrow::borrow<T0, T2>(arg0, 0xc7c4314eb7c803d6a885c978cfc45dca5a7183499d31db646146025488aa5db6::leverage_obligation::market_obligation(arg4), arg2, arg8, arg7, arg10, arg9, arg11))
    }

    // decompiled from Move bytecode v6
}

