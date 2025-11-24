module 0x2fdf01d0f63adf6721bfc3456b939a411f59476b6206efec5734e43d70b2861e::leverage_repay {
    struct RefundedEvent has copy, drop {
        leverage_owner_cap: 0x2::object::ID,
        amount: u64,
        amount_usd: 0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::Decimal,
        coin_type: 0x1::type_name::TypeName,
    }

    public fun complete_leverage<T0, T1>(arg0: &mut 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::app::ProtocolApp, arg1: &mut 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::market::Market<T0>, arg2: &mut 0x2fdf01d0f63adf6721bfc3456b939a411f59476b6206efec5734e43d70b2861e::leverage_market::LeverageMarket, arg3: &0x2fdf01d0f63adf6721bfc3456b939a411f59476b6206efec5734e43d70b2861e::leverage_obligation::LeverageMarketOwnerCap, arg4: 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::market::FlashLoan<T0, T1>, arg5: 0x1::option::Option<0x1::string::String>, arg6: 0x2::coin::Coin<T1>, arg7: &0xa6ee3c6b4b6c0fb4e3240716afda5bdd23939dfdb9ef1e5a6055d038265077ad::x_oracle::XOracle, arg8: &0x2::clock::Clock, arg9: &0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::coin_decimals_registry::CoinDecimalsRegistry, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x2fdf01d0f63adf6721bfc3456b939a411f59476b6206efec5734e43d70b2861e::leverage_market::is_leverate_on_going(arg2), 13906834393386713087);
        0x2fdf01d0f63adf6721bfc3456b939a411f59476b6206efec5734e43d70b2861e::leverage_market::mark_leverage_finished(arg2);
        let v0 = 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::market::fee<T0, T1>(&arg4) + 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::market::loan_amount<T0, T1>(&arg4);
        assert!(0x2::coin::value<T1>(&arg6) >= v0, 0x2fdf01d0f63adf6721bfc3456b939a411f59476b6206efec5734e43d70b2861e::leverage_error::cannot_repay_flash_loan());
        0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::flash_loan::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::split<T1>(&mut arg6, v0, arg10), arg4, arg5, arg10);
        0x2::event::emit<RefundedEvent>(new_refunded_event<T1>(0x2fdf01d0f63adf6721bfc3456b939a411f59476b6206efec5734e43d70b2861e::leverage_obligation::id(arg3), arg7, arg8, 0x2::coin::value<T1>(&arg6), arg9));
        arg6
    }

    public(friend) fun emit_new_refunded_event<T0>(arg0: 0x2::object::ID, arg1: &0xa6ee3c6b4b6c0fb4e3240716afda5bdd23939dfdb9ef1e5a6055d038265077ad::x_oracle::XOracle, arg2: &0x2::clock::Clock, arg3: u64, arg4: &0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::coin_decimals_registry::CoinDecimalsRegistry) {
        0x2::event::emit<RefundedEvent>(new_refunded_event<T0>(arg0, arg1, arg2, arg3, arg4));
    }

    fun new_refunded_event<T0>(arg0: 0x2::object::ID, arg1: &0xa6ee3c6b4b6c0fb4e3240716afda5bdd23939dfdb9ef1e5a6055d038265077ad::x_oracle::XOracle, arg2: &0x2::clock::Clock, arg3: u64, arg4: &0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::coin_decimals_registry::CoinDecimalsRegistry) : RefundedEvent {
        RefundedEvent{
            leverage_owner_cap : arg0,
            amount             : arg3,
            amount_usd         : 0x2fdf01d0f63adf6721bfc3456b939a411f59476b6206efec5734e43d70b2861e::leverage_obligation::get_usd_value<T0>(arg1, arg2, arg3, arg4),
            coin_type          : 0x1::type_name::get<T0>(),
        }
    }

    // decompiled from Move bytecode v6
}

