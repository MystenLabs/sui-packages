module 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::liquidity {
    public(friend) fun borrow<T0, T1>(arg0: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::registry::Registry, arg1: &0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::VaultMarket<T0, T1>, arg2: &mut 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T1>, arg3: 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::structs::Amount, arg4: 0x2::balance::Balance<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        if (0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::structs::is_none(&arg3)) {
            0x2::balance::destroy_zero<T1>(arg4);
            return 0x2::balance::zero<T1>()
        };
        let (v0, v1, _, _) = 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::user::operate<T1>(arg2, arg0, 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::borrow_debt_cap<T0, T1>(arg1), 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::structs::none(), arg3, arg4, @0x0, @0x0, 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::structs::skip(), arg5, arg6);
        0x2::balance::destroy_zero<T1>(v0);
        v1
    }

    public(friend) fun calc_withdrawal_limit_before_operate<T0, T1, T2>(arg0: &0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::VaultMarket<T0, T1>, arg1: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T2>, arg2: &0x2::clock::Clock) : (u128, u128) {
        let (_, v1, v2, v3, v4, v5, _, _) = 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::get_user_supply_data<T2>(arg1, 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::keys::holder_object(0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::vault_object_id<T0, T1>(arg0)));
        (0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::liquidity_calcs::calc_withdrawal_limit_before_operate((v1 as u128), (v2 as u128), v4, v5, v3, 0x2::clock::timestamp_ms(arg2) / 1000), (v1 as u128))
    }

    public(friend) fun get_exchange_prices<T0>(arg0: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T0>, arg1: &0x2::clock::Clock) : (u128, u128) {
        0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::get_exchange_prices<T0>(arg0, arg1)
    }

    public(friend) fun assert_liquidity_program<T0, T1>(arg0: &0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::VaultMarket<T0, T1>, arg1: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::registry::Registry) {
        assert!(0x2::object::id<0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::registry::Registry>(arg1) == 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::liquidity_program<T0, T1>(arg0), 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::errors::vault_invalid_liquidity_program());
    }

    public(friend) fun get_vault_borrow_at_liquidity<T0, T1, T2>(arg0: &0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::VaultMarket<T0, T1>, arg1: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T2>) : u128 {
        let (_, v1, _, _, _, _, _, _, _) = 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::get_user_borrow_data<T2>(arg1, 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::keys::holder_object(0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::vault_object_id<T0, T1>(arg0)));
        (v1 as u128)
    }

    public(friend) fun get_vault_supply_at_liquidity<T0, T1, T2>(arg0: &0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::VaultMarket<T0, T1>, arg1: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T2>) : u128 {
        let (_, v1, _, _, _, _, _, _) = 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::get_user_supply_data<T2>(arg1, 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::keys::holder_object(0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::vault_object_id<T0, T1>(arg0)));
        (v1 as u128)
    }

    public(friend) fun supply<T0, T1>(arg0: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::registry::Registry, arg1: &0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::VaultMarket<T0, T1>, arg2: &mut 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T0>, arg3: 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::structs::Amount, arg4: 0x2::balance::Balance<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        if (0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::structs::is_none(&arg3)) {
            0x2::balance::destroy_zero<T0>(arg4);
            return 0x2::balance::zero<T0>()
        };
        let (v0, v1, _, _) = 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::user::operate<T0>(arg2, arg0, 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::borrow_col_cap<T0, T1>(arg1), arg3, 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::structs::none(), arg4, @0x0, @0x0, 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::structs::skip(), arg5, arg6);
        0x2::balance::destroy_zero<T0>(v1);
        v0
    }

    // decompiled from Move bytecode v7
}

