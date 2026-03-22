module 0xc640c0be4e6e502ebf7e37456c8501ec2e102d5cfe4fac827c1b3ebcef544f94::leverage_reduce_to_collateral_coin {
    public fun withdraw_leverage<T0, T1, T2>(arg0: &0xc640c0be4e6e502ebf7e37456c8501ec2e102d5cfe4fac827c1b3ebcef544f94::leverage_app::LeverageApp, arg1: &0x4ad0cdb92efdaf00ba808d097af9746923150d1769046d4f8aeac9a466d8c1db::app::ProtocolApp, arg2: &mut 0x4ad0cdb92efdaf00ba808d097af9746923150d1769046d4f8aeac9a466d8c1db::market::Market<T0>, arg3: &0xc640c0be4e6e502ebf7e37456c8501ec2e102d5cfe4fac827c1b3ebcef544f94::leverage_obligation::LeverageMarketOwnerCap, arg4: u64, arg5: &0xcb8499accc8d72fc498287808427fb1bc76b509b3127df63b5859919427dbc::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &0x4ad0cdb92efdaf00ba808d097af9746923150d1769046d4f8aeac9a466d8c1db::coin_decimals_registry::CoinDecimalsRegistry, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xc640c0be4e6e502ebf7e37456c8501ec2e102d5cfe4fac827c1b3ebcef544f94::leverage_app::ensure_version_matches(arg0);
        0xc640c0be4e6e502ebf7e37456c8501ec2e102d5cfe4fac827c1b3ebcef544f94::leverage_obligation::ensure_same_market<T0>(arg3);
        0xc640c0be4e6e502ebf7e37456c8501ec2e102d5cfe4fac827c1b3ebcef544f94::leverage_obligation::ensure_coins_match<T1, T2>(arg3);
        let v0 = 0x4ad0cdb92efdaf00ba808d097af9746923150d1769046d4f8aeac9a466d8c1db::withdraw::withdraw_as_coin<T0, T1>(arg1, arg2, 0xc640c0be4e6e502ebf7e37456c8501ec2e102d5cfe4fac827c1b3ebcef544f94::leverage_obligation::market_obligation(arg3), arg7, 0xc640c0be4e6e502ebf7e37456c8501ec2e102d5cfe4fac827c1b3ebcef544f94::leverage_reduce_to_borrow_coin::enforce_ctoken_deduciton<T0, T1>(arg2, arg3, arg4), arg5, arg6, arg8);
        0xc640c0be4e6e502ebf7e37456c8501ec2e102d5cfe4fac827c1b3ebcef544f94::leverage_reduce_to_borrow_coin::emit_reduce_leverage_event(0xc640c0be4e6e502ebf7e37456c8501ec2e102d5cfe4fac827c1b3ebcef544f94::leverage_obligation::id(arg3), 0x2::coin::value<T1>(&v0), 0, 0xc640c0be4e6e502ebf7e37456c8501ec2e102d5cfe4fac827c1b3ebcef544f94::leverage_obligation::get_collateral_price<T1, T2>(arg5, arg6));
        v0
    }

    public fun withdraw_size<T0, T1, T2>(arg0: &0xc640c0be4e6e502ebf7e37456c8501ec2e102d5cfe4fac827c1b3ebcef544f94::leverage_app::LeverageApp, arg1: &0x4ad0cdb92efdaf00ba808d097af9746923150d1769046d4f8aeac9a466d8c1db::app::ProtocolApp, arg2: &mut 0x4ad0cdb92efdaf00ba808d097af9746923150d1769046d4f8aeac9a466d8c1db::market::Market<T0>, arg3: &0xc640c0be4e6e502ebf7e37456c8501ec2e102d5cfe4fac827c1b3ebcef544f94::leverage_obligation::LeverageMarketOwnerCap, arg4: u8, arg5: &0xcb8499accc8d72fc498287808427fb1bc76b509b3127df63b5859919427dbc::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &0x4ad0cdb92efdaf00ba808d097af9746923150d1769046d4f8aeac9a466d8c1db::coin_decimals_registry::CoinDecimalsRegistry, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xc640c0be4e6e502ebf7e37456c8501ec2e102d5cfe4fac827c1b3ebcef544f94::leverage_app::ensure_version_matches(arg0);
        0xc640c0be4e6e502ebf7e37456c8501ec2e102d5cfe4fac827c1b3ebcef544f94::leverage_obligation::ensure_same_market<T0>(arg3);
        0xc640c0be4e6e502ebf7e37456c8501ec2e102d5cfe4fac827c1b3ebcef544f94::leverage_obligation::ensure_coins_match<T1, T2>(arg3);
        let (v0, _) = 0xc640c0be4e6e502ebf7e37456c8501ec2e102d5cfe4fac827c1b3ebcef544f94::leverage_reduce_to_borrow_coin::enforce_collateral_deduciton_by_percentage<T0, T1>(arg2, arg3, arg4);
        let v2 = 0x4ad0cdb92efdaf00ba808d097af9746923150d1769046d4f8aeac9a466d8c1db::withdraw::withdraw_as_coin<T0, T1>(arg1, arg2, 0xc640c0be4e6e502ebf7e37456c8501ec2e102d5cfe4fac827c1b3ebcef544f94::leverage_obligation::market_obligation(arg3), arg7, v0, arg5, arg6, arg8);
        0xc640c0be4e6e502ebf7e37456c8501ec2e102d5cfe4fac827c1b3ebcef544f94::leverage_reduce_to_borrow_coin::emit_reduce_size_event(0xc640c0be4e6e502ebf7e37456c8501ec2e102d5cfe4fac827c1b3ebcef544f94::leverage_obligation::id(arg3), 0x2::coin::value<T1>(&v2), 0, 0xc640c0be4e6e502ebf7e37456c8501ec2e102d5cfe4fac827c1b3ebcef544f94::leverage_obligation::get_collateral_price<T1, T2>(arg5, arg6));
        v2
    }

    // decompiled from Move bytecode v6
}

