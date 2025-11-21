module 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::leverage_repay {
    struct RefundedEvent has copy, drop {
        leverage_owner_cap: 0x2::object::ID,
        amount: u64,
        amount_usd: 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::Decimal,
        coin_type: 0x1::type_name::TypeName,
    }

    public fun complete_leverage<T0, T1>(arg0: &mut 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::market::Market<T0>, arg1: &mut 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::leverage_market::LeverageMarket, arg2: &0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::leverage_obligation::LeverageMarketOwnerCap, arg3: 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::reserve::FlashLoan<T0, T1>, arg4: 0x2::coin::Coin<T1>, arg5: &0x5060fa94bc49945536eae3d46583d1d85dd3b1c549e5b83b48b0dfe9833ff404::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &0x4abb202e193c18f6d5b418ef03418fd5e77f40d57a19355fececf8079fa1db98::coin_decimals_registry::CoinDecimalsRegistry, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::leverage_market::is_leverate_on_going(arg1), 13906834371911876607);
        0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::leverage_market::mark_leverage_finished(arg1);
        let v0 = 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::reserve::fee<T0, T1>(&arg3) + 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::reserve::loan_amount<T0, T1>(&arg3);
        assert!(0x2::coin::value<T1>(&arg4) >= v0, 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::leverage_error::cannot_repay_flash_loan());
        0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::flash_loan::repay_flash_loan<T0, T1>(arg0, 0x2::coin::split<T1>(&mut arg4, v0, arg8), arg3, arg8);
        0x2::event::emit<RefundedEvent>(new_refunded_event<T1>(0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::leverage_obligation::id(arg2), arg5, arg6, 0x2::coin::value<T1>(&arg4), arg7));
        arg4
    }

    public(friend) fun emit_new_refunded_event<T0>(arg0: 0x2::object::ID, arg1: &0x5060fa94bc49945536eae3d46583d1d85dd3b1c549e5b83b48b0dfe9833ff404::x_oracle::XOracle, arg2: &0x2::clock::Clock, arg3: u64, arg4: &0x4abb202e193c18f6d5b418ef03418fd5e77f40d57a19355fececf8079fa1db98::coin_decimals_registry::CoinDecimalsRegistry) {
        0x2::event::emit<RefundedEvent>(new_refunded_event<T0>(arg0, arg1, arg2, arg3, arg4));
    }

    fun new_refunded_event<T0>(arg0: 0x2::object::ID, arg1: &0x5060fa94bc49945536eae3d46583d1d85dd3b1c549e5b83b48b0dfe9833ff404::x_oracle::XOracle, arg2: &0x2::clock::Clock, arg3: u64, arg4: &0x4abb202e193c18f6d5b418ef03418fd5e77f40d57a19355fececf8079fa1db98::coin_decimals_registry::CoinDecimalsRegistry) : RefundedEvent {
        RefundedEvent{
            leverage_owner_cap : arg0,
            amount             : arg3,
            amount_usd         : 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::leverage_obligation::get_usd_value<T0>(arg1, arg2, arg3, arg4),
            coin_type          : 0x1::type_name::get<T0>(),
        }
    }

    // decompiled from Move bytecode v6
}

