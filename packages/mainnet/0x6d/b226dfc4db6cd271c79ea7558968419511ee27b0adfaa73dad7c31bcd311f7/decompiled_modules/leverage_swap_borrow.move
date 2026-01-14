module 0x6db226dfc4db6cd271c79ea7558968419511ee27b0adfaa73dad7c31bcd311f7::leverage_swap_borrow {
    struct NewSwapBorrowEvent has copy, drop {
        leverage_owner_cap: 0x2::object::ID,
        operation: 0x6db226dfc4db6cd271c79ea7558968419511ee27b0adfaa73dad7c31bcd311f7::leverage_obligation::Operation,
        collateral: 0x1::type_name::TypeName,
        debt: 0x1::type_name::TypeName,
        initial_debt_amount: u64,
        collateral_price: 0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::Decimal,
    }

    public fun complete_leverage<T0, T1, T2>(arg0: &mut 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::app::ProtocolApp, arg1: &mut 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::market::Market<T0>, arg2: &mut 0x6db226dfc4db6cd271c79ea7558968419511ee27b0adfaa73dad7c31bcd311f7::leverage_market::LeverageMarket, arg3: &mut 0x6db226dfc4db6cd271c79ea7558968419511ee27b0adfaa73dad7c31bcd311f7::leverage_obligation::LeverageMarketOwnerCap, arg4: 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::market::FlashLoan<T0, T2>, arg5: 0x2::coin::Coin<T1>, arg6: 0x1::option::Option<0x1::string::String>, arg7: &0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::coin_decimals_registry::CoinDecimalsRegistry, arg8: &0xf5b4ce4da4ce6571678b0d6ea93de20400e47f8305a7964feb2a1bdd97221685::x_oracle::XOracle, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::deposit::deposit<T0, T1>(arg0, arg1, 0x6db226dfc4db6cd271c79ea7558968419511ee27b0adfaa73dad7c31bcd311f7::leverage_obligation::market_obligation(arg3), arg5, arg7, arg8, arg9, arg10);
        let v0 = 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::market::fee<T0, T2>(&arg4) + 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::market::loan_amount<T0, T2>(&arg4);
        let v1 = 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::borrow::borrow<T0, T2>(0x6db226dfc4db6cd271c79ea7558968419511ee27b0adfaa73dad7c31bcd311f7::leverage_obligation::market_obligation(arg3), arg1, arg7, v0, arg8, arg9, arg10);
        assert!(0x2::coin::value<T2>(&v1) == v0, 13906834659674685439);
        0x6db226dfc4db6cd271c79ea7558968419511ee27b0adfaa73dad7c31bcd311f7::leverage_repay::complete_leverage<T0, T2>(arg0, arg1, arg2, arg3, arg4, arg6, v1, arg8, arg9, arg7, arg10)
    }

    public fun request_leverage<T0, T1, T2>(arg0: &mut 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::app::ProtocolApp, arg1: &mut 0x6db226dfc4db6cd271c79ea7558968419511ee27b0adfaa73dad7c31bcd311f7::leverage_app::LeverageApp, arg2: &mut 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::market::Market<T0>, arg3: &mut 0x6db226dfc4db6cd271c79ea7558968419511ee27b0adfaa73dad7c31bcd311f7::leverage_market::LeverageMarket, arg4: &mut 0x6db226dfc4db6cd271c79ea7558968419511ee27b0adfaa73dad7c31bcd311f7::leverage_obligation::LeverageMarketOwnerCap, arg5: 0x2::coin::Coin<T2>, arg6: u64, arg7: &0xf5b4ce4da4ce6571678b0d6ea93de20400e47f8305a7964feb2a1bdd97221685::x_oracle::XOracle, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::market::FlashLoan<T0, T2>, 0x2::coin::Coin<T2>) {
        assert!(!0x6db226dfc4db6cd271c79ea7558968419511ee27b0adfaa73dad7c31bcd311f7::leverage_market::is_leverate_on_going(arg3), 13906834393386713087);
        0x6db226dfc4db6cd271c79ea7558968419511ee27b0adfaa73dad7c31bcd311f7::leverage_market::mark_leverage_ongoing(arg3);
        0x6db226dfc4db6cd271c79ea7558968419511ee27b0adfaa73dad7c31bcd311f7::leverage_obligation::ensure_same_market<T0>(arg4);
        0x6db226dfc4db6cd271c79ea7558968419511ee27b0adfaa73dad7c31bcd311f7::leverage_obligation::set_or_check_position<T1, T2>(arg4, 0x6db226dfc4db6cd271c79ea7558968419511ee27b0adfaa73dad7c31bcd311f7::leverage_obligation::swap_borrow());
        let v0 = NewSwapBorrowEvent{
            leverage_owner_cap  : 0x6db226dfc4db6cd271c79ea7558968419511ee27b0adfaa73dad7c31bcd311f7::leverage_obligation::id(arg4),
            operation           : 0x6db226dfc4db6cd271c79ea7558968419511ee27b0adfaa73dad7c31bcd311f7::leverage_obligation::swap_borrow(),
            collateral          : 0x1::type_name::get<T1>(),
            debt                : 0x1::type_name::get<T2>(),
            initial_debt_amount : 0x2::coin::value<T2>(&arg5),
            collateral_price    : 0x6db226dfc4db6cd271c79ea7558968419511ee27b0adfaa73dad7c31bcd311f7::leverage_obligation::get_collateral_price<T1, T2>(arg7, arg8),
        };
        0x2::event::emit<NewSwapBorrowEvent>(v0);
        let (v1, v2) = 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::flash_loan::borrow_flash_loan<T0, T2>(arg0, 0x6db226dfc4db6cd271c79ea7558968419511ee27b0adfaa73dad7c31bcd311f7::leverage_app::borrow_protocol_caller_cap(arg1), arg2, 0x6db226dfc4db6cd271c79ea7558968419511ee27b0adfaa73dad7c31bcd311f7::leverage_market::emode_group(arg3), arg6 - 0x2::coin::value<T2>(&arg5), arg9);
        let v3 = v1;
        0x2::coin::join<T2>(&mut v3, arg5);
        assert!(0x2::coin::value<T2>(&v3) == arg6, 13906834509350830079);
        (v2, v3)
    }

    // decompiled from Move bytecode v6
}

