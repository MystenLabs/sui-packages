module 0x57b8e9b99cf932009676254b23eb570b83906d0f501a5132cf4ec38a2e2f85f8::swap_entry {
    struct SpotSwap has copy, drop {
        pool_id: 0x2::object::ID,
        is_buy: bool,
        amount_in: u64,
        amount_out: u64,
        sender: address,
        recipient: address,
        asset_reserve: u64,
        stable_reserve: u64,
    }

    struct SpotPoolMutationWitness has drop {
        dummy_field: bool,
    }

    struct EscrowReceipt {
        pool_id: 0x2::object::ID,
        escrow_id: 0x2::object::ID,
    }

    struct ConditionalSwapBatch<phantom T0, phantom T1> {
        balance: 0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::conditional_balance::ConditionalMarketBalance<T0, T1>,
        market_id: 0x2::object::ID,
    }

    public fun begin_conditional_swaps<T0, T1>(arg0: &0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::coin_escrow::TokenEscrow<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : ConditionalSwapBatch<T0, T1> {
        let v0 = 0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::coin_escrow::get_market_state<T0, T1>(arg0);
        0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::market_state::assert_swaps_allowed(v0, arg1);
        let v1 = 0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::market_state::market_id(v0);
        ConditionalSwapBatch<T0, T1>{
            balance   : 0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::conditional_balance::new<T0, T1>(v1, (0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::market_state::outcome_count(v0) as u8), arg2),
            market_id : v1,
        }
    }

    public fun conditional_swap_asset_to_stable_with_wrapped_escrow<T0, T1, T2, T3, T4>(arg0: &0x247a26578dca33ebe83d531627f7cf670e93ba4c874b395613d1929a5a5c2731::proposal::Proposal<T0, T1>, arg1: &mut 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg2: 0x2::coin::Coin<T0>, arg3: u8, arg4: u64, arg5: address, arg6: &0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::spot_pool_mutation_auth::SpotPoolMutationRegistry, arg7: &0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::escrow_mutation_auth::EscrowMutationRegistry, arg8: &0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::market_state_mutation_auth::MarketStateMutationRegistry, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 0);
        let v1 = SpotPoolMutationWitness{dummy_field: false};
        let v2 = 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::extract_active_escrow<T0, T1, T2>(arg1, 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::spot_pool_mutation_auth::create<SpotPoolMutationWitness>(arg6, v1, 0x2::object::id<0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>>(arg1)));
        assert!(0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::coin_escrow::market_state_id<T0, T1>(&v2) == 0x247a26578dca33ebe83d531627f7cf670e93ba4c874b395613d1929a5a5c2731::proposal::market_state_id<T0, T1>(arg0), 1);
        let v3 = 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::swap_core::begin_swap_session<T0, T1>(&v2);
        let v4 = begin_conditional_swaps<T0, T1>(&v2, arg9, arg10);
        0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::conditional_balance::split_asset_to_balance<T0, T1>(&mut v2, &mut v4.balance, arg2);
        let v5 = 0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::conditional_balance::unwrap_to_coin<T0, T1, T3>(&mut v4.balance, &mut v2, arg3, true, v0, arg10);
        let v6 = &mut v2;
        let (v7, v8) = swap_in_batch<T0, T1, T3, T4>(v4, &v3, v6, arg3, v5, true, arg4, arg7, arg9, arg10);
        let v9 = &mut v2;
        finalize_conditional_swaps<T0, T1, T2>(v7, arg1, arg0, v9, v3, arg5, arg7, arg8, arg9, arg10);
        let v10 = SpotPoolMutationWitness{dummy_field: false};
        0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::store_active_escrow<T0, T1, T2>(arg1, v2, 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::spot_pool_mutation_auth::create<SpotPoolMutationWitness>(arg6, v10, 0x2::object::id<0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>>(arg1)));
        0x2::transfer::public_transfer<0x2::coin::Coin<T4>>(v8, arg5);
    }

    public fun conditional_swap_balance_with_wrapped_escrow<T0, T1, T2, T3, T4>(arg0: &0x247a26578dca33ebe83d531627f7cf670e93ba4c874b395613d1929a5a5c2731::proposal::Proposal<T0, T1>, arg1: &mut 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg2: &mut 0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::conditional_balance::ConditionalMarketBalance<T0, T1>, arg3: u8, arg4: bool, arg5: u64, arg6: u64, arg7: address, arg8: &0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::spot_pool_mutation_auth::SpotPoolMutationRegistry, arg9: &0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::escrow_mutation_auth::EscrowMutationRegistry, arg10: &0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::market_state_mutation_auth::MarketStateMutationRegistry, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 > 0, 0);
        let v0 = SpotPoolMutationWitness{dummy_field: false};
        let v1 = 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::extract_active_escrow<T0, T1, T2>(arg1, 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::spot_pool_mutation_auth::create<SpotPoolMutationWitness>(arg8, v0, 0x2::object::id<0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>>(arg1)));
        assert!(0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::coin_escrow::market_state_id<T0, T1>(&v1) == 0x247a26578dca33ebe83d531627f7cf670e93ba4c874b395613d1929a5a5c2731::proposal::market_state_id<T0, T1>(arg0), 1);
        let v2 = 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::swap_core::begin_swap_session<T0, T1>(&v1);
        let v3 = begin_conditional_swaps<T0, T1>(&v1, arg11, arg12);
        let v4 = 0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::conditional_balance::unwrap_to_coin<T0, T1, T3>(arg2, &mut v1, arg3, arg4, arg5, arg12);
        let v5 = &mut v1;
        let (v6, v7) = swap_in_batch<T0, T1, T3, T4>(v3, &v2, v5, arg3, v4, arg4, arg6, arg9, arg11, arg12);
        let v8 = &mut v1;
        finalize_conditional_swaps<T0, T1, T2>(v6, arg1, arg0, v8, v2, arg7, arg9, arg10, arg11, arg12);
        let v9 = SpotPoolMutationWitness{dummy_field: false};
        0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::store_active_escrow<T0, T1, T2>(arg1, v1, 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::spot_pool_mutation_auth::create<SpotPoolMutationWitness>(arg8, v9, 0x2::object::id<0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>>(arg1)));
        0x2::transfer::public_transfer<0x2::coin::Coin<T4>>(v7, arg7);
    }

    public fun conditional_swap_coin_with_wrapped_escrow<T0, T1, T2, T3, T4>(arg0: &0x247a26578dca33ebe83d531627f7cf670e93ba4c874b395613d1929a5a5c2731::proposal::Proposal<T0, T1>, arg1: &mut 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg2: 0x2::coin::Coin<T3>, arg3: u8, arg4: bool, arg5: u64, arg6: address, arg7: &0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::spot_pool_mutation_auth::SpotPoolMutationRegistry, arg8: &0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::escrow_mutation_auth::EscrowMutationRegistry, arg9: &0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::market_state_mutation_auth::MarketStateMutationRegistry, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T3>(&arg2) > 0, 0);
        let v0 = SpotPoolMutationWitness{dummy_field: false};
        let v1 = 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::extract_active_escrow<T0, T1, T2>(arg1, 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::spot_pool_mutation_auth::create<SpotPoolMutationWitness>(arg7, v0, 0x2::object::id<0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>>(arg1)));
        assert!(0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::coin_escrow::market_state_id<T0, T1>(&v1) == 0x247a26578dca33ebe83d531627f7cf670e93ba4c874b395613d1929a5a5c2731::proposal::market_state_id<T0, T1>(arg0), 1);
        let v2 = 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::swap_core::begin_swap_session<T0, T1>(&v1);
        let v3 = begin_conditional_swaps<T0, T1>(&v1, arg10, arg11);
        let v4 = &mut v1;
        let (v5, v6) = swap_in_batch<T0, T1, T3, T4>(v3, &v2, v4, arg3, arg2, arg4, arg5, arg8, arg10, arg11);
        let v7 = &mut v1;
        finalize_conditional_swaps<T0, T1, T2>(v5, arg1, arg0, v7, v2, arg6, arg8, arg9, arg10, arg11);
        let v8 = SpotPoolMutationWitness{dummy_field: false};
        0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::store_active_escrow<T0, T1, T2>(arg1, v1, 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::spot_pool_mutation_auth::create<SpotPoolMutationWitness>(arg7, v8, 0x2::object::id<0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>>(arg1)));
        0x2::transfer::public_transfer<0x2::coin::Coin<T4>>(v6, arg6);
    }

    public fun conditional_swap_stable_to_asset_with_wrapped_escrow<T0, T1, T2, T3, T4>(arg0: &0x247a26578dca33ebe83d531627f7cf670e93ba4c874b395613d1929a5a5c2731::proposal::Proposal<T0, T1>, arg1: &mut 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg2: 0x2::coin::Coin<T1>, arg3: u8, arg4: u64, arg5: address, arg6: &0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::spot_pool_mutation_auth::SpotPoolMutationRegistry, arg7: &0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::escrow_mutation_auth::EscrowMutationRegistry, arg8: &0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::market_state_mutation_auth::MarketStateMutationRegistry, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T1>(&arg2);
        assert!(v0 > 0, 0);
        let v1 = SpotPoolMutationWitness{dummy_field: false};
        let v2 = 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::extract_active_escrow<T0, T1, T2>(arg1, 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::spot_pool_mutation_auth::create<SpotPoolMutationWitness>(arg6, v1, 0x2::object::id<0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>>(arg1)));
        assert!(0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::coin_escrow::market_state_id<T0, T1>(&v2) == 0x247a26578dca33ebe83d531627f7cf670e93ba4c874b395613d1929a5a5c2731::proposal::market_state_id<T0, T1>(arg0), 1);
        let v3 = 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::swap_core::begin_swap_session<T0, T1>(&v2);
        let v4 = begin_conditional_swaps<T0, T1>(&v2, arg9, arg10);
        0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::conditional_balance::split_stable_to_balance<T0, T1>(&mut v2, &mut v4.balance, arg2);
        let v5 = 0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::conditional_balance::unwrap_to_coin<T0, T1, T3>(&mut v4.balance, &mut v2, arg3, false, v0, arg10);
        let v6 = &mut v2;
        let (v7, v8) = swap_in_batch<T0, T1, T3, T4>(v4, &v3, v6, arg3, v5, false, arg4, arg7, arg9, arg10);
        let v9 = &mut v2;
        finalize_conditional_swaps<T0, T1, T2>(v7, arg1, arg0, v9, v3, arg5, arg7, arg8, arg9, arg10);
        let v10 = SpotPoolMutationWitness{dummy_field: false};
        0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::store_active_escrow<T0, T1, T2>(arg1, v2, 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::spot_pool_mutation_auth::create<SpotPoolMutationWitness>(arg6, v10, 0x2::object::id<0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>>(arg1)));
        0x2::transfer::public_transfer<0x2::coin::Coin<T4>>(v8, arg5);
    }

    public(friend) fun extract_active_escrow_for_conditional_swaps<T0, T1, T2>(arg0: &mut 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg1: &0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::spot_pool_mutation_auth::SpotPoolMutationRegistry) : 0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::coin_escrow::TokenEscrow<T0, T1> {
        let v0 = SpotPoolMutationWitness{dummy_field: false};
        0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::extract_active_escrow<T0, T1, T2>(arg0, 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::spot_pool_mutation_auth::create<SpotPoolMutationWitness>(arg1, v0, 0x2::object::id<0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>>(arg0)))
    }

    public fun extract_escrow_for_batch<T0, T1, T2>(arg0: &mut 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg1: &0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::spot_pool_mutation_auth::SpotPoolMutationRegistry) : (0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::coin_escrow::TokenEscrow<T0, T1>, EscrowReceipt) {
        let v0 = SpotPoolMutationWitness{dummy_field: false};
        let v1 = 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::extract_active_escrow<T0, T1, T2>(arg0, 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::spot_pool_mutation_auth::create<SpotPoolMutationWitness>(arg1, v0, 0x2::object::id<0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>>(arg0)));
        let v2 = EscrowReceipt{
            pool_id   : 0x2::object::id<0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>>(arg0),
            escrow_id : 0x2::object::id<0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::coin_escrow::TokenEscrow<T0, T1>>(&v1),
        };
        (v1, v2)
    }

    public fun finalize_conditional_swaps<T0, T1, T2>(arg0: ConditionalSwapBatch<T0, T1>, arg1: &mut 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg2: &0x247a26578dca33ebe83d531627f7cf670e93ba4c874b395613d1929a5a5c2731::proposal::Proposal<T0, T1>, arg3: &mut 0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::coin_escrow::TokenEscrow<T0, T1>, arg4: 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::swap_core::SwapSession, arg5: address, arg6: &0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::escrow_mutation_auth::EscrowMutationRegistry, arg7: &0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::market_state_mutation_auth::MarketStateMutationRegistry, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::coin_escrow::market_state_id<T0, T1>(arg3) == 0x247a26578dca33ebe83d531627f7cf670e93ba4c874b395613d1929a5a5c2731::proposal::market_state_id<T0, T1>(arg2), 1);
        let ConditionalSwapBatch {
            balance   : v0,
            market_id : v1,
        } = arg0;
        assert!(v1 == 0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::coin_escrow::market_state_id<T0, T1>(arg3), 2);
        0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::swap_core::finalize_swap_session<T0, T1>(arg4, arg3, arg6);
        let v2 = 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::arbitrage::auto_rebalance_spot_after_conditional_swaps<T0, T1, T2>(arg1, arg3, 0x1::option::some<0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::conditional_balance::ConditionalMarketBalance<T0, T1>>(v0), arg6, arg7, arg8, arg9);
        assert!(0x1::option::is_some<0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::conditional_balance::ConditionalMarketBalance<T0, T1>>(&v2), 3);
        0x1::option::destroy_none<0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::conditional_balance::ConditionalMarketBalance<T0, T1>>(v2);
        transfer_or_destroy_balance<T0, T1>(0x1::option::extract<0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::conditional_balance::ConditionalMarketBalance<T0, T1>>(&mut v2), arg5);
    }

    public fun read_escrow_state_with_wrapped_escrow<T0, T1, T2>(arg0: &0x247a26578dca33ebe83d531627f7cf670e93ba4c874b395613d1929a5a5c2731::proposal::Proposal<T0, T1>, arg1: &mut 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg2: &0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::spot_pool_mutation_auth::SpotPoolMutationRegistry) : (u64, u64, u64, u64, u64, u64, vector<u64>, vector<u64>, vector<u64>, vector<u64>, vector<u64>, vector<u64>) {
        let v0 = SpotPoolMutationWitness{dummy_field: false};
        let (v1, v2) = 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::extract_escrow_by_market_id<T0, T1, T2>(arg1, 0x247a26578dca33ebe83d531627f7cf670e93ba4c874b395613d1929a5a5c2731::proposal::market_state_id<T0, T1>(arg0), 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::spot_pool_mutation_auth::create<SpotPoolMutationWitness>(arg2, v0, 0x2::object::id<0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>>(arg1)));
        let v3 = v1;
        let (v4, v5, v6, v7, v8, v9) = 0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::coin_escrow::get_all_tracking<T0, T1>(&v3);
        let v10 = vector[];
        let v11 = vector[];
        let v12 = vector[];
        let v13 = vector[];
        let v14 = vector[];
        let v15 = vector[];
        let v16 = 0;
        while (v16 < 0x247a26578dca33ebe83d531627f7cf670e93ba4c874b395613d1929a5a5c2731::proposal::outcome_count<T0, T1>(arg0)) {
            0x1::vector::push_back<u64>(&mut v10, 0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::coin_escrow::get_outcome_escrowed_asset<T0, T1>(&v3, v16));
            0x1::vector::push_back<u64>(&mut v11, 0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::coin_escrow::get_outcome_escrowed_stable<T0, T1>(&v3, v16));
            0x1::vector::push_back<u64>(&mut v12, 0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::coin_escrow::get_pool_claim_asset<T0, T1>(&v3, v16));
            0x1::vector::push_back<u64>(&mut v13, 0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::coin_escrow::get_pool_claim_stable<T0, T1>(&v3, v16));
            0x1::vector::push_back<u64>(&mut v14, 0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::coin_escrow::get_outcome_asset_supply<T0, T1>(&v3, v16));
            0x1::vector::push_back<u64>(&mut v15, 0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::coin_escrow::get_outcome_stable_supply<T0, T1>(&v3, v16));
            v16 = v16 + 1;
        };
        let v17 = SpotPoolMutationWitness{dummy_field: false};
        0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::store_extracted_escrow<T0, T1, T2>(arg1, v3, v2, 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::spot_pool_mutation_auth::create<SpotPoolMutationWitness>(arg2, v17, 0x2::object::id<0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>>(arg1)));
        (v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15)
    }

    public fun read_oracle_state_by_outcome_with_wrapped_escrow<T0, T1, T2>(arg0: &0x247a26578dca33ebe83d531627f7cf670e93ba4c874b395613d1929a5a5c2731::proposal::Proposal<T0, T1>, arg1: &mut 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg2: u8, arg3: &0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::spot_pool_mutation_auth::SpotPoolMutationRegistry) : (u128, u64, u256, u256, u64, u128, 0x1::option::Option<u64>, u128, u64, u64, u64, u64) {
        let v0 = SpotPoolMutationWitness{dummy_field: false};
        let (v1, v2) = 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::extract_escrow_by_market_id<T0, T1, T2>(arg1, 0x247a26578dca33ebe83d531627f7cf670e93ba4c874b395613d1929a5a5c2731::proposal::market_state_id<T0, T1>(arg0), 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::spot_pool_mutation_auth::create<SpotPoolMutationWitness>(arg3, v0, 0x2::object::id<0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>>(arg1)));
        let v3 = v1;
        let (v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15) = 0x247a26578dca33ebe83d531627f7cf670e93ba4c874b395613d1929a5a5c2731::proposal::get_oracle_state_by_outcome<T0, T1>(arg0, &v3, arg2);
        let v16 = SpotPoolMutationWitness{dummy_field: false};
        0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::store_extracted_escrow<T0, T1, T2>(arg1, v3, v2, 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::spot_pool_mutation_auth::create<SpotPoolMutationWitness>(arg3, v16, 0x2::object::id<0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>>(arg1)));
        (v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15)
    }

    public fun read_spot_oracle_state<T0, T1, T2>(arg0: &0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>) : (u128, u128, u64, u256) {
        let v0 = 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::get_simple_twap<T0, T1, T2>(arg0);
        (0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::PCW_TWAP_oracle::last_price(v0), 0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::PCW_TWAP_oracle::get_twap(v0), 0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::PCW_TWAP_oracle::initialized_at(v0), 0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::PCW_TWAP_oracle::cumulative_total(v0))
    }

    public fun split_asset_to_batch<T0, T1>(arg0: ConditionalSwapBatch<T0, T1>, arg1: &mut 0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::coin_escrow::TokenEscrow<T0, T1>, arg2: 0x2::coin::Coin<T0>) : ConditionalSwapBatch<T0, T1> {
        0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::conditional_balance::split_asset_to_balance<T0, T1>(arg1, &mut arg0.balance, arg2);
        arg0
    }

    public fun split_stable_to_batch<T0, T1>(arg0: ConditionalSwapBatch<T0, T1>, arg1: &mut 0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::coin_escrow::TokenEscrow<T0, T1>, arg2: 0x2::coin::Coin<T1>) : ConditionalSwapBatch<T0, T1> {
        0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::conditional_balance::split_stable_to_balance<T0, T1>(arg1, &mut arg0.balance, arg2);
        arg0
    }

    public(friend) fun store_active_escrow_after_conditional_swaps<T0, T1, T2>(arg0: &mut 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg1: 0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::coin_escrow::TokenEscrow<T0, T1>, arg2: &0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::spot_pool_mutation_auth::SpotPoolMutationRegistry) {
        let v0 = SpotPoolMutationWitness{dummy_field: false};
        0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::store_active_escrow<T0, T1, T2>(arg0, arg1, 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::spot_pool_mutation_auth::create<SpotPoolMutationWitness>(arg2, v0, 0x2::object::id<0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>>(arg0)));
    }

    public fun store_escrow_after_batch<T0, T1, T2>(arg0: &mut 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg1: 0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::coin_escrow::TokenEscrow<T0, T1>, arg2: EscrowReceipt, arg3: &0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::spot_pool_mutation_auth::SpotPoolMutationRegistry, arg4: &0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::escrow_mutation_auth::EscrowMutationRegistry, arg5: &0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::market_state_mutation_auth::MarketStateMutationRegistry, arg6: address, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let EscrowReceipt {
            pool_id   : v0,
            escrow_id : v1,
        } = arg2;
        assert!(v0 == 0x2::object::id<0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>>(arg0), 6);
        assert!(v1 == 0x2::object::id<0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::coin_escrow::TokenEscrow<T0, T1>>(&arg1), 7);
        let v2 = 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::arbitrage::auto_rebalance_spot_after_conditional_swaps<T0, T1, T2>(arg0, &mut arg1, 0x1::option::none<0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::conditional_balance::ConditionalMarketBalance<T0, T1>>(), arg4, arg5, arg7, arg8);
        if (0x1::option::is_some<0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::conditional_balance::ConditionalMarketBalance<T0, T1>>(&v2)) {
            transfer_or_destroy_balance<T0, T1>(0x1::option::extract<0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::conditional_balance::ConditionalMarketBalance<T0, T1>>(&mut v2), arg6);
        };
        0x1::option::destroy_none<0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::conditional_balance::ConditionalMarketBalance<T0, T1>>(v2);
        let v3 = SpotPoolMutationWitness{dummy_field: false};
        0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::store_active_escrow<T0, T1, T2>(arg0, arg1, 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::spot_pool_mutation_auth::create<SpotPoolMutationWitness>(arg3, v3, 0x2::object::id<0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>>(arg0)));
    }

    public fun swap_in_batch<T0, T1, T2, T3>(arg0: ConditionalSwapBatch<T0, T1>, arg1: &0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::swap_core::SwapSession, arg2: &mut 0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::coin_escrow::TokenEscrow<T0, T1>, arg3: u8, arg4: 0x2::coin::Coin<T2>, arg5: bool, arg6: u64, arg7: &0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::escrow_mutation_auth::EscrowMutationRegistry, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (ConditionalSwapBatch<T0, T1>, 0x2::coin::Coin<T3>) {
        let v0 = 0x2::coin::value<T2>(&arg4);
        assert!(v0 > 0, 0);
        assert!(arg0.market_id == 0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::coin_escrow::market_state_id<T0, T1>(arg2), 2);
        0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::market_state::assert_swaps_allowed(0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::coin_escrow::get_market_state<T0, T1>(arg2), arg8);
        0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::conditional_balance::wrap_coin<T0, T1, T2>(&mut arg0.balance, arg2, arg4, arg3, arg5);
        let v1 = if (arg5) {
            0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::swap_core::swap_balance_asset_to_stable<T0, T1>(arg1, arg2, &mut arg0.balance, arg3, v0, arg6, arg7, arg8, arg9)
        } else {
            0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::swap_core::swap_balance_stable_to_asset<T0, T1>(arg1, arg2, &mut arg0.balance, arg3, v0, arg6, arg7, arg8, arg9)
        };
        (arg0, 0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::conditional_balance::unwrap_to_coin<T0, T1, T3>(&mut arg0.balance, arg2, arg3, !arg5, v1, arg9))
    }

    public fun swap_spot_asset_to_stable<T0, T1, T2>(arg0: &mut 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: address, arg4: 0x1::option::Option<0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::conditional_balance::ConditionalMarketBalance<T0, T1>>, arg5: bool, arg6: &0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::spot_pool_mutation_auth::SpotPoolMutationRegistry, arg7: &0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::escrow_mutation_auth::EscrowMutationRegistry, arg8: &0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::market_state_mutation_auth::MarketStateMutationRegistry, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x1::option::Option<0x2::coin::Coin<T1>>, 0x1::option::Option<0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::conditional_balance::ConditionalMarketBalance<T0, T1>>) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 0);
        if (0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::has_active_escrow<T0, T1, T2>(arg0)) {
            let v3 = SpotPoolMutationWitness{dummy_field: false};
            let v4 = 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::extract_active_escrow<T0, T1, T2>(arg0, 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::spot_pool_mutation_auth::create<SpotPoolMutationWitness>(arg6, v3, 0x2::object::id<0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>>(arg0)));
            let v5 = 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::swap_asset_for_stable<T0, T1, T2>(arg0, arg1, arg2, arg9, arg10);
            assert!(0x2::coin::value<T1>(&v5) >= arg2, 4);
            if (0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::market_state::are_swaps_allowed(0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::coin_escrow::get_market_state<T0, T1>(&v4), arg9)) {
                let v6 = arg4;
                arg4 = 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::arbitrage::auto_rebalance_spot_after_conditional_swaps<T0, T1, T2>(arg0, &mut v4, v6, arg7, arg8, arg9, arg10);
            };
            let (v7, v8) = 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::get_reserves<T0, T1, T2>(arg0);
            let v9 = SpotSwap{
                pool_id        : 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::get_pool_id<T0, T1, T2>(arg0),
                is_buy         : false,
                amount_in      : v0,
                amount_out     : 0x2::coin::value<T1>(&v5),
                sender         : 0x2::tx_context::sender(arg10),
                recipient      : arg3,
                asset_reserve  : v7,
                stable_reserve : v8,
            };
            0x2::event::emit<SpotSwap>(v9);
            let v10 = SpotPoolMutationWitness{dummy_field: false};
            0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::store_active_escrow<T0, T1, T2>(arg0, v4, 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::spot_pool_mutation_auth::create<SpotPoolMutationWitness>(arg6, v10, 0x2::object::id<0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>>(arg0)));
            if (arg5) {
                (0x1::option::some<0x2::coin::Coin<T1>>(v5), arg4)
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v5, arg3);
                if (0x1::option::is_some<0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::conditional_balance::ConditionalMarketBalance<T0, T1>>(&arg4)) {
                    transfer_or_destroy_balance<T0, T1>(0x1::option::extract<0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::conditional_balance::ConditionalMarketBalance<T0, T1>>(&mut arg4), arg3);
                };
                0x1::option::destroy_none<0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::conditional_balance::ConditionalMarketBalance<T0, T1>>(arg4);
                (0x1::option::none<0x2::coin::Coin<T1>>(), 0x1::option::none<0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::conditional_balance::ConditionalMarketBalance<T0, T1>>())
            }
        } else {
            let v11 = 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::swap_asset_for_stable<T0, T1, T2>(arg0, arg1, arg2, arg9, arg10);
            let (v12, v13) = 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::get_reserves<T0, T1, T2>(arg0);
            let v14 = SpotSwap{
                pool_id        : 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::get_pool_id<T0, T1, T2>(arg0),
                is_buy         : false,
                amount_in      : v0,
                amount_out     : 0x2::coin::value<T1>(&v11),
                sender         : 0x2::tx_context::sender(arg10),
                recipient      : arg3,
                asset_reserve  : v12,
                stable_reserve : v13,
            };
            0x2::event::emit<SpotSwap>(v14);
            if (arg5) {
                (0x1::option::some<0x2::coin::Coin<T1>>(v11), arg4)
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v11, arg3);
                if (0x1::option::is_some<0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::conditional_balance::ConditionalMarketBalance<T0, T1>>(&arg4)) {
                    transfer_or_destroy_balance<T0, T1>(0x1::option::extract<0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::conditional_balance::ConditionalMarketBalance<T0, T1>>(&mut arg4), arg3);
                };
                0x1::option::destroy_none<0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::conditional_balance::ConditionalMarketBalance<T0, T1>>(arg4);
                (0x1::option::none<0x2::coin::Coin<T1>>(), 0x1::option::none<0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::conditional_balance::ConditionalMarketBalance<T0, T1>>())
            }
        }
    }

    public fun swap_spot_stable_to_asset<T0, T1, T2>(arg0: &mut 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: address, arg4: 0x1::option::Option<0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::conditional_balance::ConditionalMarketBalance<T0, T1>>, arg5: bool, arg6: &0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::spot_pool_mutation_auth::SpotPoolMutationRegistry, arg7: &0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::escrow_mutation_auth::EscrowMutationRegistry, arg8: &0xcb4dee85f5e93cab3a34f549d59eab8524898d493295f1db3eea4fe387085591::market_state_mutation_auth::MarketStateMutationRegistry, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x1::option::Option<0x2::coin::Coin<T0>>, 0x1::option::Option<0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::conditional_balance::ConditionalMarketBalance<T0, T1>>) {
        let v0 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 > 0, 0);
        if (0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::has_active_escrow<T0, T1, T2>(arg0)) {
            let v3 = SpotPoolMutationWitness{dummy_field: false};
            let v4 = 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::extract_active_escrow<T0, T1, T2>(arg0, 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::spot_pool_mutation_auth::create<SpotPoolMutationWitness>(arg6, v3, 0x2::object::id<0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>>(arg0)));
            let v5 = 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::swap_stable_for_asset<T0, T1, T2>(arg0, arg1, arg2, arg9, arg10);
            assert!(0x2::coin::value<T0>(&v5) >= arg2, 4);
            if (0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::market_state::are_swaps_allowed(0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::coin_escrow::get_market_state<T0, T1>(&v4), arg9)) {
                let v6 = arg4;
                arg4 = 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::arbitrage::auto_rebalance_spot_after_conditional_swaps<T0, T1, T2>(arg0, &mut v4, v6, arg7, arg8, arg9, arg10);
            };
            let (v7, v8) = 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::get_reserves<T0, T1, T2>(arg0);
            let v9 = SpotSwap{
                pool_id        : 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::get_pool_id<T0, T1, T2>(arg0),
                is_buy         : true,
                amount_in      : v0,
                amount_out     : 0x2::coin::value<T0>(&v5),
                sender         : 0x2::tx_context::sender(arg10),
                recipient      : arg3,
                asset_reserve  : v7,
                stable_reserve : v8,
            };
            0x2::event::emit<SpotSwap>(v9);
            let v10 = SpotPoolMutationWitness{dummy_field: false};
            0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::store_active_escrow<T0, T1, T2>(arg0, v4, 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::spot_pool_mutation_auth::create<SpotPoolMutationWitness>(arg6, v10, 0x2::object::id<0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>>(arg0)));
            if (arg5) {
                (0x1::option::some<0x2::coin::Coin<T0>>(v5), arg4)
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, arg3);
                if (0x1::option::is_some<0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::conditional_balance::ConditionalMarketBalance<T0, T1>>(&arg4)) {
                    transfer_or_destroy_balance<T0, T1>(0x1::option::extract<0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::conditional_balance::ConditionalMarketBalance<T0, T1>>(&mut arg4), arg3);
                };
                0x1::option::destroy_none<0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::conditional_balance::ConditionalMarketBalance<T0, T1>>(arg4);
                (0x1::option::none<0x2::coin::Coin<T0>>(), 0x1::option::none<0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::conditional_balance::ConditionalMarketBalance<T0, T1>>())
            }
        } else {
            let v11 = 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::swap_stable_for_asset<T0, T1, T2>(arg0, arg1, arg2, arg9, arg10);
            let (v12, v13) = 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::get_reserves<T0, T1, T2>(arg0);
            let v14 = SpotSwap{
                pool_id        : 0x7391e15cb4b1254dfdd5926b58c849c31d10839ddc5f99d4ecc87f9823956db1::unified_spot_pool::get_pool_id<T0, T1, T2>(arg0),
                is_buy         : true,
                amount_in      : v0,
                amount_out     : 0x2::coin::value<T0>(&v11),
                sender         : 0x2::tx_context::sender(arg10),
                recipient      : arg3,
                asset_reserve  : v12,
                stable_reserve : v13,
            };
            0x2::event::emit<SpotSwap>(v14);
            if (arg5) {
                (0x1::option::some<0x2::coin::Coin<T0>>(v11), arg4)
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v11, arg3);
                if (0x1::option::is_some<0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::conditional_balance::ConditionalMarketBalance<T0, T1>>(&arg4)) {
                    transfer_or_destroy_balance<T0, T1>(0x1::option::extract<0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::conditional_balance::ConditionalMarketBalance<T0, T1>>(&mut arg4), arg3);
                };
                0x1::option::destroy_none<0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::conditional_balance::ConditionalMarketBalance<T0, T1>>(arg4);
                (0x1::option::none<0x2::coin::Coin<T0>>(), 0x1::option::none<0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::conditional_balance::ConditionalMarketBalance<T0, T1>>())
            }
        }
    }

    fun transfer_or_destroy_balance<T0, T1>(arg0: 0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::conditional_balance::ConditionalMarketBalance<T0, T1>, arg1: address) {
        if (0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::conditional_balance::is_empty<T0, T1>(&arg0)) {
            0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::conditional_balance::destroy_empty<T0, T1>(arg0);
        } else {
            0x2::transfer::public_transfer<0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::conditional_balance::ConditionalMarketBalance<T0, T1>>(arg0, arg1);
        };
    }

    public fun unwrap_from_batch<T0, T1, T2>(arg0: ConditionalSwapBatch<T0, T1>, arg1: &mut 0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::coin_escrow::TokenEscrow<T0, T1>, arg2: u8, arg3: bool, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (ConditionalSwapBatch<T0, T1>, 0x2::coin::Coin<T2>) {
        (arg0, 0x1e205486ae61562a04a6de217d3a3cb8b2c9a1e88bbbe2134763c55a3f6aa49f::conditional_balance::unwrap_to_coin<T0, T1, T2>(&mut arg0.balance, arg1, arg2, arg3, arg4, arg5))
    }

    // decompiled from Move bytecode v6
}

