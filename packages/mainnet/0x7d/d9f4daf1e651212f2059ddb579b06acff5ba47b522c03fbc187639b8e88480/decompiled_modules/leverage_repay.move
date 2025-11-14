module 0x7dd9f4daf1e651212f2059ddb579b06acff5ba47b522c03fbc187639b8e88480::leverage_repay {
    struct RefundedEvent has copy, drop {
        leverage_owner_cap: 0x2::object::ID,
        amount: u64,
        amount_usd: 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::Decimal,
        coin_type: 0x1::type_name::TypeName,
    }

    public fun complete_leverage<T0, T1>(arg0: &mut 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::app::ProtocolApp, arg1: &mut 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::market::Market<T0>, arg2: &mut 0x7dd9f4daf1e651212f2059ddb579b06acff5ba47b522c03fbc187639b8e88480::leverage_market::LeverageMarket, arg3: &0x7dd9f4daf1e651212f2059ddb579b06acff5ba47b522c03fbc187639b8e88480::leverage_obligation::LeverageMarketOwnerCap, arg4: 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::market::FlashLoan<T0, T1>, arg5: 0x1::option::Option<0x1::string::String>, arg6: 0x2::coin::Coin<T1>, arg7: &0x32467102bea06f74441ca645b1fc52019ba0c3103bb9e693d85010acd617dac7::x_oracle::XOracle, arg8: &0x2::clock::Clock, arg9: &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::coin_decimals_registry::CoinDecimalsRegistry, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x7dd9f4daf1e651212f2059ddb579b06acff5ba47b522c03fbc187639b8e88480::leverage_market::is_leverate_on_going(arg2), 13906834393386713087);
        0x7dd9f4daf1e651212f2059ddb579b06acff5ba47b522c03fbc187639b8e88480::leverage_market::mark_leverage_finished(arg2);
        let v0 = 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::market::fee<T0, T1>(&arg4) + 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::market::loan_amount<T0, T1>(&arg4);
        assert!(0x2::coin::value<T1>(&arg6) >= v0, 0x7dd9f4daf1e651212f2059ddb579b06acff5ba47b522c03fbc187639b8e88480::leverage_error::cannot_repay_flash_loan());
        0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::flash_loan::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::split<T1>(&mut arg6, v0, arg10), arg4, arg5, arg10);
        0x2::event::emit<RefundedEvent>(new_refunded_event<T1>(0x7dd9f4daf1e651212f2059ddb579b06acff5ba47b522c03fbc187639b8e88480::leverage_obligation::id(arg3), arg7, arg8, 0x2::coin::value<T1>(&arg6), arg9));
        arg6
    }

    public(friend) fun emit_new_refunded_event<T0>(arg0: 0x2::object::ID, arg1: &0x32467102bea06f74441ca645b1fc52019ba0c3103bb9e693d85010acd617dac7::x_oracle::XOracle, arg2: &0x2::clock::Clock, arg3: u64, arg4: &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::coin_decimals_registry::CoinDecimalsRegistry) {
        0x2::event::emit<RefundedEvent>(new_refunded_event<T0>(arg0, arg1, arg2, arg3, arg4));
    }

    fun new_refunded_event<T0>(arg0: 0x2::object::ID, arg1: &0x32467102bea06f74441ca645b1fc52019ba0c3103bb9e693d85010acd617dac7::x_oracle::XOracle, arg2: &0x2::clock::Clock, arg3: u64, arg4: &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::coin_decimals_registry::CoinDecimalsRegistry) : RefundedEvent {
        RefundedEvent{
            leverage_owner_cap : arg0,
            amount             : arg3,
            amount_usd         : 0x7dd9f4daf1e651212f2059ddb579b06acff5ba47b522c03fbc187639b8e88480::leverage_obligation::get_usd_value<T0>(arg1, arg2, arg3, arg4),
            coin_type          : 0x1::type_name::get<T0>(),
        }
    }

    // decompiled from Move bytecode v6
}

