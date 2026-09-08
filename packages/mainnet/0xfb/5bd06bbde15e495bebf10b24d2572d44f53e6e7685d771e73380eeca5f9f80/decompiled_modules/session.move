module 0xfb5bd06bbde15e495bebf10b24d2572d44f53e6e7685d771e73380eeca5f9f80::session {
    struct SessionKey has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        agent_address: address,
        expiry_epoch: u64,
        allowed_tokens: vector<0x1::type_name::TypeName>,
        allowed_actions: u8,
        max_notional_per_tx: u64,
        window_duration_epochs: u64,
        window_start_epoch: u64,
        window_cumulative_spent: u64,
        window_limit: u64,
        max_slippage_bps_ceiling: u64,
        nonce: u64,
    }

    struct PriceFeedInput has drop, store {
        token: 0x1::type_name::TypeName,
        decimals: u8,
        price_low: u128,
        price_high: u128,
    }

    struct RebalanceProof {
        vault_id: 0x2::object::ID,
        debt_value: u128,
        settled_value: u128,
        max_slippage_bps: u64,
        price_snapshot: vector<PriceFeedInput>,
        notional_ceiling: u128,
        allowed_actions: u8,
        allowed_tokens: vector<0x1::type_name::TypeName>,
    }

    struct SessionKeyRevoked has copy, drop {
        key_id: 0x2::object::ID,
    }

    struct RebalanceSettled has copy, drop {
        vault_id: 0x2::object::ID,
        debt_value: u128,
        settled_value: u128,
        max_slippage_bps: u64,
    }

    public fun action_lend() : u8 {
        2
    }

    public fun action_swap() : u8 {
        1
    }

    public fun action_withdraw_to_owner() : u8 {
        4
    }

    public fun authorize(arg0: &mut SessionKey, arg1: &0xfb5bd06bbde15e495bebf10b24d2572d44f53e6e7685d771e73380eeca5f9f80::policy::PolicyRegistry, arg2: &0x2::clock::Clock, arg3: vector<PriceFeedInput>, arg4: u64, arg5: u64, arg6: &0x2::tx_context::TxContext) : RebalanceProof {
        0xfb5bd06bbde15e495bebf10b24d2572d44f53e6e7685d771e73380eeca5f9f80::version::assert_is_current(0xfb5bd06bbde15e495bebf10b24d2572d44f53e6e7685d771e73380eeca5f9f80::policy::version_of(arg1));
        0xfb5bd06bbde15e495bebf10b24d2572d44f53e6e7685d771e73380eeca5f9f80::policy::assert_not_revoked(arg1, 0x2::object::id<SessionKey>(arg0));
        assert!(0x2::tx_context::sender(arg6) == arg0.agent_address, 3);
        assert!(0x2::tx_context::epoch(arg6) <= arg0.expiry_epoch, 4);
        assert!(arg5 <= 10000, 11);
        assert!(arg5 <= arg0.max_slippage_bps_ceiling, 12);
        let v0 = 0x2::tx_context::epoch(arg6);
        if (v0 >= arg0.window_start_epoch + arg0.window_duration_epochs) {
            arg0.window_start_epoch = v0;
            arg0.window_cumulative_spent = 0;
        };
        assert!(arg4 <= arg0.max_notional_per_tx, 5);
        assert!(arg0.window_cumulative_spent + arg4 <= arg0.window_limit, 6);
        arg0.window_cumulative_spent = arg0.window_cumulative_spent + arg4;
        arg0.nonce = arg0.nonce + 1;
        let v1 = 0;
        while (v1 < 0x1::vector::length<PriceFeedInput>(&arg3)) {
            assert!(0x1::vector::contains<0x1::type_name::TypeName>(&arg0.allowed_tokens, &0x1::vector::borrow<PriceFeedInput>(&arg3, v1).token), 7);
            v1 = v1 + 1;
        };
        RebalanceProof{
            vault_id         : arg0.vault_id,
            debt_value       : 0,
            settled_value    : 0,
            max_slippage_bps : arg5,
            price_snapshot   : arg3,
            notional_ceiling : (arg4 as u128),
            allowed_actions  : arg0.allowed_actions,
            allowed_tokens   : arg0.allowed_tokens,
        }
    }

    public fun consume_proof(arg0: RebalanceProof) {
        let RebalanceProof {
            vault_id         : v0,
            debt_value       : v1,
            settled_value    : v2,
            max_slippage_bps : v3,
            price_snapshot   : _,
            notional_ceiling : _,
            allowed_actions  : _,
            allowed_tokens   : _,
        } = arg0;
        assert!(v2 >= 0xfb5bd06bbde15e495bebf10b24d2572d44f53e6e7685d771e73380eeca5f9f80::math::bps_of_ceil(v1, 10000 - v3), 8);
        let v8 = RebalanceSettled{
            vault_id         : v0,
            debt_value       : v1,
            settled_value    : v2,
            max_slippage_bps : v3,
        };
        0x2::event::emit<RebalanceSettled>(v8);
    }

    public fun max_slippage_bps_ceiling(arg0: &SessionKey) : u64 {
        arg0.max_slippage_bps_ceiling
    }

    public fun max_slippage_bps_ceiling_limit() : u64 {
        5000
    }

    public(friend) fun new_session_key(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: vector<0x1::type_name::TypeName>, arg4: u8, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : SessionKey {
        SessionKey{
            id                       : 0x2::object::new(arg9),
            vault_id                 : arg0,
            agent_address            : arg1,
            expiry_epoch             : arg2,
            allowed_tokens           : arg3,
            allowed_actions          : arg4,
            max_notional_per_tx      : arg5,
            window_duration_epochs   : arg6,
            window_start_epoch       : 0x2::tx_context::epoch(arg9),
            window_cumulative_spent  : 0,
            window_limit             : arg7,
            max_slippage_bps_ceiling : arg8,
            nonce                    : 0,
        }
    }

    public(friend) fun nonce(arg0: &SessionKey) : u64 {
        arg0.nonce
    }

    public(friend) fun proof_add_debt(arg0: &mut RebalanceProof, arg1: u128) {
        arg0.debt_value = arg0.debt_value + arg1;
    }

    public(friend) fun proof_add_settled(arg0: &mut RebalanceProof, arg1: u128) {
        arg0.settled_value = arg0.settled_value + arg1;
    }

    public(friend) fun proof_allowed_actions(arg0: &RebalanceProof) : u8 {
        arg0.allowed_actions
    }

    public(friend) fun proof_assert_token_allowed(arg0: &RebalanceProof, arg1: 0x1::type_name::TypeName) {
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&arg0.allowed_tokens, &arg1), 7);
    }

    public(friend) fun proof_debt_value(arg0: &RebalanceProof) : u128 {
        arg0.debt_value
    }

    public(friend) fun proof_find_price(arg0: &RebalanceProof, arg1: 0x1::type_name::TypeName) : (u128, u128, u8) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<PriceFeedInput>(&arg0.price_snapshot)) {
            let v1 = 0x1::vector::borrow<PriceFeedInput>(&arg0.price_snapshot, v0);
            if (v1.token == arg1) {
                return (v1.price_low, v1.price_high, v1.decimals)
            };
            v0 = v0 + 1;
        };
        abort 9
    }

    public(friend) fun proof_notional_ceiling(arg0: &RebalanceProof) : u128 {
        arg0.notional_ceiling
    }

    public(friend) fun proof_settled_value(arg0: &RebalanceProof) : u128 {
        arg0.settled_value
    }

    public(friend) fun proof_vault_id(arg0: &RebalanceProof) : 0x2::object::ID {
        arg0.vault_id
    }

    public fun read_price<T0>(arg0: &0x2::coin_registry::Currency<T0>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg2: &0x2::clock::Clock, arg3: &0xfb5bd06bbde15e495bebf10b24d2572d44f53e6e7685d771e73380eeca5f9f80::policy::PolicyRegistry) : PriceFeedInput {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        0xfb5bd06bbde15e495bebf10b24d2572d44f53e6e7685d771e73380eeca5f9f80::policy::assert_priced_token(arg3, v0);
        0xfb5bd06bbde15e495bebf10b24d2572d44f53e6e7685d771e73380eeca5f9f80::policy::assert_pricing_market(arg3, 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(arg1));
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg1);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::assert_price_is_fresh<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(v1, arg2);
        let v2 = 0xfb5bd06bbde15e495bebf10b24d2572d44f53e6e7685d771e73380eeca5f9f80::math::from_suilend_decimal_floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::price_lower_bound<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(v1));
        assert!(v2 > 0, 2);
        PriceFeedInput{
            token      : v0,
            decimals   : 0x2::coin_registry::decimals<T0>(arg0),
            price_low  : v2,
            price_high : 0xfb5bd06bbde15e495bebf10b24d2572d44f53e6e7685d771e73380eeca5f9f80::math::from_suilend_decimal_ceil(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::price_upper_bound<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(v1)),
        }
    }

    public fun revoke_session_key(arg0: &mut 0xfb5bd06bbde15e495bebf10b24d2572d44f53e6e7685d771e73380eeca5f9f80::policy::PolicyRegistry, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == 0xfb5bd06bbde15e495bebf10b24d2572d44f53e6e7685d771e73380eeca5f9f80::policy::owner_of(arg0, arg1) || 0xfb5bd06bbde15e495bebf10b24d2572d44f53e6e7685d771e73380eeca5f9f80::policy::is_admin(arg0, v0), 10);
        0xfb5bd06bbde15e495bebf10b24d2572d44f53e6e7685d771e73380eeca5f9f80::policy::mark_revoked(arg0, arg1);
        let v1 = SessionKeyRevoked{key_id: arg1};
        0x2::event::emit<SessionKeyRevoked>(v1);
    }

    public(friend) fun window_cumulative_spent(arg0: &SessionKey) : u64 {
        arg0.window_cumulative_spent
    }

    // decompiled from Move bytecode v7
}

