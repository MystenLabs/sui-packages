module 0x24ff5c5ff7dbdf48ad93c533a1e2dd90aa1b227f7fca1b457798333d8bfd57c3::leverage_borrow_swap {
    struct NewBorrowSwapEvent has copy, drop {
        leverage_owner_cap: 0x2::object::ID,
        operation: 0x24ff5c5ff7dbdf48ad93c533a1e2dd90aa1b227f7fca1b457798333d8bfd57c3::leverage_obligation::Operation,
        collateral: 0x1::type_name::TypeName,
        debt: 0x1::type_name::TypeName,
        collateral_amount: u64,
        collateral_price: 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::Decimal,
    }

    public fun request_leverage<T0, T1, T2>(arg0: &mut 0x7f95f91d4e21a5f9c0f1699242bc39c7f83da7b1b74e8629dda083d639542229::app::ProtocolApp, arg1: &mut 0x24ff5c5ff7dbdf48ad93c533a1e2dd90aa1b227f7fca1b457798333d8bfd57c3::leverage_app::LeverageApp, arg2: &mut 0x7f95f91d4e21a5f9c0f1699242bc39c7f83da7b1b74e8629dda083d639542229::market::Market<T0>, arg3: &mut 0x24ff5c5ff7dbdf48ad93c533a1e2dd90aa1b227f7fca1b457798333d8bfd57c3::leverage_market::LeverageMarket, arg4: &mut 0x24ff5c5ff7dbdf48ad93c533a1e2dd90aa1b227f7fca1b457798333d8bfd57c3::leverage_obligation::LeverageMarketOwnerCap, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: &0x7f95f91d4e21a5f9c0f1699242bc39c7f83da7b1b74e8629dda083d639542229::coin_decimals_registry::CoinDecimalsRegistry, arg9: &0x2::clock::Clock, arg10: &0xebf96242c7a4d830411b57b02d08fd52f3dc02dc6165e480289968e010414daf::x_oracle::XOracle, arg11: &mut 0x2::tx_context::TxContext) : (0x7f95f91d4e21a5f9c0f1699242bc39c7f83da7b1b74e8629dda083d639542229::market::FlashLoan<T0, T1>, 0x2::coin::Coin<T2>) {
        0x24ff5c5ff7dbdf48ad93c533a1e2dd90aa1b227f7fca1b457798333d8bfd57c3::leverage_market::ensure_no_leverage_on_going(arg3);
        0x24ff5c5ff7dbdf48ad93c533a1e2dd90aa1b227f7fca1b457798333d8bfd57c3::leverage_market::mark_leverage_ongoing(arg3);
        let v0 = NewBorrowSwapEvent{
            leverage_owner_cap : 0x24ff5c5ff7dbdf48ad93c533a1e2dd90aa1b227f7fca1b457798333d8bfd57c3::leverage_obligation::id(arg4),
            operation          : 0x24ff5c5ff7dbdf48ad93c533a1e2dd90aa1b227f7fca1b457798333d8bfd57c3::leverage_obligation::borrow_swap(),
            collateral         : 0x1::type_name::with_defining_ids<T1>(),
            debt               : 0x1::type_name::with_defining_ids<T2>(),
            collateral_amount  : 0x2::coin::value<T1>(&arg5),
            collateral_price   : 0x24ff5c5ff7dbdf48ad93c533a1e2dd90aa1b227f7fca1b457798333d8bfd57c3::leverage_obligation::get_collateral_price<T1, T2>(arg10, arg9),
        };
        0x2::event::emit<NewBorrowSwapEvent>(v0);
        0x24ff5c5ff7dbdf48ad93c533a1e2dd90aa1b227f7fca1b457798333d8bfd57c3::leverage_obligation::ensure_same_market<T0>(arg4);
        0x24ff5c5ff7dbdf48ad93c533a1e2dd90aa1b227f7fca1b457798333d8bfd57c3::leverage_obligation::set_or_check_position<T1, T2>(arg4, 0x24ff5c5ff7dbdf48ad93c533a1e2dd90aa1b227f7fca1b457798333d8bfd57c3::leverage_obligation::borrow_swap());
        let (v1, v2) = 0x7f95f91d4e21a5f9c0f1699242bc39c7f83da7b1b74e8629dda083d639542229::flash_loan::borrow_flash_loan<T0, T1>(arg0, 0x24ff5c5ff7dbdf48ad93c533a1e2dd90aa1b227f7fca1b457798333d8bfd57c3::leverage_app::borrow_protocol_caller_cap(arg1), arg2, 0x24ff5c5ff7dbdf48ad93c533a1e2dd90aa1b227f7fca1b457798333d8bfd57c3::leverage_market::emode_group(arg3), arg6 - 0x2::coin::value<T1>(&arg5), arg11);
        let v3 = v1;
        0x2::coin::join<T1>(&mut v3, arg5);
        assert!(0x2::coin::value<T1>(&v3) == arg6, 0x24ff5c5ff7dbdf48ad93c533a1e2dd90aa1b227f7fca1b457798333d8bfd57c3::leverage_error::token_amount_not_expected_value());
        0x7f95f91d4e21a5f9c0f1699242bc39c7f83da7b1b74e8629dda083d639542229::deposit::deposit<T0, T1>(arg0, arg2, 0x24ff5c5ff7dbdf48ad93c533a1e2dd90aa1b227f7fca1b457798333d8bfd57c3::leverage_obligation::market_obligation(arg4), v3, arg9, arg11);
        (v2, 0x7f95f91d4e21a5f9c0f1699242bc39c7f83da7b1b74e8629dda083d639542229::borrow::borrow<T0, T2>(0x24ff5c5ff7dbdf48ad93c533a1e2dd90aa1b227f7fca1b457798333d8bfd57c3::leverage_obligation::market_obligation(arg4), arg2, arg8, arg7, arg10, arg9, arg11))
    }

    // decompiled from Move bytecode v6
}

