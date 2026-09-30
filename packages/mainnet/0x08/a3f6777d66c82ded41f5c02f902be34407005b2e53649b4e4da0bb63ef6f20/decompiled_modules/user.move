module 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::user {
    public fun liquidate<T0, T1>(arg0: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::registry::Registry, arg1: &mut 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::vault_market::VaultMarket<T0, T1>, arg2: &0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::registry::VaultRegistry, arg3: &mut 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T0>, arg4: &mut 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T1>, arg5: &0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::view::PriceQuote, arg6: 0x2::balance::Balance<T1>, arg7: u64, arg8: u128, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::liquidate_logic::liquidate<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11)
    }

    public fun get_exchange_prices<T0, T1>(arg0: &0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::vault_market::VaultMarket<T0, T1>, arg1: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T0>, arg2: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T1>, arg3: &0x2::clock::Clock) : (u128, u128, u128, u128) {
        let (v0, _) = 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::liquidity::get_exchange_prices<T0>(arg1, arg3);
        let (_, v3) = 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::liquidity::get_exchange_prices<T1>(arg2, arg3);
        0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::vault_market::load_exchange_prices<T0, T1>(arg0, v0, v3, 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::from_clock(arg3))
    }

    public fun operate<T0, T1>(arg0: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::registry::Registry, arg1: &mut 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::vault_market::VaultMarket<T0, T1>, arg2: &0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::registry::VaultRegistry, arg3: &mut 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T0>, arg4: &mut 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T1>, arg5: &mut 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::position::Position, arg6: 0x1::option::Option<0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::position::PositionOwnerCap>, arg7: &0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::view::PriceQuote, arg8: 0x2::balance::Balance<T0>, arg9: 0x2::balance::Balance<T1>, arg10: 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::structs::OperateAmount, arg11: 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::structs::OperateAmount, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x1::option::Option<0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::position::PositionOwnerCap>) {
        0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::operate_logic::operate<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13)
    }

    public fun close_position<T0, T1>(arg0: &0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::vault_market::VaultMarket<T0, T1>, arg1: &0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::registry::VaultRegistry, arg2: 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::position::Position, arg3: 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::position::PositionOwnerCap, arg4: &0x2::tx_context::TxContext) {
        0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::registry::assert_version(arg1);
        0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::position::assert_belongs_to(&arg2, 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::vault_market::vault_object_id<T0, T1>(arg0));
        let (v0, v1) = 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::position::delete(arg2, arg3);
        0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::events::emit_log_close_position(0x2::tx_context::sender(arg4), v0, 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::vault_market::vault_id<T0, T1>(arg0), v1);
    }

    public fun get_stored_exchange_prices<T0, T1>(arg0: &0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::vault_market::VaultMarket<T0, T1>) : (u128, u128, u128, u128) {
        0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::vault_market::exchange_prices<T0, T1>(arg0)
    }

    public fun init_position<T0, T1>(arg0: &mut 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::vault_market::VaultMarket<T0, T1>, arg1: &0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::registry::VaultRegistry, arg2: &mut 0x2::tx_context::TxContext) : (0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::position::Position, 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::position::PositionOwnerCap) {
        0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::registry::assert_version(arg1);
        let (v0, v1) = 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::position::new(0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::vault_market::uid_mut<T0, T1>(arg0), arg2);
        let v2 = v1;
        let v3 = v0;
        0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::events::emit_log_position_opened(0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::position::nft_id(&v3), 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::vault_market::vault_object_id<T0, T1>(arg0), 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::position::cap_id(&v2), 0x2::tx_context::sender(arg2));
        (v3, v2)
    }

    public fun update_exchange_prices<T0, T1>(arg0: &mut 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::vault_market::VaultMarket<T0, T1>, arg1: &0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::registry::VaultRegistry, arg2: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T0>, arg3: &0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::reserve::TokenReserve<T1>, arg4: &0x2::clock::Clock) {
        0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::registry::assert_version(arg1);
        let (v0, _) = 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::liquidity::get_exchange_prices<T0>(arg2, arg4);
        let (_, v3) = 0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::liquidity::get_exchange_prices<T1>(arg3, arg4);
        0x8a3f6777d66c82ded41f5c02f902be34407005b2e53649b4e4da0bb63ef6f20::vault_market::update_exchange_prices<T0, T1>(arg0, v0, v3, 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::from_clock(arg4));
    }

    // decompiled from Move bytecode v7
}

