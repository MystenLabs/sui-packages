module 0x87d4b98f0005479b277e6859d2dacbb9102b813c0ff485b2d22016180fe1cbf4::leverage_repay {
    struct RefundedEvent has copy, drop {
        leverage_owner_cap: 0x2::object::ID,
        amount: u64,
        amount_usd: 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::Decimal,
        coin_type: 0x1::type_name::TypeName,
    }

    public fun complete_leverage<T0, T1>(arg0: &mut 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::app::ProtocolApp, arg1: &mut 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::market::Market<T0>, arg2: &mut 0x87d4b98f0005479b277e6859d2dacbb9102b813c0ff485b2d22016180fe1cbf4::leverage_market::LeverageMarket, arg3: &0x87d4b98f0005479b277e6859d2dacbb9102b813c0ff485b2d22016180fe1cbf4::leverage_obligation::LeverageMarketOwnerCap, arg4: 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::market::FlashLoan<T0, T1>, arg5: 0x1::option::Option<0x1::string::String>, arg6: 0x2::coin::Coin<T1>, arg7: &0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::x_oracle::XOracle, arg8: &0x2::clock::Clock, arg9: &0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::coin_decimals_registry::CoinDecimalsRegistry, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x87d4b98f0005479b277e6859d2dacbb9102b813c0ff485b2d22016180fe1cbf4::leverage_market::is_leverate_on_going(arg2), 13906834393386713087);
        0x87d4b98f0005479b277e6859d2dacbb9102b813c0ff485b2d22016180fe1cbf4::leverage_market::mark_leverage_finished(arg2);
        let v0 = 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::market::fee<T0, T1>(&arg4) + 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::market::loan_amount<T0, T1>(&arg4);
        assert!(0x2::coin::value<T1>(&arg6) >= v0, 0x87d4b98f0005479b277e6859d2dacbb9102b813c0ff485b2d22016180fe1cbf4::leverage_error::cannot_repay_flash_loan());
        0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::flash_loan::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::split<T1>(&mut arg6, v0, arg10), arg4, arg5, arg10);
        0x2::event::emit<RefundedEvent>(new_refunded_event<T1>(0x87d4b98f0005479b277e6859d2dacbb9102b813c0ff485b2d22016180fe1cbf4::leverage_obligation::id(arg3), arg7, arg8, 0x2::coin::value<T1>(&arg6), arg9));
        arg6
    }

    public(friend) fun emit_new_refunded_event<T0>(arg0: 0x2::object::ID, arg1: &0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::x_oracle::XOracle, arg2: &0x2::clock::Clock, arg3: u64, arg4: &0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::coin_decimals_registry::CoinDecimalsRegistry) {
        0x2::event::emit<RefundedEvent>(new_refunded_event<T0>(arg0, arg1, arg2, arg3, arg4));
    }

    fun new_refunded_event<T0>(arg0: 0x2::object::ID, arg1: &0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::x_oracle::XOracle, arg2: &0x2::clock::Clock, arg3: u64, arg4: &0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::coin_decimals_registry::CoinDecimalsRegistry) : RefundedEvent {
        RefundedEvent{
            leverage_owner_cap : arg0,
            amount             : arg3,
            amount_usd         : 0x87d4b98f0005479b277e6859d2dacbb9102b813c0ff485b2d22016180fe1cbf4::leverage_obligation::get_usd_value<T0>(arg1, arg2, arg3, arg4),
            coin_type          : 0x1::type_name::get<T0>(),
        }
    }

    // decompiled from Move bytecode v6
}

