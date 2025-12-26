module 0x20073d9e13cb93f4cff52e05ea3ef371efed2ebec353bee5c3c9abd62bb44048::leverage_borrow_swap {
    struct NewBorrowSwapEvent has copy, drop {
        leverage_owner_cap: 0x2::object::ID,
        operation: 0x20073d9e13cb93f4cff52e05ea3ef371efed2ebec353bee5c3c9abd62bb44048::leverage_obligation::Operation,
        collateral: 0x1::type_name::TypeName,
        debt: 0x1::type_name::TypeName,
        collateral_amount: u64,
        collateral_price: 0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::Decimal,
    }

    public fun request_leverage<T0, T1, T2>(arg0: &mut 0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::app::ProtocolApp, arg1: &mut 0x20073d9e13cb93f4cff52e05ea3ef371efed2ebec353bee5c3c9abd62bb44048::leverage_app::LeverageApp, arg2: &mut 0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::market::Market<T0>, arg3: &mut 0x20073d9e13cb93f4cff52e05ea3ef371efed2ebec353bee5c3c9abd62bb44048::leverage_market::LeverageMarket, arg4: &mut 0x20073d9e13cb93f4cff52e05ea3ef371efed2ebec353bee5c3c9abd62bb44048::leverage_obligation::LeverageMarketOwnerCap, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: &0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::coin_decimals_registry::CoinDecimalsRegistry, arg9: &0x2::clock::Clock, arg10: &0xfe91675bc6d4cef3cf3b6045567189b5a7fc98bca6199190cf0ebed3a793343a::x_oracle::XOracle, arg11: &mut 0x2::tx_context::TxContext) : (0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::market::FlashLoan<T0, T1>, 0x2::coin::Coin<T2>) {
        assert!(!0x20073d9e13cb93f4cff52e05ea3ef371efed2ebec353bee5c3c9abd62bb44048::leverage_market::is_leverate_on_going(arg3), 13906834406271614975);
        0x20073d9e13cb93f4cff52e05ea3ef371efed2ebec353bee5c3c9abd62bb44048::leverage_market::mark_leverage_ongoing(arg3);
        let v0 = NewBorrowSwapEvent{
            leverage_owner_cap : 0x20073d9e13cb93f4cff52e05ea3ef371efed2ebec353bee5c3c9abd62bb44048::leverage_obligation::id(arg4),
            operation          : 0x20073d9e13cb93f4cff52e05ea3ef371efed2ebec353bee5c3c9abd62bb44048::leverage_obligation::borrow_swap(),
            collateral         : 0x1::type_name::get<T1>(),
            debt               : 0x1::type_name::get<T2>(),
            collateral_amount  : 0x2::coin::value<T1>(&arg5),
            collateral_price   : 0x20073d9e13cb93f4cff52e05ea3ef371efed2ebec353bee5c3c9abd62bb44048::leverage_obligation::get_collateral_price<T1, T2>(arg10, arg9),
        };
        0x2::event::emit<NewBorrowSwapEvent>(v0);
        0x20073d9e13cb93f4cff52e05ea3ef371efed2ebec353bee5c3c9abd62bb44048::leverage_obligation::ensure_same_market<T0>(arg4);
        0x20073d9e13cb93f4cff52e05ea3ef371efed2ebec353bee5c3c9abd62bb44048::leverage_obligation::set_or_check_position<T1, T2>(arg4, 0x20073d9e13cb93f4cff52e05ea3ef371efed2ebec353bee5c3c9abd62bb44048::leverage_obligation::borrow_swap());
        let (v1, v2) = 0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::flash_loan::borrow_flash_loan<T0, T1>(arg0, 0x20073d9e13cb93f4cff52e05ea3ef371efed2ebec353bee5c3c9abd62bb44048::leverage_app::borrow_protocol_caller_cap(arg1), arg2, 0x20073d9e13cb93f4cff52e05ea3ef371efed2ebec353bee5c3c9abd62bb44048::leverage_market::emode_group(arg3), arg6 - 0x2::coin::value<T1>(&arg5), arg11);
        let v3 = v1;
        0x2::coin::join<T1>(&mut v3, arg5);
        assert!(0x2::coin::value<T1>(&v3) == arg6, 13906834526530699263);
        0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::deposit::deposit<T0, T1>(arg0, arg2, 0x20073d9e13cb93f4cff52e05ea3ef371efed2ebec353bee5c3c9abd62bb44048::leverage_obligation::market_obligation(arg4), v3, arg8, arg10, arg9, arg11);
        (v2, 0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::borrow::borrow<T0, T2>(0x20073d9e13cb93f4cff52e05ea3ef371efed2ebec353bee5c3c9abd62bb44048::leverage_obligation::market_obligation(arg4), arg2, arg8, arg7, arg10, arg9, arg11))
    }

    // decompiled from Move bytecode v6
}

