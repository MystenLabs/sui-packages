module 0xc8e7175f4d1331e221609aa2b337f2cbed41ba5ffad2fd120adc061e4cde2669::leverage_repay {
    struct RefundedEvent has copy, drop {
        leverage_owner_cap: 0x2::object::ID,
        amount: u64,
        amount_usd: 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::Decimal,
        coin_type: 0x1::type_name::TypeName,
    }

    public fun complete_leverage<T0, T1>(arg0: &mut 0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::app::ProtocolApp, arg1: &mut 0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::market::Market<T0>, arg2: &mut 0xc8e7175f4d1331e221609aa2b337f2cbed41ba5ffad2fd120adc061e4cde2669::leverage_market::LeverageMarket, arg3: &0xc8e7175f4d1331e221609aa2b337f2cbed41ba5ffad2fd120adc061e4cde2669::leverage_obligation::LeverageMarketOwnerCap, arg4: 0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::market::FlashLoan<T0, T1>, arg5: 0x1::option::Option<0x1::string::String>, arg6: 0x2::coin::Coin<T1>, arg7: &0xe10e433790b25a02428e046c06837d9268cc8067813808722c33de23998eafc3::x_oracle::XOracle, arg8: &0x2::clock::Clock, arg9: &0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::coin_decimals_registry::CoinDecimalsRegistry, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0xc8e7175f4d1331e221609aa2b337f2cbed41ba5ffad2fd120adc061e4cde2669::leverage_market::is_leverate_on_going(arg2), 13906834393386713087);
        0xc8e7175f4d1331e221609aa2b337f2cbed41ba5ffad2fd120adc061e4cde2669::leverage_market::mark_leverage_finished(arg2);
        let v0 = 0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::market::fee<T0, T1>(&arg4) + 0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::market::loan_amount<T0, T1>(&arg4);
        assert!(0x2::coin::value<T1>(&arg6) >= v0, 0xc8e7175f4d1331e221609aa2b337f2cbed41ba5ffad2fd120adc061e4cde2669::leverage_error::cannot_repay_flash_loan());
        0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::flash_loan::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::split<T1>(&mut arg6, v0, arg10), arg4, arg5, arg10);
        0x2::event::emit<RefundedEvent>(new_refunded_event<T1>(0xc8e7175f4d1331e221609aa2b337f2cbed41ba5ffad2fd120adc061e4cde2669::leverage_obligation::id(arg3), arg7, arg8, 0x2::coin::value<T1>(&arg6), arg9));
        arg6
    }

    public(friend) fun emit_new_refunded_event<T0>(arg0: 0x2::object::ID, arg1: &0xe10e433790b25a02428e046c06837d9268cc8067813808722c33de23998eafc3::x_oracle::XOracle, arg2: &0x2::clock::Clock, arg3: u64, arg4: &0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::coin_decimals_registry::CoinDecimalsRegistry) {
        0x2::event::emit<RefundedEvent>(new_refunded_event<T0>(arg0, arg1, arg2, arg3, arg4));
    }

    fun new_refunded_event<T0>(arg0: 0x2::object::ID, arg1: &0xe10e433790b25a02428e046c06837d9268cc8067813808722c33de23998eafc3::x_oracle::XOracle, arg2: &0x2::clock::Clock, arg3: u64, arg4: &0x441944c0b71d8566e5c8d48b2d9ba5da7f79f22dbaa2ca2d1f638735d38f4296::coin_decimals_registry::CoinDecimalsRegistry) : RefundedEvent {
        RefundedEvent{
            leverage_owner_cap : arg0,
            amount             : arg3,
            amount_usd         : 0xc8e7175f4d1331e221609aa2b337f2cbed41ba5ffad2fd120adc061e4cde2669::leverage_obligation::get_usd_value<T0>(arg1, arg2, arg3, arg4),
            coin_type          : 0x1::type_name::get<T0>(),
        }
    }

    // decompiled from Move bytecode v6
}

