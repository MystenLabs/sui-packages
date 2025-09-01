module 0x1e7d7781d4e316250edf8f0d03af7abfe4b16d1dce3287bf50475bc02bc6268a::leverage_repay {
    struct RefundedEvent has copy, drop {
        leverage_owner_cap: 0x2::object::ID,
        amount: u64,
        amount_usd: 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::Decimal,
        coin_type: 0x1::type_name::TypeName,
    }

    public fun complete_leverage<T0, T1>(arg0: &mut 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::market::Market<T0>, arg1: &mut 0x1e7d7781d4e316250edf8f0d03af7abfe4b16d1dce3287bf50475bc02bc6268a::leverage_market::LeverageMarket, arg2: &0x1e7d7781d4e316250edf8f0d03af7abfe4b16d1dce3287bf50475bc02bc6268a::leverage_obligation::LeverageMarketOwnerCap, arg3: 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::FlashLoan<T0, T1>, arg4: 0x2::coin::Coin<T1>, arg5: &0x988609a6772a8ce45037fa78bdc1eda593c5872c16dd883002c8aa4939a2a7bb::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &0x4bf60b34197a0246a1f916cb51ccd215ac7f4ddf1ec83e00eeecdc355630d998::coin_decimals_registry::CoinDecimalsRegistry, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x1e7d7781d4e316250edf8f0d03af7abfe4b16d1dce3287bf50475bc02bc6268a::leverage_market::is_leverate_on_going(arg1), 13906834371911876607);
        0x1e7d7781d4e316250edf8f0d03af7abfe4b16d1dce3287bf50475bc02bc6268a::leverage_market::mark_leverage_finished(arg1);
        let v0 = 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::fee<T0, T1>(&arg3) + 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::reserve::loan_amount<T0, T1>(&arg3);
        assert!(0x2::coin::value<T1>(&arg4) >= v0, 0x1e7d7781d4e316250edf8f0d03af7abfe4b16d1dce3287bf50475bc02bc6268a::leverage_error::cannot_repay_flash_loan());
        0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::flash_loan::repay_flash_loan<T0, T1>(arg0, 0x2::coin::split<T1>(&mut arg4, v0, arg8), arg3, arg8);
        0x2::event::emit<RefundedEvent>(new_refunded_event<T1>(0x1e7d7781d4e316250edf8f0d03af7abfe4b16d1dce3287bf50475bc02bc6268a::leverage_obligation::id(arg2), arg5, arg6, 0x2::coin::value<T1>(&arg4), arg7));
        arg4
    }

    public(friend) fun emit_new_refunded_event<T0>(arg0: 0x2::object::ID, arg1: &0x988609a6772a8ce45037fa78bdc1eda593c5872c16dd883002c8aa4939a2a7bb::x_oracle::XOracle, arg2: &0x2::clock::Clock, arg3: u64, arg4: &0x4bf60b34197a0246a1f916cb51ccd215ac7f4ddf1ec83e00eeecdc355630d998::coin_decimals_registry::CoinDecimalsRegistry) {
        0x2::event::emit<RefundedEvent>(new_refunded_event<T0>(arg0, arg1, arg2, arg3, arg4));
    }

    fun new_refunded_event<T0>(arg0: 0x2::object::ID, arg1: &0x988609a6772a8ce45037fa78bdc1eda593c5872c16dd883002c8aa4939a2a7bb::x_oracle::XOracle, arg2: &0x2::clock::Clock, arg3: u64, arg4: &0x4bf60b34197a0246a1f916cb51ccd215ac7f4ddf1ec83e00eeecdc355630d998::coin_decimals_registry::CoinDecimalsRegistry) : RefundedEvent {
        RefundedEvent{
            leverage_owner_cap : arg0,
            amount             : arg3,
            amount_usd         : 0x1e7d7781d4e316250edf8f0d03af7abfe4b16d1dce3287bf50475bc02bc6268a::leverage_obligation::get_usd_value<T0>(arg1, arg2, arg3, arg4),
            coin_type          : 0x1::type_name::get<T0>(),
        }
    }

    // decompiled from Move bytecode v6
}

