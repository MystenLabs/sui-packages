module 0x6db226dfc4db6cd271c79ea7558968419511ee27b0adfaa73dad7c31bcd311f7::leverage_borrow_swap {
    struct NewBorrowSwapEvent has copy, drop {
        leverage_owner_cap: 0x2::object::ID,
        operation: 0x6db226dfc4db6cd271c79ea7558968419511ee27b0adfaa73dad7c31bcd311f7::leverage_obligation::Operation,
        collateral: 0x1::type_name::TypeName,
        debt: 0x1::type_name::TypeName,
        collateral_amount: u64,
        collateral_price: 0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::Decimal,
    }

    public fun request_leverage<T0, T1, T2>(arg0: &mut 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::app::ProtocolApp, arg1: &mut 0x6db226dfc4db6cd271c79ea7558968419511ee27b0adfaa73dad7c31bcd311f7::leverage_app::LeverageApp, arg2: &mut 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::market::Market<T0>, arg3: &mut 0x6db226dfc4db6cd271c79ea7558968419511ee27b0adfaa73dad7c31bcd311f7::leverage_market::LeverageMarket, arg4: &mut 0x6db226dfc4db6cd271c79ea7558968419511ee27b0adfaa73dad7c31bcd311f7::leverage_obligation::LeverageMarketOwnerCap, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: &0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::coin_decimals_registry::CoinDecimalsRegistry, arg9: &0x2::clock::Clock, arg10: &0xf5b4ce4da4ce6571678b0d6ea93de20400e47f8305a7964feb2a1bdd97221685::x_oracle::XOracle, arg11: &mut 0x2::tx_context::TxContext) : (0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::market::FlashLoan<T0, T1>, 0x2::coin::Coin<T2>) {
        assert!(!0x6db226dfc4db6cd271c79ea7558968419511ee27b0adfaa73dad7c31bcd311f7::leverage_market::is_leverate_on_going(arg3), 13906834406271614975);
        0x6db226dfc4db6cd271c79ea7558968419511ee27b0adfaa73dad7c31bcd311f7::leverage_market::mark_leverage_ongoing(arg3);
        let v0 = NewBorrowSwapEvent{
            leverage_owner_cap : 0x6db226dfc4db6cd271c79ea7558968419511ee27b0adfaa73dad7c31bcd311f7::leverage_obligation::id(arg4),
            operation          : 0x6db226dfc4db6cd271c79ea7558968419511ee27b0adfaa73dad7c31bcd311f7::leverage_obligation::borrow_swap(),
            collateral         : 0x1::type_name::get<T1>(),
            debt               : 0x1::type_name::get<T2>(),
            collateral_amount  : 0x2::coin::value<T1>(&arg5),
            collateral_price   : 0x6db226dfc4db6cd271c79ea7558968419511ee27b0adfaa73dad7c31bcd311f7::leverage_obligation::get_collateral_price<T1, T2>(arg10, arg9),
        };
        0x2::event::emit<NewBorrowSwapEvent>(v0);
        0x6db226dfc4db6cd271c79ea7558968419511ee27b0adfaa73dad7c31bcd311f7::leverage_obligation::ensure_same_market<T0>(arg4);
        0x6db226dfc4db6cd271c79ea7558968419511ee27b0adfaa73dad7c31bcd311f7::leverage_obligation::set_or_check_position<T1, T2>(arg4, 0x6db226dfc4db6cd271c79ea7558968419511ee27b0adfaa73dad7c31bcd311f7::leverage_obligation::borrow_swap());
        let (v1, v2) = 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::flash_loan::borrow_flash_loan<T0, T1>(arg0, 0x6db226dfc4db6cd271c79ea7558968419511ee27b0adfaa73dad7c31bcd311f7::leverage_app::borrow_protocol_caller_cap(arg1), arg2, 0x6db226dfc4db6cd271c79ea7558968419511ee27b0adfaa73dad7c31bcd311f7::leverage_market::emode_group(arg3), arg6 - 0x2::coin::value<T1>(&arg5), arg11);
        let v3 = v1;
        0x2::coin::join<T1>(&mut v3, arg5);
        assert!(0x2::coin::value<T1>(&v3) == arg6, 13906834526530699263);
        0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::deposit::deposit<T0, T1>(arg0, arg2, 0x6db226dfc4db6cd271c79ea7558968419511ee27b0adfaa73dad7c31bcd311f7::leverage_obligation::market_obligation(arg4), v3, arg8, arg10, arg9, arg11);
        (v2, 0xfb78ab969ab53008970b076aef4e350df755ce3dd71ca2ec1da4b6ea524bef32::borrow::borrow<T0, T2>(0x6db226dfc4db6cd271c79ea7558968419511ee27b0adfaa73dad7c31bcd311f7::leverage_obligation::market_obligation(arg4), arg2, arg8, arg7, arg10, arg9, arg11))
    }

    // decompiled from Move bytecode v6
}

