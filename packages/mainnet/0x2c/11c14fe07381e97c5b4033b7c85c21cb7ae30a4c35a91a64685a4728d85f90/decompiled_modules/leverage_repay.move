module 0x2c11c14fe07381e97c5b4033b7c85c21cb7ae30a4c35a91a64685a4728d85f90::leverage_repay {
    struct RefundedEvent has copy, drop {
        leverage_owner_cap: 0x2::object::ID,
        amount: u64,
        amount_usd: 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::Decimal,
        coin_type: 0x1::type_name::TypeName,
    }

    public fun complete_leverage<T0, T1>(arg0: &mut 0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::app::ProtocolApp, arg1: &mut 0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::market::Market<T0>, arg2: &mut 0x2c11c14fe07381e97c5b4033b7c85c21cb7ae30a4c35a91a64685a4728d85f90::leverage_market::LeverageMarket, arg3: &0x2c11c14fe07381e97c5b4033b7c85c21cb7ae30a4c35a91a64685a4728d85f90::leverage_obligation::LeverageMarketOwnerCap, arg4: 0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::market::FlashLoan<T0, T1>, arg5: 0x1::option::Option<0x1::string::String>, arg6: 0x2::coin::Coin<T1>, arg7: &0xcc225fc85e4be2167573358a32df7a7c2d9bcb745d0581843413688e6f0a8f3e::x_oracle::XOracle, arg8: &0x2::clock::Clock, arg9: &0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::coin_decimals_registry::CoinDecimalsRegistry, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x2c11c14fe07381e97c5b4033b7c85c21cb7ae30a4c35a91a64685a4728d85f90::leverage_market::is_leverate_on_going(arg2), 13906834393386713087);
        0x2c11c14fe07381e97c5b4033b7c85c21cb7ae30a4c35a91a64685a4728d85f90::leverage_market::mark_leverage_finished(arg2);
        let v0 = 0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::market::fee<T0, T1>(&arg4) + 0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::market::loan_amount<T0, T1>(&arg4);
        assert!(0x2::coin::value<T1>(&arg6) >= v0, 0x2c11c14fe07381e97c5b4033b7c85c21cb7ae30a4c35a91a64685a4728d85f90::leverage_error::cannot_repay_flash_loan());
        0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::flash_loan::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::coin::split<T1>(&mut arg6, v0, arg10), arg4, arg5, arg10);
        0x2::event::emit<RefundedEvent>(new_refunded_event<T1>(0x2c11c14fe07381e97c5b4033b7c85c21cb7ae30a4c35a91a64685a4728d85f90::leverage_obligation::id(arg3), arg7, arg8, 0x2::coin::value<T1>(&arg6), arg9));
        arg6
    }

    public(friend) fun emit_new_refunded_event<T0>(arg0: 0x2::object::ID, arg1: &0xcc225fc85e4be2167573358a32df7a7c2d9bcb745d0581843413688e6f0a8f3e::x_oracle::XOracle, arg2: &0x2::clock::Clock, arg3: u64, arg4: &0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::coin_decimals_registry::CoinDecimalsRegistry) {
        0x2::event::emit<RefundedEvent>(new_refunded_event<T0>(arg0, arg1, arg2, arg3, arg4));
    }

    fun new_refunded_event<T0>(arg0: 0x2::object::ID, arg1: &0xcc225fc85e4be2167573358a32df7a7c2d9bcb745d0581843413688e6f0a8f3e::x_oracle::XOracle, arg2: &0x2::clock::Clock, arg3: u64, arg4: &0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::coin_decimals_registry::CoinDecimalsRegistry) : RefundedEvent {
        RefundedEvent{
            leverage_owner_cap : arg0,
            amount             : arg3,
            amount_usd         : 0x2c11c14fe07381e97c5b4033b7c85c21cb7ae30a4c35a91a64685a4728d85f90::leverage_obligation::get_usd_value<T0>(arg1, arg2, arg3, arg4),
            coin_type          : 0x1::type_name::get<T0>(),
        }
    }

    // decompiled from Move bytecode v6
}

