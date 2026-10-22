module 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::user {
    public fun liquidate<T0, T1>(arg0: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::Registry, arg1: &mut 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::VaultMarket<T0, T1>, arg2: &0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::registry::VaultRegistry, arg3: &mut 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::TokenReserve<T0>, arg4: &mut 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::TokenReserve<T1>, arg5: &0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::view::PriceQuote, arg6: 0x2::balance::Balance<T1>, arg7: u64, arg8: u128, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::liquidate_logic::liquidate<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11)
    }

    public fun get_exchange_prices<T0, T1>(arg0: &0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::VaultMarket<T0, T1>, arg1: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::TokenReserve<T0>, arg2: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::TokenReserve<T1>, arg3: &0x2::clock::Clock) : (u128, u128, u128, u128) {
        let (v0, _) = 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::liquidity::get_exchange_prices<T0>(arg1, arg3);
        let (_, v3) = 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::liquidity::get_exchange_prices<T1>(arg2, arg3);
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::load_exchange_prices<T0, T1>(arg0, v0, v3, 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::from_clock(arg3))
    }

    public fun operate<T0, T1>(arg0: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::Registry, arg1: &mut 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::VaultMarket<T0, T1>, arg2: &0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::registry::VaultRegistry, arg3: &mut 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::TokenReserve<T0>, arg4: &mut 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::TokenReserve<T1>, arg5: &mut 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::position::Position, arg6: 0x1::option::Option<0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::position::PositionOwnerCap>, arg7: 0x1::option::Option<0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::view::PriceQuote>, arg8: 0x2::balance::Balance<T0>, arg9: 0x2::balance::Balance<T1>, arg10: 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::structs::OperateAmount, arg11: 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::structs::OperateAmount, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x1::option::Option<0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::position::PositionOwnerCap>) {
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::operate_logic::operate<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13)
    }

    public fun close_position<T0, T1>(arg0: &0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::VaultMarket<T0, T1>, arg1: &0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::registry::VaultRegistry, arg2: 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::position::Position, arg3: 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::position::PositionOwnerCap, arg4: &0x2::tx_context::TxContext) {
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::registry::assert_version(arg1);
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::position::assert_belongs_to(&arg2, 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::vault_object_id<T0, T1>(arg0));
        let (v0, v1) = 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::position::delete(arg2, arg3);
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::events::emit_log_close_position(0x2::tx_context::sender(arg4), v0, 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::vault_id<T0, T1>(arg0), v1);
    }

    public fun get_stored_exchange_prices<T0, T1>(arg0: &0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::VaultMarket<T0, T1>) : (u128, u128, u128, u128) {
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::exchange_prices<T0, T1>(arg0)
    }

    public fun init_position<T0, T1>(arg0: &mut 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::VaultMarket<T0, T1>, arg1: &0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::registry::VaultRegistry, arg2: &mut 0x2::tx_context::TxContext) : (0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::position::Position, 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::position::PositionOwnerCap) {
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::registry::assert_version(arg1);
        let (v0, v1) = 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::position::new(0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::uid_mut<T0, T1>(arg0), 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::vault_id<T0, T1>(arg0), arg2);
        let v2 = v1;
        let v3 = v0;
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::events::emit_log_position_opened(0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::position::nft_id(&v3), 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::vault_object_id<T0, T1>(arg0), 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::position::cap_id(&v2), 0x2::tx_context::sender(arg2));
        (v3, v2)
    }

    public fun update_exchange_prices<T0, T1>(arg0: &mut 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::VaultMarket<T0, T1>, arg1: &0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::registry::VaultRegistry, arg2: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::TokenReserve<T0>, arg3: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::TokenReserve<T1>, arg4: &0x2::clock::Clock) {
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::registry::assert_version(arg1);
        let (v0, _) = 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::liquidity::get_exchange_prices<T0>(arg2, arg4);
        let (_, v3) = 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::liquidity::get_exchange_prices<T1>(arg3, arg4);
        0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::vault_market::update_exchange_prices<T0, T1>(arg0, v0, v3, 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::from_clock(arg4));
    }

    // decompiled from Move bytecode v7
}

