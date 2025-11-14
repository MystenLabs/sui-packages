module 0xc8e7175f4d1331e221609aa2b337f2cbed41ba5ffad2fd120adc061e4cde2669::leverage_borrow_swap {
    struct NewBorrowSwapEvent has copy, drop {
        leverage_owner_cap: 0x2::object::ID,
        operation: 0xc8e7175f4d1331e221609aa2b337f2cbed41ba5ffad2fd120adc061e4cde2669::leverage_obligation::Operation,
        collateral: 0x1::type_name::TypeName,
        debt: 0x1::type_name::TypeName,
        deposit_amount: u64,
        deposit_usd: 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::Decimal,
    }

    public fun request_leverage<T0, T1, T2>(arg0: &mut 0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::app::ProtocolApp, arg1: &mut 0xc8e7175f4d1331e221609aa2b337f2cbed41ba5ffad2fd120adc061e4cde2669::leverage_app::LeverageApp, arg2: &mut 0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::market::Market<T0>, arg3: &mut 0xc8e7175f4d1331e221609aa2b337f2cbed41ba5ffad2fd120adc061e4cde2669::leverage_market::LeverageMarket, arg4: &mut 0xc8e7175f4d1331e221609aa2b337f2cbed41ba5ffad2fd120adc061e4cde2669::leverage_obligation::LeverageMarketOwnerCap, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: &0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::coin_decimals_registry::CoinDecimalsRegistry, arg9: &0x2::clock::Clock, arg10: &0xe10e433790b25a02428e046c06837d9268cc8067813808722c33de23998eafc3::x_oracle::XOracle, arg11: &mut 0x2::tx_context::TxContext) : (0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::market::FlashLoan<T0, T1>, 0x2::coin::Coin<T2>) {
        assert!(!0xc8e7175f4d1331e221609aa2b337f2cbed41ba5ffad2fd120adc061e4cde2669::leverage_market::is_leverate_on_going(arg3), 13906834406271614975);
        0xc8e7175f4d1331e221609aa2b337f2cbed41ba5ffad2fd120adc061e4cde2669::leverage_market::mark_leverage_ongoing(arg3);
        let v0 = NewBorrowSwapEvent{
            leverage_owner_cap : 0xc8e7175f4d1331e221609aa2b337f2cbed41ba5ffad2fd120adc061e4cde2669::leverage_obligation::id(arg4),
            operation          : 0xc8e7175f4d1331e221609aa2b337f2cbed41ba5ffad2fd120adc061e4cde2669::leverage_obligation::borrow_swap(),
            collateral         : 0x1::type_name::get<T1>(),
            debt               : 0x1::type_name::get<T2>(),
            deposit_amount     : 0x2::coin::value<T1>(&arg5),
            deposit_usd        : 0xc8e7175f4d1331e221609aa2b337f2cbed41ba5ffad2fd120adc061e4cde2669::leverage_obligation::get_usd_value<T1>(arg10, arg9, 0x2::coin::value<T1>(&arg5), arg8),
        };
        0x2::event::emit<NewBorrowSwapEvent>(v0);
        0xc8e7175f4d1331e221609aa2b337f2cbed41ba5ffad2fd120adc061e4cde2669::leverage_obligation::set_or_check_position<T0, T1, T2>(arg4, arg2, 0xc8e7175f4d1331e221609aa2b337f2cbed41ba5ffad2fd120adc061e4cde2669::leverage_obligation::borrow_swap());
        let (v1, v2) = 0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::flash_loan::borrow_flash_loan<T0, T1>(arg0, 0xc8e7175f4d1331e221609aa2b337f2cbed41ba5ffad2fd120adc061e4cde2669::leverage_app::borrow_protocol_caller_cap(arg1), arg2, 0xc8e7175f4d1331e221609aa2b337f2cbed41ba5ffad2fd120adc061e4cde2669::leverage_market::emode_group(arg3), arg6 - 0x2::coin::value<T1>(&arg5), arg11);
        let v3 = v1;
        0xc8e7175f4d1331e221609aa2b337f2cbed41ba5ffad2fd120adc061e4cde2669::leverage_obligation::increase_collateral(arg4, 0x2::coin::value<T1>(&arg5), 0xc8e7175f4d1331e221609aa2b337f2cbed41ba5ffad2fd120adc061e4cde2669::leverage_obligation::get_collateral_price<T1, T2>(arg10, arg9));
        0x2::coin::join<T1>(&mut v3, arg5);
        assert!(0x2::coin::value<T1>(&v3) == arg6, 13906834535120633855);
        0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::deposit::deposit<T0, T1>(arg0, arg2, 0xc8e7175f4d1331e221609aa2b337f2cbed41ba5ffad2fd120adc061e4cde2669::leverage_obligation::market_obligation(arg4), v3, arg8, arg10, arg9, arg11);
        (v2, 0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::borrow::borrow<T0, T2>(0xc8e7175f4d1331e221609aa2b337f2cbed41ba5ffad2fd120adc061e4cde2669::leverage_obligation::market_obligation(arg4), arg2, arg8, arg7, arg10, arg9, arg11))
    }

    // decompiled from Move bytecode v6
}

