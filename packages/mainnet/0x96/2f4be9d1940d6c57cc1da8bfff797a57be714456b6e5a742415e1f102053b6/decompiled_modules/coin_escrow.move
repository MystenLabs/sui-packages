module 0x962f4be9d1940d6c57cc1da8bfff797a57be714456b6e5a742415e1f102053b6::coin_escrow {
    struct AssetCapKey has copy, drop, store {
        outcome_index: u64,
    }

    struct StableCapKey has copy, drop, store {
        outcome_index: u64,
    }

    struct TokenEscrow<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        market_state: 0x962f4be9d1940d6c57cc1da8bfff797a57be714456b6e5a742415e1f102053b6::market_state::MarketState,
        escrowed_asset: 0x2::balance::Balance<T0>,
        escrowed_stable: 0x2::balance::Balance<T1>,
        outcome_count: u64,
        lp_deposited_asset: u64,
        lp_deposited_stable: u64,
        user_deposited_asset: u64,
        user_deposited_stable: u64,
        asset_supplies: vector<u64>,
        stable_supplies: vector<u64>,
        wrapped_asset_balances: vector<u64>,
        wrapped_stable_balances: vector<u64>,
        dust_created_asset: vector<u64>,
        dust_created_stable: vector<u64>,
        collected_protocol_fees_asset: u64,
        collected_protocol_fees_stable: u64,
        outcome_escrowed_asset: vector<u64>,
        outcome_escrowed_stable: vector<u64>,
        pool_claim_asset: vector<u64>,
        pool_claim_stable: vector<u64>,
    }

    struct COIN_ESCROW has drop {
        dummy_field: bool,
    }

    struct LiquidityWithdrawal has copy, drop {
        escrowed_asset: u64,
        escrowed_stable: u64,
        asset_amount: u64,
        stable_amount: u64,
    }

    struct LiquidityDeposit has copy, drop {
        escrowed_asset: u64,
        escrowed_stable: u64,
        asset_amount: u64,
        stable_amount: u64,
    }

    struct TokenRedemption has copy, drop {
        outcome: u64,
        token_type: u8,
        amount: u64,
    }

    struct SaturatingSubtractionEvent has copy, drop {
        escrow_id: 0x2::object::ID,
        field: vector<u8>,
        outcome_index: u64,
        requested: u64,
        available: u64,
    }

    struct SplitAssetProgress<phantom T0, phantom T1> {
        market_id: 0x2::object::ID,
        amount: u64,
        outcome_count: u64,
        next_outcome: u64,
    }

    struct SplitStableProgress<phantom T0, phantom T1> {
        market_id: 0x2::object::ID,
        amount: u64,
        outcome_count: u64,
        next_outcome: u64,
    }

    struct RecombineAssetProgress<phantom T0, phantom T1> {
        market_id: 0x2::object::ID,
        amount: u64,
        outcome_count: u64,
        next_outcome: u64,
    }

    struct RecombineStableProgress<phantom T0, phantom T1> {
        market_id: 0x2::object::ID,
        amount: u64,
        outcome_count: u64,
        next_outcome: u64,
    }

    public fun new<T0, T1>(arg0: 0x962f4be9d1940d6c57cc1da8bfff797a57be714456b6e5a742415e1f102053b6::market_state::MarketState, arg1: &mut 0x2::tx_context::TxContext) : TokenEscrow<T0, T1> {
        TokenEscrow<T0, T1>{
            id                             : 0x2::object::new(arg1),
            market_state                   : arg0,
            escrowed_asset                 : 0x2::balance::zero<T0>(),
            escrowed_stable                : 0x2::balance::zero<T1>(),
            outcome_count                  : 0,
            lp_deposited_asset             : 0,
            lp_deposited_stable            : 0,
            user_deposited_asset           : 0,
            user_deposited_stable          : 0,
            asset_supplies                 : vector[],
            stable_supplies                : vector[],
            wrapped_asset_balances         : vector[],
            wrapped_stable_balances        : vector[],
            dust_created_asset             : vector[],
            dust_created_stable            : vector[],
            collected_protocol_fees_asset  : 0,
            collected_protocol_fees_stable : 0,
            outcome_escrowed_asset         : vector[],
            outcome_escrowed_stable        : vector[],
            pool_claim_asset               : vector[],
            pool_claim_stable              : vector[],
        }
    }

    public fun assert_accounting_invariant<T0, T1>(arg0: &TokenEscrow<T0, T1>) {
        let v0 = 0x2::balance::value<T0>(&arg0.escrowed_asset);
        let v1 = 0x2::balance::value<T1>(&arg0.escrowed_stable);
        assert!(arg0.lp_deposited_asset <= v0, 200);
        assert!(arg0.lp_deposited_stable <= v1, 200);
        assert!((arg0.lp_deposited_asset as u128) + (arg0.lp_deposited_stable as u128) + (arg0.user_deposited_asset as u128) + (arg0.user_deposited_stable as u128) <= (v0 as u128) + (v1 as u128), 200);
    }

    public fun assert_all_invariants<T0, T1>(arg0: &TokenEscrow<T0, T1>) {
        assert_accounting_invariant<T0, T1>(arg0);
        assert_quantum_invariant<T0, T1>(arg0);
    }

    public fun assert_quantum_invariant<T0, T1>(arg0: &TokenEscrow<T0, T1>) {
        if (0x962f4be9d1940d6c57cc1da8bfff797a57be714456b6e5a742415e1f102053b6::market_state::is_finalized(&arg0.market_state)) {
            let v0 = 0x962f4be9d1940d6c57cc1da8bfff797a57be714456b6e5a742415e1f102053b6::market_state::get_winning_outcome(&arg0.market_state);
            let v1 = *0x1::vector::borrow<u64>(&arg0.outcome_escrowed_asset, v0);
            let v2 = *0x1::vector::borrow<u64>(&arg0.outcome_escrowed_stable, v0);
            assert!(v1 == *0x1::vector::borrow<u64>(&arg0.asset_supplies, v0) + *0x1::vector::borrow<u64>(&arg0.wrapped_asset_balances, v0), 201);
            assert!(v2 == *0x1::vector::borrow<u64>(&arg0.stable_supplies, v0) + *0x1::vector::borrow<u64>(&arg0.wrapped_stable_balances, v0), 201);
            let v3 = *0x1::vector::borrow<u64>(&arg0.pool_claim_asset, v0);
            let v4 = *0x1::vector::borrow<u64>(&arg0.pool_claim_stable, v0);
            let v5 = if (v1 > v3) {
                v1 - v3
            } else {
                0
            };
            let v6 = if (v2 > v4) {
                v2 - v4
            } else {
                0
            };
            assert!(0x2::balance::value<T0>(&arg0.escrowed_asset) >= v5, 202);
            assert!(0x2::balance::value<T1>(&arg0.escrowed_stable) >= v6, 202);
        } else {
            let v7 = 0;
            while (v7 < arg0.outcome_count) {
                assert!(*0x1::vector::borrow<u64>(&arg0.outcome_escrowed_asset, v7) == *0x1::vector::borrow<u64>(&arg0.asset_supplies, v7) + *0x1::vector::borrow<u64>(&arg0.wrapped_asset_balances, v7), 201);
                assert!(*0x1::vector::borrow<u64>(&arg0.outcome_escrowed_stable, v7) == *0x1::vector::borrow<u64>(&arg0.stable_supplies, v7) + *0x1::vector::borrow<u64>(&arg0.wrapped_stable_balances, v7), 201);
                v7 = v7 + 1;
            };
        };
    }

    public fun burn_conditional<T0, T1, T2>(arg0: &mut TokenEscrow<T0, T1>, arg1: u64, arg2: bool, arg3: 0x2::coin::Coin<T2>, arg4: &0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::escrow_mutation_auth::EscrowMutationAuth) {
        burn_conditional_pkg<T0, T1, T2>(arg0, arg1, arg2, arg3);
    }

    public(friend) fun burn_conditional_asset<T0, T1, T2>(arg0: &mut TokenEscrow<T0, T1>, arg1: u64, arg2: 0x2::coin::Coin<T2>) {
        assert!(arg1 < arg0.outcome_count, 5);
        let v0 = 0x1::vector::borrow_mut<u64>(&mut arg0.asset_supplies, arg1);
        *v0 = *v0 - 0x2::coin::value<T2>(&arg2);
        let v1 = AssetCapKey{outcome_index: arg1};
        0x2::coin::burn<T2>(0x2::dynamic_field::borrow_mut<AssetCapKey, 0x2::coin::TreasuryCap<T2>>(&mut arg0.id, v1), arg2);
    }

    public fun burn_conditional_asset_and_withdraw<T0, T1, T2>(arg0: &mut TokenEscrow<T0, T1>, arg1: 0x2::coin::Coin<T2>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x962f4be9d1940d6c57cc1da8bfff797a57be714456b6e5a742415e1f102053b6::market_state::is_finalized(&arg0.market_state), 101);
        let v0 = 0x962f4be9d1940d6c57cc1da8bfff797a57be714456b6e5a742415e1f102053b6::market_state::get_winning_outcome(&arg0.market_state);
        let v1 = 0x2::coin::value<T2>(&arg1);
        assert!(v1 > 0, 13);
        burn_conditional_asset<T0, T1, T2>(arg0, v0, arg1);
        assert!(0x2::balance::value<T0>(&arg0.escrowed_asset) >= v1, 8);
        let v2 = 0x2::balance::split<T0>(&mut arg0.escrowed_asset, v1);
        saturating_decrement_user_asset<T0, T1>(arg0, v1);
        let v3 = 0x1::vector::borrow_mut<u64>(&mut arg0.outcome_escrowed_asset, v0);
        *v3 = *v3 - v1;
        assert_quantum_invariant<T0, T1>(arg0);
        0x2::coin::from_balance<T0>(v2, arg2)
    }

    public(friend) fun burn_conditional_pkg<T0, T1, T2>(arg0: &mut TokenEscrow<T0, T1>, arg1: u64, arg2: bool, arg3: 0x2::coin::Coin<T2>) {
        if (arg2) {
            burn_conditional_asset<T0, T1, T2>(arg0, arg1, arg3);
        } else {
            burn_conditional_stable<T0, T1, T2>(arg0, arg1, arg3);
        };
    }

    public(friend) fun burn_conditional_stable<T0, T1, T2>(arg0: &mut TokenEscrow<T0, T1>, arg1: u64, arg2: 0x2::coin::Coin<T2>) {
        assert!(arg1 < arg0.outcome_count, 5);
        let v0 = 0x1::vector::borrow_mut<u64>(&mut arg0.stable_supplies, arg1);
        *v0 = *v0 - 0x2::coin::value<T2>(&arg2);
        let v1 = StableCapKey{outcome_index: arg1};
        0x2::coin::burn<T2>(0x2::dynamic_field::borrow_mut<StableCapKey, 0x2::coin::TreasuryCap<T2>>(&mut arg0.id, v1), arg2);
    }

    public fun burn_conditional_stable_and_withdraw<T0, T1, T2>(arg0: &mut TokenEscrow<T0, T1>, arg1: 0x2::coin::Coin<T2>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x962f4be9d1940d6c57cc1da8bfff797a57be714456b6e5a742415e1f102053b6::market_state::is_finalized(&arg0.market_state), 101);
        let v0 = 0x962f4be9d1940d6c57cc1da8bfff797a57be714456b6e5a742415e1f102053b6::market_state::get_winning_outcome(&arg0.market_state);
        let v1 = 0x2::coin::value<T2>(&arg1);
        assert!(v1 > 0, 13);
        burn_conditional_stable<T0, T1, T2>(arg0, v0, arg1);
        assert!(0x2::balance::value<T1>(&arg0.escrowed_stable) >= v1, 8);
        let v2 = 0x2::balance::split<T1>(&mut arg0.escrowed_stable, v1);
        saturating_decrement_user_stable<T0, T1>(arg0, v1);
        let v3 = 0x1::vector::borrow_mut<u64>(&mut arg0.outcome_escrowed_stable, v0);
        *v3 = *v3 - v1;
        assert_quantum_invariant<T0, T1>(arg0);
        0x2::coin::from_balance<T1>(v2, arg2)
    }

    public fun caps_registered_count<T0, T1>(arg0: &TokenEscrow<T0, T1>) : u64 {
        arg0.outcome_count
    }

    public fun check_balance_sufficiency<T0, T1>(arg0: &TokenEscrow<T0, T1>) : (bool, bool) {
        (arg0.lp_deposited_asset <= 0x2::balance::value<T0>(&arg0.escrowed_asset), arg0.lp_deposited_stable <= 0x2::balance::value<T1>(&arg0.escrowed_stable))
    }

    public fun decrement_lp_backing<T0, T1>(arg0: &mut TokenEscrow<T0, T1>, arg1: u64, arg2: u64, arg3: &0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::escrow_mutation_auth::EscrowMutationAuth) {
        decrement_lp_backing_internal<T0, T1>(arg0, arg1, arg2);
    }

    fun decrement_lp_backing_internal<T0, T1>(arg0: &mut TokenEscrow<T0, T1>, arg1: u64, arg2: u64) {
        assert!(arg0.lp_deposited_asset >= arg1, 8);
        assert!(arg0.lp_deposited_stable >= arg2, 8);
        arg0.lp_deposited_asset = arg0.lp_deposited_asset - arg1;
        arg0.lp_deposited_stable = arg0.lp_deposited_stable - arg2;
    }

    public fun decrement_outcome_allocation<T0, T1>(arg0: &mut TokenEscrow<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: &0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::escrow_mutation_auth::EscrowMutationAuth) {
        let v0 = 0x1::vector::borrow_mut<u64>(&mut arg0.outcome_escrowed_asset, arg1);
        assert!(*v0 >= arg2, 8);
        *v0 = *v0 - arg2;
        let v1 = 0x1::vector::borrow_mut<u64>(&mut arg0.outcome_escrowed_stable, arg1);
        assert!(*v1 >= arg3, 8);
        *v1 = *v1 - arg3;
    }

    public(friend) fun decrement_outcome_escrowed_for_all<T0, T1>(arg0: &mut TokenEscrow<T0, T1>, arg1: bool, arg2: u64) {
        let v0 = 0;
        while (v0 < arg0.outcome_count) {
            if (arg1) {
                let v1 = 0x1::vector::borrow_mut<u64>(&mut arg0.outcome_escrowed_asset, v0);
                assert!(*v1 >= arg2, 103);
                *v1 = *v1 - arg2;
            } else {
                let v2 = 0x1::vector::borrow_mut<u64>(&mut arg0.outcome_escrowed_stable, v0);
                assert!(*v2 >= arg2, 103);
                *v2 = *v2 - arg2;
            };
            v0 = v0 + 1;
        };
    }

    public fun decrement_pool_claim<T0, T1>(arg0: &mut TokenEscrow<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: &0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::escrow_mutation_auth::EscrowMutationAuth) {
        let v0 = 0x2::object::id<TokenEscrow<T0, T1>>(arg0);
        let v1 = 0x1::vector::borrow_mut<u64>(&mut arg0.pool_claim_asset, arg1);
        if (*v1 >= arg2) {
            *v1 = *v1 - arg2;
        } else {
            let v2 = SaturatingSubtractionEvent{
                escrow_id     : v0,
                field         : b"pool_claim_asset",
                outcome_index : arg1,
                requested     : arg2,
                available     : *v1,
            };
            0x2::event::emit<SaturatingSubtractionEvent>(v2);
            *v1 = 0;
        };
        let v3 = 0x1::vector::borrow_mut<u64>(&mut arg0.pool_claim_stable, arg1);
        if (*v3 >= arg3) {
            *v3 = *v3 - arg3;
        } else {
            let v4 = SaturatingSubtractionEvent{
                escrow_id     : v0,
                field         : b"pool_claim_stable",
                outcome_index : arg1,
                requested     : arg3,
                available     : *v3,
            };
            0x2::event::emit<SaturatingSubtractionEvent>(v4);
            *v3 = 0;
        };
    }

    public fun decrement_supplies_for_all_outcomes<T0, T1>(arg0: &mut TokenEscrow<T0, T1>, arg1: u64, arg2: u64, arg3: &0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::escrow_mutation_auth::EscrowMutationAuth) {
        assert!(arg0.outcome_count > 0, 4);
        let v0 = 0;
        while (v0 < arg0.outcome_count) {
            if (arg1 > 0) {
                let v1 = 0x1::vector::borrow_mut<u64>(&mut arg0.asset_supplies, v0);
                assert!(*v1 >= arg1, 103);
                *v1 = *v1 - arg1;
                let v2 = 0x1::vector::borrow_mut<u64>(&mut arg0.outcome_escrowed_asset, v0);
                assert!(*v2 >= arg1, 103);
                *v2 = *v2 - arg1;
                let v3 = 0x1::vector::borrow_mut<u64>(&mut arg0.pool_claim_asset, v0);
                if (*v3 >= arg1) {
                    *v3 = *v3 - arg1;
                } else {
                    *v3 = 0;
                };
            };
            if (arg2 > 0) {
                let v4 = 0x1::vector::borrow_mut<u64>(&mut arg0.stable_supplies, v0);
                assert!(*v4 >= arg2, 103);
                *v4 = *v4 - arg2;
                let v5 = 0x1::vector::borrow_mut<u64>(&mut arg0.outcome_escrowed_stable, v0);
                assert!(*v5 >= arg2, 103);
                *v5 = *v5 - arg2;
                let v6 = 0x1::vector::borrow_mut<u64>(&mut arg0.pool_claim_stable, v0);
                if (*v6 >= arg2) {
                    *v6 = *v6 - arg2;
                } else {
                    *v6 = 0;
                };
            };
            v0 = v0 + 1;
        };
    }

    public fun decrement_supply_for_outcome<T0, T1>(arg0: &mut TokenEscrow<T0, T1>, arg1: u64, arg2: bool, arg3: u64, arg4: &0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::escrow_mutation_auth::EscrowMutationAuth) {
        assert!(arg1 < arg0.outcome_count, 5);
        if (arg2) {
            let v0 = 0x1::vector::borrow_mut<u64>(&mut arg0.asset_supplies, arg1);
            assert!(*v0 >= arg3, 103);
            *v0 = *v0 - arg3;
        } else {
            let v1 = 0x1::vector::borrow_mut<u64>(&mut arg0.stable_supplies, arg1);
            assert!(*v1 >= arg3, 103);
            *v1 = *v1 - arg3;
        };
    }

    public fun decrement_user_backing<T0, T1>(arg0: &mut TokenEscrow<T0, T1>, arg1: u64, arg2: bool, arg3: &0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::escrow_mutation_auth::EscrowMutationAuth) {
        decrement_user_backing_pkg<T0, T1>(arg0, arg1, arg2);
    }

    public(friend) fun decrement_user_backing_pkg<T0, T1>(arg0: &mut TokenEscrow<T0, T1>, arg1: u64, arg2: bool) {
        if (arg2) {
            saturating_decrement_user_asset<T0, T1>(arg0, arg1);
        } else {
            saturating_decrement_user_stable<T0, T1>(arg0, arg1);
        };
    }

    public fun decrement_wrapped_balance<T0, T1>(arg0: &mut TokenEscrow<T0, T1>, arg1: u64, arg2: bool, arg3: u64, arg4: &0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::escrow_mutation_auth::EscrowMutationAuth) {
        decrement_wrapped_balance_pkg<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public(friend) fun decrement_wrapped_balance_pkg<T0, T1>(arg0: &mut TokenEscrow<T0, T1>, arg1: u64, arg2: bool, arg3: u64) {
        if (arg2) {
            let v0 = 0x1::vector::borrow_mut<u64>(&mut arg0.wrapped_asset_balances, arg1);
            assert!(*v0 >= arg3, 8);
            *v0 = *v0 - arg3;
        } else {
            let v1 = 0x1::vector::borrow_mut<u64>(&mut arg0.wrapped_stable_balances, arg1);
            assert!(*v1 >= arg3, 8);
            *v1 = *v1 - arg3;
        };
    }

    public(friend) fun decrement_wrapped_for_all_and_check_invariant<T0, T1>(arg0: &mut TokenEscrow<T0, T1>, arg1: bool, arg2: u64) {
        assert!(arg0.outcome_count > 0, 4);
        let v0 = 0;
        while (v0 < arg0.outcome_count) {
            if (arg1) {
                let v1 = 0x1::vector::borrow_mut<u64>(&mut arg0.wrapped_asset_balances, v0);
                assert!(*v1 >= arg2, 8);
                *v1 = *v1 - arg2;
            } else {
                let v2 = 0x1::vector::borrow_mut<u64>(&mut arg0.wrapped_stable_balances, v0);
                assert!(*v2 >= arg2, 8);
                *v2 = *v2 - arg2;
            };
            v0 = v0 + 1;
        };
        assert_quantum_invariant<T0, T1>(arg0);
    }

    public(friend) fun deposit_spot_asset_for_balance<T0, T1>(arg0: &mut TokenEscrow<T0, T1>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.escrowed_asset, 0x2::coin::into_balance<T0>(arg1));
        arg0.user_deposited_asset = arg0.user_deposited_asset + 0x2::coin::value<T0>(&arg1);
    }

    public fun deposit_spot_liquidity<T0, T1>(arg0: &mut TokenEscrow<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>, arg3: &0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::escrow_mutation_auth::EscrowMutationAuth) {
        0x2::balance::join<T0>(&mut arg0.escrowed_asset, arg1);
        0x2::balance::join<T1>(&mut arg0.escrowed_stable, arg2);
        arg0.lp_deposited_asset = arg0.lp_deposited_asset + 0x2::balance::value<T0>(&arg1);
        arg0.lp_deposited_stable = arg0.lp_deposited_stable + 0x2::balance::value<T1>(&arg2);
    }

    public(friend) fun deposit_spot_stable_for_balance<T0, T1>(arg0: &mut TokenEscrow<T0, T1>, arg1: 0x2::coin::Coin<T1>) {
        0x2::balance::join<T1>(&mut arg0.escrowed_stable, 0x2::coin::into_balance<T1>(arg1));
        arg0.user_deposited_stable = arg0.user_deposited_stable + 0x2::coin::value<T1>(&arg1);
    }

    public fun emergency_remove_asset_treasury_cap<T0, T1, T2>(arg0: &mut TokenEscrow<T0, T1>, arg1: u64, arg2: &0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::emergency_cap::EmergencyCap, arg3: &0x2::clock::Clock) : 0x2::coin::TreasuryCap<T2> {
        0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::emergency_cap::assert_ready(arg2, arg3);
        assert!(arg1 < arg0.outcome_count, 5);
        let v0 = AssetCapKey{outcome_index: arg1};
        0x2::dynamic_field::remove<AssetCapKey, 0x2::coin::TreasuryCap<T2>>(&mut arg0.id, v0)
    }

    public fun emergency_remove_stable_treasury_cap<T0, T1, T2>(arg0: &mut TokenEscrow<T0, T1>, arg1: u64, arg2: &0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::emergency_cap::EmergencyCap, arg3: &0x2::clock::Clock) : 0x2::coin::TreasuryCap<T2> {
        0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::emergency_cap::assert_ready(arg2, arg3);
        assert!(arg1 < arg0.outcome_count, 5);
        let v0 = StableCapKey{outcome_index: arg1};
        0x2::dynamic_field::remove<StableCapKey, 0x2::coin::TreasuryCap<T2>>(&mut arg0.id, v0)
    }

    public fun emergency_withdraw_spot_balances<T0, T1>(arg0: &mut TokenEscrow<T0, T1>, arg1: u64, arg2: u64, arg3: &0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::emergency_cap::EmergencyCap, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::emergency_cap::assert_ready(arg3, arg4);
        let v0 = 0x2::balance::value<T0>(&arg0.escrowed_asset);
        let v1 = 0x2::balance::value<T1>(&arg0.escrowed_stable);
        let v2 = if (arg1 == 0 || arg1 > v0) {
            v0
        } else {
            arg1
        };
        let v3 = if (arg2 == 0 || arg2 > v1) {
            v1
        } else {
            arg2
        };
        let v4 = withdraw_asset_balance_pkg<T0, T1>(arg0, v2, arg5);
        (v4, withdraw_stable_balance_pkg<T0, T1>(arg0, v3, arg5))
    }

    public fun finish_recombine_asset_progress<T0, T1>(arg0: RecombineAssetProgress<T0, T1>, arg1: &mut TokenEscrow<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let RecombineAssetProgress {
            market_id     : v0,
            amount        : v1,
            outcome_count : v2,
            next_outcome  : v3,
        } = arg0;
        assert!(v3 == v2, 1);
        assert!(market_state_id<T0, T1>(arg1) == v0, 2);
        saturating_decrement_user_asset<T0, T1>(arg1, v1);
        let v4 = withdraw_asset_balance_pkg<T0, T1>(arg1, v1, arg2);
        assert_quantum_invariant<T0, T1>(arg1);
        v4
    }

    public fun finish_recombine_stable_progress<T0, T1>(arg0: RecombineStableProgress<T0, T1>, arg1: &mut TokenEscrow<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let RecombineStableProgress {
            market_id     : v0,
            amount        : v1,
            outcome_count : v2,
            next_outcome  : v3,
        } = arg0;
        assert!(v3 == v2, 1);
        assert!(market_state_id<T0, T1>(arg1) == v0, 2);
        saturating_decrement_user_stable<T0, T1>(arg1, v1);
        let v4 = withdraw_stable_balance_pkg<T0, T1>(arg1, v1, arg2);
        assert_quantum_invariant<T0, T1>(arg1);
        v4
    }

    public fun finish_split_asset_progress<T0, T1>(arg0: SplitAssetProgress<T0, T1>, arg1: &TokenEscrow<T0, T1>) {
        let SplitAssetProgress {
            market_id     : v0,
            amount        : _,
            outcome_count : v2,
            next_outcome  : v3,
        } = arg0;
        assert!(v3 == v2, 1);
        assert!(market_state_id<T0, T1>(arg1) == v0, 2);
        assert_quantum_invariant<T0, T1>(arg1);
    }

    public fun finish_split_stable_progress<T0, T1>(arg0: SplitStableProgress<T0, T1>, arg1: &TokenEscrow<T0, T1>) {
        let SplitStableProgress {
            market_id     : v0,
            amount        : _,
            outcome_count : v2,
            next_outcome  : v3,
        } = arg0;
        assert!(v3 == v2, 1);
        assert!(market_state_id<T0, T1>(arg1) == v0, 2);
        assert_quantum_invariant<T0, T1>(arg1);
    }

    public fun get_all_asset_supplies<T0, T1>(arg0: &TokenEscrow<T0, T1>) : &vector<u64> {
        &arg0.asset_supplies
    }

    public fun get_all_stable_supplies<T0, T1>(arg0: &TokenEscrow<T0, T1>) : &vector<u64> {
        &arg0.stable_supplies
    }

    public fun get_all_supplies<T0, T1>(arg0: &TokenEscrow<T0, T1>) : (vector<u64>, vector<u64>) {
        (arg0.asset_supplies, arg0.stable_supplies)
    }

    public fun get_all_tracking<T0, T1>(arg0: &TokenEscrow<T0, T1>) : (u64, u64, u64, u64, u64, u64) {
        (0x2::balance::value<T0>(&arg0.escrowed_asset), 0x2::balance::value<T1>(&arg0.escrowed_stable), arg0.lp_deposited_asset, arg0.lp_deposited_stable, arg0.user_deposited_asset, arg0.user_deposited_stable)
    }

    public fun get_asset_supply<T0, T1, T2>(arg0: &TokenEscrow<T0, T1>, arg1: u64) : u64 {
        let v0 = AssetCapKey{outcome_index: arg1};
        0x2::coin::total_supply<T2>(0x2::dynamic_field::borrow<AssetCapKey, 0x2::coin::TreasuryCap<T2>>(&arg0.id, v0))
    }

    public fun get_collected_protocol_fees<T0, T1>(arg0: &TokenEscrow<T0, T1>) : (u64, u64) {
        (arg0.collected_protocol_fees_asset, arg0.collected_protocol_fees_stable)
    }

    public fun get_dust_created_asset<T0, T1>(arg0: &TokenEscrow<T0, T1>, arg1: u64) : u64 {
        *0x1::vector::borrow<u64>(&arg0.dust_created_asset, arg1)
    }

    public fun get_dust_created_stable<T0, T1>(arg0: &TokenEscrow<T0, T1>, arg1: u64) : u64 {
        *0x1::vector::borrow<u64>(&arg0.dust_created_stable, arg1)
    }

    public fun get_escrowed_asset_balance<T0, T1>(arg0: &TokenEscrow<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.escrowed_asset)
    }

    public fun get_escrowed_stable_balance<T0, T1>(arg0: &TokenEscrow<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.escrowed_stable)
    }

    public fun get_lp_deposited_asset<T0, T1>(arg0: &TokenEscrow<T0, T1>) : u64 {
        arg0.lp_deposited_asset
    }

    public fun get_lp_deposited_stable<T0, T1>(arg0: &TokenEscrow<T0, T1>) : u64 {
        arg0.lp_deposited_stable
    }

    public fun get_market_state<T0, T1>(arg0: &TokenEscrow<T0, T1>) : &0x962f4be9d1940d6c57cc1da8bfff797a57be714456b6e5a742415e1f102053b6::market_state::MarketState {
        &arg0.market_state
    }

    public fun get_market_state_mut<T0, T1>(arg0: &mut TokenEscrow<T0, T1>, arg1: &0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::escrow_mutation_auth::EscrowMutationAuth) : &mut 0x962f4be9d1940d6c57cc1da8bfff797a57be714456b6e5a742415e1f102053b6::market_state::MarketState {
        &mut arg0.market_state
    }

    public fun get_outcome_asset_supply<T0, T1>(arg0: &TokenEscrow<T0, T1>, arg1: u64) : u64 {
        *0x1::vector::borrow<u64>(&arg0.asset_supplies, arg1)
    }

    public fun get_outcome_escrowed_asset<T0, T1>(arg0: &TokenEscrow<T0, T1>, arg1: u64) : u64 {
        *0x1::vector::borrow<u64>(&arg0.outcome_escrowed_asset, arg1)
    }

    public fun get_outcome_escrowed_stable<T0, T1>(arg0: &TokenEscrow<T0, T1>, arg1: u64) : u64 {
        *0x1::vector::borrow<u64>(&arg0.outcome_escrowed_stable, arg1)
    }

    public fun get_outcome_stable_supply<T0, T1>(arg0: &TokenEscrow<T0, T1>, arg1: u64) : u64 {
        *0x1::vector::borrow<u64>(&arg0.stable_supplies, arg1)
    }

    public fun get_outcome_wrapped_asset<T0, T1>(arg0: &TokenEscrow<T0, T1>, arg1: u64) : u64 {
        *0x1::vector::borrow<u64>(&arg0.wrapped_asset_balances, arg1)
    }

    public fun get_outcome_wrapped_stable<T0, T1>(arg0: &TokenEscrow<T0, T1>, arg1: u64) : u64 {
        *0x1::vector::borrow<u64>(&arg0.wrapped_stable_balances, arg1)
    }

    public fun get_pool_claim_asset<T0, T1>(arg0: &TokenEscrow<T0, T1>, arg1: u64) : u64 {
        *0x1::vector::borrow<u64>(&arg0.pool_claim_asset, arg1)
    }

    public fun get_pool_claim_stable<T0, T1>(arg0: &TokenEscrow<T0, T1>, arg1: u64) : u64 {
        *0x1::vector::borrow<u64>(&arg0.pool_claim_stable, arg1)
    }

    public fun get_spot_balances<T0, T1>(arg0: &TokenEscrow<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.escrowed_asset), 0x2::balance::value<T1>(&arg0.escrowed_stable))
    }

    public fun get_stable_supply<T0, T1, T2>(arg0: &TokenEscrow<T0, T1>, arg1: u64) : u64 {
        let v0 = StableCapKey{outcome_index: arg1};
        0x2::coin::total_supply<T2>(0x2::dynamic_field::borrow<StableCapKey, 0x2::coin::TreasuryCap<T2>>(&arg0.id, v0))
    }

    public fun get_user_deposited_asset<T0, T1>(arg0: &TokenEscrow<T0, T1>) : u64 {
        arg0.user_deposited_asset
    }

    public fun get_user_deposited_stable<T0, T1>(arg0: &TokenEscrow<T0, T1>) : u64 {
        arg0.user_deposited_stable
    }

    public fun get_wrapped_balances<T0, T1>(arg0: &TokenEscrow<T0, T1>) : (vector<u64>, vector<u64>) {
        (arg0.wrapped_asset_balances, arg0.wrapped_stable_balances)
    }

    public fun increment_dust_created<T0, T1>(arg0: &mut TokenEscrow<T0, T1>, arg1: u64, arg2: bool, arg3: u64, arg4: &0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::escrow_mutation_auth::EscrowMutationAuth) {
        if (arg2) {
            let v0 = 0x1::vector::borrow_mut<u64>(&mut arg0.dust_created_asset, arg1);
            *v0 = *v0 + arg3;
        } else {
            let v1 = 0x1::vector::borrow_mut<u64>(&mut arg0.dust_created_stable, arg1);
            *v1 = *v1 + arg3;
        };
    }

    public(friend) fun increment_outcome_escrowed_for_all<T0, T1>(arg0: &mut TokenEscrow<T0, T1>, arg1: bool, arg2: u64) {
        let v0 = 0;
        while (v0 < arg0.outcome_count) {
            if (arg1) {
                let v1 = 0x1::vector::borrow_mut<u64>(&mut arg0.outcome_escrowed_asset, v0);
                *v1 = *v1 + arg2;
            } else {
                let v2 = 0x1::vector::borrow_mut<u64>(&mut arg0.outcome_escrowed_stable, v0);
                *v2 = *v2 + arg2;
            };
            v0 = v0 + 1;
        };
    }

    public fun increment_supplies_for_all_outcomes<T0, T1>(arg0: &mut TokenEscrow<T0, T1>, arg1: u64, arg2: u64, arg3: &0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::escrow_mutation_auth::EscrowMutationAuth) {
        assert!(arg0.outcome_count > 0, 4);
        let v0 = 0;
        while (v0 < arg0.outcome_count) {
            if (arg1 > 0) {
                let v1 = 0x1::vector::borrow_mut<u64>(&mut arg0.asset_supplies, v0);
                *v1 = *v1 + arg1;
                let v2 = 0x1::vector::borrow_mut<u64>(&mut arg0.outcome_escrowed_asset, v0);
                *v2 = *v2 + arg1;
                let v3 = 0x1::vector::borrow_mut<u64>(&mut arg0.pool_claim_asset, v0);
                *v3 = *v3 + arg1;
            };
            if (arg2 > 0) {
                let v4 = 0x1::vector::borrow_mut<u64>(&mut arg0.stable_supplies, v0);
                *v4 = *v4 + arg2;
                let v5 = 0x1::vector::borrow_mut<u64>(&mut arg0.outcome_escrowed_stable, v0);
                *v5 = *v5 + arg2;
                let v6 = 0x1::vector::borrow_mut<u64>(&mut arg0.pool_claim_stable, v0);
                *v6 = *v6 + arg2;
            };
            v0 = v0 + 1;
        };
    }

    public fun increment_wrapped_balance<T0, T1>(arg0: &mut TokenEscrow<T0, T1>, arg1: u64, arg2: bool, arg3: u64, arg4: &0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::escrow_mutation_auth::EscrowMutationAuth) {
        increment_wrapped_balance_pkg<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public(friend) fun increment_wrapped_balance_pkg<T0, T1>(arg0: &mut TokenEscrow<T0, T1>, arg1: u64, arg2: bool, arg3: u64) {
        if (arg2) {
            let v0 = 0x1::vector::borrow_mut<u64>(&mut arg0.wrapped_asset_balances, arg1);
            *v0 = *v0 + arg3;
        } else {
            let v1 = 0x1::vector::borrow_mut<u64>(&mut arg0.wrapped_stable_balances, arg1);
            *v1 = *v1 + arg3;
        };
    }

    public(friend) fun increment_wrapped_for_all_and_check_invariant<T0, T1>(arg0: &mut TokenEscrow<T0, T1>, arg1: bool, arg2: u64) {
        assert!(arg0.outcome_count > 0, 4);
        let v0 = 0;
        while (v0 < arg0.outcome_count) {
            if (arg1) {
                let v1 = 0x1::vector::borrow_mut<u64>(&mut arg0.wrapped_asset_balances, v0);
                *v1 = *v1 + arg2;
            } else {
                let v2 = 0x1::vector::borrow_mut<u64>(&mut arg0.wrapped_stable_balances, v0);
                *v2 = *v2 + arg2;
            };
            v0 = v0 + 1;
        };
        assert_quantum_invariant<T0, T1>(arg0);
    }

    public fun lp_deposit_quantum<T0, T1>(arg0: &mut TokenEscrow<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>, arg3: &0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::escrow_mutation_auth::EscrowMutationAuth) : (u64, u64) {
        assert!(arg0.outcome_count > 0, 4);
        let v0 = 0x2::balance::value<T0>(&arg1);
        let v1 = 0x2::balance::value<T1>(&arg2);
        0x2::balance::join<T0>(&mut arg0.escrowed_asset, arg1);
        0x2::balance::join<T1>(&mut arg0.escrowed_stable, arg2);
        arg0.lp_deposited_asset = arg0.lp_deposited_asset + v0;
        arg0.lp_deposited_stable = arg0.lp_deposited_stable + v1;
        let v2 = 0;
        while (v2 < arg0.outcome_count) {
            let v3 = 0x1::vector::borrow_mut<u64>(&mut arg0.asset_supplies, v2);
            *v3 = *v3 + v0;
            let v4 = 0x1::vector::borrow_mut<u64>(&mut arg0.stable_supplies, v2);
            *v4 = *v4 + v1;
            let v5 = 0x1::vector::borrow_mut<u64>(&mut arg0.outcome_escrowed_asset, v2);
            *v5 = *v5 + v0;
            let v6 = 0x1::vector::borrow_mut<u64>(&mut arg0.outcome_escrowed_stable, v2);
            *v6 = *v6 + v1;
            let v7 = 0x1::vector::borrow_mut<u64>(&mut arg0.pool_claim_asset, v2);
            *v7 = *v7 + v0;
            let v8 = 0x1::vector::borrow_mut<u64>(&mut arg0.pool_claim_stable, v2);
            *v8 = *v8 + v1;
            v2 = v2 + 1;
        };
        assert_accounting_invariant<T0, T1>(arg0);
        assert_quantum_invariant<T0, T1>(arg0);
        (v0, v1)
    }

    public fun lp_withdraw_quantum<T0, T1>(arg0: &mut TokenEscrow<T0, T1>, arg1: u64, arg2: u64, arg3: &0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::escrow_mutation_auth::EscrowMutationAuth, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x962f4be9d1940d6c57cc1da8bfff797a57be714456b6e5a742415e1f102053b6::market_state::is_finalized(&arg0.market_state), 101);
        let v0 = 0x962f4be9d1940d6c57cc1da8bfff797a57be714456b6e5a742415e1f102053b6::market_state::get_winning_outcome(&arg0.market_state);
        let v1 = 0x2::balance::value<T0>(&arg0.escrowed_asset);
        let v2 = 0x2::balance::value<T1>(&arg0.escrowed_stable);
        let v3 = arg0.lp_deposited_asset;
        let v4 = arg0.lp_deposited_stable;
        let v5 = *0x1::vector::borrow<u64>(&arg0.asset_supplies, v0);
        let v6 = *0x1::vector::borrow<u64>(&arg0.stable_supplies, v0);
        let v7 = *0x1::vector::borrow<u64>(&arg0.outcome_escrowed_asset, v0);
        let v8 = *0x1::vector::borrow<u64>(&arg0.outcome_escrowed_stable, v0);
        let v9 = *0x1::vector::borrow<u64>(&arg0.pool_claim_asset, v0);
        let v10 = *0x1::vector::borrow<u64>(&arg0.pool_claim_stable, v0);
        let v11 = if (v7 > v9) {
            v7 - v9
        } else {
            0
        };
        let v12 = if (v8 > v10) {
            v8 - v10
        } else {
            0
        };
        let v13 = if (v1 > v11) {
            v1 - v11
        } else {
            0
        };
        let v14 = if (v2 > v12) {
            v2 - v12
        } else {
            0
        };
        let v15 = if (v3 < v5) {
            v3
        } else {
            v5
        };
        let v16 = if (v15 < v13) {
            v15
        } else {
            v13
        };
        let v17 = if (v16 < v9) {
            v16
        } else {
            v9
        };
        let v18 = if (v4 < v6) {
            v4
        } else {
            v6
        };
        let v19 = if (v18 < v14) {
            v18
        } else {
            v14
        };
        let v20 = if (v19 < v10) {
            v19
        } else {
            v10
        };
        let v21 = if (arg1 < v17) {
            arg1
        } else {
            v17
        };
        let v22 = if (arg2 < v20) {
            arg2
        } else {
            v20
        };
        if (v21 > 0) {
            let v23 = 0x1::vector::borrow_mut<u64>(&mut arg0.asset_supplies, v0);
            *v23 = *v23 - v21;
            let v24 = 0x1::vector::borrow_mut<u64>(&mut arg0.outcome_escrowed_asset, v0);
            *v24 = *v24 - v21;
            let v25 = 0x1::vector::borrow_mut<u64>(&mut arg0.pool_claim_asset, v0);
            if (*v25 >= v21) {
                *v25 = *v25 - v21;
            } else {
                *v25 = 0;
            };
        };
        if (v22 > 0) {
            let v26 = 0x1::vector::borrow_mut<u64>(&mut arg0.stable_supplies, v0);
            *v26 = *v26 - v22;
            let v27 = 0x1::vector::borrow_mut<u64>(&mut arg0.outcome_escrowed_stable, v0);
            *v27 = *v27 - v22;
            let v28 = 0x1::vector::borrow_mut<u64>(&mut arg0.pool_claim_stable, v0);
            if (*v28 >= v22) {
                *v28 = *v28 - v22;
            } else {
                *v28 = 0;
            };
        };
        decrement_lp_backing_internal<T0, T1>(arg0, v21, v22);
        let v29 = withdraw_asset_balance_pkg<T0, T1>(arg0, v21, arg4);
        let v30 = withdraw_stable_balance_pkg<T0, T1>(arg0, v22, arg4);
        assert_quantum_invariant<T0, T1>(arg0);
        (v29, v30)
    }

    public fun market_state_id<T0, T1>(arg0: &TokenEscrow<T0, T1>) : 0x2::object::ID {
        0x2::object::id<0x962f4be9d1940d6c57cc1da8bfff797a57be714456b6e5a742415e1f102053b6::market_state::MarketState>(&arg0.market_state)
    }

    public fun mint_conditional<T0, T1, T2>(arg0: &mut TokenEscrow<T0, T1>, arg1: u64, arg2: bool, arg3: u64, arg4: &mut 0x2::tx_context::TxContext, arg5: &0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::escrow_mutation_auth::EscrowMutationAuth) : 0x2::coin::Coin<T2> {
        mint_conditional_pkg<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4)
    }

    public(friend) fun mint_conditional_asset<T0, T1, T2>(arg0: &mut TokenEscrow<T0, T1>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert!(arg1 < arg0.outcome_count, 5);
        let v0 = AssetCapKey{outcome_index: arg1};
        let v1 = 0x1::vector::borrow_mut<u64>(&mut arg0.asset_supplies, arg1);
        *v1 = *v1 + arg2;
        0x2::coin::mint<T2>(0x2::dynamic_field::borrow_mut<AssetCapKey, 0x2::coin::TreasuryCap<T2>>(&mut arg0.id, v0), arg2, arg3)
    }

    public(friend) fun mint_conditional_pkg<T0, T1, T2>(arg0: &mut TokenEscrow<T0, T1>, arg1: u64, arg2: bool, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        if (arg2) {
            mint_conditional_asset<T0, T1, T2>(arg0, arg1, arg3, arg4)
        } else {
            mint_conditional_stable<T0, T1, T2>(arg0, arg1, arg3, arg4)
        }
    }

    public(friend) fun mint_conditional_stable<T0, T1, T2>(arg0: &mut TokenEscrow<T0, T1>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert!(arg1 < arg0.outcome_count, 5);
        let v0 = StableCapKey{outcome_index: arg1};
        let v1 = 0x1::vector::borrow_mut<u64>(&mut arg0.stable_supplies, arg1);
        *v1 = *v1 + arg2;
        0x2::coin::mint<T2>(0x2::dynamic_field::borrow_mut<StableCapKey, 0x2::coin::TreasuryCap<T2>>(&mut arg0.id, v0), arg2, arg3)
    }

    public fun quantum_invariant_error() : u64 {
        201
    }

    public fun recombine_asset_progress_step<T0, T1, T2>(arg0: RecombineAssetProgress<T0, T1>, arg1: &mut TokenEscrow<T0, T1>, arg2: u64, arg3: 0x2::coin::Coin<T2>) : RecombineAssetProgress<T0, T1> {
        assert!(market_state_id<T0, T1>(arg1) == arg0.market_id, 2);
        assert!(arg0.next_outcome < arg0.outcome_count, 5);
        assert!(arg2 == arg0.next_outcome, 1);
        assert!(0x2::coin::value<T2>(&arg3) == arg0.amount, 0);
        burn_conditional_asset<T0, T1, T2>(arg1, arg2, arg3);
        let v0 = 0x1::vector::borrow_mut<u64>(&mut arg1.outcome_escrowed_asset, arg2);
        assert!(*v0 >= arg0.amount, 103);
        *v0 = *v0 - arg0.amount;
        arg0.next_outcome = arg0.next_outcome + 1;
        arg0
    }

    public fun recombine_stable_progress_step<T0, T1, T2>(arg0: RecombineStableProgress<T0, T1>, arg1: &mut TokenEscrow<T0, T1>, arg2: u64, arg3: 0x2::coin::Coin<T2>) : RecombineStableProgress<T0, T1> {
        assert!(market_state_id<T0, T1>(arg1) == arg0.market_id, 2);
        assert!(arg0.next_outcome < arg0.outcome_count, 5);
        assert!(arg2 == arg0.next_outcome, 1);
        assert!(0x2::coin::value<T2>(&arg3) == arg0.amount, 0);
        burn_conditional_stable<T0, T1, T2>(arg1, arg2, arg3);
        let v0 = 0x1::vector::borrow_mut<u64>(&mut arg1.outcome_escrowed_stable, arg2);
        assert!(*v0 >= arg0.amount, 103);
        *v0 = *v0 - arg0.amount;
        arg0.next_outcome = arg0.next_outcome + 1;
        arg0
    }

    public fun register_conditional_caps<T0, T1, T2, T3>(arg0: &mut TokenEscrow<T0, T1>, arg1: u64, arg2: 0x2::coin::TreasuryCap<T2>, arg3: 0x2::coin::TreasuryCap<T3>) {
        assert!(arg1 < 0x962f4be9d1940d6c57cc1da8bfff797a57be714456b6e5a742415e1f102053b6::market_state::outcome_count(&arg0.market_state), 5);
        assert!(arg1 == arg0.outcome_count, 1);
        let v0 = AssetCapKey{outcome_index: arg1};
        let v1 = StableCapKey{outcome_index: arg1};
        0x2::dynamic_field::add<AssetCapKey, 0x2::coin::TreasuryCap<T2>>(&mut arg0.id, v0, arg2);
        0x2::dynamic_field::add<StableCapKey, 0x2::coin::TreasuryCap<T3>>(&mut arg0.id, v1, arg3);
        0x1::vector::push_back<u64>(&mut arg0.asset_supplies, 0);
        0x1::vector::push_back<u64>(&mut arg0.stable_supplies, 0);
        0x1::vector::push_back<u64>(&mut arg0.wrapped_asset_balances, 0);
        0x1::vector::push_back<u64>(&mut arg0.wrapped_stable_balances, 0);
        0x1::vector::push_back<u64>(&mut arg0.dust_created_asset, 0);
        0x1::vector::push_back<u64>(&mut arg0.dust_created_stable, 0);
        0x1::vector::push_back<u64>(&mut arg0.outcome_escrowed_asset, 0);
        0x1::vector::push_back<u64>(&mut arg0.outcome_escrowed_stable, 0);
        0x1::vector::push_back<u64>(&mut arg0.pool_claim_asset, 0);
        0x1::vector::push_back<u64>(&mut arg0.pool_claim_stable, 0);
        arg0.outcome_count = arg0.outcome_count + 1;
    }

    fun saturating_decrement_user_asset<T0, T1>(arg0: &mut TokenEscrow<T0, T1>, arg1: u64) {
        if (arg0.user_deposited_asset >= arg1) {
            arg0.user_deposited_asset = arg0.user_deposited_asset - arg1;
        } else {
            let v0 = SaturatingSubtractionEvent{
                escrow_id     : 0x2::object::id<TokenEscrow<T0, T1>>(arg0),
                field         : b"user_deposited_asset",
                outcome_index : 18446744073709551615,
                requested     : arg1,
                available     : arg0.user_deposited_asset,
            };
            0x2::event::emit<SaturatingSubtractionEvent>(v0);
            arg0.user_deposited_asset = 0;
        };
    }

    fun saturating_decrement_user_stable<T0, T1>(arg0: &mut TokenEscrow<T0, T1>, arg1: u64) {
        if (arg0.user_deposited_stable >= arg1) {
            arg0.user_deposited_stable = arg0.user_deposited_stable - arg1;
        } else {
            let v0 = SaturatingSubtractionEvent{
                escrow_id     : 0x2::object::id<TokenEscrow<T0, T1>>(arg0),
                field         : b"user_deposited_stable",
                outcome_index : 18446744073709551615,
                requested     : arg1,
                available     : arg0.user_deposited_stable,
            };
            0x2::event::emit<SaturatingSubtractionEvent>(v0);
            arg0.user_deposited_stable = 0;
        };
    }

    public fun split_asset_progress_step<T0, T1, T2>(arg0: SplitAssetProgress<T0, T1>, arg1: &mut TokenEscrow<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (SplitAssetProgress<T0, T1>, 0x2::coin::Coin<T2>) {
        assert!(market_state_id<T0, T1>(arg1) == arg0.market_id, 2);
        assert!(arg0.next_outcome < arg0.outcome_count, 5);
        assert!(arg2 == arg0.next_outcome, 1);
        let v0 = 0x1::vector::borrow_mut<u64>(&mut arg1.outcome_escrowed_asset, arg2);
        *v0 = *v0 + arg0.amount;
        arg0.next_outcome = arg0.next_outcome + 1;
        (arg0, mint_conditional_asset<T0, T1, T2>(arg1, arg2, arg0.amount, arg3))
    }

    public fun split_stable_progress_step<T0, T1, T2>(arg0: SplitStableProgress<T0, T1>, arg1: &mut TokenEscrow<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (SplitStableProgress<T0, T1>, 0x2::coin::Coin<T2>) {
        assert!(market_state_id<T0, T1>(arg1) == arg0.market_id, 2);
        assert!(arg0.next_outcome < arg0.outcome_count, 5);
        assert!(arg2 == arg0.next_outcome, 1);
        let v0 = 0x1::vector::borrow_mut<u64>(&mut arg1.outcome_escrowed_stable, arg2);
        *v0 = *v0 + arg0.amount;
        arg0.next_outcome = arg0.next_outcome + 1;
        (arg0, mint_conditional_stable<T0, T1, T2>(arg1, arg2, arg0.amount, arg3))
    }

    public fun start_recombine_asset_progress<T0, T1, T2>(arg0: &mut TokenEscrow<T0, T1>, arg1: u64, arg2: 0x2::coin::Coin<T2>) : RecombineAssetProgress<T0, T1> {
        assert!(arg1 == 0, 1);
        let v0 = caps_registered_count<T0, T1>(arg0);
        assert!(v0 > 0, 4);
        assert!(arg1 < v0, 5);
        let v1 = 0x2::coin::value<T2>(&arg2);
        assert!(v1 > 0, 13);
        burn_conditional_asset<T0, T1, T2>(arg0, arg1, arg2);
        let v2 = 0x1::vector::borrow_mut<u64>(&mut arg0.outcome_escrowed_asset, arg1);
        assert!(*v2 >= v1, 103);
        *v2 = *v2 - v1;
        RecombineAssetProgress<T0, T1>{
            market_id     : market_state_id<T0, T1>(arg0),
            amount        : v1,
            outcome_count : v0,
            next_outcome  : 1,
        }
    }

    public fun start_recombine_stable_progress<T0, T1, T2>(arg0: &mut TokenEscrow<T0, T1>, arg1: u64, arg2: 0x2::coin::Coin<T2>) : RecombineStableProgress<T0, T1> {
        assert!(arg1 == 0, 1);
        let v0 = caps_registered_count<T0, T1>(arg0);
        assert!(v0 > 0, 4);
        assert!(arg1 < v0, 5);
        let v1 = 0x2::coin::value<T2>(&arg2);
        assert!(v1 > 0, 13);
        burn_conditional_stable<T0, T1, T2>(arg0, arg1, arg2);
        let v2 = 0x1::vector::borrow_mut<u64>(&mut arg0.outcome_escrowed_stable, arg1);
        assert!(*v2 >= v1, 103);
        *v2 = *v2 - v1;
        RecombineStableProgress<T0, T1>{
            market_id     : market_state_id<T0, T1>(arg0),
            amount        : v1,
            outcome_count : v0,
            next_outcome  : 1,
        }
    }

    public fun start_split_asset_progress<T0, T1>(arg0: &mut TokenEscrow<T0, T1>, arg1: 0x2::coin::Coin<T0>) : SplitAssetProgress<T0, T1> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 13);
        let v1 = caps_registered_count<T0, T1>(arg0);
        assert!(v1 > 0, 4);
        0x2::balance::join<T0>(&mut arg0.escrowed_asset, 0x2::coin::into_balance<T0>(arg1));
        arg0.user_deposited_asset = arg0.user_deposited_asset + v0;
        SplitAssetProgress<T0, T1>{
            market_id     : market_state_id<T0, T1>(arg0),
            amount        : v0,
            outcome_count : v1,
            next_outcome  : 0,
        }
    }

    public fun start_split_stable_progress<T0, T1>(arg0: &mut TokenEscrow<T0, T1>, arg1: 0x2::coin::Coin<T1>) : SplitStableProgress<T0, T1> {
        let v0 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 > 0, 13);
        let v1 = caps_registered_count<T0, T1>(arg0);
        assert!(v1 > 0, 4);
        0x2::balance::join<T1>(&mut arg0.escrowed_stable, 0x2::coin::into_balance<T1>(arg1));
        arg0.user_deposited_stable = arg0.user_deposited_stable + v0;
        SplitStableProgress<T0, T1>{
            market_id     : market_state_id<T0, T1>(arg0),
            amount        : v0,
            outcome_count : v1,
            next_outcome  : 0,
        }
    }

    public fun track_collected_protocol_fees<T0, T1>(arg0: &mut TokenEscrow<T0, T1>, arg1: u64, arg2: u64, arg3: &0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::escrow_mutation_auth::EscrowMutationAuth) {
        arg0.collected_protocol_fees_asset = arg0.collected_protocol_fees_asset + arg1;
        arg0.collected_protocol_fees_stable = arg0.collected_protocol_fees_stable + arg2;
    }

    public fun track_swap_asset_to_stable<T0, T1>(arg0: &mut TokenEscrow<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: &0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::escrow_mutation_auth::EscrowMutationAuth) {
        let v0 = 0x1::vector::borrow_mut<u64>(&mut arg0.outcome_escrowed_asset, arg1);
        assert!(*v0 >= arg2, 103);
        let v1 = 0x1::vector::borrow_mut<u64>(&mut arg0.outcome_escrowed_stable, arg1);
        assert!(*v1 <= 18446744073709551615 - arg3, 104);
        *v0 = *v0 - arg2;
        *v1 = *v1 + arg3;
    }

    public fun track_swap_stable_to_asset<T0, T1>(arg0: &mut TokenEscrow<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: &0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::escrow_mutation_auth::EscrowMutationAuth) {
        let v0 = 0x1::vector::borrow_mut<u64>(&mut arg0.outcome_escrowed_stable, arg1);
        assert!(*v0 >= arg2, 103);
        let v1 = 0x1::vector::borrow_mut<u64>(&mut arg0.outcome_escrowed_asset, arg1);
        assert!(*v1 <= 18446744073709551615 - arg3, 104);
        *v0 = *v0 - arg2;
        *v1 = *v1 + arg3;
    }

    public fun track_system_swap_asset_to_stable<T0, T1>(arg0: &mut TokenEscrow<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: &0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::escrow_mutation_auth::EscrowMutationAuth) {
        let v0 = 0x1::vector::borrow_mut<u64>(&mut arg0.asset_supplies, arg1);
        assert!(*v0 >= arg2, 103);
        *v0 = *v0 - arg2;
        let v1 = 0x1::vector::borrow_mut<u64>(&mut arg0.stable_supplies, arg1);
        assert!(*v1 <= 18446744073709551615 - arg3, 104);
        *v1 = *v1 + arg3;
        let v2 = 0x1::vector::borrow_mut<u64>(&mut arg0.outcome_escrowed_asset, arg1);
        assert!(*v2 >= arg2, 103);
        *v2 = *v2 - arg2;
        let v3 = 0x1::vector::borrow_mut<u64>(&mut arg0.outcome_escrowed_stable, arg1);
        assert!(*v3 <= 18446744073709551615 - arg3, 104);
        *v3 = *v3 + arg3;
        let v4 = 0x1::vector::borrow_mut<u64>(&mut arg0.pool_claim_asset, arg1);
        if (*v4 >= arg2) {
            *v4 = *v4 - arg2;
        } else {
            *v4 = 0;
        };
        let v5 = 0x1::vector::borrow_mut<u64>(&mut arg0.pool_claim_stable, arg1);
        *v5 = *v5 + arg3;
    }

    public fun track_system_swap_stable_to_asset<T0, T1>(arg0: &mut TokenEscrow<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: &0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::escrow_mutation_auth::EscrowMutationAuth) {
        let v0 = 0x1::vector::borrow_mut<u64>(&mut arg0.stable_supplies, arg1);
        assert!(*v0 >= arg2, 103);
        *v0 = *v0 - arg2;
        let v1 = 0x1::vector::borrow_mut<u64>(&mut arg0.asset_supplies, arg1);
        assert!(*v1 <= 18446744073709551615 - arg3, 104);
        *v1 = *v1 + arg3;
        let v2 = 0x1::vector::borrow_mut<u64>(&mut arg0.outcome_escrowed_stable, arg1);
        assert!(*v2 >= arg2, 103);
        *v2 = *v2 - arg2;
        let v3 = 0x1::vector::borrow_mut<u64>(&mut arg0.outcome_escrowed_asset, arg1);
        assert!(*v3 <= 18446744073709551615 - arg3, 104);
        *v3 = *v3 + arg3;
        let v4 = 0x1::vector::borrow_mut<u64>(&mut arg0.pool_claim_stable, arg1);
        if (*v4 >= arg2) {
            *v4 = *v4 - arg2;
        } else {
            *v4 = 0;
        };
        let v5 = 0x1::vector::borrow_mut<u64>(&mut arg0.pool_claim_asset, arg1);
        *v5 = *v5 + arg3;
    }

    public fun withdraw_asset_balance<T0, T1>(arg0: &mut TokenEscrow<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext, arg3: &0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::escrow_mutation_auth::EscrowMutationAuth) : 0x2::coin::Coin<T0> {
        withdraw_asset_balance_pkg<T0, T1>(arg0, arg1, arg2)
    }

    public(friend) fun withdraw_asset_balance_pkg<T0, T1>(arg0: &mut TokenEscrow<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::balance::value<T0>(&arg0.escrowed_asset) >= arg1, 8);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.escrowed_asset, arg1), arg2)
    }

    public fun withdraw_stable_balance<T0, T1>(arg0: &mut TokenEscrow<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext, arg3: &0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::escrow_mutation_auth::EscrowMutationAuth) : 0x2::coin::Coin<T1> {
        withdraw_stable_balance_pkg<T0, T1>(arg0, arg1, arg2)
    }

    public(friend) fun withdraw_stable_balance_pkg<T0, T1>(arg0: &mut TokenEscrow<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x2::balance::value<T1>(&arg0.escrowed_stable) >= arg1, 8);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.escrowed_stable, arg1), arg2)
    }

    // decompiled from Move bytecode v6
}

