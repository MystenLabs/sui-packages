module 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::user {
    public fun liquidate<T0, T1>(arg0: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::registry::Registry, arg1: &mut 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::VaultMarket<T0, T1>, arg2: &0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::registry::VaultRegistry, arg3: &mut 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T0>, arg4: &mut 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T1>, arg5: &0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::view::PriceQuote, arg6: 0x2::balance::Balance<T1>, arg7: u64, arg8: u128, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::liquidate_logic::liquidate<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11)
    }

    public fun get_exchange_prices<T0, T1>(arg0: &0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::VaultMarket<T0, T1>, arg1: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T0>, arg2: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T1>, arg3: &0x2::clock::Clock) : (u128, u128, u128, u128) {
        let (v0, _) = 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::liquidity::get_exchange_prices<T0>(arg1, arg3);
        let (_, v3) = 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::liquidity::get_exchange_prices<T1>(arg2, arg3);
        0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::load_exchange_prices<T0, T1>(arg0, v0, v3, 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::units::from_clock(arg3))
    }

    public fun operate<T0, T1>(arg0: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::registry::Registry, arg1: &mut 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::VaultMarket<T0, T1>, arg2: &0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::registry::VaultRegistry, arg3: &mut 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T0>, arg4: &mut 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T1>, arg5: &mut 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::position::Position, arg6: 0x1::option::Option<0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::position::PositionOwnerCap>, arg7: 0x1::option::Option<0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::view::PriceQuote>, arg8: 0x2::balance::Balance<T0>, arg9: 0x2::balance::Balance<T1>, arg10: 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::structs::OperateAmount, arg11: 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::structs::OperateAmount, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x1::option::Option<0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::position::PositionOwnerCap>) {
        0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::operate_logic::operate<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13)
    }

    public fun close_position<T0, T1>(arg0: &0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::VaultMarket<T0, T1>, arg1: &0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::registry::VaultRegistry, arg2: 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::position::Position, arg3: 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::position::PositionOwnerCap, arg4: &0x2::tx_context::TxContext) {
        0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::registry::assert_version(arg1);
        0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::position::assert_belongs_to(&arg2, 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::vault_object_id<T0, T1>(arg0));
        let (v0, v1) = 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::position::delete(arg2, arg3);
        0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::events::emit_log_close_position(0x2::tx_context::sender(arg4), v0, 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::vault_id<T0, T1>(arg0), v1);
    }

    public fun get_stored_exchange_prices<T0, T1>(arg0: &0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::VaultMarket<T0, T1>) : (u128, u128, u128, u128) {
        0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::exchange_prices<T0, T1>(arg0)
    }

    public fun init_position<T0, T1>(arg0: &mut 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::VaultMarket<T0, T1>, arg1: &0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::registry::VaultRegistry, arg2: &mut 0x2::tx_context::TxContext) : (0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::position::Position, 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::position::PositionOwnerCap) {
        0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::registry::assert_version(arg1);
        let (v0, v1) = 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::position::new(0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::uid_mut<T0, T1>(arg0), 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::vault_id<T0, T1>(arg0), arg2);
        let v2 = v1;
        let v3 = v0;
        0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::events::emit_log_position_opened(0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::position::nft_id(&v3), 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::vault_object_id<T0, T1>(arg0), 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::position::cap_id(&v2), 0x2::tx_context::sender(arg2));
        (v3, v2)
    }

    public fun update_exchange_prices<T0, T1>(arg0: &mut 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::VaultMarket<T0, T1>, arg1: &0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::registry::VaultRegistry, arg2: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T0>, arg3: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T1>, arg4: &0x2::clock::Clock) {
        0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::registry::assert_version(arg1);
        let (v0, _) = 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::liquidity::get_exchange_prices<T0>(arg2, arg4);
        let (_, v3) = 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::liquidity::get_exchange_prices<T1>(arg3, arg4);
        0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::update_exchange_prices<T0, T1>(arg0, v0, v3, 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::units::from_clock(arg4));
    }

    // decompiled from Move bytecode v7
}

