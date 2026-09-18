module 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::user {
    public fun liquidate<T0, T1>(arg0: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::registry::Registry, arg1: &mut 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::VaultMarket<T0, T1>, arg2: &0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::registry::VaultRegistry, arg3: &mut 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T0>, arg4: &mut 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T1>, arg5: &0xebe2409c7ea9636f0e446797515cbee2ab809d898b06d99179d9eda59e1e42d5::view::PriceQuote, arg6: 0x2::balance::Balance<T1>, arg7: u64, arg8: u128, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidate_logic::liquidate<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11)
    }

    public fun get_exchange_prices<T0, T1>(arg0: &0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::VaultMarket<T0, T1>, arg1: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T0>, arg2: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T1>, arg3: &0x2::clock::Clock) : (u128, u128, u128, u128) {
        let (v0, _) = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidity::get_exchange_prices<T0>(arg1, arg3);
        let (_, v3) = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidity::get_exchange_prices<T1>(arg2, arg3);
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::load_exchange_prices<T0, T1>(arg0, v0, v3, 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::from_clock(arg3))
    }

    public fun operate<T0, T1>(arg0: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::registry::Registry, arg1: &mut 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::VaultMarket<T0, T1>, arg2: &0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::registry::VaultRegistry, arg3: &mut 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T0>, arg4: &mut 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T1>, arg5: &mut 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::position::Position, arg6: 0x1::option::Option<0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::position::PositionOwnerCap>, arg7: &0xebe2409c7ea9636f0e446797515cbee2ab809d898b06d99179d9eda59e1e42d5::view::PriceQuote, arg8: 0x2::balance::Balance<T0>, arg9: 0x2::balance::Balance<T1>, arg10: 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::structs::OperateAmount, arg11: 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::structs::OperateAmount, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x1::option::Option<0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::position::PositionOwnerCap>) {
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::operate_logic::operate<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13)
    }

    public fun close_position<T0, T1>(arg0: &0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::VaultMarket<T0, T1>, arg1: &0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::registry::VaultRegistry, arg2: 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::position::Position, arg3: 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::position::PositionOwnerCap, arg4: &0x2::tx_context::TxContext) {
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::registry::assert_version(arg1);
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::position::assert_belongs_to(&arg2, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::vault_object_id<T0, T1>(arg0));
        let (v0, v1) = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::position::delete(arg2, arg3);
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::events::emit_log_close_position(0x2::tx_context::sender(arg4), v0, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::vault_id<T0, T1>(arg0), v1);
    }

    public fun get_stored_exchange_prices<T0, T1>(arg0: &0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::VaultMarket<T0, T1>) : (u128, u128, u128, u128) {
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::exchange_prices<T0, T1>(arg0)
    }

    public fun init_position<T0, T1>(arg0: &mut 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::VaultMarket<T0, T1>, arg1: &0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::registry::VaultRegistry, arg2: &mut 0x2::tx_context::TxContext) : (0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::position::Position, 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::position::PositionOwnerCap) {
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::registry::assert_version(arg1);
        let (v0, v1) = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::position::new(0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::uid_mut<T0, T1>(arg0), arg2);
        let v2 = v1;
        let v3 = v0;
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::events::emit_log_position_opened(0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::position::nft_id(&v3), 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::vault_object_id<T0, T1>(arg0), 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::position::cap_id(&v2), 0x2::tx_context::sender(arg2));
        (v3, v2)
    }

    public fun update_exchange_prices<T0, T1>(arg0: &mut 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::VaultMarket<T0, T1>, arg1: &0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::registry::VaultRegistry, arg2: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T0>, arg3: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T1>, arg4: &0x2::clock::Clock) {
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::registry::assert_version(arg1);
        let (v0, _) = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidity::get_exchange_prices<T0>(arg2, arg4);
        let (_, v3) = 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::liquidity::get_exchange_prices<T1>(arg3, arg4);
        0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::vault_market::update_exchange_prices<T0, T1>(arg0, v0, v3, 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::from_clock(arg4));
    }

    // decompiled from Move bytecode v7
}

