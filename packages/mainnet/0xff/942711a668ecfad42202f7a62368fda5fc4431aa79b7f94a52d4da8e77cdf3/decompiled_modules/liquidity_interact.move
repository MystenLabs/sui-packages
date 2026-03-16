module 0xff942711a668ecfad42202f7a62368fda5fc4431aa79b7f94a52d4da8e77cdf3::liquidity_interact {
    struct EscrowMutationWitness has drop {
        dummy_field: bool,
    }

    struct MarketStateMutationWitness has drop {
        dummy_field: bool,
    }

    struct SpotPoolMutationWitness has drop {
        dummy_field: bool,
    }

    struct ProtocolFeesCollected has copy, drop {
        proposal_id: 0x2::object::ID,
        winning_outcome: u64,
        fee_asset_amount: u64,
        fee_stable_amount: u64,
        timestamp_ms: u64,
    }

    struct SpotProtocolFeesCollected has copy, drop {
        pool_id: 0x2::object::ID,
        fee_asset_amount: u64,
        fee_stable_amount: u64,
        timestamp_ms: u64,
    }

    public fun collect_protocol_fees<T0, T1>(arg0: &mut 0x56dd1789976cf838cd5040f957a54117d05daf51c6696aa74bd84a016830e177::proposal::Proposal<T0, T1>, arg1: &mut 0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::TokenEscrow<T0, T1>, arg2: &mut 0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::fee::FeeManager, arg3: &0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::fee::FeeAdminCap, arg4: &0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::escrow_mutation_auth::EscrowMutationRegistry, arg5: &0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::market_state_mutation_auth::MarketStateMutationRegistry, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x56dd1789976cf838cd5040f957a54117d05daf51c6696aa74bd84a016830e177::proposal::is_finalized<T0, T1>(arg0), 3);
        assert!(0x56dd1789976cf838cd5040f957a54117d05daf51c6696aa74bd84a016830e177::proposal::is_winning_outcome_set<T0, T1>(arg0), 3);
        assert!(0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::market_state_id<T0, T1>(arg1) == 0x56dd1789976cf838cd5040f957a54117d05daf51c6696aa74bd84a016830e177::proposal::market_state_id<T0, T1>(arg0), 9);
        0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::fee::assert_admin_cap(arg2, arg3);
        let v0 = EscrowMutationWitness{dummy_field: false};
        let v1 = 0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::escrow_mutation_auth::create<EscrowMutationWitness>(arg4, v0);
        let v2 = MarketStateMutationWitness{dummy_field: false};
        let v3 = 0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::market_state_mutation_auth::create<MarketStateMutationWitness>(arg5, v2);
        let v4 = 0x56dd1789976cf838cd5040f957a54117d05daf51c6696aa74bd84a016830e177::proposal::get_winning_outcome<T0, T1>(arg0);
        let v5 = 0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::market_state::get_pool_mut_by_outcome(0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::get_market_state_mut<T0, T1>(arg1, &v1), v4, &v1);
        let v6 = 0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::conditional_amm::get_protocol_fees_asset(v5);
        let v7 = 0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::conditional_amm::get_protocol_fees_stable(v5);
        let (v8, v9) = 0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::get_spot_balances<T0, T1>(arg1);
        if (v6 > 0) {
            assert!(v8 >= v6, 7);
        };
        if (v7 > 0) {
            assert!(v9 >= v7, 7);
        };
        if (v6 > 0) {
            0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::fee::deposit_fees_with_proposal<T0>(arg2, 0x2::coin::into_balance<T0>(0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::withdraw_asset_balance<T0, T1>(arg1, v6, arg7, &v1)), 0x56dd1789976cf838cd5040f957a54117d05daf51c6696aa74bd84a016830e177::proposal::get_id<T0, T1>(arg0), arg6);
        };
        if (v7 > 0) {
            0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::fee::deposit_fees_with_proposal<T1>(arg2, 0x2::coin::into_balance<T1>(0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::withdraw_stable_balance<T0, T1>(arg1, v7, arg7, &v1)), 0x56dd1789976cf838cd5040f957a54117d05daf51c6696aa74bd84a016830e177::proposal::get_id<T0, T1>(arg0), arg6);
        };
        if (v6 > 0 || v7 > 0) {
            0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::track_collected_protocol_fees<T0, T1>(arg1, v6, v7, &v1);
            let (_, _) = 0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::conditional_amm::collect_protocol_fees(0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::market_state::get_pool_mut_by_outcome(0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::get_market_state_mut<T0, T1>(arg1, &v1), v4, &v1), &v3);
            let v12 = ProtocolFeesCollected{
                proposal_id       : 0x56dd1789976cf838cd5040f957a54117d05daf51c6696aa74bd84a016830e177::proposal::get_id<T0, T1>(arg0),
                winning_outcome   : v4,
                fee_asset_amount  : v6,
                fee_stable_amount : v7,
                timestamp_ms      : 0x2::clock::timestamp_ms(arg6),
            };
            0x2::event::emit<ProtocolFeesCollected>(v12);
        };
        0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::assert_quantum_invariant<T0, T1>(arg1);
    }

    public entry fun add_liquidity_entry<T0, T1, T2, T3, T4>(arg0: &mut 0x56dd1789976cf838cd5040f957a54117d05daf51c6696aa74bd84a016830e177::proposal::Proposal<T0, T1>, arg1: &mut 0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::TokenEscrow<T0, T1>, arg2: u64, arg3: 0x2::coin::Coin<T2>, arg4: 0x2::coin::Coin<T3>, arg5: u64, arg6: &0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::escrow_mutation_auth::EscrowMutationRegistry, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        abort 10
    }

    fun assert_emergency_access<T0, T1>(arg0: &0x56dd1789976cf838cd5040f957a54117d05daf51c6696aa74bd84a016830e177::proposal::Proposal<T0, T1>, arg1: &0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::TokenEscrow<T0, T1>, arg2: &0x2::clock::Clock, arg3: &0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::emergency_cap::EmergencyCap) {
        assert!(0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::market_state_id<T0, T1>(arg1) == 0x56dd1789976cf838cd5040f957a54117d05daf51c6696aa74bd84a016830e177::proposal::market_state_id<T0, T1>(arg0), 9);
        0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::emergency_cap::assert_ready(arg3, arg2);
    }

    public fun collect_protocol_fees_with_wrapped_escrow<T0, T1, T2>(arg0: &mut 0x56dd1789976cf838cd5040f957a54117d05daf51c6696aa74bd84a016830e177::proposal::Proposal<T0, T1>, arg1: &mut 0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg2: &mut 0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::fee::FeeManager, arg3: &0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::fee::FeeAdminCap, arg4: &0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::spot_pool_mutation_auth::SpotPoolMutationRegistry, arg5: &0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::escrow_mutation_auth::EscrowMutationRegistry, arg6: &0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::market_state_mutation_auth::MarketStateMutationRegistry, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = extract_proposal_escrow<T0, T1, T2>(arg0, arg1, arg4);
        let v2 = v0;
        let v3 = &mut v2;
        collect_protocol_fees<T0, T1>(arg0, v3, arg2, arg3, arg5, arg6, arg7, arg8);
        store_proposal_escrow<T0, T1, T2>(arg1, v2, v1, arg4);
    }

    public fun collect_spot_protocol_fees<T0, T1, T2>(arg0: &mut 0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg1: &mut 0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::fee::FeeManager, arg2: &0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::fee::FeeAdminCap, arg3: &0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::spot_pool_mutation_auth::SpotPoolMutationRegistry, arg4: &0x2::clock::Clock) {
        0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::fee::assert_admin_cap(arg1, arg2);
        let (v0, v1) = 0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::unified_spot_pool::get_protocol_fee_amounts<T0, T1, T2>(arg0);
        if (v0 == 0 && v1 == 0) {
            return
        };
        if (v0 > 0) {
            let v2 = SpotPoolMutationWitness{dummy_field: false};
            0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::fee::deposit_fees<T0>(arg1, 0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::unified_spot_pool::withdraw_protocol_fees_asset<T0, T1, T2>(arg0, 0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::spot_pool_mutation_auth::create<SpotPoolMutationWitness>(arg3, v2, 0x2::object::id<0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>>(arg0))), arg4);
        };
        if (v1 > 0) {
            let v3 = SpotPoolMutationWitness{dummy_field: false};
            0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::fee::deposit_fees<T1>(arg1, 0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::unified_spot_pool::withdraw_protocol_fees_stable<T0, T1, T2>(arg0, 0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::spot_pool_mutation_auth::create<SpotPoolMutationWitness>(arg3, v3, 0x2::object::id<0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>>(arg0))), arg4);
        };
        let v4 = SpotProtocolFeesCollected{
            pool_id           : 0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::unified_spot_pool::get_pool_id<T0, T1, T2>(arg0),
            fee_asset_amount  : v0,
            fee_stable_amount : v1,
            timestamp_ms      : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<SpotProtocolFeesCollected>(v4);
    }

    public entry fun emergency_burn_asset_treasury_cap<T0, T1, T2>(arg0: &0x56dd1789976cf838cd5040f957a54117d05daf51c6696aa74bd84a016830e177::proposal::Proposal<T0, T1>, arg1: &mut 0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::TokenEscrow<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::emergency_cap::EmergencyCap, arg5: &0x2::tx_context::TxContext) {
        assert_emergency_access<T0, T1>(arg0, arg1, arg3, arg4);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T2>>(0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::emergency_remove_asset_treasury_cap<T0, T1, T2>(arg1, arg2, arg4, arg3), @0x0);
    }

    public entry fun emergency_burn_asset_treasury_cap_with_wrapped_escrow<T0, T1, T2, T3>(arg0: &0x56dd1789976cf838cd5040f957a54117d05daf51c6696aa74bd84a016830e177::proposal::Proposal<T0, T1>, arg1: &mut 0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg2: u64, arg3: &0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::spot_pool_mutation_auth::SpotPoolMutationRegistry, arg4: &0x2::clock::Clock, arg5: &0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::emergency_cap::EmergencyCap, arg6: &0x2::tx_context::TxContext) {
        let (v0, v1) = extract_proposal_escrow<T0, T1, T2>(arg0, arg1, arg3);
        let v2 = v0;
        assert_emergency_access<T0, T1>(arg0, &v2, arg4, arg5);
        store_proposal_escrow<T0, T1, T2>(arg1, v2, v1, arg3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T3>>(0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::emergency_remove_asset_treasury_cap<T0, T1, T3>(&mut v2, arg2, arg5, arg4), @0x0);
    }

    public entry fun emergency_burn_stable_treasury_cap<T0, T1, T2>(arg0: &0x56dd1789976cf838cd5040f957a54117d05daf51c6696aa74bd84a016830e177::proposal::Proposal<T0, T1>, arg1: &mut 0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::TokenEscrow<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::emergency_cap::EmergencyCap, arg5: &0x2::tx_context::TxContext) {
        assert_emergency_access<T0, T1>(arg0, arg1, arg3, arg4);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T2>>(0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::emergency_remove_stable_treasury_cap<T0, T1, T2>(arg1, arg2, arg4, arg3), @0x0);
    }

    public entry fun emergency_burn_stable_treasury_cap_with_wrapped_escrow<T0, T1, T2, T3>(arg0: &0x56dd1789976cf838cd5040f957a54117d05daf51c6696aa74bd84a016830e177::proposal::Proposal<T0, T1>, arg1: &mut 0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg2: u64, arg3: &0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::spot_pool_mutation_auth::SpotPoolMutationRegistry, arg4: &0x2::clock::Clock, arg5: &0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::emergency_cap::EmergencyCap, arg6: &0x2::tx_context::TxContext) {
        let (v0, v1) = extract_proposal_escrow<T0, T1, T2>(arg0, arg1, arg3);
        let v2 = v0;
        assert_emergency_access<T0, T1>(arg0, &v2, arg4, arg5);
        store_proposal_escrow<T0, T1, T2>(arg1, v2, v1, arg3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T3>>(0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::emergency_remove_stable_treasury_cap<T0, T1, T3>(&mut v2, arg2, arg5, arg4), @0x0);
    }

    public entry fun emergency_take_asset_treasury_cap_to_sender<T0, T1, T2>(arg0: &0x56dd1789976cf838cd5040f957a54117d05daf51c6696aa74bd84a016830e177::proposal::Proposal<T0, T1>, arg1: &mut 0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::TokenEscrow<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::emergency_cap::EmergencyCap, arg5: &0x2::tx_context::TxContext) {
        assert_emergency_access<T0, T1>(arg0, arg1, arg3, arg4);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T2>>(0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::emergency_remove_asset_treasury_cap<T0, T1, T2>(arg1, arg2, arg4, arg3), 0x2::tx_context::sender(arg5));
    }

    public entry fun emergency_take_asset_treasury_cap_to_sender_with_wrapped_escrow<T0, T1, T2, T3>(arg0: &0x56dd1789976cf838cd5040f957a54117d05daf51c6696aa74bd84a016830e177::proposal::Proposal<T0, T1>, arg1: &mut 0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg2: u64, arg3: &0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::spot_pool_mutation_auth::SpotPoolMutationRegistry, arg4: &0x2::clock::Clock, arg5: &0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::emergency_cap::EmergencyCap, arg6: &0x2::tx_context::TxContext) {
        let (v0, v1) = extract_proposal_escrow<T0, T1, T2>(arg0, arg1, arg3);
        let v2 = v0;
        assert_emergency_access<T0, T1>(arg0, &v2, arg4, arg5);
        store_proposal_escrow<T0, T1, T2>(arg1, v2, v1, arg3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T3>>(0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::emergency_remove_asset_treasury_cap<T0, T1, T3>(&mut v2, arg2, arg5, arg4), 0x2::tx_context::sender(arg6));
    }

    public entry fun emergency_take_stable_treasury_cap_to_sender<T0, T1, T2>(arg0: &0x56dd1789976cf838cd5040f957a54117d05daf51c6696aa74bd84a016830e177::proposal::Proposal<T0, T1>, arg1: &mut 0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::TokenEscrow<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::emergency_cap::EmergencyCap, arg5: &0x2::tx_context::TxContext) {
        assert_emergency_access<T0, T1>(arg0, arg1, arg3, arg4);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T2>>(0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::emergency_remove_stable_treasury_cap<T0, T1, T2>(arg1, arg2, arg4, arg3), 0x2::tx_context::sender(arg5));
    }

    public entry fun emergency_take_stable_treasury_cap_to_sender_with_wrapped_escrow<T0, T1, T2, T3>(arg0: &0x56dd1789976cf838cd5040f957a54117d05daf51c6696aa74bd84a016830e177::proposal::Proposal<T0, T1>, arg1: &mut 0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg2: u64, arg3: &0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::spot_pool_mutation_auth::SpotPoolMutationRegistry, arg4: &0x2::clock::Clock, arg5: &0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::emergency_cap::EmergencyCap, arg6: &0x2::tx_context::TxContext) {
        let (v0, v1) = extract_proposal_escrow<T0, T1, T2>(arg0, arg1, arg3);
        let v2 = v0;
        assert_emergency_access<T0, T1>(arg0, &v2, arg4, arg5);
        store_proposal_escrow<T0, T1, T2>(arg1, v2, v1, arg3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T3>>(0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::emergency_remove_stable_treasury_cap<T0, T1, T3>(&mut v2, arg2, arg5, arg4), 0x2::tx_context::sender(arg6));
    }

    public entry fun emergency_withdraw_escrow_to_sender<T0, T1>(arg0: &0x56dd1789976cf838cd5040f957a54117d05daf51c6696aa74bd84a016830e177::proposal::Proposal<T0, T1>, arg1: &mut 0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::TokenEscrow<T0, T1>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::emergency_cap::EmergencyCap, arg6: &mut 0x2::tx_context::TxContext) {
        assert_emergency_access<T0, T1>(arg0, arg1, arg4, arg5);
        let (v0, v1) = 0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::emergency_withdraw_spot_balances<T0, T1>(arg1, arg2, arg3, arg5, arg4, arg6);
        let v2 = v1;
        let v3 = v0;
        if (0x2::coin::value<T0>(&v3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg6));
        } else {
            0x2::coin::destroy_zero<T0>(v3);
        };
        if (0x2::coin::value<T1>(&v2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, 0x2::tx_context::sender(arg6));
        } else {
            0x2::coin::destroy_zero<T1>(v2);
        };
    }

    public entry fun emergency_withdraw_escrow_to_sender_with_wrapped_escrow<T0, T1, T2>(arg0: &0x56dd1789976cf838cd5040f957a54117d05daf51c6696aa74bd84a016830e177::proposal::Proposal<T0, T1>, arg1: &mut 0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg2: u64, arg3: u64, arg4: &0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::spot_pool_mutation_auth::SpotPoolMutationRegistry, arg5: &0x2::clock::Clock, arg6: &0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::emergency_cap::EmergencyCap, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = extract_proposal_escrow<T0, T1, T2>(arg0, arg1, arg4);
        let v2 = v0;
        assert_emergency_access<T0, T1>(arg0, &v2, arg5, arg6);
        let (v3, v4) = 0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::emergency_withdraw_spot_balances<T0, T1>(&mut v2, arg2, arg3, arg6, arg5, arg7);
        let v5 = v4;
        let v6 = v3;
        store_proposal_escrow<T0, T1, T2>(arg1, v2, v1, arg4);
        if (0x2::coin::value<T0>(&v6) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v6, 0x2::tx_context::sender(arg7));
        } else {
            0x2::coin::destroy_zero<T0>(v6);
        };
        if (0x2::coin::value<T1>(&v5) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v5, 0x2::tx_context::sender(arg7));
        } else {
            0x2::coin::destroy_zero<T1>(v5);
        };
    }

    fun extract_proposal_escrow<T0, T1, T2>(arg0: &0x56dd1789976cf838cd5040f957a54117d05daf51c6696aa74bd84a016830e177::proposal::Proposal<T0, T1>, arg1: &mut 0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg2: &0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::spot_pool_mutation_auth::SpotPoolMutationRegistry) : (0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::TokenEscrow<T0, T1>, bool) {
        let v0 = SpotPoolMutationWitness{dummy_field: false};
        0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::unified_spot_pool::extract_escrow_by_market_id<T0, T1, T2>(arg1, 0x56dd1789976cf838cd5040f957a54117d05daf51c6696aa74bd84a016830e177::proposal::market_state_id<T0, T1>(arg0), 0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::spot_pool_mutation_auth::create<SpotPoolMutationWitness>(arg2, v0, 0x2::object::id<0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>>(arg1)))
    }

    public fun get_spot_balances_with_wrapped_escrow<T0, T1, T2>(arg0: &0x56dd1789976cf838cd5040f957a54117d05daf51c6696aa74bd84a016830e177::proposal::Proposal<T0, T1>, arg1: &mut 0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg2: &0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::spot_pool_mutation_auth::SpotPoolMutationRegistry) : (u64, u64) {
        let (v0, v1) = extract_proposal_escrow<T0, T1, T2>(arg0, arg1, arg2);
        let v2 = v0;
        let (v3, v4) = 0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::get_spot_balances<T0, T1>(&v2);
        store_proposal_escrow<T0, T1, T2>(arg1, v2, v1, arg2);
        (v3, v4)
    }

    public fun recombine_balance_to_asset_with_wrapped_escrow<T0, T1, T2>(arg0: &0x56dd1789976cf838cd5040f957a54117d05daf51c6696aa74bd84a016830e177::proposal::Proposal<T0, T1>, arg1: &mut 0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg2: &mut 0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::conditional_balance::ConditionalMarketBalance<T0, T1>, arg3: u64, arg4: &0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::spot_pool_mutation_auth::SpotPoolMutationRegistry, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1) = extract_proposal_escrow<T0, T1, T2>(arg0, arg1, arg4);
        let v2 = v0;
        store_proposal_escrow<T0, T1, T2>(arg1, v2, v1, arg4);
        0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::conditional_balance::recombine_balance_to_asset<T0, T1>(&mut v2, arg2, arg3, arg5)
    }

    public fun recombine_balance_to_stable_with_wrapped_escrow<T0, T1, T2>(arg0: &0x56dd1789976cf838cd5040f957a54117d05daf51c6696aa74bd84a016830e177::proposal::Proposal<T0, T1>, arg1: &mut 0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg2: &mut 0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::conditional_balance::ConditionalMarketBalance<T0, T1>, arg3: u64, arg4: &0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::spot_pool_mutation_auth::SpotPoolMutationRegistry, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1) = extract_proposal_escrow<T0, T1, T2>(arg0, arg1, arg4);
        let v2 = v0;
        store_proposal_escrow<T0, T1, T2>(arg1, v2, v1, arg4);
        0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::conditional_balance::recombine_balance_to_stable<T0, T1>(&mut v2, arg2, arg3, arg5)
    }

    public fun redeem_conditional_asset<T0, T1, T2>(arg0: &0x56dd1789976cf838cd5040f957a54117d05daf51c6696aa74bd84a016830e177::proposal::Proposal<T0, T1>, arg1: &mut 0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::TokenEscrow<T0, T1>, arg2: 0x2::coin::Coin<T2>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x56dd1789976cf838cd5040f957a54117d05daf51c6696aa74bd84a016830e177::proposal::is_finalized<T0, T1>(arg0), 3);
        assert!(0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::market_state_id<T0, T1>(arg1) == 0x56dd1789976cf838cd5040f957a54117d05daf51c6696aa74bd84a016830e177::proposal::market_state_id<T0, T1>(arg0), 9);
        assert!(arg3 == 0x56dd1789976cf838cd5040f957a54117d05daf51c6696aa74bd84a016830e177::proposal::get_winning_outcome<T0, T1>(arg0), 2);
        0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::burn_conditional_asset_and_withdraw<T0, T1, T2>(arg1, arg2, arg5)
    }

    public fun redeem_conditional_asset_from_balance_with_wrapped_escrow<T0, T1, T2, T3>(arg0: &0x56dd1789976cf838cd5040f957a54117d05daf51c6696aa74bd84a016830e177::proposal::Proposal<T0, T1>, arg1: &mut 0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg2: &mut 0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::conditional_balance::ConditionalMarketBalance<T0, T1>, arg3: u8, arg4: u64, arg5: &0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::spot_pool_mutation_auth::SpotPoolMutationRegistry, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1) = extract_proposal_escrow<T0, T1, T2>(arg0, arg1, arg5);
        let v2 = v0;
        let v3 = 0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::conditional_balance::unwrap_to_coin<T0, T1, T3>(arg2, &mut v2, arg3, true, arg4, arg7);
        let v4 = &mut v2;
        store_proposal_escrow<T0, T1, T2>(arg1, v2, v1, arg5);
        redeem_conditional_asset<T0, T1, T3>(arg0, v4, v3, (arg3 as u64), arg6, arg7)
    }

    public fun redeem_conditional_asset_with_wrapped_escrow<T0, T1, T2, T3>(arg0: &0x56dd1789976cf838cd5040f957a54117d05daf51c6696aa74bd84a016830e177::proposal::Proposal<T0, T1>, arg1: &mut 0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg2: 0x2::coin::Coin<T3>, arg3: u64, arg4: &0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::spot_pool_mutation_auth::SpotPoolMutationRegistry, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1) = extract_proposal_escrow<T0, T1, T2>(arg0, arg1, arg4);
        let v2 = v0;
        let v3 = &mut v2;
        store_proposal_escrow<T0, T1, T2>(arg1, v2, v1, arg4);
        redeem_conditional_asset<T0, T1, T3>(arg0, v3, arg2, arg3, arg5, arg6)
    }

    public fun redeem_conditional_stable<T0, T1, T2>(arg0: &0x56dd1789976cf838cd5040f957a54117d05daf51c6696aa74bd84a016830e177::proposal::Proposal<T0, T1>, arg1: &mut 0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::TokenEscrow<T0, T1>, arg2: 0x2::coin::Coin<T2>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x56dd1789976cf838cd5040f957a54117d05daf51c6696aa74bd84a016830e177::proposal::is_finalized<T0, T1>(arg0), 3);
        assert!(0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::market_state_id<T0, T1>(arg1) == 0x56dd1789976cf838cd5040f957a54117d05daf51c6696aa74bd84a016830e177::proposal::market_state_id<T0, T1>(arg0), 9);
        assert!(arg3 == 0x56dd1789976cf838cd5040f957a54117d05daf51c6696aa74bd84a016830e177::proposal::get_winning_outcome<T0, T1>(arg0), 2);
        0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::burn_conditional_stable_and_withdraw<T0, T1, T2>(arg1, arg2, arg5)
    }

    public fun redeem_conditional_stable_from_balance_with_wrapped_escrow<T0, T1, T2, T3>(arg0: &0x56dd1789976cf838cd5040f957a54117d05daf51c6696aa74bd84a016830e177::proposal::Proposal<T0, T1>, arg1: &mut 0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg2: &mut 0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::conditional_balance::ConditionalMarketBalance<T0, T1>, arg3: u8, arg4: u64, arg5: &0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::spot_pool_mutation_auth::SpotPoolMutationRegistry, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1) = extract_proposal_escrow<T0, T1, T2>(arg0, arg1, arg5);
        let v2 = v0;
        let v3 = 0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::conditional_balance::unwrap_to_coin<T0, T1, T3>(arg2, &mut v2, arg3, false, arg4, arg7);
        let v4 = &mut v2;
        store_proposal_escrow<T0, T1, T2>(arg1, v2, v1, arg5);
        redeem_conditional_stable<T0, T1, T3>(arg0, v4, v3, (arg3 as u64), arg6, arg7)
    }

    public fun redeem_conditional_stable_with_wrapped_escrow<T0, T1, T2, T3>(arg0: &0x56dd1789976cf838cd5040f957a54117d05daf51c6696aa74bd84a016830e177::proposal::Proposal<T0, T1>, arg1: &mut 0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg2: 0x2::coin::Coin<T3>, arg3: u64, arg4: &0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::spot_pool_mutation_auth::SpotPoolMutationRegistry, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1) = extract_proposal_escrow<T0, T1, T2>(arg0, arg1, arg4);
        let v2 = v0;
        let v3 = &mut v2;
        store_proposal_escrow<T0, T1, T2>(arg1, v2, v1, arg4);
        redeem_conditional_stable<T0, T1, T3>(arg0, v3, arg2, arg3, arg5, arg6)
    }

    public entry fun remove_liquidity_entry<T0, T1, T2, T3, T4>(arg0: &mut 0x56dd1789976cf838cd5040f957a54117d05daf51c6696aa74bd84a016830e177::proposal::Proposal<T0, T1>, arg1: &mut 0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::TokenEscrow<T0, T1>, arg2: u64, arg3: 0x2::coin::Coin<T4>, arg4: u64, arg5: u64, arg6: &0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::escrow_mutation_auth::EscrowMutationRegistry, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        abort 10
    }

    fun store_proposal_escrow<T0, T1, T2>(arg0: &mut 0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg1: 0x681cb834438f0493c82bf4bd9d77fcfbac0843cc05242e30e0e7cb1a108a3859::coin_escrow::TokenEscrow<T0, T1>, arg2: bool, arg3: &0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::spot_pool_mutation_auth::SpotPoolMutationRegistry) {
        let v0 = SpotPoolMutationWitness{dummy_field: false};
        0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::unified_spot_pool::store_extracted_escrow<T0, T1, T2>(arg0, arg1, arg2, 0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::spot_pool_mutation_auth::create<SpotPoolMutationWitness>(arg3, v0, 0x2::object::id<0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>>(arg0)));
    }

    // decompiled from Move bytecode v6
}

