module 0x20073d9e13cb93f4cff52e05ea3ef371efed2ebec353bee5c3c9abd62bb44048::leverage_repay {
    struct RefundedEvent has copy, drop {
        leverage_owner_cap: 0x2::object::ID,
        amount: u64,
        amount_usd: 0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::Decimal,
        coin_type: 0x1::type_name::TypeName,
    }

    public fun complete_leverage<T0, T1>(arg0: &mut 0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::app::ProtocolApp, arg1: &mut 0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::market::Market<T0>, arg2: &mut 0x20073d9e13cb93f4cff52e05ea3ef371efed2ebec353bee5c3c9abd62bb44048::leverage_market::LeverageMarket, arg3: &0x20073d9e13cb93f4cff52e05ea3ef371efed2ebec353bee5c3c9abd62bb44048::leverage_obligation::LeverageMarketOwnerCap, arg4: 0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::market::FlashLoan<T0, T1>, arg5: 0x1::option::Option<0x1::string::String>, arg6: 0x2::coin::Coin<T1>, arg7: &0xfe91675bc6d4cef3cf3b6045567189b5a7fc98bca6199190cf0ebed3a793343a::x_oracle::XOracle, arg8: &0x2::clock::Clock, arg9: &0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::coin_decimals_registry::CoinDecimalsRegistry, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x20073d9e13cb93f4cff52e05ea3ef371efed2ebec353bee5c3c9abd62bb44048::leverage_market::is_leverate_on_going(arg2), 13906834393386713087);
        0x20073d9e13cb93f4cff52e05ea3ef371efed2ebec353bee5c3c9abd62bb44048::leverage_market::mark_leverage_finished(arg2);
        let v0 = 0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::market::fee<T0, T1>(&arg4) + 0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::market::loan_amount<T0, T1>(&arg4);
        assert!(0x2::coin::value<T1>(&arg6) >= v0, 0x20073d9e13cb93f4cff52e05ea3ef371efed2ebec353bee5c3c9abd62bb44048::leverage_error::cannot_repay_flash_loan());
        0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::flash_loan::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::split<T1>(&mut arg6, v0, arg10), arg4, arg5, arg10);
        0x2::event::emit<RefundedEvent>(new_refunded_event<T1>(0x20073d9e13cb93f4cff52e05ea3ef371efed2ebec353bee5c3c9abd62bb44048::leverage_obligation::id(arg3), arg7, arg8, 0x2::coin::value<T1>(&arg6), arg9));
        arg6
    }

    public(friend) fun emit_new_refunded_event<T0>(arg0: 0x2::object::ID, arg1: &0xfe91675bc6d4cef3cf3b6045567189b5a7fc98bca6199190cf0ebed3a793343a::x_oracle::XOracle, arg2: &0x2::clock::Clock, arg3: u64, arg4: &0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::coin_decimals_registry::CoinDecimalsRegistry) {
        0x2::event::emit<RefundedEvent>(new_refunded_event<T0>(arg0, arg1, arg2, arg3, arg4));
    }

    fun new_refunded_event<T0>(arg0: 0x2::object::ID, arg1: &0xfe91675bc6d4cef3cf3b6045567189b5a7fc98bca6199190cf0ebed3a793343a::x_oracle::XOracle, arg2: &0x2::clock::Clock, arg3: u64, arg4: &0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::coin_decimals_registry::CoinDecimalsRegistry) : RefundedEvent {
        RefundedEvent{
            leverage_owner_cap : arg0,
            amount             : arg3,
            amount_usd         : 0x20073d9e13cb93f4cff52e05ea3ef371efed2ebec353bee5c3c9abd62bb44048::leverage_obligation::get_usd_value<T0>(arg1, arg2, arg3, arg4),
            coin_type          : 0x1::type_name::get<T0>(),
        }
    }

    // decompiled from Move bytecode v6
}

